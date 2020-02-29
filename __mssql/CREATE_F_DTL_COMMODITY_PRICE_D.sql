/*
=======================================================================================================================================================================================================
SUBJECT         : commodity web data from python/beautifulsoup
OBJECT TYPE     : table
OBJECT NAME     : ltn.dbo.f_dtl_commodity_price_d
CREATED BY      : Harold Delaney
CREATED ON      : 20170320
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

DROP TABLE LTN.DBO.F_DTL_COMMODITY_PRICE_D;

CREATE TABLE LTN.DBO.F_DTL_COMMODITY_PRICE_D
( MSMT_DTE_ID  int NOT NULL
, DATA_TYPE    varchar(20) NOT NULL
, TRADE_DT     varchar(50) NOT NULL
, INDEX_VAL    numeric(22,2) NOT NULL
, HIGH_VAL     numeric(22,2) NOT NULL
, LOW_VAL      numeric(22,2) NOT NULL
, TTL_MRKT_VAL numeric(22,0) NOT NULL
, DIV_MRKT_VAL numeric(22,0) NOT NULL
, CAPTR_DTE_ID int NOT NULL
, STARTED_AT   datetime NOT NULL
, FINISHED_AT  datetime NOT NULL
);

CREATE NONCLUSTERED INDEX UX_F_DTL_F_DTL_COMMODITY_PRICE_D ON LTN.DBO.F_DTL_COMMODITY_PRICE_D ( MSMT_DTE_ID, DATA_TYPE );

ALTER TABLE LTN.DBO.F_DTL_COMMODITY_PRICE_D REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec CREATE_F_DTL_COMMODITY_PRICE_D   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_COMMODITY_PRICE_D', @p_pkg_nme = 'LTN_PKG_F_DTL_COMMODITY_PRICE_D'

select * from #TMP_DTL_COMMODITY_PRICE_D




select data_type, count(*) from LTN.DBO.F_DTL_COMMODITY_PRICE_D group by data_type

INSERT INTO LTN.DBO.F_DTL_COMMODITY_PRICE_D ( MSMT_DTE_ID
                                            , STARTED_AT
                                            , FINISHED_AT
                                            , DATA_TYPE
                                            , TRADE_DTTM
                                            , PRICE
                                            , OPEN_PRICE
                                            , HIGH_PRICE
                                            , LOW_PRICE
                                            , VOLUME
                                            , PRCNT_CHNGE
                                            )
SELECT DT.MSMT_DTE_ID
     , STARTED_AT
     , FINISHED_AT
     , DATA_TYPE
     , TRADE_DTTM
     , replace(PRICE,',','') as PRICE
     , replace(OPEN_PRICE,',','') as OPEN_PRICE
     , replace(HIGH_PRICE,',','') HIGH_PRICE
     , replace(LOW_PRICE,',','') as LOW_PRICE
     , isnull(cast(1 * (CASE len(ltrim(rtrim(replace(replace(upper(VOLUME), 'K', ''),'M',''))))-1
            WHEN 2
            THEN cast(ltrim(rtrim(replace(replace(upper(VOLUME), 'K', ''),'M',''))) AS decimal(3, 2))
            WHEN 3
            THEN cast(ltrim(rtrim(replace(replace(upper(VOLUME), 'K', ''),'M',''))) AS decimal(4, 2))
            WHEN 4
            THEN cast(ltrim(rtrim(replace(replace(upper(VOLUME), 'K', ''),'M',''))) AS decimal(5, 2))
            WHEN 5
            THEN cast(ltrim(rtrim(replace(replace(upper(VOLUME), 'K', ''),'M',''))) AS decimal(6, 2))
            WHEN 6
            THEN cast(ltrim(rtrim(replace(replace(upper(VOLUME), 'K', ''),'M',''))) AS decimal(7, 2))
            WHEN 7
            THEN cast(ltrim(rtrim(replace(replace(upper(VOLUME), 'K', ''),'M',''))) AS decimal(8, 2))
       END) * case when charindex('K', upper(VOLUME)) > 0 then 1000 when charindex('M', upper(VOLUME)) > 0 then 1000000 else 1 end
	  as int),0) AS VOLUME
     , PRCNT_CHNGE
  FROM (
       SELECT cast(reverse(substring(reverse(replace(date, ',','')), 1, charindex(' ', reverse(replace(date, ',','')))-1))+'-'+CASE upper(substring(replace(date, ',',''), 1, charindex(' ', replace(date, ',',''))-1))
                                                                                                  WHEN 'JAN'
                                                                                                  THEN '01'
                                                                                                  WHEN 'FEB'
                                                                                                  THEN '02'
                                                                                                  WHEN 'MAR'
                                                                                                  THEN '03'
                                                                                                  WHEN 'APR'
                                                                                                  THEN '04'
                                                                                                  WHEN 'MAY'
                                                                                                  THEN '05'
                                                                                                  WHEN 'JUN'
                                                                                                  THEN '06'
                                                                                                  WHEN 'JUL'
                                                                                                  THEN '07'
                                                                                                  WHEN 'AUG'
                                                                                                  THEN '08'
                                                                                                  WHEN 'SEP'
                                                                                                  THEN '09'
                                                                                                  WHEN 'OCT'
                                                                                                  THEN '10'
                                                                                                  WHEN 'NOV'
                                                                                                  THEN '11'
                                                                                                  WHEN 'DEC'
                                                                                                  THEN '12'
                                                                                                  ELSE '00'
                                                                                             END+'-'+left(substring(replace(date, ',',''), charindex(' ', replace(date, ',',''))+1, len(replace(date, ',',''))), charindex(' ', substring(replace(date, ',',''), charindex(' ', replace(date, ',',''))+2, len(replace(date, ',',''))))) AS date) AS MSMT_DTE
            , '' AS STARTED_AT
            , '' AS FINISHED_AT
            , 'COCOA' AS DATA_TYPE
            , '' AS TRADE_DTTM
            , DAT.PRICE
            , DAT.[OPEN] AS OPEN_PRICE
            , DAT.HIGH AS HIGH_PRICE
            , DAT.LOW AS LOW_PRICE
            , case when DAT.VOL = '-' then '0' else DAT.VOL end  AS VOLUME
            , [CHANGE %] AS PRCNT_CHNGE
    FROM --ltn.[dbo].[tmp_commodity_cocoa] AS DAT
       ) AS DAT2
       LEFT OUTER JOIN DBO.DIM_DTE AS DT
       ON 1 = 1
          AND MSMT_DTE = DTE_ID
 WHERE 1 = 1
       AND MSMT_DTE_ID < 20170320
	  order by 9 ;


=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_commodity_price_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_commodity_price_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_commodity_price_d -- Alter the SP Always
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
         
         SET @l_tbl_nme = 'f_dtl_commodity_price_d';
	    SET @l_stg_tbl_nme = 'stg_dtl_commodity_price_d';
         
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

drop table #TMP_DTL_COMMODITY_PRICE_D
*/
		  
    CREATE TABLE #TMP_DTL_COMMODITY_PRICE_D
    ( MSMT_DTE_ID  int NOT NULL
    , DATA_TYPE    varchar(20) NOT NULL
    , TRADE_DT     varchar(50) NOT NULL
    , INDEX_VAL    numeric(22, 2) NOT NULL
    , HIGH_VAL     numeric(22, 2) NOT NULL
    , LOW_VAL      numeric(22, 2) NOT NULL
    , TTL_MRKT_VAL numeric(22, 0) NOT NULL
    , DIV_MRKT_VAL numeric(22, 0) NOT NULL
    , CAPTR_DTE_ID int NOT NULL
    , STARTED_AT   datetime NOT NULL
    , FINISHED_AT  datetime NOT NULL
    );
    
    INSERT INTO #TMP_DTL_COMMODITY_PRICE_D ( MSMT_DTE_ID
								   , DATA_TYPE
								   , TRADE_DT
								   , INDEX_VAL
								   , HIGH_VAL
								   , LOW_VAL
								   , TTL_MRKT_VAL
								   , DIV_MRKT_VAL
								   , CAPTR_DTE_ID
								   , STARTED_AT
								   , FINISHED_AT
								   )
    SELECT MSMT_DTE_ID
	    , DATA_TYPE
	    , TRADE_DT
	    , CASE
			 WHEN isnumeric(INDEX_VAL) = 1
			 THEN convert( numeric(22, 2), INDEX_VAL)
			 ELSE 0
		 END AS INDEX_VAL
	    , CASE
			 WHEN isnumeric(HIGH_VAL) = 1
			 THEN convert( numeric(22, 2), HIGH_VAL)
			 ELSE 0
		 END AS HIGH_VAL
	    , CASE
			 WHEN isnumeric(LOW_VAL) = 1
			 THEN convert( numeric(22, 2), LOW_VAL)
			 ELSE 0
		 END AS LOW_VAL
	    , CASE
			 WHEN isnumeric(TTL_MRKT_VAL) = 1
			 THEN convert( numeric(22, 0), TTL_MRKT_VAL)
			 ELSE 0
		 END AS TTL_MRKT_VAL
	    , CASE
			 WHEN isnumeric(DIV_MRKT_VAL) = 1
			 THEN convert( numeric(22, 0), DIV_MRKT_VAL)
			 ELSE 0
		 END AS DIV_MRKT_VAL
	    , CAPTR_DTE_ID
	    , STARTED_AT
	    , FINISHED_AT
	 FROM openquery(PY_WEB_DATA, 'SELECT DAT.MSMT_DTE_ID
								    , DAT.DATA_TYPE
								    , DAT.TRADE_DT
								    , DAT.INDEX_VAL
								    , DAT.HIGH_VAL
								    , DAT.LOW_VAL
								    , DAT.TTL_MRKT_VAL
								    , DAT.DIV_MRKT_VAL
								    , DAT.CAPTR_DTE_ID
								    , DAT.STARTED_AT
								    , DAT.FINISHED_AT
								    FROM PY_COMMODITY_DATA AS DAT;');

/*
STEP 2   
---------------------------------------------------------------------------------------------------
** check:
    - if element has changed mark as needing to be updated
    - if element is new mark as needing insertion
** no deletion necessary as we will keep history of older announcements

drop table #TMP_DTL_COMMODITY_PRICE_D_DTA
*/
    CREATE TABLE #TMP_DTL_COMMODITY_PRICE_D_DTA
    ( ACTION_CDE  varchar(1) NOT NULL
    , MSMT_DTE_ID  int NOT NULL
    , DATA_TYPE    varchar(20) NOT NULL
    , TRADE_DT     varchar(50) NOT NULL
    , INDEX_VAL    numeric(22, 2) NOT NULL
    , HIGH_VAL     numeric(22, 2) NOT NULL
    , LOW_VAL      numeric(22, 2) NOT NULL
    , TTL_MRKT_VAL numeric(22, 0) NOT NULL
    , DIV_MRKT_VAL numeric(22, 0) NOT NULL
    , CAPTR_DTE_ID int NOT NULL
    , STARTED_AT   datetime NOT NULL
    , FINISHED_AT  datetime NOT NULL
    );

    INSERT INTO #TMP_DTL_COMMODITY_PRICE_D_DTA ( ACTION_CDE
									  , MSMT_DTE_ID
									  , DATA_TYPE
									  , TRADE_DT
									  , INDEX_VAL
									  , HIGH_VAL
									  , LOW_VAL
									  , TTL_MRKT_VAL
									  , DIV_MRKT_VAL
									  , CAPTR_DTE_ID
									  , STARTED_AT
									  , FINISHED_AT
									  )
    SELECT CASE
			 WHEN DEST.MSMT_DTE_ID IS NULL
			 THEN 'I' -- no record found - insert new record
			 WHEN isnull(SRCE.INDEX_VAL, 0) <> isnull(DEST.INDEX_VAL, 0)
				 OR isnull(SRCE.HIGH_VAL, 0) <> isnull(DEST.HIGH_VAL, 0)
				 OR isnull(SRCE.LOW_VAL, 0) <> isnull(DEST.LOW_VAL, 0)
				 OR isnull(SRCE.TTL_MRKT_VAL, 0) <> isnull(DEST.TTL_MRKT_VAL, 0)
				 OR isnull(SRCE.DIV_MRKT_VAL, 0) <> isnull(DEST.DIV_MRKT_VAL, 0)
			 THEN 'U' -- record is found but details have changed - update record
			 ELSE 'N' -- records match - do nothing
		 END AS ACTION_CDE
	    , SRCE.MSMT_DTE_ID
	    , SRCE.DATA_TYPE
	    , SRCE.TRADE_DT
	    , SRCE.INDEX_VAL
	    , SRCE.HIGH_VAL
	    , SRCE.LOW_VAL
	    , SRCE.TTL_MRKT_VAL
	    , SRCE.DIV_MRKT_VAL
	    , SRCE.CAPTR_DTE_ID
	    , SRCE.STARTED_AT
	    , SRCE.FINISHED_AT
	 FROM #TMP_DTL_COMMODITY_PRICE_D AS SRCE
		 LEFT OUTER JOIN LTN.DBO.F_DTL_COMMODITY_PRICE_D AS DEST
		 ON 1 = 1
		    AND SRCE.TRADE_DT = DEST.TRADE_DT
		    AND SRCE.DATA_TYPE = DEST.DATA_TYPE;


/*
STEP 3  
---------------------------------------------------------------------------------------------------
** UPDATE and INSERT steps
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)

select * from #TMP_F_DTL_GOVT_KDA_M_DTA
*/

    UPDATE LTN.DBO.F_DTL_COMMODITY_PRICE_D
	  SET INDEX_VAL = SRCE.INDEX_VAL
	    , HIGH_VAL = SRCE.HIGH_VAL
	    , LOW_VAL = SRCE.LOW_VAL
	    , TTL_MRKT_VAL = SRCE.TTL_MRKT_VAL
	    , CAPTR_DTE_ID = SRCE.CAPTR_DTE_ID
	 FROM LTN.DBO.F_DTL_COMMODITY_PRICE_D DEST
		 INNER JOIN #TMP_DTL_COMMODITY_PRICE_D_DTA SRCE
		 ON 1 = 1
		    AND SRCE.TRADE_DT = DEST.TRADE_DT
		    AND SRCE.DATA_TYPE = DEST.DATA_TYPE
	WHERE 1 = 1
		 AND SRCE.ACTION_CDE IN ( 'U' );
			    
    INSERT INTO LTN.DBO.F_DTL_COMMODITY_PRICE_D ( MSMT_DTE_ID
									   , DATA_TYPE
									   , TRADE_DT
									   , INDEX_VAL
									   , HIGH_VAL
									   , LOW_VAL
									   , TTL_MRKT_VAL
									   , DIV_MRKT_VAL
									   , CAPTR_DTE_ID
									   , STARTED_AT
									   , FINISHED_AT
									   )
    SELECT TMP.MSMT_DTE_ID
	    , TMP.DATA_TYPE
	    , TMP.TRADE_DT
	    , TMP.INDEX_VAL
	    , TMP.HIGH_VAL
	    , TMP.LOW_VAL
	    , TMP.TTL_MRKT_VAL
	    , TMP.DIV_MRKT_VAL
	    , TMP.CAPTR_DTE_ID
	    , TMP.STARTED_AT
	    , TMP.FINISHED_AT
	 FROM #TMP_DTL_COMMODITY_PRICE_D_DTA AS TMP
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
   SELECT convert(                        varchar(10), cast(getdate() AS date), 112) AS MSMT_DTE_ID
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
        , 'msmt_dte_id variable used : '+convert( varchar(10), cast(getdate() AS date), 112)+' --- error msg : '+error_message();

END
    CATCH;

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/

END;

