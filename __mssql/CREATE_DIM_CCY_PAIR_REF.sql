/*
=======================================================================================================================================================================================================
SUBJECT		 : forex ref table - listr of currency pairs and the dates we hold for the period measure we hold
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.dim_ccy_pair_ref
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161222
SOURCE		 : 
PREPERATION	 : 
			   
REMARKS		 : 1) 
			   2) 
			   3) 
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.dim_ccy_pair_ref;

CREATE TABLE ltn.dbo.dim_ccy_pair_ref
             (
             pair           varchar(6) not null
           , pair_type      varchar(3) not null
           , period_measure varchar(6) not null
           , start_dte_id   int not null
           , end_dte_id     int not null
		 , last_updated   date not null
             );

CREATE NONCLUSTERED INDEX ix_dim_ccy_pair_ref ON ltn.dbo.dim_ccy_pair_ref(pair);

=======================================================================================================================================================================================================
select * from ltnfx.dbo.dim_ccy_pair_ref

select * from ltn.dbo.ctl_ssis_err_log order by task_end_datetime desc
msmt_dte_id variable used : 20161222 --- error msg : Cannot insert duplicate key row in object 'dbo.dim_ccy_pair_ref' with unique index 'ux_dim_ccy_pair_ref'. The duplicate key value is (AUDCAD).
=======================================================================================================================================================================================================
*/

USE [ltnfx];
GO

IF OBJECT_ID('create_dim_ccy_pair_ref') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_dim_ccy_pair_ref AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_dim_ccy_pair_ref -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
BEGIN
    --SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;
    --SET DATEFIRST 7

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
=======================================================================================================================================================================================================
REF TABLE DATA GENERATION
- inserts all dates and forex pairs held along with the period measure
- easy ref for when querying the detail ccy tables
=======================================================================================================================================================================================================
*/

    TRUNCATE TABLE ltnfx.dbo.dim_ccy_pair_ref;

    INSERT INTO LTNFX.DBO.DIM_CCY_PAIR_REF ( PAIR
								   , PAIR_TYPE
								   , PERIOD_MEASURE
								   , START_DTE_ID
								   , END_DTE_ID
								   , LAST_UPDATED
								   )
    SELECT DAT.PAIR
	    , DAT.PAIR_TYPE
	    , DAT.PERIOD_MEASURE
	    , DAT.START_DTE_ID
	    , DAT.END_DTE_ID
	    , cast(getdate() AS date) AS LAST_UPDATED
	 FROM (
		 SELECT DTL.FOREX_PAIR AS PAIR
			 , CASE
				   WHEN DTL.FOREX_PAIR LIKE '%XAU%'
					   OR DTL.FOREX_PAIR LIKE '%AUX%'
				   THEN 'IDX'
				   ELSE 'CCY'
			   END AS PAIR_TYPE
			 , 'TICK' AS PERIOD_MEASURE
			 , min(DTL.MSMT_DTE_ID) AS START_DTE_ID
			 , max(DTL.MSMT_DTE_ID) AS END_DTE_ID
		   FROM DBO.F_DTL_CCY_PAIRS_T AS DTL
		  WHERE 1 = 1
		  --and forex_pair = 'EURUSD'
		  GROUP BY DTL.FOREX_PAIR
		 UNION ALL
		 SELECT DTL.FOREX_PAIR AS PAIR
			 , CASE
				   WHEN DTL.FOREX_PAIR LIKE '%XAU%'
					   OR DTL.FOREX_PAIR LIKE '%AUX%'
				   THEN 'IDX'
				   ELSE 'CCY'
			   END AS PAIR_TYPE
			 , 'MINUTE' AS PERIOD_MEASURE
			 , min(DTL.MSMT_DTE_ID) AS START_DTE_ID
			 , max(DTL.MSMT_DTE_ID) AS END_DTE_ID
		   FROM DBO.F_DTL_CCY_PAIRS_MI AS DTL
		  WHERE 1 = 1
		  --and forex_pair = 'EURUSD'
		  GROUP BY DTL.FOREX_PAIR
		 ) AS DAT;

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

