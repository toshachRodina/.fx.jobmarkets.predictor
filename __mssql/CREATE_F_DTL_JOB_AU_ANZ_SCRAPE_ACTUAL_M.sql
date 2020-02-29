/*
=======================================================================================================================================================================================================
SUBJECT		 : anz job ads data from anz website - this is the ACTUAL result 
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_job_au_anz_scrape_actual_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20180201
SOURCE		 : sqlite3 database
PREPERATION	 : 
                  
			   
REMARKS		 : 1) this differs from f_dtl_job_au_anz_scrape_m in the following ways
                     - this takes the most recent data from each month
				 - as this data wont be ADJUSTED, we refer to it as ACTUAL
				 - f_dtl_job_au_anz_scrape_m will have the as is month to month data and will show ADJUSTMENTS
			   2) 
			   3)
INDEXES
PK_ for primary keys
UK_ for unique keys
IX_ for non clustered non unique indexes
UX_ for unique indexes
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.f_dtl_job_au_anz_scrape_actual_m;

CREATE TABLE LTN.DBO.F_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M
( MSMT_DTE_ID                       int NOT NULL
, DATA_TYPE                         varchar(30) NOT NULL
, CNTRY_CDE                         varchar(2) NOT NULL
, SITE_CDE                          varchar(30) NOT NULL
, RPT_DTE_ID                        int NOT NULL
, RPT_DTE                           varchar(10) NOT NULL
, ORIGINAL_NBR                      int NOT NULL
, SEASONALLY_ADJUSTED_NBR           int NOT NULL
, SEASONALLY_ADJUSTED_MTH_PCNT_CHNG decimal(5, 2) NOT NULL
, SEASONALLY_ADJUSTED_YR_PCNT_CHNG  decimal(5, 2) NOT NULL
, TREND_NBR                         int NOT NULL
, TREND_MTH_PCNT_CHNG               decimal(5, 2) NOT NULL
, TREND_YR_PCNT_CHNG                decimal(5, 2) NOT NULL
, CAPTR_DTE_ID                      int NOT NULL
, STARTED_AT                        datetime NOT NULL
, FINISHED_AT                       datetime NOT NULL
);

CREATE NONCLUSTERED INDEX UX_F_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M ON LTN.DBO.F_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M ( MSMT_DTE_ID );

ALTER TABLE ltn.dbo.f_dtl_job_au_anz_scrape_actual_m REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_job_scrape_d   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_JOB_SCRAPE_D', @p_pkg_nme = 'LTN_PKG_F_DTL_JOB_SCRAPE_D'

=======================================================================================================================================================================================================
*/
USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_job_au_anz_scrape_actual_m') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_job_au_anz_scrape_actual_m AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_job_au_anz_scrape_actual_m -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
     BEGIN
         --SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD
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
         DECLARE
                @l_stg_tbl_nme AS nvarchar(50);
         
         SET @l_tbl_nme = 'f_dtl_job_au_anz_scrape_actual_m';
         
         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_prces_dte_id AS nvarchar(8);
	    DECLARE 
			 @l_min_date_id_to_keep as nvarchar(8)

         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

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
** load data from sqlite3 database to sqlserver temp table
** there are duplicate records shown from various sites - distinct removes these

drop table #TMP_DTL_JOB_AU_ANZ_SCRAPE_M
*/

    CREATE TABLE #TMP_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M
    ( MSMT_DTE_ID                       int NOT NULL
    , DATA_TYPE                         varchar(30) NOT NULL
    , CNTRY_CDE                         varchar(2) NOT NULL
    , SITE_CDE                          varchar(30) NOT NULL
    , RPT_DTE_ID                        int NOT NULL
    , RPT_DTE                           varchar(10) NOT NULL
    , ORIGINAL_NBR                      int NOT NULL
    , SEASONALLY_ADJUSTED_NBR           int NOT NULL
    , SEASONALLY_ADJUSTED_MTH_PCNT_CHNG decimal(5, 2) NOT NULL
    , SEASONALLY_ADJUSTED_YR_PCNT_CHNG  decimal(5, 2) NOT NULL
    , TREND_NBR                         int NOT NULL
    , TREND_MTH_PCNT_CHNG               decimal(5, 2) NOT NULL
    , TREND_YR_PCNT_CHNG                decimal(5, 2) NOT NULL
    , CAPTR_DTE_ID                      int NOT NULL
    , STARTED_AT                        datetime NOT NULL
    , FINISHED_AT                       datetime NOT NULL
    );

    INSERT INTO #TMP_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M ( MSMT_DTE_ID
										  , DATA_TYPE
										  , CNTRY_CDE
										  , SITE_CDE
										  , RPT_DTE_ID
										  , RPT_DTE
										  , ORIGINAL_NBR
										  , SEASONALLY_ADJUSTED_NBR
										  , SEASONALLY_ADJUSTED_MTH_PCNT_CHNG
										  , SEASONALLY_ADJUSTED_YR_PCNT_CHNG
										  , TREND_NBR
										  , TREND_MTH_PCNT_CHNG
										  , TREND_YR_PCNT_CHNG
										  , CAPTR_DTE_ID
										  , STARTED_AT
										  , FINISHED_AT
										  )
    SELECT MSMT_DTE_ID
	    , DATA_TYPE
	    , CNTRY_CDE
	    , SITE_CDE
	    , RPT_DTE_ID
	    , RPT_DTE
	    , ORIGINAL_NBR
	    , SEASONALLY_ADJUSTED_NBR
	    , SEASONALLY_ADJUSTED_MTH_PCNT_CHNG
	    , SEASONALLY_ADJUSTED_YR_PCNT_CHNG
	    , TREND_NBR
	    , TREND_MTH_PCNT_CHNG
	    , TREND_YR_PCNT_CHNG
	    , CAPTR_DTE_ID
	    , STARTED_AT
	    , FINISHED_AT
	 FROM openquery(PY_WEB_DATA, '
						 SELECT DAT.MSMT_DTE_ID
							 , DAT.DATA_TYPE
							 , DAT.CNTRY_CDE
							 , DAT.SITE_CDE
							 , DAT.RPT_DTE_ID
							 , DAT.RPT_DTE
							 , DAT.ORIGINAL_NBR
							 , DAT.SEASONALLY_ADJUSTED_NBR
							 , DAT.SEASONALLY_ADJUSTED_MTH_PCNT_CHNG
							 , DAT.SEASONALLY_ADJUSTED_YR_PCNT_CHNG
							 , DAT.TREND_NBR
							 , DAT.TREND_MTH_PCNT_CHNG
							 , DAT.TREND_YR_PCNT_CHNG
							 , DAT.CAPTR_DTE_ID
							 , DAT.STARTED_AT
							 , DAT.FINISHED_AT
						   FROM PY_JOBS_AU_ANZ_DATA AS DAT');

/*
STEP 2
---------------------------------------------------------------------------------------------------
** extract only the most recent data from each pdf (msmt_dte_id)

drop table #TMP2_DTL_JOB_AU_ANZ_SCRAPE_M
*/

    CREATE TABLE #TMP2_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M
    ( MSMT_DTE_ID                       int NOT NULL
    , DATA_TYPE                         varchar(30) NOT NULL
    , CNTRY_CDE                         varchar(2) NOT NULL
    , SITE_CDE                          varchar(30) NOT NULL
    , RPT_DTE_ID                        int NOT NULL
    , RPT_DTE                           varchar(10) NOT NULL
    , ORIGINAL_NBR                      int NOT NULL
    , SEASONALLY_ADJUSTED_NBR           int NOT NULL
    , SEASONALLY_ADJUSTED_MTH_PCNT_CHNG decimal(5, 2) NOT NULL
    , SEASONALLY_ADJUSTED_YR_PCNT_CHNG  decimal(5, 2) NOT NULL
    , TREND_NBR                         int NOT NULL
    , TREND_MTH_PCNT_CHNG               decimal(5, 2) NOT NULL
    , TREND_YR_PCNT_CHNG                decimal(5, 2) NOT NULL
    , CAPTR_DTE_ID                      int NOT NULL
    , STARTED_AT                        datetime NOT NULL
    , FINISHED_AT                       datetime NOT NULL
    );

    WITH DTES(MSMT_DTE_ID
		  , ORIG_RPT_DTE_ID
		  , NEW_RPT_DTE_ID)
	    AS (SELECT TMP.MSMT_DTE_ID
			   , max(TMP.RPT_DTE_ID) AS ORIG_RPT_DTE_ID
			   , convert(varchar(10), eomonth(convert(date, convert(varchar(10), max(TMP.RPT_DTE_ID), 120))), 112) AS NEW_RPT_DTE_ID
			FROM #TMP_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M AS TMP
		    GROUP BY TMP.MSMT_DTE_ID)
	    INSERT INTO #TMP2_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M ( MSMT_DTE_ID
											   , DATA_TYPE
											   , CNTRY_CDE
											   , SITE_CDE
											   , RPT_DTE_ID
											   , RPT_DTE
											   , ORIGINAL_NBR
											   , SEASONALLY_ADJUSTED_NBR
											   , SEASONALLY_ADJUSTED_MTH_PCNT_CHNG
											   , SEASONALLY_ADJUSTED_YR_PCNT_CHNG
											   , TREND_NBR
											   , TREND_MTH_PCNT_CHNG
											   , TREND_YR_PCNT_CHNG
											   , CAPTR_DTE_ID
											   , STARTED_AT
											   , FINISHED_AT
											   )
	    SELECT DAT.MSMT_DTE_ID
		    , DAT.DATA_TYPE
		    , DAT.CNTRY_CDE
		    , DAT.SITE_CDE
		    , DTES.NEW_RPT_DTE_ID AS RPT_DTE_ID
		    , DAT.RPT_DTE
		    , DAT.ORIGINAL_NBR
		    , DAT.SEASONALLY_ADJUSTED_NBR
		    , DAT.SEASONALLY_ADJUSTED_MTH_PCNT_CHNG
		    , DAT.SEASONALLY_ADJUSTED_YR_PCNT_CHNG
		    , DAT.TREND_NBR
		    , DAT.TREND_MTH_PCNT_CHNG
		    , DAT.TREND_YR_PCNT_CHNG
		    , DAT.CAPTR_DTE_ID
		    , DAT.STARTED_AT
		    , DAT.FINISHED_AT
		 FROM #TMP_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M AS DAT
			 INNER JOIN DTES
			 ON DAT.MSMT_DTE_ID = DTES.MSMT_DTE_ID
			    AND DAT.RPT_DTE_ID = DTES.ORIG_RPT_DTE_ID
		WHERE 1 = 1
		ORDER BY 1;
	    
/*
STEP 2 
---------------------------------------------------------------------------------------------------
** insert into final f_dtl table 
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)
*/

    INSERT INTO LTN.DBO.F_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M ( MSMT_DTE_ID
											  , DATA_TYPE
											  , CNTRY_CDE
											  , SITE_CDE
											  , RPT_DTE_ID
											  , RPT_DTE
											  , ORIGINAL_NBR
											  , SEASONALLY_ADJUSTED_NBR
											  , SEASONALLY_ADJUSTED_MTH_PCNT_CHNG
											  , SEASONALLY_ADJUSTED_YR_PCNT_CHNG
											  , TREND_NBR
											  , TREND_MTH_PCNT_CHNG
											  , TREND_YR_PCNT_CHNG
											  , CAPTR_DTE_ID
											  , STARTED_AT
											  , FINISHED_AT
											  )
    SELECT TMP.MSMT_DTE_ID
	    , TMP.DATA_TYPE
	    , TMP.CNTRY_CDE
	    , TMP.SITE_CDE
	    , TMP.RPT_DTE_ID
	    , TMP.RPT_DTE
	    , TMP.ORIGINAL_NBR
	    , TMP.SEASONALLY_ADJUSTED_NBR
	    , TMP.SEASONALLY_ADJUSTED_MTH_PCNT_CHNG
	    , TMP.SEASONALLY_ADJUSTED_YR_PCNT_CHNG
	    , TMP.TREND_NBR
	    , TMP.TREND_MTH_PCNT_CHNG
	    , TMP.TREND_YR_PCNT_CHNG
	    , TMP.CAPTR_DTE_ID
	    , TMP.STARTED_AT
	    , TMP.FINISHED_AT
	 FROM #TMP2_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M AS TMP
		 LEFT OUTER JOIN LTN.DBO.F_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M AS DTL
		 ON 1 = 1
		    AND TMP.MSMT_DTE_ID = DTL.MSMT_DTE_ID
		    AND TMP.DATA_TYPE = DTL.DATA_TYPE
		    AND TMP.CNTRY_CDE = DTL.CNTRY_CDE
		    AND TMP.SITE_CDE = DTL.SITE_CDE
	WHERE 1 = 1
		 AND DTL.MSMT_DTE_ID IS NULL
		 AND DTL.DATA_TYPE IS NULL
		 AND DTL.CNTRY_CDE IS NULL
		 AND DTL.SITE_CDE IS NULL;
						 
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
BEGIN
   CATCH;

   INSERT INTO LTN.DBO.CTL_SSIS_ERR_LOG ( MSMT_DTE_ID
                                        , ENV
                                        , JOB_NME
                                        , TASK_NME
                                        , TASK_TP
                                        , TASK_START_DATETIME
                                        , TASK_END_DATETIME
                                        , TASK_STATUS
                                        , TASK_OUTPUT
                                        )
   SELECT convert(varchar(10), cast(getdate() AS date), 112) AS MSMT_DTE_ID
        , @p_env
        , @p_pkg_nme
        , @p_task_nme
        , 'SQLSCRIPT'
        , getdate()
        , getdate()
        , CASE
               WHEN error_message() IS NULL
               THEN 'SUCCESS'
               ELSE 'ERROR'
          END
        , 'msmt_dte_id variable used : '+convert(varchar(10), cast(getdate() AS date), 112)+' --- error msg : '+error_message();

END
    CATCH;

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/

END;
