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
           WHERE NAME = 'VW_RPT_PIP_TICK'
                 AND TYPE = 'v'
          )
   BEGIN
      DROP VIEW DBO.VW_RPT_PIP_TICK
   END;
GO

/* 
===================================================================================================
CREATE VIEW
===================================================================================================
*/

CREATE VIEW DBO.VW_RPT_PIP_TICK
AS
WITH CAL(MSMT_DTE_ID
       , ANNCE_DTTM
       , CRNCY_CDE)
     AS (SELECT DISTINCT
                CAL.MSMT_DTE_ID
              , cast(CAL.ANNCE_DTE+' '+CASE upper(CAL.ANNCE_TM)
                                            WHEN 'ALL DAY'
                                            THEN '00:00'
                                            ELSE CAL.ANNCE_TM
                                       END AS datetime) AS ANNCE_DTTM
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
                                     ) ) -- DONT NEED THIS - ITS HANDLED IN THE FX_LITE SCRIPT TO RESTRICT ON RELEVANT CODES
     SELECT FX.MSMT_DTE_ID
          , FX.FOREX_PAIR
          , FX.CRNCY_CDE
          , FX.EST_DTTM_STAMP
          , FX.AEST_DTTM_STAMP
          , CAL.ANNCE_DTTM AS AEST_ANNCE_TM_STAMP
          , FX.BID_QT
          , FX.ASK_QT
          , FX.ANNCE_DESC_LST
       FROM CAL
            INNER JOIN LTNFX_LITE.DBO.F_DTL_CCY_PAIRS_T AS FX
            ON 1 = 1
               AND CAL.MSMT_DTE_ID = FX.MSMT_DTE_ID
               AND CAL.CRNCY_CDE = FX.CRNCY_CDE
      WHERE 1 = 1
            AND FX.AEST_DTTM_STAMP >= dateadd(SECOND, -10, CAL.ANNCE_DTTM) -- 10 SECONDS PRIOR TO ANNOUNCEMENT
            AND FX.AEST_DTTM_STAMP <= dateadd(SECOND, 90, CAL.ANNCE_DTTM); -- 1.5 MINUTES POST ANNOUNCEMENT
/*==========================================================================================================
 OLD
            AND FX.AEST_DTTM_STAMP >= dateadd(MINUTE, -2, CAL.ANNCE_DTTM) -- 2 MINUTES PRIOR TO ANNOUNCEMENT
            AND FX.AEST_DTTM_STAMP <= dateadd(MINUTE, 5, CAL.ANNCE_DTTM); -- 5 MINUTES POST ANNOUNCEMENT
==========================================================================================================*/
