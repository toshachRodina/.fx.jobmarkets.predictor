/*
=======================================================================================================================================================================================================
SUBJECT		 : myjobspace - job search site summary job listing data by work category
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_jobsearch_nz_myjobspace_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161201
SOURCE		 : jora [ http://myjobspace.co.nz/ ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed daily to get the summary "balances" at point in time
			   2) designed to get a feel for the delta movements in job postings
			   3) jora scrape seems to loop continuously and needs to be manually stopped - NEEDS INVESTIGATING
				    a) scraping via a different path and there appears to be more categories
				    b) will run in parallel and eventually turn off original jora
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------
DROP TABLE ltn.dbo.stg_jobsearch_nz_myjobspace_raw;

CREATE TABLE ltn.dbo.stg_jobsearch_nz_myjobspace_raw
             (
             msmt_dte_id  nvarchar(8) NOT NULL
           , job_category varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_jobsearch_nz_myjobspace_d;

CREATE TABLE ltn.dbo.f_dtl_jobsearch_nz_myjobspace_d
             (
             msmt_dte_id  int NOT NULL
           , job_site_nme varchar(25) NOT NULL
           , job_category varchar(255) NOT NULL
           , job_count    int NOT NULL
             );

CREATE UNIQUE INDEX ux_f_dtl_jobsearch_nz_myjobspace_d ON ltn.dbo.f_dtl_jobsearch_nz_myjobspace_d(msmt_dte_id, job_category);

ALTER TABLE ltn.dbo.f_dtl_jobsearch_nz_myjobspace_d REBUILD
WITH(DATA_COMPRESSION = ROW);
=======================================================================================================================================================================================================


=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_jobsearch_nz_myjobspace_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_jobsearch_nz_myjobspace_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_jobsearch_nz_myjobspace_d -- Alter the SP Always
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

	    SET @l_tbl_nme = 'f_dtl_jobsearch_nz_myjobspace_d';
	 
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
                             ltn.dbo.stg_jobsearch_nz_myjobspace_raw
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


/*=================================================================================================
STEP 1 
---------------------------------------------------------------------------------------------------
** tidy up raw data
=================================================================================================*/
		  CREATE TABLE #TMP_DTL_JOBSEARCH_NZ_MYJOBSPACE_S1
		  ( MSMT_DTE_ID  int NOT NULL
		  , JOB_CATEGORY varchar(max) NOT NULL
		  );


		  INSERT INTO #TMP_DTL_JOBSEARCH_NZ_MYJOBSPACE_S1 ( MSMT_DTE_ID
												, JOB_CATEGORY
												)
		  SELECT STG.MSMT_DTE_ID
			  , DBO.FN_CLEANSTRING ( ltrim(rtrim(upper(replace(STG.JOB_CATEGORY, ') ', ')~')))) ) AS JOB_CATEGORY
		    FROM LTN.DBO.STG_JOBSEARCH_NZ_MYJOBSPACE_RAW AS STG
		   WHERE 1 = 1;


/*=================================================================================================
STEP 2 
---------------------------------------------------------------------------------------------------
** transpose flat list into unique rows
=================================================================================================*/

		  CREATE TABLE #TMP_DTL_JOBSEARCH_NZ_MYJOBSPACE_S2
		  ( MSMT_DTE_ID  int NOT NULL
		  , JOB_CATEGORY varchar(255) NOT NULL
		  );


		  -- recursively splits the job_category field into seperate rows. 
		  WITH ROW_DAT(MSMT_DTE_ID
				   , LIST_ITEM
				   , JOB_CATEGORY)
			  AS (
			  SELECT STG.MSMT_DTE_ID
				  , left(replace(STG.JOB_CATEGORY , '~', '^'), charindex('^', replace(STG.JOB_CATEGORY ,'~', '^')+'^')-1) AS LIST_ITEM
				  , stuff(replace(STG.JOB_CATEGORY , '~', '^'), 1, charindex('^', replace( STG.JOB_CATEGORY, '~', '^')+'^'), '') AS JOB_CATEGORY
			    FROM #TMP_DTL_JOBSEARCH_NZ_MYJOBSPACE_S1 AS STG
			  UNION ALL
			  SELECT DAT.MSMT_DTE_ID
				  , left(replace(DAT.JOB_CATEGORY , '~', '^'), charindex('^', replace(DAT.JOB_CATEGORY ,'~', '^')+'^')-1) AS LIST_ITEM
				  , stuff(replace(DAT.JOB_CATEGORY , '~', '^'), 1, charindex('^', replace( DAT.JOB_CATEGORY, '~', '^')+'^'), '') AS JOB_CATEGORY
			    FROM ROW_DAT AS DAT
			   WHERE 1 = 1
				    AND replace(DAT.JOB_CATEGORY, '    ', '~') > ''
				    )
			  INSERT INTO #TMP_DTL_JOBSEARCH_NZ_MYJOBSPACE_S2 ( MSMT_DTE_ID
													, JOB_CATEGORY
													)
			  SELECT DAT.MSMT_DTE_ID
				  , ltrim(rtrim(DAT.LIST_ITEM)) AS JOB_CATEGORY
			    FROM ROW_DAT AS DAT
			   WHERE 1 = 1
			   OPTION(MAXRECURSION 0);
		  -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option


/*=================================================================================================
STEP 3 
---------------------------------------------------------------------------------------------------
** tidy up final output
** insert into final table
=================================================================================================*/

		  DECLARE @l_job_site_nme AS nvarchar(50);

		  SET @l_job_site_nme = 'MYJOBSPACE';

		  WITH FULL_TXT(REF_TXT)
			  AS (
			  SELECT 'AGRICULTURE, FISHING & FORESTRY'
			  UNION
			  SELECT 'BANKING, FINANCE & INSURANCE'
			  UNION
			  SELECT 'CONSTRUCTION & ARCHITECTURE'
			  UNION
			  SELECT 'EXECUTIVE & GENERAL MANAGEMENT'
			  UNION
			  SELECT 'MANUFACTURING & OPERATIONS'
			  UNION
			  SELECT 'MARKETING, MEDIA & COMMUNICATIONS')
			  INSERT INTO LTN.DBO.F_DTL_JOBSEARCH_NZ_MYJOBSPACE_D ( MSMT_DTE_ID
													    , JOB_SITE_NME
													    , JOB_CATEGORY
													    , JOB_COUNT
													    )
			  SELECT STG.MSMT_DTE_ID
				  , @l_job_site_nme AS JOB_SITE_NAME
				  , CASE
					    WHEN FT.REF_TXT IS NULL
					    THEN ltrim(rtrim(left(STG.JOB_CATEGORY, charindex('(', STG.JOB_CATEGORY)-1)))
					    ELSE FT.REF_TXT
				    END AS JOB_CATEGORY
				  , DBO.FN_GETNUMERIC ( STG.JOB_CATEGORY ) AS JOB_COUNT
			    FROM #TMP_DTL_JOBSEARCH_NZ_MYJOBSPACE_S2 AS STG
				    LEFT OUTER JOIN FULL_TXT AS FT
				    ON 1 = 1
					  AND left(STG.JOB_CATEGORY, 15) = left(FT.REF_TXT, 15);


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
