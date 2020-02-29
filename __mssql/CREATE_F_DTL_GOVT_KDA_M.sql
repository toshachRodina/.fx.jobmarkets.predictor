/*
=======================================================================================================================================================================================================
SUBJECT		 : government key date announcement web data from python/beautifulsoup
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_govt_kda_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170428
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

DROP TABLE LTN.DBO.F_DTL_GOVT_KDA_M;

CREATE TABLE LTN.DBO.F_DTL_GOVT_KDA_M
( MSMT_DTE_ID int NOT NULL
, DATA_TYPE   varchar(30) NOT NULL
, CNTRY_CDE   varchar(2) NOT NULL
, SITE_CDE    varchar(20) NOT NULL
, ANNCE_DTE   varchar(20) NULL
, ANNCE_TM    varchar(20) NULL
, ANNCE_CDE   varchar(20) NULL
, ANNCE_DESC  varchar(1000) NULL
, STARTED_AT  varchar(20) NOT NULL
, FINISHED_AT varchar(20) NOT NULL
);

CREATE NONCLUSTERED INDEX UX_F_DTL_GOVT_KDA_M ON LTN.DBO.F_DTL_GOVT_KDA_M ( MSMT_DTE_ID, CNTRY_CDE );

ALTER TABLE LTN.DBO.F_DTL_GOVT_KDA_M REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec CREATE_F_DTL_GOVT_KDA_M   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_GOVT_KDA_M', @p_pkg_nme = 'LTN_PKG_F_DTL_GOVT_KDA_M'


select * from f_dtl_govt_kda_m
=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_govt_kda_m') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_govt_kda_m AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_govt_kda_m -- Alter the SP Always
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
         
         SET @l_tbl_nme = 'create_f_dtl_govt_kda_m';
         
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
		  CREATE TABLE #TMP_F_DTL_GOVT_KDA_M
		  ( MSMT_DTE_ID int NOT NULL
		  , DATA_TYPE   varchar(30) NOT NULL
		  , CNTRY_CDE   varchar(2) NOT NULL
		  , SITE_CDE    varchar(20) NOT NULL
		  , ANNCE_DTE   varchar(20) NULL
		  , ANNCE_TM    varchar(20) NULL
		  , ANNCE_CDE   varchar(20) NULL
		  , ANNCE_DESC  varchar(1000) NULL
		  , STARTED_AT  varchar(20) NOT NULL
		  , FINISHED_AT varchar(20) NOT NULL
		  );

		  INSERT INTO #TMP_F_DTL_GOVT_KDA_M ( MSMT_DTE_ID
									 , DATA_TYPE
									 , CNTRY_CDE
									 , SITE_CDE
									 , ANNCE_DTE
									 , ANNCE_TM
									 , ANNCE_CDE
									 , ANNCE_DESC
									 , STARTED_AT
									 , FINISHED_AT
									 )
		  SELECT MSMT_DTE_ID
			  , DATA_TYPE
			  , CNTRY_CDE
			  , SITE_CDE
			  , ANNCE_DTE
			  , ANNCE_TM
			  , ANNCE_CDE
			  , ANNCE_DESC
			  , STARTED_AT
			  , FINISHED_AT
		    FROM openquery(PY_WEB_DATA, 'SELECT DAT.MSMT_DTE_ID
									   , DAT.DATA_TYPE
									   , DAT.CNTRY_CDE
									   , DAT.SITE_CDE
									   , DAT.ANNCE_DTE
									   , DAT.ANNCE_TM
									   , DAT.ANNCE_CDE
									   , DAT.ANNCE_DESC
									   , DAT.STARTED_AT
									   , DAT.FINISHED_AT
								    FROM PY_GOVT_KEY_DATE_ANNOUNCEMENTS AS DAT;');

/*
STEP 2   select * from #TMP_F_DTL_GOVT_KDA_M where cntry_cde = 'NZ' and (ANNCE_DESC like '%IWI STAT%' or ANNCE_DESC like '%ENVIRONMENTAL REPORTING SERIES%')
---------------------------------------------------------------------------------------------------
** check:
    - if element has changed mark as needing to be updated
    - if element is new mark as needing insertion
** no deletion necessary as we will keep history of older announcements
*/
		  CREATE TABLE #TMP_F_DTL_GOVT_KDA_M_DTA
		  ( ACTION_CDE   varchar(1) NOT NULL
		  , MSMT_DTE_ID int NOT NULL
		  , DATA_TYPE   varchar(30) NOT NULL
		  , CNTRY_CDE   varchar(2) NOT NULL
		  , SITE_CDE    varchar(20) NOT NULL
		  , ANNCE_DTE   varchar(20) NULL
		  , ANNCE_TM    varchar(20) NULL
		  , ANNCE_CDE   varchar(20) NULL
		  , ANNCE_DESC  varchar(1000) NULL
		  , STARTED_AT  varchar(20) NOT NULL
		  , FINISHED_AT varchar(20) NOT NULL
		  );

		  INSERT INTO #TMP_F_DTL_GOVT_KDA_M_DTA ( ACTION_CDE
		                                        , MSMT_DTE_ID
										, DATA_TYPE
										, CNTRY_CDE
										, SITE_CDE
										, ANNCE_DTE
										, ANNCE_TM
										, ANNCE_CDE
										, ANNCE_DESC
										, STARTED_AT
										, FINISHED_AT
										)
		  SELECT CASE
				    WHEN DEST.MSMT_DTE_ID IS NULL
				    THEN 'I' -- no record found - insert new record
				    WHEN isnull(SRCE.ANNCE_DESC, '~') <> isnull(DEST.ANNCE_DESC, '~')
				    THEN 'U' -- record is found but details have changed - update record
				    ELSE 'N' -- records match - do nothing
			    END AS ACTION_CDE
			  , SRCE.MSMT_DTE_ID
			  , SRCE.DATA_TYPE
			  , SRCE.CNTRY_CDE
			  , SRCE.SITE_CDE
			  , SRCE.ANNCE_DTE
			  , SRCE.ANNCE_TM
			  , SRCE.ANNCE_CDE
			  , SRCE.ANNCE_DESC
			  , SRCE.STARTED_AT
			  , SRCE.FINISHED_AT
		    FROM #TMP_F_DTL_GOVT_KDA_M AS SRCE
			    LEFT OUTER JOIN LTN.DBO.F_DTL_GOVT_KDA_M AS DEST
			    ON 1 = 1
				  AND SRCE.ANNCE_DTE = DEST.ANNCE_DTE
				  AND SRCE.CNTRY_CDE = DEST.CNTRY_CDE
				  AND SRCE.SITE_CDE = DEST.SITE_CDE
				  AND SRCE.ANNCE_CDE = DEST.ANNCE_CDE;

/*
STEP 3   select * from #TMP_F_DTL_GOVT_KDA_M_DTA where ACTION_CDE = 'U'
---------------------------------------------------------------------------------------------------
** UPDATE and INSERT steps
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)

select * from #TMP_F_DTL_GOVT_KDA_M_DTA
*/

		  UPDATE LTN.DBO.F_DTL_GOVT_KDA_M
			SET ANNCE_DESC = SRCE.ANNCE_DESC
			   ,MSMT_DTE_ID = SRCE.MSMT_DTE_ID
			   ,STARTED_AT = SRCE.STARTED_AT
			   ,FINISHED_AT = SRCE.FINISHED_AT
		    FROM LTN.DBO.F_DTL_GOVT_KDA_M DEST
			    INNER JOIN #TMP_F_DTL_GOVT_KDA_M_DTA SRCE
			    ON 1 = 1
				  AND SRCE.ANNCE_DTE = DEST.ANNCE_DTE
				  AND SRCE.CNTRY_CDE = DEST.CNTRY_CDE
				  AND SRCE.SITE_CDE = DEST.SITE_CDE
				  AND SRCE.ANNCE_CDE = DEST.ANNCE_CDE
		   WHERE 1 = 1
			    AND SRCE.ACTION_CDE IN ( 'U' );
			    
		  INSERT INTO LTN.DBO.F_DTL_GOVT_KDA_M ( MSMT_DTE_ID
									    , DATA_TYPE
									    , CNTRY_CDE
									    , SITE_CDE
									    , ANNCE_DTE
									    , ANNCE_TM
									    , ANNCE_CDE
									    , ANNCE_DESC
									    , STARTED_AT
									    , FINISHED_AT
									    )
		  SELECT TMP.MSMT_DTE_ID
			  , TMP.DATA_TYPE
			  , TMP.CNTRY_CDE
			  , TMP.SITE_CDE
			  , TMP.ANNCE_DTE
			  , TMP.ANNCE_TM
			  , TMP.ANNCE_CDE
			  , TMP.ANNCE_DESC
			  , TMP.STARTED_AT
			  , TMP.FINISHED_AT
		    FROM #TMP_F_DTL_GOVT_KDA_M_DTA AS TMP
		   WHERE 1 = 1
			    AND TMP.ACTION_CDE IN ( 'I' );
						 
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

