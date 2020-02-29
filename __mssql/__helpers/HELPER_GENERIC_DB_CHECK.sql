/*
===================================================================================================
VARS SCRIPTS
===================================================================================================
*/
use LTN

-- CTL_SSIS_VARS SCRIPT
SELECT *
  FROM LTN.DBO.CTL_SSIS_VARS AS VARS
 WHERE 1 = 1
       AND VARS.ENV = 'DEV'
 ORDER BY 1
        , 3
	   , 2
        , 4;

-- PY_VARS_CTL SCRIPT
SELECT *
  FROM LTN.DBO.PY_VARS_CTL AS VARS
 WHERE 1 = 1
       AND VARS.ENV = 'PROD'
 ORDER BY 1
        , 3
        , 2
        , 4;

-- PY_VARS_TWEEP_CTL SCRIPT
SELECT *
  FROM LTN.DBO.PY_VARS_TWEEP_CTL AS VARS
 WHERE 1 = 1
       AND VARS.ENV = 'PROD'
 ORDER BY 1
        , 3
        , 2
        , 4;

/*
===================================================================================================
LOGGING SCRIPTS
===================================================================================================
*/
-- CTL_SSIS_ERR_LOG
SELECT *
  FROM LTN.DBO.CTL_SSIS_ERR_LOG AS ELOG
 WHERE 1 = 1
 ORDER BY ELOG.TASK_END_DATETIME DESC;

-- SYSSSISLOG
SELECT *
  FROM LTN.DBO.SYSSSISLOG
 ORDER BY ENDTIME DESC;

-- DELETE HISTORY OLDER THAN 3 MONTHS (MAYBE AUTOMATE IN SSIS PACKAGE AS TIDY UP EXERCISE)
DELETE FROM LTN.DBO.SYSSSISLOG
 WHERE 1 = 1
       AND ENDTIME < dateadd(MONTH, -3, getdate());


/*
===================================================================================================
JOBS SCRIPTS
===================================================================================================
*/
USE LTN

-- SUMMARY QUERY ----------------------------------------------------------------------------------
SELECT MSMT_DTE_ID
     , CNTRY_CDE
     , count(*) AS ROW_COUNT
     , sum(FACET_CNT) AS JOBS_COUNT
  FROM LTN.DBO.F_DTL_JOB_SCRAPE_D
 WHERE 1 = 1
   AND MSMT_DTE_ID >= convert(varchar(10), dateadd(DAY, -4, getdate()), 112) --20170125
 GROUP BY MSMT_DTE_ID
        , CNTRY_CDE
 ORDER BY CASE CNTRY_CDE
               WHEN 'AU'
               THEN 1
               WHEN 'NZ'
               THEN 2
               WHEN 'UK'
               THEN 3
               WHEN 'CA'
               THEN 4
               WHEN 'US'
               THEN 5
          END
        , 1 DESC;

-- DETAIL QUERY -----------------------------------------------------------------------------------
SELECT max(DAT.MSMT_DTE_ID) AS MSMT_DTE_ID
     , DAT.CNTRY_CDE
     , DAT.SITE_CDE
     , sum(DAT.CURR_ROW_CNT) AS CURR_ROW_CNT
     , sum(DAT.PREV_ROW_CNT) AS PREV_ROW_CNT
     , sum(DAT.CURR_FACET_CNT) AS CURR_FACET_CNT
     , sum(DAT.PREV_FACET_CNT) AS PREV_FACET_CNT
  FROM (
       SELECT MSMT_DTE_ID
            , CNTRY_CDE
            , SITE_CDE
            , CASE
                   WHEN MSMT_DTE_ID = convert(varchar(10), dateadd(DAY, 0, getdate()), 112)
                   THEN count(*)
                   ELSE 0
              END AS CURR_ROW_CNT
            , CASE
                   WHEN MSMT_DTE_ID = convert(varchar(10), dateadd(DAY, -1, getdate()), 112)
                   THEN count(*)
                   ELSE 0
              END AS PREV_ROW_CNT
            , CASE
                   WHEN MSMT_DTE_ID = convert(varchar(10), dateadd(DAY, 0, getdate()), 112)
                   THEN sum(FACET_CNT)
                   ELSE 0
              END AS CURR_FACET_CNT
            , cast(CASE
                        WHEN MSMT_DTE_ID = convert(varchar(10), dateadd(DAY, -1, getdate()), 112)
                        THEN sum(FACET_CNT)
                        ELSE 0
                   END AS integer) AS PREV_FACET_CNT
         FROM LTN.DBO.F_DTL_JOB_SCRAPE_D
        WHERE 1 = 1
              AND CNTRY_CDE = 'AU'
              AND MSMT_DTE_ID >= convert(varchar(10), dateadd(DAY, -1, getdate()), 112)
        GROUP BY MSMT_DTE_ID
               , CNTRY_CDE
               , SITE_CDE
       ) AS DAT
 GROUP BY DAT.CNTRY_CDE
        , DAT.SITE_CDE
ORDER BY 1
       , 2
       , 3;

/*
===================================================================================================
BUSINESSES FOR SALE SCRIPTS
===================================================================================================
*/
-- SUMMARY QUERY ----------------------------------------------------------------------------------

SELECT MSMT_DTE_ID
     , CNTRY_CDE
     , count(*) AS ROW_COUNT
     , sum(FACET_CNT) AS JOBS_COUNT
  FROM LTN.DBO.F_DTL_B4S_SCRAPE_D
 WHERE 1 = 1
       AND MSMT_DTE_ID >= convert(varchar(10), dateadd(DAY, -10, getdate()), 112) --20170125
 GROUP BY MSMT_DTE_ID
        , CNTRY_CDE
 ORDER BY 2
        , 1 DESC;

-- DETAIL QUERY -----------------------------------------------------------------------------------
SELECT max(DAT.MSMT_DTE_ID) AS MSMT_DTE_ID
     , DAT.CNTRY_CDE
     , DAT.SITE_CDE
     , sum(DAT.CURR_ROW_CNT) AS CURR_ROW_CNT
     , sum(DAT.PREV_ROW_CNT) AS PREV_ROW_CNT
     , sum(DAT.CURR_FACET_CNT) AS CURR_FACET_CNT
     , sum(DAT.PREV_FACET_CNT) AS PREV_FACET_CNT
  FROM (
       SELECT MSMT_DTE_ID
            , CNTRY_CDE
            , SITE_CDE
            , CASE
                   WHEN MSMT_DTE_ID = convert(varchar(10), dateadd(DAY, 0, getdate()), 112)
                   THEN count(*)
                   ELSE 0
              END AS CURR_ROW_CNT
            , CASE
                   WHEN MSMT_DTE_ID = convert(varchar(10), dateadd(DAY, -1, getdate()), 112)
                   THEN count(*)
                   ELSE 0
              END AS PREV_ROW_CNT
            , CASE
                   WHEN MSMT_DTE_ID = convert(varchar(10), dateadd(DAY, 0, getdate()), 112)
                   THEN sum(FACET_CNT)
                   ELSE 0
              END AS CURR_FACET_CNT
            , cast(CASE
                        WHEN MSMT_DTE_ID = convert(varchar(10), dateadd(DAY, -1, getdate()), 112)
                        THEN sum(FACET_CNT)
                        ELSE 0
                   END AS integer) AS PREV_FACET_CNT
         FROM LTN.DBO.F_DTL_B4S_SCRAPE_D
        WHERE 1 = 1
              AND MSMT_DTE_ID >= convert(varchar(10), dateadd(DAY, -1, getdate()), 112)
        GROUP BY MSMT_DTE_ID
               , CNTRY_CDE
               , SITE_CDE
       ) AS DAT
 GROUP BY CNTRY_CDE
        , SITE_CDE
ORDER BY 1
       , 3;

/*
===================================================================================================
TWITTER SCRIPTS
===================================================================================================
*/

SELECT MSMT_DTE_ID
     , CNTRY_CDE
     , count(*)
  FROM LTN.DBO.F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D
 WHERE 1 = 1
       AND MSMT_DTE_ID >= convert(varchar(10), dateadd(DAY, -5, getdate()), 112)
 GROUP BY MSMT_DTE_ID
        , CNTRY_CDE
 ORDER BY CASE CNTRY_CDE
               WHEN 'AU'
               THEN 1
               WHEN 'NZ'
               THEN 2
               WHEN 'UK'
               THEN 3
               WHEN 'CA'
               THEN 4
               WHEN 'US'
               THEN 5
          END
        , 1 DESC;

/*
===================================================================================================
COMMODITY SCRIPTS
===================================================================================================
*/
SELECT MSMT_DTE_ID
     , DATA_TYPE
     , TRADE_DT
     , count(*) AS ROW_CNT
     , round(sum(INDEX_VAL), 4) AS INDEX_VAL
     , round(sum(HIGH_VAL), 4) AS HIGH_VAL
     , round(sum(LOW_VAL), 4) AS LOW_VAL
     , round(sum(TTL_MRKT_VAL), 4) AS TTL_MRKT_VAL
  FROM LTN.DBO.F_DTL_COMMODITY_PRICE_D
 WHERE 1 = 1
       AND TRADE_DT >= dateadd(DAY, -10, getdate())
 GROUP BY MSMT_DTE_ID
        , DATA_TYPE
        , TRADE_DT
 ORDER BY 2
        , 1 DESC;

/*
===================================================================================================
LABOUR FORCE SCRIPTS
===================================================================================================
*/
-- LABOUR FORCE STATUS
SELECT *
  FROM ltn.[dbo].[F_DTL_LABOUR_FORCE_STATUS_M]
ORDER BY 2 DESC;

-- ACTUAL - ABS WEBSITE RESULTS (PRE ANY ADJUSTMENTS)
SELECT *
  FROM LTN.DBO.F_DTL_LABOUR_FORCE_STATUS_ACTUAL_M
ORDER BY 2 DESC;


-- LABOUR FORCE HOURS WORKED
SELECT *
  FROM LTN.DBO.F_DTL_LABOUR_FORCE_HRS_WRKD_M
ORDER BY 2 DESC;

-- LABOUR FORCE UNDERUTILISED PERSONS
SELECT *
  FROM LTN.DBO.F_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M
ORDER BY 2 DESC;
  
/*
===================================================================================================
ECONOMIC CALENDAR SCRIPTS
===================================================================================================
*/  

SELECT *
  FROM LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W
ORDER BY MSMT_DTE_ID DESC
       , CNTRY_CDE
       , ANNCE_CDE;
  
/*
===================================================================================================
CCY PAIRS SCRIPTS
===================================================================================================
*/
-- TICK DATA
SELECT *
  FROM LTNFX.DBO.DIM_CCY_PAIR_REF
 WHERE 1 = 1
       AND PERIOD_MEASURE = 'TICK'
       AND PAIR NOT LIKE '%AUD%';

-- MINUTE BAR DATA
SELECT *
  FROM LTNFX.DBO.DIM_CCY_PAIR_REF
 WHERE 1 = 1
       AND PERIOD_MEASURE = 'MINUTE'
 ORDER BY CASE
               WHEN PAIR LIKE '%AUD%'
               THEN 0
               WHEN PAIR LIKE '%CAD%'
               THEN 1
               WHEN PAIR LIKE '%GBP%'
               THEN 2
               WHEN PAIR LIKE '%NZD%'
               THEN 3
               WHEN PAIR LIKE '%USD%'
               THEN 4
               ELSE 5
          END
        , 2;
