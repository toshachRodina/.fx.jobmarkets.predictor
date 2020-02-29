/*
=======================================================================================================================================================================================================
SUBJECT		 : seek - job search site summary job listing data by work category
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_jobsearch_nz_seek_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161201
SOURCE		 : businessforsale [ https://www.seek.co.nz/ ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed daily to get the summary "balances" at point in time
			   2) designed to get a feel for the delta movements in businesses for sale postings
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.stg_jobsearch_nz_seek_raw;

CREATE TABLE ltn.dbo.stg_jobsearch_nz_seek_raw
             (
             msmt_dte_id  nvarchar(8) NOT NULL
           , industryGroup varchar(max) NOT NULL
		 , industrySubGroup varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_jobsearch_nz_seek_d;

CREATE TABLE ltn.dbo.f_dtl_jobsearch_nz_seek_d
             (
             msmt_dte_id  int NOT NULL
           , job_site_nme varchar(25) NOT NULL
           , job_category varchar(255) NOT NULL
		 , job_sub_category varchar(255) NOT NULL
           , job_count    int NOT NULL
             );

CREATE NONCLUSTERED INDEX ux_f_dtl_jobsearch_nz_seek_d ON ltn.dbo.f_dtl_jobsearch_nz_seek_d(msmt_dte_id, job_category);

ALTER TABLE ltn.dbo.f_dtl_jobsearch_nz_seek_d REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
select * from ltn.dbo.stg_jobsearch_nz_seek_raw

select * from ltn.dbo.f_dtl_jobsearch_nz_seek_d order by 1,2,3
=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_jobsearch_nz_seek_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_jobsearch_nz_seek_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_jobsearch_nz_seek_d -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
     BEGIN
         SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD

         SET ANSI_NULLS ON;
         SET QUOTED_IDENTIFIER ON;

/*=====================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS

=====================================================================================================================================================================================================*/

         -- TABLES ----------------------------------------------------------------
         DECLARE
                @l_tbl_nme AS nvarchar(50);
         DECLARE
                @l_prces_dte_id AS nvarchar(8);

         SET @l_tbl_nme = 'f_dtl_jobsearch_nz_seek_d';
         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_msmt_dte_id AS nvarchar(8);

         SET @l_msmt_dte_id =
             (
                 SELECT MAX(msmt_dte_id)
                        FROM
                             ltn.dbo.stg_jobsearch_nz_seek_raw
             );

/*=====================================================================================================================================================================================================
MAIN CODE BLOCK
- TABLE TIDY UP (IF NEEDED)
- INSERT NEW DATA
- SWITCH INTO EMPTY PARTITIONS (IF USING TABLE PARTITIONS

=====================================================================================================================================================================================================*/

/*=====================================================================================================================================================================================================
TRY BLOACK - START

=====================================================================================================================================================================================================*/

         BEGIN TRY

/*=================================================================================================
STEP 1 
---------------------------------------------------------------------------------------------------
** tidy up raw output
=================================================================================================*/

			CREATE TABLE #tmp_dtl_jobsearch_nz_seek_s1
						   (
						   msmt_dte_id  int NOT NULL
						 , job_industry_group varchar(max) NOT NULL
						 , job_industry_sub_group varchar(max) NOT NULL
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
							  AND rir.itm_rltshp_type_cde = 'NZ_SEEK'
							  AND rir.itm_rule_nbr = 1
							  AND rir.end_dte_id = 29991231
				);

			 DECLARE
				   @text_to_remove_sub_industry_field AS varchar(50);

			 SET @text_to_remove_sub_industry_field =
				(
				    SELECT rir.val_1
						 FROM
							 ltn.dbo.ref_itm_rule AS rir
						 WHERE 1 = 1
							  AND rir.itm_type_cde = 'JOBSEARCH'
							  AND rir.itm_rltshp_type_cde = 'NZ_SEEK'
							  AND rir.itm_rule_nbr = 2
							  AND rir.end_dte_id = 29991231
				);		
					 
			 INSERT INTO #tmp_dtl_jobsearch_nz_seek_s1
					  (msmt_dte_id
					 , job_industry_group
					 , job_industry_sub_group
					  )
				SELECT stg.msmt_dte_id
					, LTRIM(RTRIM(REPLACE(UPPER(stg.industrygroup), @text_to_remove_industry_field, ''))) AS industrygroup
					, SUBSTRING(LTRIM(RTRIM(REPLACE(UPPER(stg.industrysubgroup), @text_to_remove_sub_industry_field, ''))), PATINDEX('%[a-z]%', LTRIM(RTRIM(REPLACE(UPPER(stg.industrysubgroup), @text_to_remove_sub_industry_field, '')))), LEN(LTRIM(RTRIM(REPLACE(UPPER(stg.industrysubgroup), @text_to_remove_sub_industry_field, ''))))) AS industrysubgroup
					  FROM
						  ltn.dbo.stg_jobsearch_nz_seek_raw AS stg;

/*=================================================================================================
STEP 2   
---------------------------------------------------------------------------------------------------
** transpose industry listing into distinct rows
=================================================================================================*/

				CREATE TABLE #tmp_dtl_jobsearch_nz_seek_s2
						   (
						   msmt_dte_id  int NOT NULL
						 , job_industry_group varchar(max) NOT NULL
						 , job_industry_sub_group varchar(max) NOT NULL
						   );

				 -- recursively splits the job_category field into seperate rows. 
				 WITH row_dat(msmt_dte_id
						  , job_industry_group
						  , list_item
						  , job_industry_sub_group)
					 AS (
					 SELECT stg.msmt_dte_id
					      , stg.job_industry_group
						 , LEFT(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.job_industry_sub_group))), ') ', ')~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.job_industry_sub_group))), ') ', ')~'))+'~')-1) AS list_item
						 , STUFF(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.job_industry_sub_group))), ') ', ')~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.job_industry_sub_group))), ') ', ')~'))+'~'), '') AS job_sub_industry
					   FROM
							   #tmp_dtl_jobsearch_nz_seek_s1 AS stg
							--   where 1 = 1 and bus4sale_industry_group = 'ACCOMMODATION AND TOURISM'
					 UNION ALL
					 SELECT dat.msmt_dte_id
						 , dat.job_industry_group
						 , LEFT(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.job_industry_sub_group))), ') ', ')~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.job_industry_sub_group))), ') ', ')~'))+'~')-1) AS list_item
						 , STUFF(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.job_industry_sub_group))), ') ', ')~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.job_industry_sub_group))), ') ', ')~'))+'~'), '') AS job_sub_industry
						   FROM
							   row_dat AS dat
						   WHERE 1 = 1
							    AND UPPER(REPLACE(LTRIM(RTRIM(dat.job_industry_sub_group)), ') ', ')~')) > '')
					INSERT INTO #tmp_dtl_jobsearch_nz_seek_s2
						   (msmt_dte_id
						  , job_industry_group
						  , job_industry_sub_group
						   ) 
					 SELECT dat.msmt_dte_id
					      , dat.job_industry_group
						 , LTRIM(RTRIM(dat.list_item)) AS job_category
					 --, LTRIM(RTRIM(dat.job_category)) AS sub_list
						   FROM
							   row_dat AS dat
						   WHERE 1 = 1
							    AND LTRIM(RTRIM(dat.list_item)) != ''
							    order by 1,2,3
						   OPTION(MAXRECURSION 0)
						   ;
				 -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option	
	
/*=================================================================================================
STEP 3
---------------------------------------------------------------------------------------------------
** seperate numeric values from text for each job category
** show job categories and job counts as unique columns
** store in final dtl table
=================================================================================================*/


				DECLARE
					  @l_job_site_nme AS nvarchar(50);

				SET @l_job_site_nme = 'SEEK';

				INSERT INTO ltn.dbo.f_dtl_jobsearch_nz_seek_d
					  (msmt_dte_id
					 , job_site_nme
					 , job_category
					 , job_sub_category
					 , job_count
					  )
				SELECT s2.msmt_dte_id
					, @l_job_site_nme AS job_site_nme
					, s2.job_industry_group
					, LTRIM(RTRIM(LEFT(s2.job_industry_sub_group, PATINDEX('%[0-9]%', s2.job_industry_sub_group)-2))) AS job_sub_category
					, [dbo].[fn_getnumeric]( s2.job_industry_sub_group ) AS job_count
					  FROM
						  #tmp_dtl_jobsearch_nz_seek_s2 AS s2
					  WHERE 1 = 1
						   AND LTRIM(RTRIM(job_industry_group)) != ''
					  ORDER BY 1
						    , 2
						    , 3;
					    
						    					             
	    END TRY

/*=====================================================================================================================================================================================================
TRY BLOACK - END

=====================================================================================================================================================================================================*/

/*=====================================================================================================================================================================================================
CATCH BLOACK - START

=====================================================================================================================================================================================================*/

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
             SELECT CONVERT( varchar(10), CAST(GETDATE() AS date), 112) AS msmt_dte_id
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

/*=====================================================================================================================================================================================================
CATCH BLOACK - END

=====================================================================================================================================================================================================*/

     END;


