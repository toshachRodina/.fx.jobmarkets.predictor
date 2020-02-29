/*
=======================================================================================================================================================================================================
SUBJECT		 : indeed - job search site summary job listing data by work category
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_jobsearch_us_indeed_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161201
SOURCE		 : jora [ http://www.indeed.com/ ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed daily to get the summary "balances" at point in time
			   2) designed to get a feel for the delta movements in job postings
			   3) jora scrape seems to loop continuously and needs to be manually stopped - NEEDS INVESTIGATING
				    a) scraping via a different path and there appears to be more categories
				    b) will run in parallel and eventually turn off original jora
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------
DROP TABLE ltn.dbo.stg_jobsearch_us_indeed_raw;

CREATE TABLE ltn.dbo.stg_jobsearch_us_indeed_raw
             (
             msmt_dte_id  nvarchar(8) NOT NULL
           , job_category varchar(max) NOT NULL
           , job_count    varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_jobsearch_us_indeed_d;

CREATE TABLE ltn.dbo.f_dtl_jobsearch_us_indeed_d
             (
             msmt_dte_id  int NOT NULL
           , job_site_nme varchar(25) NOT NULL
           , job_category varchar(255) NOT NULL
           , job_count    int NOT NULL
             );

CREATE UNIQUE INDEX ux_f_dtl_jobsearch_us_indeed_d ON ltn.dbo.f_dtl_jobsearch_us_indeed_d(msmt_dte_id, job_category);

ALTER TABLE ltn.dbo.f_dtl_jobsearch_us_indeed_d REBUILD
WITH(DATA_COMPRESSION = ROW);
=======================================================================================================================================================================================================


=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_jobsearch_us_indeed_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_jobsearch_us_indeed_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_jobsearch_us_indeed_d -- Alter the SP Always
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

	    SET @l_tbl_nme = 'f_dtl_jobsearch_us_indeed_d';
	 
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
                             ltn.dbo.stg_jobsearch_us_indeed_raw
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

		  SET @l_job_site_nme = 'INDEED';


		  DECLARE
                    @text_to_remove_job_category AS varchar(50);

             SET @text_to_remove_job_category =
                 (
                     SELECT rir.val_1
                            FROM
                                 ltn.dbo.ref_itm_rule AS rir
                            WHERE 1 = 1
                                  AND rir.itm_type_cde = 'JOBSEARCH'
                                  AND rir.itm_rltshp_type_cde = 'US_INDEED'
                                  AND rir.itm_rule_nbr = 1
                                  AND rir.end_dte_id = 29991231
                 );
			  
		  INSERT INTO ltn.dbo.f_dtl_jobsearch_us_indeed_d
			    (msmt_dte_id
			   , job_site_nme
			   , job_category
			   , job_count
			    ) 
		  SELECT stg.msmt_dte_id
			  , @l_job_site_nme AS job_site_nme
			  , LTRIM(RTRIM(LEFT(UPPER(stg.job_category), CHARINDEX(@text_to_remove_job_category, UPPER(stg.job_category))-1))) AS job_category
			  , AVG(CAST(dbo.fn_getnumeric( stg.job_count ) AS int)) AS job_count
			    FROM
				    ltn.dbo.stg_jobsearch_us_indeed_raw AS stg
			    WHERE 1 = 1
			    GROUP BY stg.msmt_dte_id
					 , LTRIM(RTRIM(LEFT(UPPER(stg.job_category), CHARINDEX(@text_to_remove_job_category, UPPER(stg.job_category))-1)));

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
