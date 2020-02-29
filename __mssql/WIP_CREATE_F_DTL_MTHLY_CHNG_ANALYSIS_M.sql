/*
** JOB SCRAPING
** ANNOUNCEMENT KEY DATA POINTS
** FX MOVEMENTS TICKS  -- DONE
** 
*/



/* 
=======================================================================================================================================================================================================
FX MOVEMENTS
FOR THE FOCUS PERIOD
** CAPTURE BASE PERIOD (@l_start_tp_sec) PRIOR TO FOCUS PERIOD
   NB:  CA, AUDCAD, 20161007 HAS LARGER DATA GAPS THAN MOST PERIODS AND REQUIRES A WIDER WINDOW TO LOOK BACK ON (EG. NEED TO USE 13 SECONDS AS BASE RATHER THAN SUGGESTED 10
** MEASURE FROM BASE PERIOD, 5 SEC, 10 SEC, 20 SEC AND 30 SEC PERIODS WITH DELTA AND % DELTAS (POSSIBLY REQUIRE FINER GROUPINGS)
=======================================================================================================================================================================================================
*/

declare @l_start_tp_sec as integer
set @l_start_tp_sec = -10

SELECT DAT2.MSMT_DTE_ID
	, convert( nvarchar(6), cast(DAT2.FOCUS_DTTM_AEDT_AEST as date), 112) AS ANNCE_YR_MTH
	, convert( nvarchar(6), cast(dateadd(MONTH, -1, DAT2.FOCUS_DTTM_AEDT_AEST) as date), 112) AS FOR_YR_MTH
     , DAT2.CNTRY_CDE
     , DAT2.FOCUS_DTTM_AEDT_AEST
     , DAT2.FOREX_PAIR
       ------ BASE PRICES
     , cast(sum(DAT2.TP5SEC_MIN_BID_QT) AS decimal(10, 6)) AS BASE_START_BID_QT
     , cast(sum(DAT2.TP5SEC_MIN_ASK_QT) AS decimal(10, 6)) AS BASE_START_ASK_QT
       ------ TP5SEC     
     , cast(sum(DAT2.TP5SEC_MAX_BID_QT) AS decimal(10, 6)) AS TP5SEC_END_BID_QT
     , cast(sum(DAT2.TP5SEC_MAX_BID_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP5SEC_MIN_BID_QT) AS decimal(10, 6)) AS TP5SEC_BID_DELTA
     , cast(round( ( ( cast(sum(DAT2.TP5SEC_MAX_BID_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP5SEC_MIN_BID_QT) AS decimal(10, 6)) ) / cast(sum(DAT2.TP5SEC_MIN_BID_QT) AS decimal(10, 6)) ) * 100, 6) AS decimal(10, 6)) AS TP5SEC_BID_PRCNT_DELTA
     , cast(sum(DAT2.TP5SEC_MAX_ASK_QT) AS decimal(10, 6)) AS TP5SEC_END_ASK_QT
     , cast(sum(DAT2.TP5SEC_MAX_ASK_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP5SEC_MIN_ASK_QT) AS decimal(10, 6)) AS TP5SEC_ASK_DELTA
     , cast(round( ( ( cast(sum(DAT2.TP5SEC_MAX_ASK_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP5SEC_MIN_ASK_QT) AS decimal(10, 6)) ) / cast(sum(DAT2.TP5SEC_MIN_ASK_QT) AS decimal(10, 6)) ) * 100, 6) AS decimal(10, 6)) AS TP5SEC_ASK_PRCNT_DELTA
       ------ TP510EC
     , cast(sum(DAT2.TP10SEC_MAX_BID_QT) AS decimal(10, 6)) AS TP10SEC_END_BID_QT
     , cast(sum(DAT2.TP10SEC_MAX_BID_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP10SEC_MIN_BID_QT) AS decimal(10, 6)) AS TP10SEC_BID_DELTA
     , cast(round( ( ( cast(sum(DAT2.TP10SEC_MAX_BID_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP10SEC_MIN_BID_QT) AS decimal(10, 6)) ) / cast(sum(DAT2.TP10SEC_MIN_BID_QT) AS decimal(10, 6)) ) * 100, 6) AS decimal(10, 6)) AS TP10SEC_BID_PRCNT_DELTA
     , cast(sum(DAT2.TP10SEC_MAX_ASK_QT) AS decimal(10, 6)) AS TP10SEC_END_ASK_QT
     , cast(sum(DAT2.TP10SEC_MAX_ASK_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP10SEC_MIN_ASK_QT) AS decimal(10, 6)) AS TP10SEC_ASK_DELTA
     , cast(round( ( ( cast(sum(DAT2.TP10SEC_MAX_ASK_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP10SEC_MIN_ASK_QT) AS decimal(10, 6)) ) / cast(sum(DAT2.TP10SEC_MIN_ASK_QT) AS decimal(10, 6)) ) * 100, 6) AS decimal(10, 6)) AS TP10SEC_ASK_PRCNT_DELTA
       ------ TP520EC
     , cast(sum(DAT2.TP20SEC_MAX_BID_QT) AS decimal(10, 6)) AS TP20SEC_END_BID_QT
     , cast(sum(DAT2.TP20SEC_MAX_BID_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP20SEC_MIN_BID_QT) AS decimal(10, 6)) AS TP20SEC_BID_DELTA
     , cast(round( ( ( cast(sum(DAT2.TP20SEC_MAX_BID_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP20SEC_MIN_BID_QT) AS decimal(10, 6)) ) / cast(sum(DAT2.TP20SEC_MIN_BID_QT) AS decimal(10, 6)) ) * 100, 6) AS decimal(10, 6)) AS TP20SEC_BID_PRCNT_DELTA
     , cast(sum(DAT2.TP20SEC_MAX_ASK_QT) AS decimal(10, 6)) AS TP20SEC_END_ASK_QT
     , cast(sum(DAT2.TP20SEC_MAX_ASK_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP20SEC_MIN_ASK_QT) AS decimal(10, 6)) AS TP20SEC_ASK_DELTA
     , cast(round( ( ( cast(sum(DAT2.TP20SEC_MAX_ASK_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP20SEC_MIN_ASK_QT) AS decimal(10, 6)) ) / cast(sum(DAT2.TP20SEC_MIN_ASK_QT) AS decimal(10, 6)) ) * 100, 6) AS decimal(10, 6)) AS TP20SEC_ASK_PRCNT_DELTA
       ------ TP530EC
     , cast(sum(DAT2.TP30SEC_MAX_BID_QT) AS decimal(10, 6)) AS TP30SEC_END_BID_QT
     , cast(sum(DAT2.TP30SEC_MAX_BID_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP30SEC_MIN_BID_QT) AS decimal(10, 6)) AS TP30SEC_BID_DELTA
     , cast(round( ( ( cast(sum(DAT2.TP30SEC_MAX_BID_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP30SEC_MIN_BID_QT) AS decimal(10, 6)) ) / cast(sum(DAT2.TP30SEC_MIN_BID_QT) AS decimal(10, 6)) ) * 100, 6) AS decimal(10, 6)) AS TP30SEC_BID_PRCNT_DELTA
     , cast(sum(DAT2.TP30SEC_MAX_ASK_QT) AS decimal(10, 6)) AS TP30SEC_END_ASK_QT
     , cast(sum(DAT2.TP30SEC_MAX_ASK_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP30SEC_MIN_ASK_QT) AS decimal(10, 6)) AS TP30SEC_ASK_DELTA
     , cast(round( ( ( cast(sum(DAT2.TP30SEC_MAX_ASK_QT) AS decimal(10, 6)) - cast(sum(DAT2.TP30SEC_MIN_ASK_QT) AS decimal(10, 6)) ) / cast(sum(DAT2.TP30SEC_MIN_ASK_QT) AS decimal(10, 6)) ) * 100, 6) AS decimal(10, 6)) AS TP30SEC_ASK_PRCNT_DELTA
  FROM (
       SELECT DAT1.MSMT_DTE_ID
            , DAT1.CNTRY_CDE
            , DAT1.FOCUS_DTTM_AEDT_AEST
            , DAT1.FOREX_PAIR
              ------ TP5SEC
              ------ BID
            , CASE
                   WHEN DAT1.TP5SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = min(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP5SEC)
                             THEN DAT1.BID_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP5SEC_MIN_BID_QT
            , CASE
                   WHEN DAT1.TP5SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = max(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP5SEC)
                             THEN DAT1.BID_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP5SEC_MAX_BID_QT
              ------ ASK
            , CASE
                   WHEN DAT1.TP5SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = min(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP5SEC)
                             THEN DAT1.ASK_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP5SEC_MIN_ASK_QT
            , CASE
                   WHEN DAT1.TP5SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = max(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP5SEC)
                             THEN DAT1.ASK_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP5SEC_MAX_ASK_QT
              ------ TP10SEC
            , CASE
                   WHEN DAT1.TP10SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = min(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP10SEC)
                             THEN DAT1.BID_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP10SEC_MIN_BID_QT
            , CASE
                   WHEN DAT1.TP10SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = max(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP10SEC)
                             THEN DAT1.BID_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP10SEC_MAX_BID_QT
              ------ ASK
            , CASE
                   WHEN DAT1.TP10SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = min(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP10SEC)
                             THEN DAT1.ASK_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP10SEC_MIN_ASK_QT
            , CASE
                   WHEN DAT1.TP10SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = max(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP10SEC)
                             THEN DAT1.ASK_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP10SEC_MAX_ASK_QT
              ------ TP20SEC
              ------ BID
            , CASE
                   WHEN DAT1.TP20SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = min(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP20SEC)
                             THEN DAT1.BID_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP20SEC_MIN_BID_QT
            , CASE
                   WHEN DAT1.TP20SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = max(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP20SEC)
                             THEN DAT1.BID_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP20SEC_MAX_BID_QT
              ------ ASK
            , CASE
                   WHEN DAT1.TP20SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = min(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP20SEC)
                             THEN DAT1.ASK_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP20SEC_MIN_ASK_QT
            , CASE
                   WHEN DAT1.TP20SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = max(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP20SEC)
                             THEN DAT1.ASK_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP20SEC_MAX_ASK_QT
              ------ TP30SEC
              ------ BID
            , CASE
                   WHEN DAT1.TP30SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = min(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP30SEC)
                             THEN DAT1.BID_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP30SEC_MIN_BID_QT
            , CASE
                   WHEN DAT1.TP30SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = max(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP30SEC)
                             THEN DAT1.BID_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP30SEC_MAX_BID_QT
              ------ ASK
            , CASE
                   WHEN DAT1.TP30SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = min(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP30SEC)
                             THEN DAT1.ASK_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP30SEC_MIN_ASK_QT
            , CASE
                   WHEN DAT1.TP30SEC = 1
                   THEN CASE
                             WHEN DAT1.AEDT_DTTM_STAMP = max(DAT1.AEDT_DTTM_STAMP) OVER(PARTITION BY DAT1.MSMT_DTE_ID
                                                                                                   , DAT1.CNTRY_CDE
                                                                                                   , DAT1.FOREX_PAIR
                                                                                                   , DAT1.TP30SEC)
                             THEN DAT1.ASK_QT
                             ELSE 0
                        END
                   ELSE NULL
              END AS TP30SEC_MAX_ASK_QT
         FROM (
              SELECT FX.MSMT_DTE_ID
                   , FX.CNTRY_CDE
                   , FX.FOCUS_DTTM_AEDT_AEST
                   , FX.FOREX_PAIR
                   , FX.AEDT_DTTM_STAMP
                   , CASE
                          WHEN FX.AEDT_DTTM_STAMP BETWEEN dateadd(SECOND,
                                                                  CASE
                                                                       WHEN FX.CNTRY_CDE = 'CA'
                                                                            AND FX.FOREX_PAIR = 'AUDCAD'
                                                                            AND FX.MSMT_DTE_ID = 20161007
                                                                       THEN-13
                                                                       ELSE @l_start_tp_sec
                                                                  END, FX.FOCUS_DTTM_AEDT_AEST) AND dateadd(SECOND, 5, FX.FOCUS_DTTM_AEDT_AEST)
                          THEN 1
                          ELSE 0
                     END AS TP5SEC
                   , CASE
                          WHEN FX.AEDT_DTTM_STAMP BETWEEN dateadd(SECOND,
                                                                  CASE
                                                                       WHEN FX.CNTRY_CDE = 'CA'
                                                                            AND FX.FOREX_PAIR = 'AUDCAD'
                                                                            AND FX.MSMT_DTE_ID = 20161007
                                                                       THEN-13
                                                                       ELSE @l_start_tp_sec
                                                                  END, FX.FOCUS_DTTM_AEDT_AEST) AND dateadd(SECOND, 10, FX.FOCUS_DTTM_AEDT_AEST)
                          THEN 1
                          ELSE 0
                     END AS TP10SEC
                   , CASE
                          WHEN FX.AEDT_DTTM_STAMP BETWEEN dateadd(SECOND,
                                                                  CASE
                                                                       WHEN FX.CNTRY_CDE = 'CA'
                                                                            AND FX.FOREX_PAIR = 'AUDCAD'
                                                                            AND FX.MSMT_DTE_ID = 20161007
                                                                       THEN-13
                                                                       ELSE @l_start_tp_sec
                                                                  END, FX.FOCUS_DTTM_AEDT_AEST) AND dateadd(SECOND, 20, FX.FOCUS_DTTM_AEDT_AEST)
                          THEN 1
                          ELSE 0
                     END AS TP20SEC
                   , CASE
                          WHEN FX.AEDT_DTTM_STAMP BETWEEN dateadd(SECOND,
                                                                  CASE
                                                                       WHEN FX.CNTRY_CDE = 'CA'
                                                                            AND FX.FOREX_PAIR = 'AUDCAD'
                                                                            AND FX.MSMT_DTE_ID = 20161007
                                                                       THEN-13
                                                                       ELSE @l_start_tp_sec
                                                                  END, FX.FOCUS_DTTM_AEDT_AEST) AND dateadd(SECOND, 30, FX.FOCUS_DTTM_AEDT_AEST)
                          THEN 1
                          ELSE 0
                     END AS TP30SEC
                   , avg(FX.BID_QT) AS BID_QT
                   , avg(FX.ASK_QT) AS ASK_QT
                FROM LTNFX_LITE.DBO.F_DTL_CCY_PAIRS_T AS FX
                     INNER JOIN LTNFX_LITE.DBO.DIM_FOCUS_DTE AS FOC
                     ON 1 = 1
                        AND FX.MSMT_DTE_ID = convert( varchar(10), cast(cast(FOC.FOCUS_DTTM_AEDT_AEST AS date) AS date), 112)
                        AND FX.CNTRY_CDE = FOC.CNTRY_CDE
               WHERE 1 = 1
                     AND FX.AEDT_DTTM_STAMP BETWEEN dateadd(SECOND,
                                                            CASE
                                                                 WHEN FX.CNTRY_CDE = 'CA'
                                                                      AND FX.FOREX_PAIR = 'AUDCAD'
                                                                      AND FX.MSMT_DTE_ID = 20161007
                                                                 THEN-13
                                                                 ELSE @l_start_tp_sec
                                                            END, FX.FOCUS_DTTM_AEDT_AEST) AND dateadd(SECOND, 30, FX.FOCUS_DTTM_AEDT_AEST)
               GROUP BY FX.MSMT_DTE_ID
                      , FX.CNTRY_CDE
                      , FX.FOCUS_DTTM_AEDT_AEST
                      , FX.FOREX_PAIR
                      , FX.AEDT_DTTM_STAMP
              ) AS DAT1
        WHERE 1 = 1
       ) AS DAT2
 WHERE 1 = 1
 GROUP BY DAT2.MSMT_DTE_ID
        , DAT2.CNTRY_CDE
        , DAT2.FOCUS_DTTM_AEDT_AEST
        , DAT2.FOREX_PAIR
 ORDER BY DAT2.CNTRY_CDE
        , DAT2.FOREX_PAIR
        , DAT2.MSMT_DTE_ID
        , DAT2.FOCUS_DTTM_AEDT_AEST;



/* 
=======================================================================================================================================================================================================
JOB SCRAPING
FOR MONTH
** RETURN TREND (UP, DOWN, SIDEWAYS)
** QUANTIFY MOVEMENT (% CHANGE FROM START OF PERIOD TO END OF PERIOD
=======================================================================================================================================================================================================
*/


/*
** INSERT QUERY TO BULK LOAD 
SELECT 'INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES (''' + dat.CNTRY_CDE + ''', ''' + dat.SITE_CDE + ''', ' + case when dat.CNTRY_CDE = 'AU' AND dat.SITE_CDE like 'JORA%' then '''N''' else '''Y''' end + ');'
  FROM (
       SELECT DISTINCT
              CNTRY_CDE
            , SITE_CDE
         FROM LTN.DBO.F_DTL_JOB_SCRAPE_D
       ) AS DAT
 ORDER BY dat.CNTRY_CDE, dat.SITE_CDE;

UPDATE #TMP_SITE_CDE_INCL
   SET INCL_FLAG = 'N'
 WHERE CNTRY_CDE = 'AU'
       AND SITE_CDE LIKE 'JORA%';

DROP TABLE #TMP_SITE_CDE_INCL;
*/

CREATE TABLE #TMP_SITE_CDE_INCL
( CNTRY_CDE  varchar(2) NOT NULL
, SITE_CDE   varchar(20) NOT NULL
, INCL_FLAG  varchar(1) NOT NULL
);

INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'ADZUNA', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'CAREERJET', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'GUMTREE', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'HAYS', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'INDEED', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'JOBSEARCH', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'JOBSERVE', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'JORA', 'N');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'JORAX2', 'N');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('AU', 'SEEK', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('CA', 'CAREERBUILDER', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('CA', 'CAREERJET', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('CA', 'INDEED', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('CA', 'JOBBANK', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('CA', 'JOBSERVE', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('CA', 'WORKOPOLIS', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('NZ', 'CAREERJET', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('NZ', 'INDEED', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('NZ', 'JORA', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('NZ', 'JORAX2', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('NZ', 'MYJOBSPACE', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('NZ', 'SEEK', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('NZ', 'TRADEME', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'CAREERJET', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'INDEED', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'JOBSEARCH', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'JOBSERVE', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'JOBSITE', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'JORA', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'JORAX2', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'REED', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'TOTALJOBS', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('UK', 'UNIVERSAL', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('US', 'CAREERBUILDER', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('US', 'CAREERJET', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('US', 'INDEED', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('US', 'JOBSERVE', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('US', 'JORA', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('US', 'JORAX2', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('US', 'SIMPLYHIRED', 'Y');
INSERT INTO #TMP_SITE_CDE_INCL (CNTRY_CDE, SITE_CDE, INCL_FLAG) VALUES ('US', 'THELADDERS', 'Y');


DROP TABLE #TMP_TIME_SHFT_REF

CREATE TABLE #TMP_TIME_SHFT_REF
( CNTRY_CDE  varchar(2) NOT NULL
, DAYS_SHIFT integer NOT NULL
);

INSERT INTO #TMP_TIME_SHFT_REF (CNTRY_CDE, DAYS_SHIFT) VALUES ('AU', 42);
INSERT INTO #TMP_TIME_SHFT_REF (CNTRY_CDE, DAYS_SHIFT) VALUES ('CA', 42);
INSERT INTO #TMP_TIME_SHFT_REF (CNTRY_CDE, DAYS_SHIFT) VALUES ('NZ', 42);
INSERT INTO #TMP_TIME_SHFT_REF (CNTRY_CDE, DAYS_SHIFT) VALUES ('UK', 42);
INSERT INTO #TMP_TIME_SHFT_REF (CNTRY_CDE, DAYS_SHIFT) VALUES ('US', 42);

SELECT DAT2.FOR_YR_MTH
     , DAT2.ANNCE_YR_MTH
     , DAT2.DATA_TYPE
     , DAT2.CNTRY_CDE
     , DAT2.FACET_CNT_TTL
     , sum(DAT2.START_PERIOD_FACET_CNT) AS START_PERIOD_FACET_CNT
     , sum(DAT2.END_PERIOD_FACET_CNT) AS END_PERIOD_FACET_CNT
  FROM (
       SELECT DISTINCT
              DAT1.FOR_YR_MTH
            , DAT1.ANNCE_YR_MTH
            , DAT1.DATA_TYPE
            , DAT1.CNTRY_CDE
              --, DAT1.SITE_CDE
            , sum(DAT1.FACET_CNT) OVER(PARTITION BY DAT1.FOR_YR_MTH
                                                  , DAT1.DATA_TYPE
                                                  , DAT1.CNTRY_CDE) AS FACET_CNT_TTL
            , CASE
                   WHEN DAT1.START_PERIOD_IND = 1
                   THEN sum(DAT1.FACET_CNT) OVER(PARTITION BY DAT1.FOR_YR_MTH
                                                            , DAT1.DATA_TYPE
                                                            , DAT1.CNTRY_CDE
                                                            , DAT1.START_PERIOD_IND)
                   ELSE 0
              END AS START_PERIOD_FACET_CNT
            , CASE
                   WHEN DAT1.END_PERIOD_IND = 1
                   THEN sum(DAT1.FACET_CNT) OVER(PARTITION BY DAT1.FOR_YR_MTH
                                                            , DAT1.DATA_TYPE
                                                            , DAT1.CNTRY_CDE
                                                            , DAT1.END_PERIOD_IND)
                   ELSE 0
              END AS END_PERIOD_FACET_CNT
         FROM (
              SELECT JOBS.MSMT_DTE_ID
                   , REF.DAYS_SHIFT
                   , convert( varchar(10), cast(cast(cast(dateadd(DAY, REF.DAYS_SHIFT, convert(varchar(20), convert(date, convert(varchar(8), JOBS.MSMT_DTE_ID), 112), 120)) AS date) AS date) AS date), 112) AS MSMT_DTE_SHFT_ID
                   , cast(dateadd(DAY, REF.DAYS_SHIFT, convert(    varchar(20), convert(date, convert(varchar(8), JOBS.MSMT_DTE_ID), 112), 120)) AS date) AS MSMT_DTE_SHFT
                   , CASE
                          WHEN cast(dateadd(DAY, REF.DAYS_SHIFT, convert(    varchar(20), convert(date, convert(varchar(8), JOBS.MSMT_DTE_ID), 112), 120)) AS date) = DTE.FIRST_DAY_OF_MONTH
                          THEN 1
                          ELSE 0
                     END AS START_PERIOD_IND
                   , CASE
                          WHEN cast(dateadd(DAY, REF.DAYS_SHIFT, convert(    varchar(20), convert(date, convert(varchar(8), JOBS.MSMT_DTE_ID), 112), 120)) AS date) = DTE.LAST_DAY_OF_MONTH
                          THEN 1
                          ELSE 0
                     END AS END_PERIOD_IND
                   , convert( nvarchar(6), cast(dateadd(DAY, REF.DAYS_SHIFT, convert(varchar(20), convert(date, convert(varchar(8), JOBS.MSMT_DTE_ID), 112), 120)) AS date), 112) AS FOR_YR_MTH
			    , convert( nvarchar(6), dateadd(MONTH, 1, cast(dateadd(DAY, REF.DAYS_SHIFT, convert(varchar(20), convert(date, convert(varchar(8), JOBS.MSMT_DTE_ID), 112), 120)) AS date)), 112) AS ANNCE_YR_MTH
                   , 'JOBS' AS DATA_TYPE
                   , JOBS.CNTRY_CDE
                   , JOBS.SITE_CDE
                   , 'INDUSTRY' AS FACET_TYPE
                   , JOBS.FACET_DESC
                   , JOBS.FACET_CNT
                FROM LTN.DBO.F_DTL_JOB_SCRAPE_D AS JOBS
                     LEFT OUTER JOIN #TMP_SITE_CDE_INCL AS SITES
                     ON 1 = 1
                        AND JOBS.CNTRY_CDE = SITES.CNTRY_CDE
                        AND JOBS.SITE_CDE = SITES.SITE_CDE
                     LEFT OUTER JOIN #TMP_TIME_SHFT_REF AS REF
                     ON 1 = 1
                        AND JOBS.CNTRY_CDE = REF.CNTRY_CDE
                     LEFT OUTER JOIN LTN.DBO.DIM_DTE AS DTE
                     ON 1 = 1
                        AND convert( varchar(10), cast(cast(cast(dateadd(DAY, REF.DAYS_SHIFT, convert(varchar(20), convert(date, convert(varchar(8), JOBS.MSMT_DTE_ID), 112), 120)) AS date) AS date) AS date), 112) = DTE.MSMT_DTE_ID
               WHERE 1 = 1
                     AND convert(nvarchar(6), cast(dateadd(DAY, REF.DAYS_SHIFT, convert(varchar(20), convert(date, convert(varchar(8), JOBS.MSMT_DTE_ID), 112), 120)) AS date), 112) > 201611
                     AND SITES.INCL_FLAG = 'Y'
                     AND JOBS.FACET_TYPE IN ( 'INDUSTRY' -- INDUSTRY
                                            , 'SECTOR' -- INDUSTRY
                                            , 'SECTORS' -- INDUSTRY
                                            , 'CATEGORY' -- INDUSTRY
                                            , 'INDUSTRIES' -- INDUSTRY
                     )
              ) AS DAT1
        WHERE 1 = 1
       ) AS DAT2
 WHERE 1 = 1
 GROUP BY DAT2.FOR_YR_MTH
        , DAT2.ANNCE_YR_MTH
        , DAT2.DATA_TYPE
        , DAT2.CNTRY_CDE
        , DAT2.FACET_CNT_TTL
 HAVING not(sum(DAT2.START_PERIOD_FACET_CNT) = 0)
     and not(sum(DAT2.END_PERIOD_FACET_CNT) = 0)
 ORDER BY DAT2.CNTRY_CDE
        , DAT2.FOR_YR_MTH;

