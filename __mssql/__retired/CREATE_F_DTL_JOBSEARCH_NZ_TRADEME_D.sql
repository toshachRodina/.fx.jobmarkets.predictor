/*
=======================================================================================================================================================================================================
SUBJECT		 : trademe - job search site summary job listing data by work category
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_jobsearch_nz_trademe_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161201
SOURCE		 : jora [ http://www.trademe.co.nz/jobs ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed daily to get the summary "balances" at point in time
			   2) designed to get a feel for the delta movements in job postings
			   3) jora scrape seems to loop continuously and needs to be manually stopped - NEEDS INVESTIGATING
				    a) scraping via a different path and there appears to be more categories
				    b) will run in parallel and eventually turn off original jora
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------
DROP TABLE ltn.dbo.stg_jobsearch_nz_trademe_raw;

CREATE TABLE ltn.dbo.stg_jobsearch_nz_trademe_raw
             (
             msmt_dte_id  nvarchar(8) NOT NULL
           , job_category varchar(max) NOT NULL
           , job_count    varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_jobsearch_nz_trademe_d;

CREATE TABLE ltn.dbo.f_dtl_jobsearch_nz_trademe_d
             (
             msmt_dte_id  int NOT NULL
           , job_site_nme varchar(25) NOT NULL
           , job_category varchar(255) NOT NULL
           , job_count    int NOT NULL
             );

CREATE UNIQUE INDEX ux_f_dtl_jobsearch_nz_trademe_d ON ltn.dbo.f_dtl_jobsearch_nz_trademe_d(msmt_dte_id, job_category);

ALTER TABLE ltn.dbo.f_dtl_jobsearch_nz_trademe_d REBUILD
WITH(DATA_COMPRESSION = ROW);
=======================================================================================================================================================================================================


=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_jobsearch_nz_trademe_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_jobsearch_nz_trademe_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_jobsearch_nz_trademe_d -- Alter the SP Always
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

	    SET @l_tbl_nme = 'f_dtl_jobsearch_nz_trademe_d';
	 
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
                             ltn.dbo.stg_jobsearch_nz_trademe_raw
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
** clean up row text in both job_category and job_count (remove unrequired data)
*/

		  DECLARE
			    @l_job_site_nme AS nvarchar(50);

		  SET @l_job_site_nme = 'TRADEME';
		  
		  INSERT INTO LTN.DBO.F_DTL_JOBSEARCH_NZ_TRADEME_D ( MSMT_DTE_ID
												 , JOB_SITE_NME
												 , JOB_CATEGORY
												 , JOB_COUNT
												 )
		  SELECT STG.MSMT_DTE_ID
			  , @l_job_site_nme AS JOB_SITE_NME
			  , upper(ltrim(rtrim(STG.JOB_CATEGORY))) AS JOB_CATEGORY
			  , avg(cast(STG.JOB_COUNT AS int)) AS JOB_COUNT
		    FROM LTN.DBO.STG_JOBSEARCH_NZ_TRADEME_RAW AS STG
		   WHERE 1 = 1
		   GROUP BY STG.MSMT_DTE_ID
				, upper(ltrim(rtrim(STG.JOB_CATEGORY)))
		   ORDER BY 1
				, 2;

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
