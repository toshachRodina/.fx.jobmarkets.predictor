/*
=======================================================================================================================================================================================================
SUBJECT		 : businesses for sale scrape - web data from python/beautifulsoup
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_b4s_scrape_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170316
SOURCE		 : sqlite3 database
PREPERATION	 : 
                  
			   
REMARKS		 : 1) 
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

DROP TABLE ltn.dbo.f_dtl_b4s_scrape_d;

CREATE TABLE LTN.DBO.F_DTL_B4S_SCRAPE_D
( MSMT_DTE_ID int NOT NULL
, STARTED_AT  datetime NOT NULL
, FINISHED_AT datetime NOT NULL
, DATA_TYPE   varchar(30) NOT NULL
, CNTRY_CDE   varchar(2) NOT NULL
, SITE_CDE    varchar(30) NOT NULL
, FACET_TYPE  varchar(30) NOT NULL
, FACET_DESC  varchar(200) NOT NULL
, FACET_CNT   int NOT NULL
);

CREATE NONCLUSTERED INDEX UX_F_DTL_B4S_SCRAPE_D ON LTN.DBO.F_DTL_B4S_SCRAPE_D ( MSMT_DTE_ID, CNTRY_CDE, SITE_CDE );

ALTER TABLE ltn.dbo.f_dtl_b4s_scrape_d REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_b4s_scrape_d   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_B4S_SCRAPE_D', @p_pkg_nme = 'LTN_PKG_F_DTL_B4S_SCRAPE_D'


=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_b4s_scrape_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_b4s_scrape_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_b4s_scrape_d -- Alter the SP Always
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
         
         SET @l_tbl_nme = 'f_dtl_b4s_scrape_d';
	    SET @l_stg_tbl_nme = 'stg_dtl_b4s_scrape_d';
         
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
*/
		  
		  CREATE TABLE #TMP_DTL_B4S_SCRAPE_D
		  ( MSMT_DTE_ID int NOT NULL
		  , STARTED_AT  datetime NOT NULL
		  , FINISHED_AT datetime NOT NULL
		  , DATA_TYPE   varchar(30) NOT NULL
		  , CNTRY_CDE   varchar(2) NOT NULL
		  , SITE_CDE    varchar(30) NOT NULL
		  , FACET_TYPE  varchar(30) NOT NULL
		  , FACET_DESC  varchar(200) NOT NULL
		  , FACET_CNT   int NOT NULL
		  );

		  INSERT INTO #TMP_DTL_B4S_SCRAPE_D ( MSMT_DTE_ID
									 , STARTED_AT
									 , FINISHED_AT
									 , DATA_TYPE
									 , CNTRY_CDE
									 , SITE_CDE
									 , FACET_TYPE
									 , FACET_DESC
									 , FACET_CNT
									 )
		  SELECT DISTINCT
			    MSMT_DTE_ID
			  , STARTED_AT
			  , FINISHED_AT
			  , DATA_TYPE
			  , CNTRY_CDE
			  , SITE_CDE
			  , FACET_TYPE
			  , FACET_DESC
			  , FACET_CNT
		    FROM openquery(PY_WEB_DATA, '
				    SELECT DAT.MSMT_DTE_ID
						  , DAT.STARTED_AT
						  , DAT.FINISHED_AT
						  , DAT.DATA_TYPE
						  , DAT.CNTRY_CDE
						  , DAT.SITE_CDE
						  , DAT.FACET_TYPE
						  , DAT.FACET_DESC
						  , DAT.FACET_CNT
					   FROM PY_B4S_DATA AS DAT');


/*
STEP 2 
---------------------------------------------------------------------------------------------------
** insert into final f_dtl table 
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)
*/

		  INSERT INTO LTN.DBO.F_DTL_B4S_SCRAPE_D ( MSMT_DTE_ID
										 , STARTED_AT
										 , FINISHED_AT
										 , DATA_TYPE
										 , CNTRY_CDE
										 , SITE_CDE
										 , FACET_TYPE
										 , FACET_DESC
										 , FACET_CNT
										 )
		  SELECT TMP.MSMT_DTE_ID
			  , TMP.STARTED_AT
			  , TMP.FINISHED_AT
			  , TMP.DATA_TYPE
			  , TMP.CNTRY_CDE
			  , TMP.SITE_CDE
			  , TMP.FACET_TYPE
			  , TMP.FACET_DESC
			  , TMP.FACET_CNT
		    FROM #TMP_DTL_B4S_SCRAPE_D AS TMP
			    LEFT OUTER JOIN LTN.DBO.F_DTL_B4S_SCRAPE_D AS DTL
			    ON 1 = 1
				  AND TMP.MSMT_DTE_ID = DTL.MSMT_DTE_ID
				  AND TMP.DATA_TYPE = DTL.DATA_TYPE
				  AND TMP.CNTRY_CDE = DTL.CNTRY_CDE
				  AND TMP.SITE_CDE = DTL.SITE_CDE
				  AND TMP.FACET_TYPE = DTL.FACET_TYPE
				  AND TMP.FACET_DESC = DTL.FACET_DESC
		   WHERE 1 = 1
			    AND DTL.MSMT_DTE_ID IS NULL
			    AND DTL.DATA_TYPE IS NULL
			    AND DTL.CNTRY_CDE IS NULL
			    AND DTL.SITE_CDE IS NULL
			    AND DTL.FACET_TYPE IS NULL
			    AND DTL.FACET_DESC IS NULL;
						 
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

