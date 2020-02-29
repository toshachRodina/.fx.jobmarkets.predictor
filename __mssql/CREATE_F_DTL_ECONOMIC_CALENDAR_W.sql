/*
=======================================================================================================================================================================================================
SUBJECT         : economic calendar from python/beautifulsoup
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_economic_calendar_w
CREATED BY      : Harold Delaney
CREATED ON      : 20171204
SOURCE          : sqlite3 database
PREPERATION     : 
                  
			   
REMARKS         : 1) 
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

DROP TABLE LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W;

CREATE TABLE LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W
(MSMT_DTE_ID  int NOT NULL
,DATA_TYPE    varchar(30) NOT NULL
,SITE_CDE     varchar(20) NOT NULL
,ANNCE_DTE    varchar(20) NOT NULL
,ANNCE_TM     varchar(20) NOT NULL
,CNTRY_CDE    varchar(3) NOT NULL
,ANNCE_CDE    varchar(20) NOT NULL
,ANNCE_DESC   varchar(1000) NOT NULL
,IMPACT       varchar(20) NULL
,ACTUAL       varchar(20) NULL
,FORECAST     varchar(20) NULL
,PREVIOUS     varchar(20) NULL
,CAPTR_DTE_ID int NOT NULL
,STARTED_AT   datetime NOT NULL
,FINISHED_AT  datetime NOT NULL
); 



CREATE NONCLUSTERED INDEX UX_F_DTL_ECONOMIC_CALENDAR_W ON LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W ( MSMT_DTE_ID, CNTRY_CDE );

ALTER TABLE LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec CREATE_F_DTL_ECONOMIC_CALENDAR_W   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_ECONOMIC_CALENDAR_W', @p_pkg_nme = 'LTN_PKG_F_DTL_GOVT_KDA_M'


select * from ltn.dbo.f_dtl_economic_calendar_w
=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('CREATE_F_DTL_ECONOMIC_CALENDAR_W') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_economic_calendar_w AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_economic_calendar_w -- Alter the SP Always
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
         
         SET @l_tbl_nme = 'f_dtl_economic_calendar_w';
         
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

drop table #TMP_F_DTL_ECONOMIC_CALENDAR_W
*/	
    CREATE TABLE #TMP_F_DTL_ECONOMIC_CALENDAR_W
    ( MSMT_DTE_ID  int NOT NULL
    , DATA_TYPE    varchar(30) NOT NULL
    , SITE_CDE     varchar(20) NOT NULL
    , ANNCE_DTE    varchar(20) NOT NULL
    , ANNCE_TM     varchar(20) NOT NULL
    , CNTRY_CDE    varchar(3) NOT NULL
    , ANNCE_CDE    varchar(20) NOT NULL
    , ANNCE_DESC   varchar(1000) NOT NULL
    , IMPACT       varchar(20) NULL
    , ACTUAL       varchar(20) NULL
    , FORECAST     varchar(20) NULL
    , PREVIOUS     varchar(20) NULL
    , CAPTR_DTE_ID int NOT NULL
    , STARTED_AT   date NOT NULL
    , FINISHED_AT  date NOT NULL
    );

    INSERT INTO #TMP_F_DTL_ECONOMIC_CALENDAR_W
    (MSMT_DTE_ID
    ,DATA_TYPE
    ,SITE_CDE
    ,ANNCE_DTE
    ,ANNCE_TM
    ,CNTRY_CDE
    ,ANNCE_CDE
    ,ANNCE_DESC
    ,IMPACT
    ,ACTUAL
    ,FORECAST
    ,PREVIOUS
    ,CAPTR_DTE_ID
    ,STARTED_AT
    ,FINISHED_AT
    )
    SELECT DISTINCT 
           MSMT_DTE_ID
		,DATA_TYPE
		,SITE_CDE
		,ANNCE_DTE
		,ANNCE_TM
		,CNTRY_CDE
		,ANNCE_CDE
		,ANNCE_DESC
		,IMPACT
		,ACTUAL
		,FORECAST
		,PREVIOUS
		,CAPTR_DTE_ID
		,STARTED_AT
		,FINISHED_AT
	 FROM openquery(PY_WEB_DATA,'SELECT DAT.MSMT_DTE_ID
								,DAT.DATA_TYPE
								,DAT.SITE_CDE
								,DAT.ANNCE_DTE
								,DAT.ANNCE_TM 
								,DAT.CNTRY_CDE
								,DAT.ANNCE_CDE
								,DAT.ANNCE_DESC
								,DAT.IMPACT
								,DAT.ACTUAL
								,DAT.FORECAST
								,DAT.PREVIOUS
								,DAT.CAPTR_DTE_ID
								,DAT.STARTED_AT
								,DAT.FINISHED_AT
							 FROM PY_ECONOMIC_CALENDAR AS DAT;');

/*
STEP 2   
---------------------------------------------------------------------------------------------------
** check:
    - if element has changed mark as needing to be updated
    - if element is new mark as needing insertion
** no deletion necessary as we will keep history of older announcements

drop table #TMP_F_DTL_ECONOMIC_CALENDAR_W_DTA
*/
    CREATE TABLE #TMP_F_DTL_ECONOMIC_CALENDAR_W_DTA
    ( ACTION_CDE   varchar(1) NOT NULL
    , MSMT_DTE_ID  int NOT NULL
    , DATA_TYPE    varchar(30) NOT NULL
    , SITE_CDE     varchar(20) NOT NULL
    , ANNCE_DTE    varchar(20) NOT NULL
    , ANNCE_TM     varchar(20) NOT NULL
    , CNTRY_CDE    varchar(3) NOT NULL
    , ANNCE_CDE    varchar(20) NOT NULL
    , ANNCE_DESC   varchar(1000) NOT NULL
    , IMPACT       varchar(20) NULL
    , ACTUAL       varchar(20) NULL
    , FORECAST     varchar(20) NULL
    , PREVIOUS     varchar(20) NULL
    , CAPTR_DTE_ID int NOT NULL
    , STARTED_AT   date NOT NULL
    , FINISHED_AT  date NOT NULL
    );

    INSERT INTO #TMP_F_DTL_ECONOMIC_CALENDAR_W_DTA ( ACTION_CDE
										 , MSMT_DTE_ID
										 , DATA_TYPE
										 , SITE_CDE
										 , ANNCE_DTE
										 , ANNCE_TM
										 , CNTRY_CDE
										 , ANNCE_CDE
										 , ANNCE_DESC
										 , IMPACT
										 , ACTUAL
										 , FORECAST
										 , PREVIOUS
										 , CAPTR_DTE_ID
										 , STARTED_AT
										 , FINISHED_AT
										 )
    SELECT CASE
			 WHEN DEST.MSMT_DTE_ID IS NULL
			 THEN 'I' -- no record found - insert new record
			 WHEN isnull(SRCE.ANNCE_TM, '~') <> isnull(DEST.ANNCE_TM, '~')
				 OR isnull(SRCE.ANNCE_DESC, '~') <> isnull(DEST.ANNCE_DESC, '~')
				 OR isnull(SRCE.IMPACT, '~') <> isnull(DEST.IMPACT, '~')
				 OR isnull(SRCE.ACTUAL, '~') <> isnull(DEST.ACTUAL, '~')
				 OR isnull(SRCE.FORECAST, '~') <> isnull(DEST.FORECAST, '~')
				 OR isnull(SRCE.PREVIOUS, '~') <> isnull(DEST.PREVIOUS, '~')
			 THEN 'U' -- record is found but details have changed - update record
			 ELSE 'N' -- records match - do nothing
		 END AS ACTION_CDE
	    , SRCE.MSMT_DTE_ID
	    , SRCE.DATA_TYPE
	    , SRCE.SITE_CDE
	    , SRCE.ANNCE_DTE
	    , SRCE.ANNCE_TM
	    , SRCE.CNTRY_CDE
	    , SRCE.ANNCE_CDE
	    , SRCE.ANNCE_DESC
	    , SRCE.IMPACT
	    , SRCE.ACTUAL
	    , SRCE.FORECAST
	    , SRCE.PREVIOUS
	    , SRCE.CAPTR_DTE_ID
	    , SRCE.STARTED_AT
	    , SRCE.FINISHED_AT
	 FROM (
		 SELECT DTL.MSMT_DTE_ID
			 , DTL.DATA_TYPE
			 , DTL.SITE_CDE
			 , DTL.ANNCE_DTE
			 , DTL.ANNCE_TM
			 , DTL.CNTRY_CDE
			 , DTL.ANNCE_CDE
			 , DTL.ANNCE_DESC
			 , DTL.IMPACT
			 , DTL.ACTUAL
			 , DTL.FORECAST
			 , DTL.PREVIOUS
			 , rank() OVER(PARTITION BY DTL.MSMT_DTE_ID
								 , DTL.CNTRY_CDE
								 , DTL.ANNCE_CDE ORDER BY DTL.CAPTR_DTE_ID DESC) AS RNK
			 , DTL.CAPTR_DTE_ID
			 , DTL.STARTED_AT
			 , DTL.FINISHED_AT
		   FROM #TMP_F_DTL_ECONOMIC_CALENDAR_W AS DTL
		  WHERE 1 = 1
		 ) AS SRCE
		 LEFT OUTER JOIN LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W AS DEST
		 ON 1 = 1
		    AND SRCE.MSMT_DTE_ID = DEST.MSMT_DTE_ID
		    AND SRCE.CNTRY_CDE = DEST.CNTRY_CDE
		    AND SRCE.ANNCE_CDE = DEST.ANNCE_CDE
	WHERE 1 = 1
		 AND SRCE.RNK = 1;


/*
STEP 3   select * from #TMP_F_DTL_GOVT_KDA_M_DTA where ACTION_CDE = 'U'
---------------------------------------------------------------------------------------------------
** UPDATE and INSERT steps
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)
*/
    UPDATE LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W
	  SET ANNCE_TM = SRCE.ANNCE_TM
	    , ANNCE_DESC = SRCE.ANNCE_DESC
	    , IMPACT = SRCE.IMPACT
	    , ACTUAL = SRCE.ACTUAL
	    , FORECAST = SRCE.FORECAST
	    , PREVIOUS = SRCE.PREVIOUS
	    , CAPTR_DTE_ID = SRCE.CAPTR_DTE_ID
	 FROM LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W AS DEST
		 INNER JOIN #TMP_F_DTL_ECONOMIC_CALENDAR_W_DTA AS SRCE
		 ON 1 = 1
		    AND SRCE.MSMT_DTE_ID = DEST.MSMT_DTE_ID
		    AND SRCE.CNTRY_CDE = DEST.CNTRY_CDE
		    AND SRCE.ANNCE_CDE = DEST.ANNCE_CDE
	WHERE 1 = 1
		 AND SRCE.ACTION_CDE IN('U');
			    

    INSERT INTO LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W ( MSMT_DTE_ID
										, DATA_TYPE
										, SITE_CDE
										, ANNCE_DTE
										, ANNCE_TM
										, CNTRY_CDE
										, ANNCE_CDE
										, ANNCE_DESC
										, IMPACT
										, ACTUAL
										, FORECAST
										, PREVIOUS
										, CAPTR_DTE_ID
										, STARTED_AT
										, FINISHED_AT
										)
    SELECT TMP.MSMT_DTE_ID
	    , TMP.DATA_TYPE
	    , TMP.SITE_CDE
	    , TMP.ANNCE_DTE
	    , TMP.ANNCE_TM
	    , TMP.CNTRY_CDE
	    , TMP.ANNCE_CDE
	    , TMP.ANNCE_DESC
	    , TMP.IMPACT
	    , TMP.ACTUAL
	    , TMP.FORECAST
	    , TMP.PREVIOUS
	    , TMP.CAPTR_DTE_ID
	    , TMP.STARTED_AT
	    , TMP.FINISHED_AT
	 FROM #TMP_F_DTL_ECONOMIC_CALENDAR_W_DTA AS TMP
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

