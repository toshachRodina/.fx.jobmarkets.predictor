/*
=======================================================================================================================================================================================================
SUBJECT		 : index commodoties minute bar - minute by minute (min) interval 
OBJECT TYPE	 : table
OBJECT NAME     : ltnfx.dbo.f_dtl_idx_pairs_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161121
SOURCE		 : histdata [ http://www.histdata.com/ ]
PREPERATION	 : history is FTP from site
                  live data?
			   
REMARKS		 : 1) 
			   2) 
			   3)
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltnfx.dbo.stg_idx_pairs_mi;

CREATE TABLE LTNFX.DBO.STG_IDX_PAIRS_MI
( IDX_PAIR     varchar(50)
, DT_TM_STAMP  varchar(50)
, OPEN_BID_QT  varchar(50)
, HIGH_BID_QT  varchar(50)
, LOW_BID_QT   varchar(50)
, CLOSE_BID_QT varchar(50)
, VOLUME       varchar(50)
);

DROP TABLE ltnfx.dbo.f_dtl_idx_pairs_mi;

CREATE TABLE ltnfx.dbo.f_dtl_idx_pairs_mi
             (
             msmt_dte_id     int NOT NULL
           , idx_pair      varchar(6) NOT NULL
           , aedt_dttm_stamp datetime NOT NULL
           , edt_dttm_stamp  datetime NOT NULL
           , open_bid_qt     decimal(22, 6) NOT NULL
           , high_bid_qt     decimal(22, 6) NOT NULL
           , low_bid_qt      decimal(22, 6) NOT NULL
           , close_bid_qt    decimal(22, 6) NOT NULL
             );

CREATE NONCLUSTERED INDEX ix_f_dtl_idx_pairs_mi ON ltnfx.dbo.f_dtl_idx_pairs_mi(msmt_dte_id, idx_pair );

ALTER TABLE ltnfx.dbo.f_dtl_idx_pairs_mi REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_ccy_pairs_mi   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_CCY_PAIRS_MI', @p_pkg_nme = 'LTN_PKG_CCY_PAIRS_MI'

select * from ltn.dbo.f_dtl_ccy_pairs_mi order by 3

select * from ltn.dbo.ctl_ssis_err_log order by task_end_datetime desc
=======================================================================================================================================================================================================
*/


USE [ltnfx];
GO

IF OBJECT_ID('create_f_dtl_idx_pairs_mi') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_idx_pairs_mi AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_idx_pairs_mi -- Alter the SP Always
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
         
         SET @l_tbl_nme = 'f_dtl_idx_pairs_mi';

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
** convert date time stamp varchar into actual date time
** convert bid and ask values into decimal
*/

				CREATE TABLE #tmp_dtl_idx_pairs_mi_s1
						   (
						   idx_pair      varchar(6) NOT NULL
						 , edt_dt_tm_stamp datetime NOT NULL
						 , open_bid_qt     decimal(22, 6) NOT NULL
						 , high_bid_qt     decimal(22, 6) NOT NULL
						 , low_bid_qt      decimal(22, 6) NOT NULL
						 , close_bid_qt    decimal(22, 6) NOT NULL
						   );

				INSERT INTO #tmp_dtl_idx_pairs_mi_s1
					  (idx_pair
					 , edt_dt_tm_stamp
					 , open_bid_qt
					 , high_bid_qt
					 , low_bid_qt
					 , close_bid_qt
					  )
				SELECT stg.idx_pair
					, CONVERT( varchar, CONVERT(datetime, SUBSTRING(stg.dt_tm_stamp, 1, 8)), 111)+' '+SUBSTRING(SUBSTRING(stg.dt_tm_stamp, 9, 7), 1, 2)+':'+SUBSTRING(SUBSTRING(stg.dt_tm_stamp, 9, 7), 3, 2)+':00' AS edt_dt_tm_stamp--+SUBSTRING(SUBSTRING(stg.dt_tm_stamp, 10, 7), 5, 2)
					, CAST(stg.open_bid_qt AS    decimal(22, 6)) AS open_bid_qt
					, CAST(stg.high_bid_qt AS    decimal(22, 6)) AS high_bid_qt
					, CAST(stg.low_bid_qt AS    decimal(22, 6)) AS low_bid_qt
					, CAST(stg.close_bid_qt AS    decimal(22, 6)) AS close_bid_qt
					  FROM
						  ltnfx.dbo.stg_idx_pairs_mi AS stg;


/*
STEP 2 
---------------------------------------------------------------------------------------------------
** insert into final f_dtl table 
** calculate msmt_dte_id from the transaction date
** calculate aedt (australian eastern daylight time)
*/

				INSERT INTO ltnfx.dbo.f_dtl_idx_pairs_mi
					  (msmt_dte_id
					 , idx_pair
					 , aedt_dttm_stamp
					 , edt_dttm_stamp
					 , open_bid_qt
					 , high_bid_qt
					 , low_bid_qt
					 , close_bid_qt
					  )
				SELECT CONVERT( varchar(8), CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, s1.edt_dt_tm_stamp), DATENAME(tzoffset, SYSDATETIMEOFFSET()))), 112) msmt_dte_id
					, s1.idx_pair
					, CONVERT( datetime, SWITCHOFFSET(CONVERT(datetimeoffset, s1.edt_dt_tm_stamp), DATENAME(tzoffset, SYSDATETIMEOFFSET()))) AS aedt_dt_tm_stamp
					, s1.edt_dt_tm_stamp
					, s1.open_bid_qt
					, s1.high_bid_qt
					, s1.low_bid_qt
					, s1.close_bid_qt
					  FROM
						  #tmp_dtl_idx_pairs_mi_s1 AS s1
						  order by 3;
						 
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
