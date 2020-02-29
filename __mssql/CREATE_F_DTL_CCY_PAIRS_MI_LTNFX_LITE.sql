/*
=======================================================================================================================================================================================================
SUBJECT		 : currency AUDUSD minute bar - minute by minute interval
OBJECT TYPE	 : table
OBJECT NAME     : ltnfx_lite.dbo.f_dtl_ccy_pairs_mi
CREATED BY	 : Harold Delaney
CREATED ON	 : 20171217
SOURCE		 : histdata [ http://www.histdata.com/ ]
PREPERATION	 : history is FTP from site
			   
REMARKS		 : 1) TIMES FROM ECONOMIC_CALENDAR TABLE ARE AUSTRALIAN EASTERN STANDARD TIME (AEST) (MELB/CANB/SYD)
			   2) TIMES FROM THE FX TABLES ARE EASTERN STANDARD TIME (EST) (NEW YORK)
			   3) FX TIMES (EST) ARE CONVERTED TO ALIGN WITH (AEST) 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------
DROP TABLE LTNFX_LITE.DBO.F_DTL_CCY_PAIRS_MI;

CREATE TABLE LTNFX_LITE.DBO.F_DTL_CCY_PAIRS_MI
( MSMT_DTE_ID     int NOT NULL
, FOREX_PAIR      varchar(6) NOT NULL
, EST_DTTM_STAMP  datetime NOT NULL
, AEST_DTTM_STAMP datetime NULL
, OPEN_BID_QT     decimal(22, 6) NOT NULL
, HIGH_BID_QT     decimal(22, 6) NOT NULL
, LOW_BID_QT      decimal(22, 6) NOT NULL
, CLOSE_BID_QT    decimal(22, 6) NOT NULL
, CRNCY_CDE       varchar(3) NOT NULL
, ANNCE_DESC_LST  varchar(1000) NOT NULL
)
ON [PRIMARY];

CREATE NONCLUSTERED INDEX ix_f_dtl_ccy_pairs_mi ON LTNFX_LITE.dbo.f_dtl_ccy_pairs_mi(msmt_dte_id, forex_pair, crncy_cde);

ALTER TABLE LTNFX_LITE.DBO.F_DTL_CCY_PAIRS_MI REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================

exec create_f_dtl_ccy_pairs_mi   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_CCY_PAIRS_T', @p_pkg_nme = 'LTN_PKG_CCY_PAIRS_T'

=======================================================================================================================================================================================================
*/

USE [LTNFX_LITE];
GO

IF OBJECT_ID('create_f_dtl_ccy_pairs_mi') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_ccy_pairs_mi AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_ccy_pairs_mi -- Alter the SP Always
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
         
SET @l_tbl_nme = 'f_dtl_ccy_pairs_mi';

-- DATES -----------------------------------------------------------------
         
DECLARE
    @l_prces_dte_id AS nvarchar(8);

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
** LOAD FOCUS DATES INTO TEMP TABLE
** IF OTHER ANNOUNCEMENTS ARE REQUIRED, ANNCE_CDE CAN BE ADDED HERE AND MISSING DATES WILL BE UPDATED
   IN PROCEEDING STEPS

DROP TABLE #TMP_CALENDAR_DATES
*/
    CREATE TABLE #TMP_CALENDAR_DATES
    (MSMT_DTE_ID    int NOT NULL
    ,ANNCE_DTE      varchar(10) NOT NULL
    ,ANNCE_TM       varchar(5) NOT NULL
    ,ANNCE_DTTM     datetime NOT NULL
    ,CNTRY_CDE      varchar(3) NOT NULL
    ,ANNCE_DESC_LST varchar(1000) NOT NULL
    );

    INSERT INTO #TMP_CALENDAR_DATES ( MSMT_DTE_ID
							 , ANNCE_DTE
							 , ANNCE_TM
							 , ANNCE_DTTM
							 , CNTRY_CDE
							 , ANNCE_DESC_LST
							 )
    SELECT DAT.MSMT_DTE_ID
	    , DAT.ANNCE_DTE
	    , DAT.ANNCE_TM
	    , cast(DAT.ANNCE_DTE+' '+DAT.ANNCE_TM AS datetime) AS ANNCE_DTTM
	    , DAT.CNTRY_CDE
	    , max(CASE
				WHEN DAT.RNK = 1
				THEN DAT.ANNCE_DESC
				ELSE ''
			END)+max(CASE
					    WHEN DAT.RNK = 2
					    THEN ' / '+DAT.ANNCE_DESC
					    ELSE ''
				    END)+max(CASE
							   WHEN DAT.RNK = 3
							   THEN ' / '+DAT.ANNCE_DESC
							   ELSE ''
						   END)+max(CASE
									  WHEN DAT.RNK = 4
									  THEN ' / '+DAT.ANNCE_DESC
									  ELSE ''
								  END)+max(CASE
											 WHEN DAT.RNK = 5
											 THEN ' / '+DAT.ANNCE_DESC
											 ELSE ''
										 END) AS ANNCE_DESC_LST
	 FROM (
		 SELECT CAL.MSMT_DTE_ID
			 , CAL.ANNCE_DTE
			 , CAL.ANNCE_TM
			 , CAL.CNTRY_CDE
			 , '('+CAL.ANNCE_CDE+') '+CAL.ANNCE_DESC AS ANNCE_DESC
			 , rank() OVER(PARTITION BY CAL.MSMT_DTE_ID
								 , CAL.ANNCE_TM
								 , CAL.CNTRY_CDE ORDER BY CAL.ANNCE_CDE) AS RNK
		   FROM LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W AS CAL
		  WHERE 1 = 1
    /*========================================================================
	CODES FROM ECONOMIC CALENDAR TABLE.
			    ** ADD OR REMOVE THESE TO INCLUDE FX DATA FOR DIFFERENT ECONOMIC EVENTS
    ========================================================================*/
			   AND CAL.ANNCE_CDE IN ( '582.75'
							    , '690.38'
							    , '737.62'
							    , '643.12'
							    , '687.75'
							    , '1795.9'
							    , '785.54'
							    , '642.12'
							    )
			   AND CAL.CNTRY_CDE != 'EUR'
		 ) AS DAT
	WHERE 1 = 1
	GROUP BY DAT.MSMT_DTE_ID
		  , DAT.ANNCE_DTE
		  , DAT.ANNCE_TM
		  , DAT.CNTRY_CDE;

/*
STEP 2
---------------------------------------------------------------------------------------------------
** RETURN LIST OF ANNOUNCEMENT DATES THAT DONT HAVE CORRESPONDING FX DATA
** INSERT FX DATA (IF EXISTS) BASED ON THESE DATES

DROP TABLE #TMP_CALENDAR_DATES2
*/
    CREATE TABLE #TMP_CALENDAR_DATES2
    (MSMT_DTE_ID    int NOT NULL
    ,ANNCE_DTE      varchar(10) NOT NULL
    ,ANNCE_TM       varchar(5) NOT NULL
    ,ANNCE_DTTM     datetime NOT NULL
    ,CNTRY_CDE      varchar(3) NOT NULL
    ,ANNCE_DESC_LST varchar(1000) NOT NULL
    );

    INSERT INTO #TMP_CALENDAR_DATES2 ( MSMT_DTE_ID
							  , ANNCE_DTE
							  , ANNCE_TM
							  , ANNCE_DTTM
							  , CNTRY_CDE
							  , ANNCE_DESC_LST
							  )
    SELECT CAL.MSMT_DTE_ID
	    , CAL.ANNCE_DTE
	    , CAL.ANNCE_TM
	    , CAL.ANNCE_DTTM
	    , CAL.CNTRY_CDE
	    , CAL.ANNCE_DESC_LST
	 FROM #TMP_CALENDAR_DATES AS CAL
		 LEFT OUTER JOIN LTNFX_LITE.DBO.F_DTL_CCY_PAIRS_MI AS FX
		 ON 1 = 1
		    AND FX.FOREX_PAIR LIKE '%'+CAL.CNTRY_CDE+'%'
		    AND CAL.MSMT_DTE_ID = FX.MSMT_DTE_ID
		    AND CAL.ANNCE_DTTM = FX.AEST_DTTM_STAMP
	WHERE 1 = 1
		 AND FX.MSMT_DTE_ID IS NULL;
		    
/*
STEP 3
---------------------------------------------------------------------------------------------------
** INSERT NEW RECORDS (FROM ABOVE DATE FILTER) INTO TABLE IF FX DATA EXISTS

*/

    INSERT INTO LTNFX_LITE.DBO.F_DTL_CCY_PAIRS_MI ( MSMT_DTE_ID
										, FOREX_PAIR
										, EST_DTTM_STAMP
										, AEST_DTTM_STAMP
										, OPEN_BID_QT
										, HIGH_BID_QT
										, LOW_BID_QT
										, CLOSE_BID_QT
										, CRNCY_CDE
										, ANNCE_DESC_LST
										)
    SELECT FX.MSMT_DTE_ID
	    , FX.FOREX_PAIR
	    , FX.EST_DTTM_STAMP
	    , FX.AEST_DTTM_STAMP
	    , FX.OPEN_BID_QT
	    , FX.HIGH_BID_QT
	    , FX.LOW_BID_QT
	    , FX.CLOSE_BID_QT
	    , CAL.CNTRY_CDE AS CRNCY_CDE
	    , CAL.ANNCE_DESC_LST
	 FROM #TMP_CALENDAR_DATES AS CAL
		 INNER JOIN (
				  SELECT FX.MSMT_DTE_ID
					  , FX.FOREX_PAIR
					  , FX.EST_DTTM_STAMP
					  , FX.AEST_DTTM_STAMP
					  , FX.OPEN_BID_QT
					  , FX.HIGH_BID_QT
					  , FX.LOW_BID_QT
					  , FX.CLOSE_BID_QT
				    FROM LTNFX.DBO.F_DTL_CCY_PAIRS_MI AS FX --with (index([ix_f_dtl_ccy_pairs_mi]))
				   WHERE 1 = 1
				  ) AS FX
		 ON 1 = 1
		    AND FX.FOREX_PAIR LIKE '%'+CAL.CNTRY_CDE+'%'
		    AND FX.MSMT_DTE_ID = CAL.MSMT_DTE_ID
	WHERE 1 = 1
		 AND FX.MSMT_DTE_ID >= (
						   SELECT min(DTE.MSMT_DTE_ID)
							FROM #TMP_CALENDAR_DATES2 AS DTE
						   )
		 AND FX.AEST_DTTM_STAMP >= dateadd(HOUR, -2, CAL.ANNCE_DTTM)
		 AND FX.AEST_DTTM_STAMP <= dateadd(HOUR, 2, CAL.ANNCE_DTTM);

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