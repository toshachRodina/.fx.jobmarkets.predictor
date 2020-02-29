/*
=======================================================================================================================================================================================================
SUBJECT		 : seek - businesses for sale search site summary job listing data by work category
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_bus4sale_au_seek_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161103
SOURCE		 : seekbusiness [ https://www.seekbusiness.com.au ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed daily to get the summary "balances" at point in time
			   2) designed to get a feel for the delta movements in businesses for sale postings
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.stg_bus4sale_au_seek_raw;

CREATE TABLE ltn.dbo.stg_bus4sale_au_seek_raw
             (
             msmt_dte_id  nvarchar(8) NOT NULL
           , industry varchar(max) NOT NULL
		 , opportunity varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_bus4sale_au_seek_d;

CREATE TABLE ltn.dbo.f_dtl_bus4sale_au_seek_d
             (
             msmt_dte_id  int NOT NULL
           , bus4sale_site_nme varchar(25) NOT NULL
           , bus4sale_category varchar(255) NOT NULL
           , bus4sale_count    int NOT NULL
             );

CREATE UNIQUE INDEX ux_f_dtl_bus4sale_au_seek_d ON ltn.dbo.f_dtl_bus4sale_au_seek_d(msmt_dte_id, bus4sale_category);

ALTER TABLE ltn.dbo.f_dtl_bus4sale_au_seek_d REBUILD
WITH(DATA_COMPRESSION = ROW);

DROP TABLE ltn.dbo.f_dtl_bus4sale_au_seek_opportunity_d;

CREATE TABLE ltn.dbo.f_dtl_bus4sale_au_seek_opportunity_d
             (
             msmt_dte_id  int NOT NULL
           , bus4sale_site_nme varchar(25) NOT NULL
           , bus4sale_opportunity varchar(255) NOT NULL
           , bus4sale_count    int NOT NULL
             );

CREATE UNIQUE INDEX ux_f_dtl_bus4sale_au_seek_opportunity_d ON ltn.dbo.f_dtl_bus4sale_au_seek_opportunity_d(msmt_dte_id, bus4sale_opportunity);

ALTER TABLE ltn.dbo.f_dtl_bus4sale_au_seek_opportunity_d REBUILD
WITH(DATA_COMPRESSION = ROW);


=======================================================================================================================================================================================================
select * from ltn.dbo.stg_bus4sale_au_seek_raw
select * from ltn.dbo.f_dtl_bus4sale_au_seek_d
select * from ltn.dbo.f_dtl_bus4sale_au_seek_opportunity_d
=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_bus4sale_au_seek_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_bus4sale_au_seek_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_bus4sale_au_seek_d -- Alter the SP Always
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

         SET @l_tbl_nme = 'f_dtl_bus4sale_au_seek_d';
         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_msmt_dte_id AS nvarchar(8);

         SET @l_msmt_dte_id =
             (
                 SELECT MAX(msmt_dte_id)
                        FROM
                             ltn.dbo.stg_bus4sale_au_seek_raw
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
STEP 1 (2 PARTS)
a. INDUSTRY CATEGORY
b. OPPORTUNITY (BUSINESS, FRANCHISE, LICENSE/DISTRIBUTION
---------------------------------------------------------------------------------------------------
** tidy up raw output
** transpose industry listing into distinct rows
=================================================================================================*/

/*===============================================================================================
a. INDUSTRY CATEGORY
=================================================================================================*/

				CREATE TABLE #tmp_dtl_bus4sale_au_seek_industry_s1
						   (
						   msmt_dte_id  int NOT NULL
						 , bus4sale_industry varchar(max) NOT NULL
						   );


				 -- recursively splits the job_category field into seperate rows. 
				 WITH row_dat(msmt_dte_id
						  , list_item
						  , bus4sale_industry)
					 AS (
					 SELECT stg.msmt_dte_id
						 , LEFT(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.industry))), ') ', ')~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.industry))), ') ', ')~'))+'~')-1) AS list_item
						 , STUFF(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.industry))), ') ', ')~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.industry))), ') ', ')~'))+'~'), '') AS bus4sale_industry
					 	   FROM
							   ltn.dbo.stg_bus4sale_au_seek_raw AS stg
					 UNION ALL
					 SELECT dat.msmt_dte_id
						 , LEFT(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.bus4sale_industry))), ') ', ')~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.bus4sale_industry))), ') ', ')~'))+'~')-1) AS list_item
						 , STUFF(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.bus4sale_industry))), ') ', ')~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.bus4sale_industry))), ') ', ')~'))+'~'), '') AS job_category
						   FROM
							   row_dat AS dat
						   WHERE 1 = 1
							    AND UPPER(REPLACE(LTRIM(RTRIM(dat.bus4sale_industry)), '  ', '~')) > ''
							 )
					 INSERT INTO #tmp_dtl_bus4sale_au_seek_industry_s1
						   (msmt_dte_id
						  , bus4sale_industry
						   )
					 SELECT dat.msmt_dte_id
						 , LTRIM(RTRIM(dat.list_item)) AS job_category
					 --, LTRIM(RTRIM(dat.job_category)) AS sub_list
						   FROM
							   row_dat AS dat
						   WHERE 1 = 1
							    AND LTRIM(RTRIM(dat.list_item)) != ''
					--	   OPTION(MAXRECURSION 0);
				 -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option	


/*===============================================================================================
b. OPPORTUNITY
=================================================================================================*/

				CREATE TABLE #tmp_dtl_bus4sale_au_seek_industry_opportunity_s1
						   (
						   msmt_dte_id  int NOT NULL
						 , bus4sale_opportunity varchar(max) NOT NULL
						   );

				 -- recursively splits the job_category field into seperate rows. 
				 WITH row_dat(msmt_dte_id
						  , list_item
						  , bus4sale_opportunity)
					 AS (
					 SELECT stg.msmt_dte_id
						 , LEFT(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.opportunity))), ') ', ')~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.opportunity))), ') ', ')~'))+'~')-1) AS list_item
						 , STUFF(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.opportunity))), ') ', ')~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (stg.opportunity))), ') ', ')~'))+'~'), '') AS bus4sale_opportunity
					 	   FROM
							   ltn.dbo.stg_bus4sale_au_seek_raw AS stg
					 UNION ALL
					 SELECT dat.msmt_dte_id
						 , LEFT(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.bus4sale_opportunity))), ') ', ')~')), CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.bus4sale_opportunity))), ') ', ')~'))+'~')-1) AS list_item
						 , STUFF(UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.bus4sale_opportunity))), ') ', ')~')), 1, CHARINDEX('~', UPPER(REPLACE(LTRIM(RTRIM([dbo].[fn_cleanstring] (dat.bus4sale_opportunity))), ') ', ')~'))+'~'), '') AS bus4sale_opportunity
						   FROM
							   row_dat AS dat
						   WHERE 1 = 1
							    AND UPPER(REPLACE(LTRIM(RTRIM(dat.bus4sale_opportunity)), '  ', '~')) > ''
							 )
					 INSERT INTO #tmp_dtl_bus4sale_au_seek_industry_opportunity_s1
						   (msmt_dte_id
						  , bus4sale_opportunity
						   )
					 SELECT dat.msmt_dte_id
						 , LTRIM(RTRIM(dat.list_item)) AS bus4sale_opportunity
					 --, LTRIM(RTRIM(dat.job_category)) AS sub_list
						   FROM
							   row_dat AS dat
						   WHERE 1 = 1
							    AND LTRIM(RTRIM(dat.list_item)) != ''
					--	   OPTION(MAXRECURSION 0);
				 -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option	


/*=================================================================================================
STEP 2 (2 PARTS)
a. INDUSTRY CATEGORY
b. OPPORTUNITY (BUSINESS, FRANCHISE, LICENSE/DISTRIBUTION
---------------------------------------------------------------------------------------------------
** seperate numeric values from text for each job category
** show job categories and job counts as unique columns
** store in final dtl table
=================================================================================================*/

/*===============================================================================================
a. INDUSTRY CATEGORY
=================================================================================================*/

			  DECLARE
					  @l_bus4sale_site_nme AS nvarchar(50);

			  SET @l_bus4sale_site_nme = 'SEEK';
			  
			  INSERT INTO ltn.dbo.f_dtl_bus4sale_au_seek_d
				    (msmt_dte_id
				   , bus4sale_site_nme
				   , bus4sale_category
				   , bus4sale_count
				    ) 
			  SELECT s1.msmt_dte_id
				  , @l_bus4sale_site_nme as bus4sale_site_nme
				  , ltrim(rtrim(left(s1.bus4sale_industry,  PATINDEX('%[0-9]%', s1.bus4sale_industry) - 2)))  as bus4sale_category
				  , [dbo].[fn_getnumeric]( s1.bus4sale_industry ) as bus4sale_count
			  FROM
					    #tmp_dtl_bus4sale_au_seek_industry_s1 AS s1
				    WHERE 1 = 1 order by 1,3;
				    
/*===============================================================================================
b. OPPORTUNITY
=================================================================================================*/

                 INSERT INTO ltn.dbo.f_dtl_bus4sale_au_seek_opportunity_d
				    (msmt_dte_id
				   , bus4sale_site_nme
				   , bus4sale_opportunity
				   , bus4sale_count
				    ) 
			  SELECT s1.msmt_dte_id
				  , @l_bus4sale_site_nme as bus4sale_site_nme
				  , ltrim(rtrim(left(s1.bus4sale_opportunity,  PATINDEX('%[0-9]%', s1.bus4sale_opportunity) - 2)))  as bus4sale_opportunity
				  , [dbo].[fn_getnumeric]( s1.bus4sale_opportunity ) as bus4sale_count
		  FROM
					    #tmp_dtl_bus4sale_au_seek_industry_opportunity_s1 AS s1
				    WHERE 1 = 1 order by 1,3;

         
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


