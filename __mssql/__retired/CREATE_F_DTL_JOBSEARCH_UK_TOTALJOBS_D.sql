/*=====================================================================================================================================================================================================
=======================================================================================================================================================================================================
SUBJECT		 : totaljobs - job search site summary job listing data by work category
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_jobsearch_uk_totaljobs_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161205
SOURCE		 : gov [ https://www.totaljobs.com/ ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed daily to get the summary "balances" at point in time
			   2) designed to get a feel for the delta movements in job postings
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.stg_jobsearch_uk_totaljobs_raw;

CREATE TABLE ltn.dbo.stg_jobsearch_uk_totaljobs_raw
             (
             msmt_dte_id  nvarchar(8) NOT NULL
           , job_category varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_jobsearch_uk_totaljobs_d;

CREATE TABLE ltn.dbo.f_dtl_jobsearch_uk_totaljobs_d
             (
             msmt_dte_id  int NOT NULL
           , job_site_nme varchar(25) NOT NULL
           , job_category varchar(255) NOT NULL
           , job_count    int NOT NULL
             );

CREATE UNIQUE INDEX ux_f_dtl_jobsearch_uk_totaljobs_d ON ltn.dbo.f_dtl_jobsearch_uk_totaljobs_d(msmt_dte_id, job_category);

ALTER TABLE ltn.dbo.f_dtl_jobsearch_uk_totaljobs_d REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================


=======================================================================================================================================================================================================
=====================================================================================================================================================================================================*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_jobsearch_uk_totaljobs_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_jobsearch_uk_totaljobs_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_jobsearch_uk_totaljobs_d -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
     BEGIN
         SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD

         SET ANSI_NULLS ON;
         SET QUOTED_IDENTIFIER ON;

/*===================================================================================================================================================================================================
=====================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS

=====================================================================================================================================================================================================
===================================================================================================================================================================================================*/

         -- TABLES ----------------------------------------------------------------
         DECLARE
                @l_tbl_nme AS nvarchar(50);
         DECLARE
                @l_prces_dte_id AS nvarchar(8);

         SET @l_tbl_nme = 'f_dtl_jobsearch_uk_totaljobs_d';
         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_msmt_dte_id AS nvarchar(8);

         SET @l_msmt_dte_id =
             (
                 SELECT MAX(msmt_dte_id)
                        FROM
                             ltn.dbo.stg_jobsearch_uk_totaljobs_raw
             );

/*
=====================================================================================================================================================================================================
MAIN CODE BLOCK
- TABLE TIDY UP (IF NEEDED)
- INSERT NEW DATA
- SWITCH INTO EMPTY PARTITIONS (IF USING TABLE PARTITIONS

=====================================================================================================================================================================================================
*/

/*
=====================================================================================================================================================================================================
TRY BLOACK - START

=====================================================================================================================================================================================================
*/

         BEGIN TRY

/*=================================================================================================
STEP 1 
---------------------------------------------------------------------------------------------------
** remove blank or non required lines
** general tidy up of staging data
=================================================================================================*/

             CREATE TABLE #tmp_dtl_jobsearch_uk_totaljobs_s1
                          (
                          msmt_dte_id  int NOT NULL
                        , job_category varchar(255) NOT NULL
                          );

			 INSERT INTO #tmp_dtl_jobsearch_uk_totaljobs_s1
				   (msmt_dte_id
				  , job_category
				   )
			 SELECT stg.msmt_dte_id
				 , LTRIM(RTRIM(REPLACE(UPPER([dbo].[fn_cleanstring]( stg.job_category )), '"', ''))) AS job_category
				   FROM
					   ltn.dbo.stg_jobsearch_uk_totaljobs_raw AS stg
				   WHERE 1 = 1
					    AND LTRIM(RTRIM([dbo].[fn_cleanstring]( stg.job_category ))) != '';

/*=================================================================================================
STEP 2
---------------------------------------------------------------------------------------------------
** seperate numeric values from text for each job category
** show job categories and job counts as unique columns
** store in final dtl table
=================================================================================================*/

             DECLARE
                    @l_job_site_nme AS nvarchar(50);

             SET @l_job_site_nme = 'TOTALJOBS';

		  
             INSERT INTO ltn.dbo.f_dtl_jobsearch_uk_totaljobs_d
                    (msmt_dte_id
                   , job_site_nme
                   , job_category
                   , job_count
                    ) 
             SELECT s1.msmt_dte_id
                  , @l_job_site_nme AS job_site_nme
                  , LTRIM(RTRIM(SUBSTRING(s1.job_category, 1, CHARINDEX('(', s1.job_category)-1))) AS job_category
                  , [dbo].[fn_getnumeric]( s1.job_category ) AS job_count
                    FROM
                         #tmp_dtl_jobsearch_uk_totaljobs_s1 AS s1
                    WHERE 1 = 1
                    ORDER BY 1
                           , 3;
         END TRY

/*
=====================================================================================================================================================================================================
TRY BLOACK - END

=====================================================================================================================================================================================================
*/

/*
=====================================================================================================================================================================================================
CATCH BLOACK - START

=====================================================================================================================================================================================================
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
             SELECT CONVERT(                        varchar(10), CAST(GETDATE() AS date), 112) AS msmt_dte_id
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
=====================================================================================================================================================================================================
CATCH BLOACK - END

=====================================================================================================================================================================================================
*/

     END;