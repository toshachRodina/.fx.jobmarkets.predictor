/*
=======================================================================================================================================================================================================
SUBJECT		 : currency AUDUSD tick - second by second (tick) interval AUDUSD currency pairs
OBJECT TYPE	 : table
OBJECT NAME     : ltnfx.dbo.f_dtl_ccy_pairs_t
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161110
SOURCE		 : histdata [ http://www.histdata.com/ ]
PREPERATION	 : history is FTP from site
                  live data?
			   
REMARKS		 : 1) 
			   2) 
			   3)
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltnfx.dbo.stg_ccy_pairs_t;

CREATE TABLE LTNFX.DBO.STG_CCY_PAIRS_T
( FOREX_PAIR  nvarchar(50)
, DT_TM_STAMP varchar(50)
, BID_QT      varchar(50)
, ASK_QT      varchar(50)
, VOLUME      varchar(50)
);

DROP TABLE LTNFX.DBO.F_DTL_CCY_PAIRS_T;

CREATE TABLE LTNFX.DBO.F_DTL_CCY_PAIRS_T
( MSMT_DTE_ID     int NOT NULL
, FOREX_PAIR      varchar(6) NOT NULL
, EST_DTTM_STAMP  datetime NOT NULL
, AEST_DTTM_STAMP datetime NOT NULL
, BID_QT          decimal(22, 6) NOT NULL
, ASK_QT          decimal(22, 6) NOT NULL
);

CREATE NONCLUSTERED INDEX ix_f_dtl_ccy_pairs_t ON ltnfx.dbo.f_dtl_ccy_pairs_t(msmt_dte_id, forex_pair );

ALTER TABLE LTNFX.DBO.F_DTL_CCY_PAIRS_T REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_ccy_pairs_t   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_CCY_PAIRS_T', @p_pkg_nme = 'LTN_PKG_CCY_PAIRS_T'

select * from ltnfx.dbo.f_dtl_ccy_pairs_t order by 3

select * from ltnfx.dbo.ctl_ssis_err_log order by task_end_datetime desc
=======================================================================================================================================================================================================
*/

USE [ltnfx];
GO

IF OBJECT_ID('create_f_dtl_ccy_pairs_t') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_ccy_pairs_t AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_ccy_pairs_t -- Alter the SP Always
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
DECLARE @l_tbl_nme AS nvarchar(50);

SET @l_tbl_nme = 'f_dtl_ccy_pairs_t';

-- DATES -----------------------------------------------------------------
DECLARE @l_prces_dte_id AS nvarchar(8);

SET @l_prces_dte_id = convert(varchar(10), cast(cast(getdate() AS date) AS date), 112);
	    
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
** convert date time stamp varchar into actual date time
** convert bid and ask values into decimal
*/

    CREATE TABLE #TMP_DTL_CCY_PAIRS_T_S1
    ( FOREX_PAIR      varchar(6) NOT NULL
    , EST_DTTM_STAMP  datetime NOT NULL
    , AEST_DTTM_STAMP datetime NOT NULL
    , BID_QT          decimal(22, 6) NOT NULL
    , ASK_QT          decimal(22, 6) NOT NULL
    );

    INSERT INTO #TMP_DTL_CCY_PAIRS_T_S1 ( FOREX_PAIR
								, EST_DTTM_STAMP
								, AEST_DTTM_STAMP
								, BID_QT
								, ASK_QT
								)
    SELECT DAT.FOREX_PAIR
	    , DAT.EST_DTTM_STAMP
	    , convert(datetime, DAT.EST_DTTM_STAMP) AT TIME ZONE 'Eastern Standard Time' -- TIME ZONE OF DATETIME BEING EVALUATED
		 AT TIME ZONE 'AUS Eastern Standard Time' -- TIME ZONE TO CONVERT TO
		 AS AEST_DTTM_STAMP
	    , DAT.BID_QT
	    , DAT.ASK_QT
	 FROM (
		 SELECT ltrim(rtrim(STG.FOREX_PAIR)) AS FOREX_PAIR
			 , convert(varchar, convert(datetime, substring(STG.DT_TM_STAMP, 1, 8)), 111)+' '+substring(substring(STG.DT_TM_STAMP, 10, 7), 1, 2)+':'+substring(substring(STG.DT_TM_STAMP, 10, 7), 3, 2)+':'+substring(substring(STG.DT_TM_STAMP, 10, 7), 5, 2) AS EST_DTTM_STAMP
			 , cast(STG.BID_QT AS decimal(22, 6)) AS BID_QT
			 , cast(STG.ASK_QT AS decimal(22, 6)) AS ASK_QT
		   FROM LTNFX.DBO.STG_CCY_PAIRS_T AS STG
		 ) AS DAT;

/*
STEP 2 
---------------------------------------------------------------------------------------------------
** insert into final f_dtl table if data not already existing
** calculate msmt_dte_id from the transaction date aest
** calculate aedt (australian eastern standard time)
*/

    INSERT INTO LTNFX.DBO.F_DTL_CCY_PAIRS_T ( MSMT_DTE_ID
								    , FOREX_PAIR
								    , EST_DTTM_STAMP
								    , AEST_DTTM_STAMP
								    , BID_QT
								    , ASK_QT
								    )
    SELECT convert(varchar(8), S1.AEST_DTTM_STAMP, 112) AS MSMT_DTE_ID
	    , S1.FOREX_PAIR
	    , S1.EST_DTTM_STAMP
	    , S1.AEST_DTTM_STAMP
	    , S1.BID_QT
	    , S1.ASK_QT
	 FROM #TMP_DTL_CCY_PAIRS_T_S1 AS S1
		 LEFT OUTER JOIN LTNFX.DBO.F_DTL_CCY_PAIRS_T AS FX
		 ON 1 = 1
		    AND S1.FOREX_PAIR = FX.FOREX_PAIR
		    AND convert(varchar(8), S1.AEST_DTTM_STAMP, 112) = FX.MSMT_DTE_ID
		    AND S1.AEST_DTTM_STAMP = FX.AEST_DTTM_STAMP
	WHERE 1 = 1
		 AND FX.MSMT_DTE_ID IS NULL
	ORDER BY 3;
						 
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

END CATCH;

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/
END;
