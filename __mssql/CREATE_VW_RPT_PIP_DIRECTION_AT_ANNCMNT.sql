/*
THIS VIEW IS TO PROVIDE AN OVERALL MOVEMENT INDICATOR FOR THE KEY ANNOUNCEMENT PERIOD
EG.  IF ABS RELEASES UNEMPLOYMENT FIGURES AT 11:30 THEN THE OVERALL MOVEMENT WAS UP / DOWN / INDIFFERENT?

AIM HERE IS TO QUICKLY TRACK ACTUAL PIP MOVEMENT DIRECTION WITH ANNOUNCEMENT DATA AND JOB AD DATA
SOME BASIC RULES AROUND WHAT UP, DOWN, INDIFFERENT IS AND WHAT IS THE WINDOW OF TIME TO VIEW THIS MOVEMENT NEEDS TO BE APPLIED
*/

USE [LTN]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* 
===================================================================================================
DROP VIEW IF IT ALREADY EXISTS
===================================================================================================
*/
IF EXISTS (
          SELECT 1
            FROM SYS.VIEWS
           WHERE NAME = 'VW_RPT_PIP_DIRECTION_AT_ANNCMNT'
                 AND TYPE = 'v'
          )
   BEGIN
      DROP VIEW DBO.VW_RPT_PIP_DIRECTION_AT_ANNCMNT
   END;
GO

/* 
===================================================================================================
CREATE VIEW
===================================================================================================
*/

CREATE VIEW DBO.VW_RPT_PIP_DIRECTION_AT_ANNCMNT
AS
WITH CAL(MSMT_DTE_ID
       , ANNCE_DTTM
       , ANNCE_DTE
       , ANNCE_TM
       , CRNCY_CDE)
     AS (
     SELECT DISTINCT
            CAL.MSMT_DTE_ID
          , cast(CAL.ANNCE_DTE+' '+CASE upper(CAL.ANNCE_TM)
                                        WHEN 'ALL DAY'
                                        THEN '00:00'
                                        ELSE CAL.ANNCE_TM
                                   END AS datetime) AS ANNCE_DTTM
          , CAL.ANNCE_DTE
          , CAL.ANNCE_TM
          , CAL.CNTRY_CDE AS CRNCY_CDE
       FROM LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W AS CAL
      WHERE 1 = 1
            AND CAL.ANNCE_CDE IN ( '582.75'
                                 , '690.38'
                                 , '643.12'
                                 , '687.75'
                                 , '737.62'
                                 , '1795.9'
                                 , '785.54'
                                 ) )
     SELECT DAT.MSMT_DTE_ID
          , DAT.CRNCY_CDE
          , DAT.CNTRY_ID
          , DAT.ANNCE_DTE
          , DAT.ANNCE_TM
          , DAT.FOREX_PAIR
          , DAT.ANNCE_DESC_LST
/*===============================================================================================================================
** CONCEPTS -------------------------------------------------------------------------------
-- IF PRE-ANNCE IS GREATER THAN POST-ANNCE THEN USE THE MAX PRE-ANNCE VALUE
-- IF PRE-ANNCE IS LESS THAN POST-ANNCE THEN USE THE MIN PRE-ANNCE VALUE
-- IF POST-ANNCE IS GREATER THAN PRE-ANNCE THEN USE MAX POST-ANNCE VALUE
-- IF POST-ANNCE IS LESS THAN PRE-ANNCE THEN USE MIN POST-ANNCE VALUE
-- IN SHORT: IF TREND IS UP FROM PRE-ANNCE, WE WANT TO COMPARE THE LOWEST POINT PRIOR TO ANNCE AND THE HIGHEST POST-ANNCE VALUE
--           IF TREND IS DOWN FROM PRE-ANNCE, WE WANT TO COMPARE THE HIGHEST POINT PRIOR TO ANNCE AND THE LOWEST POST-ANNCE VALUE
===============================================================================================================================*/
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_1MIN_AVG_BID
                 THEN DAT.PRE_ANNC_MAX_BID
                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_1MIN_AVG_BID
                 THEN DAT.PRE_ANNC_MIN_BID
                 ELSE 0
            END AS PRE_ANNC_BID__AVG -- USING AVERAGE PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_1MIN_AVG_ASK
                 THEN DAT.PRE_ANNC_MAX_ASK
                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_AVG_ASK
                 THEN DAT.PRE_ANNC_MIN_ASK
                 ELSE 0
            END AS PRE_ANNC_ASK__AVG -- USING AVERAGE PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN DAT.PRE_ANNC_MIN_BID > DAT.POST_ANNC_1MIN_MIN_BID
                 THEN DAT.PRE_ANNC_MAX_BID
                 WHEN DAT.PRE_ANNC_MIN_BID < DAT.POST_ANNC_1MIN_MIN_BID
                 THEN DAT.PRE_ANNC_MIN_BID
                 ELSE 0
            END AS PRE_ANNC_BID__MAXMIN -- USING MAX/MIN PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN DAT.PRE_ANNC_MIN_ASK > DAT.POST_ANNC_1MIN_MIN_ASK
                 THEN DAT.PRE_ANNC_MAX_ASK
                 WHEN DAT.PRE_ANNC_MIN_ASK < DAT.POST_ANNC_1MIN_MIN_ASK
                 THEN DAT.PRE_ANNC_MIN_ASK
                 ELSE 0
            END AS PRE_ANNC_ASK__MAXMIN -- USING MAX/MIN PRE AND POST VALUES TO DETERMINE DIRECTION
-- 1MINUTE INTERVAL
-- BID -- AVERAGE MODEL
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_1MIN_AVG_BID
                 THEN DAT.POST_ANNC_1MIN_MIN_BID
                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_1MIN_AVG_BID
                 THEN DAT.POST_ANNC_1MIN_MAX_BID
                 ELSE 0
            END AS POST_ANNCE_1MIN_BID__AVG -- USING AVERAGE PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_1MIN_AVG_BID
                 THEN abs(
                          DAT.PRE_ANNC_MAX_BID
                          - DAT.POST_ANNC_1MIN_MIN_BID)
                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_1MIN_AVG_BID
                 THEN abs(
                          DAT.POST_ANNC_1MIN_MAX_BID
                          - DAT.PRE_ANNC_MIN_BID)
                 ELSE 0
            END AS BID_1MIN_PIP_DELTA__AVG -- USING AVERAGE PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_1MIN_AVG_BID
                           THEN DAT.PRE_ANNC_MAX_BID
                           WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_1MIN_AVG_BID
                           THEN DAT.PRE_ANNC_MIN_BID
                           ELSE 0
                      END > CASE
                                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_1MIN_AVG_BID
                                 THEN DAT.POST_ANNC_1MIN_MIN_BID
                                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_1MIN_AVG_BID
                                 THEN DAT.POST_ANNC_1MIN_MAX_BID
                                 ELSE 0
                            END
                 THEN 'DOWN'
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_1MIN_AVG_BID
                           THEN DAT.PRE_ANNC_MAX_BID
                           WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_1MIN_AVG_BID
                           THEN DAT.PRE_ANNC_MIN_BID
                           ELSE 0
                      END < CASE
                                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_1MIN_AVG_BID
                                 THEN DAT.POST_ANNC_1MIN_MIN_BID
                                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_1MIN_AVG_BID
                                 THEN DAT.POST_ANNC_1MIN_MAX_BID
                                 ELSE 0
                            END
                 THEN 'UP'
                 ELSE '??'
            END AS BID_1MIN_TRND__AVG -- USING AVERAGE PRE AND POST VALUES TO DETERMINE DIRECTION
-- BID -- MINMAX MODEL
          , CASE
                 WHEN DAT.PRE_ANNC_MIN_BID > DAT.POST_ANNC_1MIN_MIN_BID
                 THEN DAT.POST_ANNC_1MIN_MIN_BID
                 WHEN DAT.PRE_ANNC_MIN_BID < DAT.POST_ANNC_1MIN_MIN_BID
                 THEN DAT.POST_ANNC_1MIN_MAX_BID
                 ELSE 0
            END AS POST_ANNCE_1MIN_BID__MINMAX
          , CASE
                 WHEN DAT.PRE_ANNC_MIN_BID > DAT.POST_ANNC_1MIN_MIN_BID
                 THEN abs(
                          DAT.PRE_ANNC_MAX_BID
                          - DAT.POST_ANNC_1MIN_MIN_BID)
                 WHEN DAT.PRE_ANNC_MIN_BID < DAT.POST_ANNC_1MIN_MIN_BID
                 THEN abs(
                          DAT.POST_ANNC_1MIN_MAX_BID
                          - DAT.PRE_ANNC_MIN_BID)
                 ELSE 0
            END AS BID_1MIN_PIP_DELTA__MINMAX -- USING MIN/MAX PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_MIN_BID > DAT.POST_ANNC_1MIN_MIN_BID
                           THEN DAT.PRE_ANNC_MAX_BID
                           WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_1MIN_MIN_BID
                           THEN DAT.PRE_ANNC_MIN_BID
                           ELSE 0
                      END > CASE
                                 WHEN DAT.PRE_ANNC_MIN_BID > DAT.POST_ANNC_1MIN_MIN_BID
                                 THEN DAT.POST_ANNC_1MIN_MIN_BID
                                 WHEN DAT.PRE_ANNC_MIN_BID < DAT.POST_ANNC_1MIN_MIN_BID
                                 THEN DAT.POST_ANNC_1MIN_MAX_BID
                                 ELSE 0
                            END
                 THEN 'DOWN'
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_MIN_BID > DAT.POST_ANNC_1MIN_MIN_BID
                           THEN DAT.PRE_ANNC_MAX_BID
                           WHEN DAT.PRE_ANNC_MIN_BID < DAT.POST_ANNC_1MIN_MIN_BID
                           THEN DAT.PRE_ANNC_MIN_BID
                           ELSE 0
                      END < CASE
                                 WHEN DAT.PRE_ANNC_MIN_BID > DAT.POST_ANNC_1MIN_MIN_BID
                                 THEN DAT.POST_ANNC_1MIN_MIN_BID
                                 WHEN DAT.PRE_ANNC_MIN_BID < DAT.POST_ANNC_1MIN_MIN_BID
                                 THEN DAT.POST_ANNC_1MIN_MAX_BID
                                 ELSE 0
                            END
                 THEN 'UP'
                 ELSE '??'
            END AS BID_1MIN_TRND__MINMAX -- USING MIN/MAX PRE AND POST VALUES TO DETERMINE DIRECTION
-- ASK -- AVERAGE MODEL
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_1MIN_AVG_ASK
                 THEN DAT.POST_ANNC_1MIN_MIN_ASK
                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_AVG_ASK
                 THEN DAT.POST_ANNC_1MIN_MAX_ASK
                 ELSE 0
            END AS POST_ANNCE_1MIN_ASK__AVG -- USING AVERAGE PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_1MIN_AVG_ASK
                 THEN abs(
                          DAT.PRE_ANNC_MAX_ASK
                          - DAT.POST_ANNC_1MIN_MIN_ASK)
                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_AVG_ASK
                 THEN abs(
                          DAT.POST_ANNC_1MIN_MAX_ASK
                          - DAT.PRE_ANNC_MIN_ASK)
                 ELSE 0
            END AS ASK_1MIN_PIP_DELTA__AVG -- USING AVERAGE PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_1MIN_AVG_ASK
                           THEN DAT.PRE_ANNC_MAX_ASK
                           WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_AVG_ASK
                           THEN DAT.PRE_ANNC_MIN_ASK
                           ELSE 0
                      END > CASE
                                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_1MIN_AVG_ASK
                                 THEN DAT.POST_ANNC_1MIN_MIN_ASK
                                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_AVG_ASK
                                 THEN DAT.POST_ANNC_1MIN_MAX_ASK
                                 ELSE 0
                            END
                 THEN 'DOWN'
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_1MIN_AVG_ASK
                           THEN DAT.PRE_ANNC_MAX_ASK
                           WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_AVG_ASK
                           THEN DAT.PRE_ANNC_MIN_ASK
                           ELSE 0
                      END < CASE
                                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_1MIN_AVG_ASK
                                 THEN DAT.POST_ANNC_1MIN_MIN_ASK
                                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_AVG_ASK
                                 THEN DAT.POST_ANNC_1MIN_MAX_ASK
                                 ELSE 0
                            END
                 THEN 'UP'
                 ELSE '??'
            END AS ASK_1MIN_TRND__AVG -- USING AVERAGE PRE AND POST VALUES TO DETERMINE DIRECTION
-- ASK -- MINMAX MODEL
          , CASE
                 WHEN DAT.PRE_ANNC_MIN_ASK > DAT.POST_ANNC_1MIN_MIN_ASK
                 THEN DAT.POST_ANNC_1MIN_MIN_ASK
                 WHEN DAT.PRE_ANNC_MIN_ASK < DAT.POST_ANNC_1MIN_MIN_ASK
                 THEN DAT.POST_ANNC_1MIN_MAX_ASK
                 ELSE 0
            END AS POST_ANNCE_1MIN_ASK__MINMAX
          , CASE
                 WHEN DAT.PRE_ANNC_MIN_ASK > DAT.POST_ANNC_1MIN_MIN_ASK
                 THEN abs(
                          DAT.PRE_ANNC_MAX_ASK
                          - DAT.POST_ANNC_1MIN_MIN_ASK)
                 WHEN DAT.PRE_ANNC_MIN_ASK < DAT.POST_ANNC_1MIN_MIN_ASK
                 THEN abs(
                          DAT.POST_ANNC_1MIN_MAX_ASK
                          - DAT.PRE_ANNC_MIN_ASK)
                 ELSE 0
            END AS ASK_1MIN_PIP_DELTA__MINMAX -- USING MIN/MAX PRE AND POST VALUES TO DETERMINE DIRECTION
          , CASE
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_MIN_ASK > DAT.POST_ANNC_1MIN_MIN_ASK
                           THEN DAT.PRE_ANNC_MAX_ASK
                           WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_MIN_ASK
                           THEN DAT.PRE_ANNC_MIN_ASK
                           ELSE 0
                      END > CASE
                                 WHEN DAT.PRE_ANNC_MIN_ASK > DAT.POST_ANNC_1MIN_MIN_ASK
                                 THEN DAT.POST_ANNC_1MIN_MIN_ASK
                                 WHEN DAT.PRE_ANNC_MIN_ASK < DAT.POST_ANNC_1MIN_MIN_ASK
                                 THEN DAT.POST_ANNC_1MIN_MAX_ASK
                                 ELSE 0
                            END
                 THEN 'DOWN'
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_1MIN_MIN_ASK
                           THEN DAT.PRE_ANNC_MAX_ASK
                           WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_1MIN_MIN_ASK
                           THEN DAT.PRE_ANNC_MIN_ASK
                           ELSE 0
                      END < CASE
                                 WHEN DAT.PRE_ANNC_MIN_ASK > DAT.POST_ANNC_1MIN_MIN_ASK
                                 THEN DAT.POST_ANNC_1MIN_MIN_ASK
                                 WHEN DAT.PRE_ANNC_MIN_ASK < DAT.POST_ANNC_1MIN_MIN_ASK
                                 THEN DAT.POST_ANNC_1MIN_MAX_ASK
                                 ELSE 0
                            END
                 THEN 'UP'
                 ELSE '??'
            END AS ASK_1MIN_TRND__MINMAX -- USING MIN/MAX PRE AND POST VALUES TO DETERMINE DIRECTION
/*=====================================================================================
-- 2MINUTE INTERVAL
-- BID
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_2MIN_AVG_BID
                 THEN DAT.POST_ANNC_2MIN_MIN_BID
                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_2MIN_AVG_BID
                 THEN DAT.POST_ANNC_2MIN_MAX_BID
                 ELSE 0
            END AS POST_ANNCE_2MIN_BID
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_2MIN_AVG_BID
                 THEN abs(
                          DAT.PRE_ANNC_MAX_BID
                          - DAT.POST_ANNC_2MIN_MIN_BID)
                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_2MIN_AVG_BID
                 THEN abs(
                          DAT.POST_ANNC_2MIN_MAX_BID
                          - DAT.PRE_ANNC_MIN_BID)
                 ELSE 0
            END AS BID_2MIN_PIP_DELTA
          , CASE
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_2MIN_AVG_BID
                           THEN DAT.PRE_ANNC_MAX_BID
                           WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_2MIN_AVG_BID
                           THEN DAT.PRE_ANNC_MIN_BID
                           ELSE 0
                      END > CASE
                                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_2MIN_AVG_BID
                                 THEN DAT.POST_ANNC_2MIN_MIN_BID
                                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_2MIN_AVG_BID
                                 THEN DAT.POST_ANNC_2MIN_MAX_BID
                                 ELSE 0
                            END
                 THEN 'DOWN'
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_2MIN_AVG_BID
                           THEN DAT.PRE_ANNC_MAX_BID
                           WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_2MIN_AVG_BID
                           THEN DAT.PRE_ANNC_MIN_BID
                           ELSE 0
                      END < CASE
                                 WHEN DAT.PRE_ANNC_AVG_BID > DAT.POST_ANNC_2MIN_AVG_BID
                                 THEN DAT.POST_ANNC_2MIN_MIN_BID
                                 WHEN DAT.PRE_ANNC_AVG_BID < DAT.POST_ANNC_2MIN_AVG_BID
                                 THEN DAT.POST_ANNC_2MIN_MAX_BID
                                 ELSE 0
                            END
                 THEN 'UP'
                 ELSE '??'
            END AS BID_2MIN_TRND
-- ASK
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_2MIN_AVG_ASK
                 THEN DAT.POST_ANNC_2MIN_MIN_ASK
                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_2MIN_AVG_ASK
                 THEN DAT.POST_ANNC_2MIN_MAX_ASK
                 ELSE 0
            END AS POST_ANNCE_2MIN_ASK
          , CASE
                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_2MIN_AVG_ASK
                 THEN abs(
                          DAT.PRE_ANNC_MAX_ASK
                          - DAT.POST_ANNC_2MIN_MIN_ASK)
                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_2MIN_AVG_ASK
                 THEN abs(
                          DAT.POST_ANNC_2MIN_MAX_ASK
                          - DAT.PRE_ANNC_MIN_ASK)
                 ELSE 0
            END AS ASK_2MIN_PIP_DELTA
          , CASE
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_2MIN_AVG_ASK
                           THEN DAT.PRE_ANNC_MAX_ASK
                           WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_2MIN_AVG_ASK
                           THEN DAT.PRE_ANNC_MIN_ASK
                           ELSE 0
                      END > CASE
                                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_2MIN_AVG_ASK
                                 THEN DAT.POST_ANNC_2MIN_MIN_ASK
                                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_2MIN_AVG_ASK
                                 THEN DAT.POST_ANNC_2MIN_MAX_ASK
                                 ELSE 0
                            END
                 THEN 'DOWN'
                 WHEN CASE
                           WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_2MIN_AVG_ASK
                           THEN DAT.PRE_ANNC_MAX_ASK
                           WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_2MIN_AVG_ASK
                           THEN DAT.PRE_ANNC_MIN_ASK
                           ELSE 0
                      END < CASE
                                 WHEN DAT.PRE_ANNC_AVG_ASK > DAT.POST_ANNC_2MIN_AVG_ASK
                                 THEN DAT.POST_ANNC_2MIN_MIN_ASK
                                 WHEN DAT.PRE_ANNC_AVG_ASK < DAT.POST_ANNC_2MIN_AVG_ASK
                                 THEN DAT.POST_ANNC_2MIN_MAX_ASK
                                 ELSE 0
                            END
                 THEN 'UP'
                 ELSE '??'
            END AS ASK_2MIN_TRND
, DAT.PRE_ANNC_MIN_BID
          , DAT.PRE_ANNC_MAX_BID
          , DAT.PRE_ANNC_MIN_ASK
          , DAT.PRE_ANNC_MAX_ASK
-- POST-ANNCE DAT
          , DAT.POST_ANNC_1MIN_MIN_BID
          , DAT.POST_ANNC_1MIN_MAX_BID
          , DAT.POST_ANNC_1MIN_MIN_ASK
          , DAT.POST_ANNC_1MIN_MAX_ASK
          , DAT.POST_ANNC_2MIN_MIN_BID
          , DAT.POST_ANNC_2MIN_MAX_BID
          , DAT.POST_ANNC_2MIN_MIN_ASK
          , DAT.POST_ANNC_2MIN_MAX_ASK
		, DAT.POST_ANNC_3MIN_MIN_BID
          , DAT.POST_ANNC_3MIN_MAX_BID
          , DAT.POST_ANNC_3MIN_MIN_ASK
          , DAT.POST_ANNC_3MIN_MAX_ASK
          , DAT.POST_ANNC_4MIN_MIN_BID
          , DAT.POST_ANNC_4MIN_MAX_BID
          , DAT.POST_ANNC_4MIN_MIN_ASK
          , DAT.POST_ANNC_4MIN_MAX_ASK
          , DAT.POST_ANNC_5MIN_MIN_BID
          , DAT.POST_ANNC_5MIN_MAX_BID
          , DAT.POST_ANNC_5MIN_MIN_ASK
          , DAT.POST_ANNC_5MIN_MAX_ASK
=====================================================================================*/
       FROM (
            SELECT DISTINCT
                   BASE.MSMT_DTE_ID
                 , BASE.CRNCY_CDE
                 , BASE.CNTRY_ID
                 , BASE.ANNCE_DTE
                 , BASE.ANNCE_TM
                 , BASE.FOREX_PAIR
                 , BASE.ANNCE_DESC_LST
--- PRE ANNCE DAT
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, -10, BASE.ANNCE_DTTM) AND dateadd(SECOND, -5, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS PRE_ANNC_MIN_BID
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, -10, BASE.ANNCE_DTTM) AND dateadd(SECOND, -5, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS PRE_ANNC_MAX_BID
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, -10, BASE.ANNCE_DTTM) AND dateadd(SECOND, -5, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS PRE_ANNC_AVG_BID
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, -10, BASE.ANNCE_DTTM) AND dateadd(SECOND, -5, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS PRE_ANNC_MIN_ASK
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, -10, BASE.ANNCE_DTTM) AND dateadd(SECOND, -5, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS PRE_ANNC_MAX_ASK
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, -10, BASE.ANNCE_DTTM) AND dateadd(SECOND, -5, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS PRE_ANNC_AVG_ASK
--- POST ANNCE DAT
--- 1 MINUTE INTERVAL (1 MINUTE FROM ANNOUNCEMENT)
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 1, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_1MIN_MIN_BID
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 1, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_1MIN_MAX_BID
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 1, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_1MIN_AVG_BID
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 1, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_1MIN_MIN_ASK
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 1, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_1MIN_MAX_ASK
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 1, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_1MIN_AVG_ASK
--- 2 MINUTE INTERVAL (2 MINUTE FROM ANNOUNCEMENT)
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 2, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_2MIN_MIN_BID
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 2, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_2MIN_MAX_BID
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 2, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_2MIN_AVG_BID
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 2, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_2MIN_MIN_ASK
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 2, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_2MIN_MAX_ASK
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 2, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_2MIN_AVG_ASK
--- 3 MINUTE INTERVAL (3 MINUTE FROM ANNOUNCEMENT)
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 3, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_3MIN_MIN_BID
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 3, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_3MIN_MAX_BID
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 3, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_3MIN_AVG_BID
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 3, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_3MIN_MIN_ASK
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 3, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_3MIN_MAX_ASK
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 3, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_3MIN_AVG_ASK
--- 4 MINUTE INTERVAL (4 MINUTE FROM ANNOUNCEMENT)
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 4, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_4MIN_MIN_BID
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 4, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_4MIN_MAX_BID
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 4, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_4MIN_AVG_BID
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 4, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_4MIN_MIN_ASK
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 4, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_4MIN_MAX_ASK
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 4, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_4MIN_AVG_ASK
--- 5 MINUTE INTERVAL (5 MINUTE FROM ANNOUNCEMENT)
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 5, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_5MIN_MIN_BID
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 5, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_5MIN_MAX_BID
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 5, BASE.ANNCE_DTTM)
                            THEN BASE.BID_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_5MIN_AVG_BID
                 , min(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 5, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 999999
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_5MIN_MIN_ASK
                 , max(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 5, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_5MIN_MAX_ASK
                 , avg(CASE
                            WHEN BASE.AEST_DTTM_STAMP BETWEEN dateadd(SECOND, 0, BASE.ANNCE_DTTM) AND dateadd(MINUTE, 5, BASE.ANNCE_DTTM)
                            THEN BASE.ASK_QT
                            ELSE 0
                       END) OVER(PARTITION BY BASE.MSMT_DTE_ID
                                            , BASE.CRNCY_CDE
                                            , BASE.FOREX_PAIR) AS POST_ANNC_5MIN_AVG_ASK
              FROM (
                   SELECT CAL.MSMT_DTE_ID
                        , CAL.CRNCY_CDE
                        , CASE CAL.CRNCY_CDE
                               WHEN 'AUD'
                               THEN 'AU'
                               WHEN 'CAD'
                               THEN 'CA'
                               WHEN 'NZD'
                               THEN 'NZ'
                               WHEN 'GBP'
                               THEN 'UK'
                               WHEN 'USD'
                               THEN 'US'
                               ELSE 'UKNWN'
                          END AS CNTRY_ID
                        , CAL.ANNCE_DTTM
                        , CAL.ANNCE_DTE
                        , CAL.ANNCE_TM
                        , FX.FOREX_PAIR
                        , FX.ANNCE_DESC_LST
                        , FX.AEST_DTTM_STAMP
                        , avg(FX.BID_QT) AS BID_QT -- multiple values at sime time - average to get single return (not sure if this is the right approach as some instance have largish pip movements eg. 0.00140)
                        , avg(FX.ASK_QT) AS ASK_QT -- multiple values at sime time - average to get single return (not sure if this is the right approach as some instance have largish pip movements eg. 0.00140)
                     FROM CAL
                          INNER JOIN LTNFX_LITE.DBO.F_DTL_CCY_PAIRS_T AS FX
                          ON 1 = 1
                             AND CAL.MSMT_DTE_ID = FX.MSMT_DTE_ID
                             AND CAL.CRNCY_CDE = FX.CRNCY_CDE
--- TESTING
--AND FX.FOREX_PAIR = 'AUDUSD'
--AND CAL.MSMT_DTE_ID = 20170615
                    GROUP BY CAL.MSMT_DTE_ID
                           , CAL.CRNCY_CDE
                           , CASE CAL.CRNCY_CDE
                                  WHEN 'AUD'
                                  THEN 'AU'
                                  WHEN 'CAD'
                                  THEN 'CA'
                                  WHEN 'NZD'
                                  THEN 'NZ'
                                  WHEN 'GBP'
                                  THEN 'UK'
                                  WHEN 'USD'
                                  THEN 'US'
                                  ELSE 'UKNWN'
                             END
                           , CAL.ANNCE_DTTM
                           , CAL.ANNCE_DTE
                           , CAL.ANNCE_TM
                           , FX.FOREX_PAIR
                           , FX.ANNCE_DESC_LST
                           , FX.AEST_DTTM_STAMP
                           , FX.BID_QT
                           , FX.ASK_QT
                   ) AS BASE
             WHERE 1 = 1
            ) AS DAT
      WHERE 1 = 1;
