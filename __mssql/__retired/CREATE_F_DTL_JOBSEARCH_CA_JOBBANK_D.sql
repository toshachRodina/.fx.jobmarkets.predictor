/*
=======================================================================================================================================================================================================
SUBJECT		 : jobbank - job search site summary job listing data by work category
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_jobsearch_ca_jobbank_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161205
SOURCE		 : jora [ http://www.jobbank.gc.ca/ ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed daily to get the summary "balances" at point in time
			   2) designed to get a feel for the delta movements in job postings
			   3) jor scrape seems to loop continuously and needs to be manually stopped - NEEDS INVESTIGATING
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.stg_jobsearch_ca_jobbank_raw;

CREATE TABLE ltn.dbo.stg_jobsearch_ca_jobbank_raw
             (
             msmt_dte_id  nvarchar(8) NOT NULL
           , job_category varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_jobsearch_ca_jobbank_d;

CREATE TABLE ltn.dbo.f_dtl_jobsearch_ca_jobbank_d
             (
             msmt_dte_id      int NOT NULL
           , job_site_nme     varchar(25) NOT NULL
           , job_category     varchar(255) NOT NULL
           , noc              varchar(5) NOT NULL
           , job_sub_category varchar(255) NOT NULL
           , job_count        int NOT NULL
             );

CREATE UNIQUE INDEX ux_f_dtl_jobsearch_ca_jobbank_d ON ltn.dbo.f_dtl_jobsearch_ca_jobbank_d(msmt_dte_id, job_category, noc);

ALTER TABLE ltn.dbo.f_dtl_jobsearch_ca_jobbank_d REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================


=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_jobsearch_ca_jobbank_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_jobsearch_ca_jobbank_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_jobsearch_ca_jobbank_d -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
     BEGIN
         SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD

         SET ANSI_NULLS ON;
         SET QUOTED_IDENTIFIER ON;

/*
=======================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS
=======================================================================================================================================================================================================
*/

-- TABLES ----------------------------------------------------------------
	    DECLARE
			@l_tbl_nme AS nvarchar(50);

	    SET @l_tbl_nme = 'f_dtl_jobsearch_ca_jobbank_d';
	 
         -- DATES -----------------------------------------------------------------
	    DECLARE
			@l_prces_dte_id AS nvarchar(8);

         DECLARE
                @l_msmt_dte_id AS nvarchar(8);

         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);
         SET @l_msmt_dte_id =
             (
                 SELECT MAX(msmt_dte_id)
                        FROM
                             ltn.dbo.stg_jobsearch_ca_jobbank_raw
             );

/*
=======================================================================================================================================================================================================
MAIN CODE BLOCK
- TABLE TIDY UP (IF NEEDED)
- INSERT NEW DATA
- SWITCH INTO EMPTY PARTITIONS (IF USING TABLE PARTITIONS)
=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
TRY BLOACK - START
=======================================================================================================================================================================================================
*/

         BEGIN TRY

/*
STEP 1 
---------------------------------------------------------------------------------------------------
** clean up row text in job_category (remove unwanted text)
*/

		  CREATE TABLE #tmp_dtl_jobsearch_ca_jobbank_s1
					(
					msmt_dte_id  int NOT NULL
				   , job_category varchar(max) NOT NULL
					);

		  DECLARE
			    @text_to_remove_industry_field AS varchar(50);

		  SET @text_to_remove_industry_field =
			 (
				SELECT rir.val_1
					  FROM
						  ltn.dbo.ref_itm_rule AS rir
					  WHERE 1 = 1
						   AND rir.itm_type_cde = 'JOBSEARCH'
						   AND rir.itm_rltshp_type_cde = 'CA_JOBBANK'
						   AND rir.itm_rule_nbr = 1
						   AND rir.end_dte_id = 29991231
			 );

		  INSERT INTO #tmp_dtl_jobsearch_ca_jobbank_s1
						  (msmt_dte_id
						  , job_category
						  )
		  SELECT stg.msmt_dte_id
			  , replace(upper(stg.job_category),@text_to_remove_industry_field,'') AS job_category
		    FROM
				    ltn.dbo.stg_jobsearch_ca_jobbank_raw AS stg
			    WHERE 1 = 1;



/*
STEP 2  
---------------------------------------------------------------------------------------------------
** recursively split into seperate rows all major industry categories and their sub categories
*/

             CREATE TABLE #tmp_dtl_jobsearch_ca_jobbank_s2
                          (
                          msmt_dte_id  int NOT NULL
                        , job_category varchar(max) NOT NULL
                          );

             -- recursively splits the job_category field into seperate rows. 
             WITH row_dat(msmt_dte_id
                        , list_item
                        , job_category)
                  AS (
                  SELECT stg.msmt_dte_id
			        , LEFT(UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (stg.job_category), '"', ''))), '     ', ')~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (stg.job_category), '"', ''))), '     ', ')~'))+'~')-1) AS list_item
                       , STUFF(UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (stg.job_category), '"', ''))), '     ', ')~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (stg.job_category), '"', ''))), '     ', ')~'))+'~'), '') AS job_category
                   FROM
                              ltn.dbo.#tmp_dtl_jobsearch_ca_jobbank_s1 AS stg
                  UNION ALL
                  SELECT dat.msmt_dte_id
                       , LEFT(UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (dat.job_category), '"', ''))), '     ', ')~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (dat.job_category), '"', ''))), '     ', ')~'))+'~')-1) AS list_item
                       , STUFF(UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (dat.job_category), '"', ''))), '     ', ')~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (dat.job_category), '"', ''))), '     ', ')~'))+'~'), '') AS job_category
                         FROM
                              row_dat AS dat
                         WHERE 1 = 1
                               AND UPPER(REPLACE(LTRIM(RTRIM(REPLACE(dat.job_category, '"', ''))), '     ', '~')) > '')
                  INSERT INTO #tmp_dtl_jobsearch_ca_jobbank_s2
                         (msmt_dte_id
                        , job_category
                         )
                  SELECT dat.msmt_dte_id
                       , LTRIM(RTRIM(dat.list_item)) AS job_category
                         FROM
                              row_dat AS dat
                         WHERE 1 = 1
                         OPTION(MAXRECURSION 0);
             -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option


/*
STEP 3  
---------------------------------------------------------------------------------------------------
** split into seperate columns category and sub category list
*/

		  CREATE TABLE #tmp_dtl_jobsearch_ca_jobbank_s3
					(
					msmt_dte_id          int NOT NULL
				   , job_category         varchar(255) NOT NULL
				   , job_sub_category_lst varchar(max) NOT NULL
					);

		  INSERT INTO #tmp_dtl_jobsearch_ca_jobbank_s3
			    (msmt_dte_id
			   , job_category
			   , job_sub_category_lst
			    )
		  SELECT s2.msmt_dte_id
			  , LTRIM(RTRIM(SUBSTRING(s2.job_category, 1, PATINDEX('%[0-9]%', s2.job_category)-1))) AS job_category
			  , SUBSTRING(STUFF(s2.job_category, CHARINDEX(LTRIM(RTRIM(SUBSTRING(s2.job_category, 1, PATINDEX('%[0-9]%', s2.job_category)-1))), s2.job_category), LEN(LTRIM(RTRIM(SUBSTRING(s2.job_category, 1, PATINDEX('%[0-9]%', s2.job_category)-1)))), ''), PATINDEX('%[A-Z]%', REPLACE(s2.job_category, SUBSTRING(s2.job_category, 1, PATINDEX('%[0-9]%', s2.job_category)-1), '')), LEN(s2.job_category)) AS job_sub_category_lst
			    FROM
				    #tmp_dtl_jobsearch_ca_jobbank_s2 AS s2;

/*
STEP 4
---------------------------------------------------------------------------------------------------
** recursively split into seperate rows the sub sub category list
*/

             CREATE TABLE #tmp_dtl_jobsearch_ca_jobbank_s4
                          (
                          msmt_dte_id  int NOT NULL
                        , job_category varchar(255) NOT NULL
				    , job_sub_category varchar(max) NOT NULL
                          );


             -- recursively splits the job_category field into seperate rows. 
             WITH row_dat(msmt_dte_id
		              , job_category
                        , list_item
                        , job_sub_category_lst)
                  AS (
                  SELECT stg.msmt_dte_id
			        , stg.job_category
			        , LEFT(UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (stg.job_sub_category_lst), '"', ''))), '    ', '~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (stg.job_sub_category_lst), '"', ''))), '    ', '~'))+'~')-1) AS list_item
                       , STUFF(UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (stg.job_sub_category_lst), '"', ''))), '    ', '~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (stg.job_sub_category_lst), '"', ''))), '    ', '~'))+'~'), '') AS job_sub_category_lst
                   FROM
                              #tmp_dtl_jobsearch_ca_jobbank_s3 AS stg
                  UNION ALL
                  SELECT dat.msmt_dte_id
			        , dat.job_category
                       , LEFT(UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (dat.job_sub_category_lst), '"', ''))), '    ', '~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (dat.job_sub_category_lst), '"', ''))), '    ', '~'))+'~')-1) AS list_item
                       , STUFF(UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (dat.job_sub_category_lst), '"', ''))), '    ', '~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM(REPLACE([dbo].[fn_cleanstring] (dat.job_sub_category_lst), '"', ''))), '    ', '~'))+'~'), '') AS job_sub_category_lst
                         FROM
                              row_dat AS dat
                         WHERE 1 = 1
                               AND UPPER(REPLACE(LTRIM(RTRIM(REPLACE(dat.job_sub_category_lst, '"', ''))), '    ', '~')) > '')
                  INSERT INTO #tmp_dtl_jobsearch_ca_jobbank_s4
                         (msmt_dte_id
                        , job_category
				    , job_sub_category
                         )
                  SELECT dat.msmt_dte_id
			        , dat.job_category
                       , LTRIM(RTRIM(dat.list_item)) AS job_sub_category
                         FROM
                              row_dat AS dat
                         WHERE 1 = 1
                         OPTION(MAXRECURSION 0);
             -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option


/*
STEP 5
---------------------------------------------------------------------------------------------------
** split out unique identifiers from text (NOC_
** these are duplicated accross major categories so having the identifier will allow easily to handle
** insert into the final destination table
*/


			 DECLARE
				   @l_job_site_nme AS nvarchar(50);

			 SET @l_job_site_nme = 'JOBBANK';

			 INSERT INTO ltn.dbo.f_dtl_jobsearch_ca_jobbank_d
				   (msmt_dte_id
				  , job_site_nme
				  , job_category
				  , noc
				  , job_sub_category
				  , job_count
				   )
			 SELECT stg.msmt_dte_id
				 , @l_job_site_nme AS job_site_nme
				 , stg.job_category
				 , [dbo].[fn_getnumeric]( SUBSTRING(stg.job_sub_category, CHARINDEX('(NOC', stg.job_sub_category), 10) ) AS noc
				 , LTRIM(RTRIM(SUBSTRING(REPLACE(stg.job_sub_category, SUBSTRING(stg.job_sub_category, CHARINDEX('(NOC', stg.job_sub_category), 10), ''), 1, PATINDEX('%[0-9]%', REPLACE(stg.job_sub_category, SUBSTRING(stg.job_sub_category, CHARINDEX('(NOC', stg.job_sub_category), 10), ''))-1))) AS job_sub_category
				 , [dbo].[fn_getnumeric]( REPLACE(stg.job_sub_category, SUBSTRING(stg.job_sub_category, CHARINDEX('(NOC', stg.job_sub_category), 10), '') ) AS job_count
				   FROM
					   #tmp_dtl_jobsearch_ca_jobbank_s4 AS stg
				   ORDER BY 2
						, 3;

         END TRY
/*
=======================================================================================================================================================================================================
TRY BLOACK - END
=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
CATCH BLOACK - START
=======================================================================================================================================================================================================
*/

         BEGIN CATCH
             INSERT INTO ltn.dbo.ctl_ssis_err_log
                    (msmt_dte_id
                   , env
                   , job_nme
                   , task_nme
                   , task_tp
                   , task_start_datetime
                   , task_end_datetime
                   , task_status
                   , task_output
                    )
             SELECT CONVERT(varchar(10), CAST(GETDATE() AS date), 112) AS msmt_dte_id
                  , @p_env
                  , @p_pkg_nme
                  , @p_task_nme
                  , 'SQLSCRIPT'
                  , GETDATE()
                  , GETDATE()
                  , CASE
                        WHEN ERROR_MESSAGE() IS NULL
                        THEN 'SUCCESS'
                        ELSE 'ERROR'
                    END
                  , 'msmt_dte_id variable used : '+CONVERT( varchar(10), CAST(GETDATE() AS date), 112)+' --- error msg : '+ERROR_MESSAGE();
         END CATCH;

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/

     END;
