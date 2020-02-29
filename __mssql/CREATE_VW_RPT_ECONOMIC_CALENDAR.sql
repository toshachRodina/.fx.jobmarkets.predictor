USE [LTN]
GO

/****** Object:  View [dbo].[vw_rpt_jobs_all]    Script Date: 12/11/2017 3:07:07 PM ******/
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
           WHERE NAME = 'VW_RPT_ECONOMIC_CALENDAR'
                 AND TYPE = 'v'
          )
   BEGIN
      DROP VIEW DBO.VW_RPT_ECONOMIC_CALENDAR
   END;
GO

/* 
===================================================================================================
CREATE VIEW
===================================================================================================
*/

CREATE VIEW DBO.VW_RPT_ECONOMIC_CALENDAR
AS
SELECT DAT.MSMT_DTE_ID
     , DAT.DTE_ID
     , DAT.WEEKDAY_NME_SHRT
     , DAT.WORKDAY_IND
     , DAT.ANNCE_TM
     , DAT.CNTRY_CDE
     , DAT.CNTRY_DESC
     , DAT.CRNCY_CDE
     , DAT.ANNCE_DESC
     , DAT.IMPACT_VAL
     , DAT.IMPACT
     , DAT.ACTUAL
     , DAT.FORECAST
     , DAT.PREVIOUS
     , DAT.VAL_TYPE
     , DAT.PREVIOUS_STRIPPED
     , DAT.FORECAST_STRIPPED
     , DAT.ACTUAL_STRIPPED
     ,
       DAT.ACTUAL_STRIPPED
       - DAT.FORECAST_STRIPPED AS FORCAST_PRCSN_DIFF
     ,cast(case when DAT.ACTUAL_STRIPPED = 0 then 0 else
       ( 
        ( 
         DAT.ACTUAL_STRIPPED
         - DAT.FORECAST_STRIPPED )
        / DAT.ACTUAL_STRIPPED )
       * 100 end as numeric(22,2)) AS FORCAST_PRCSN_PRCNT_DIFF
  FROM (
       SELECT DTE.MSMT_DTE_ID
            , DTE.DTE_ID
            , DTE.WEEKDAY_NME_SHRT
            , DTE.WORKDAY_IND
            , isnull(CAL.ANNCE_TM, '') AS ANNCE_TM
            , isnull(CASE CAL.CNTRY_CDE
                          WHEN 'AUD'
                          THEN 'AU'
                          WHEN 'NZD'
                          THEN 'NZ'
                          WHEN 'CAD'
                          THEN 'CA'
                          WHEN 'GBP'
                          THEN 'UK'
                          WHEN 'USD'
                          THEN 'US'
                          WHEN 'EUR'
                          THEN 'EU'
                          WHEN 'CNY'
                          THEN 'CH'
                          WHEN 'JPY'
                          THEN 'JP'
                          WHEN 'CHF'
                          THEN 'SW'
                          ELSE ''
                     END, '') AS CNTRY_CDE
            , isnull(CASE CAL.CNTRY_CDE
                          WHEN 'AUD'
                          THEN 'Australia'
                          WHEN 'NZD'
                          THEN 'New Zealand'
                          WHEN 'CAD'
                          THEN 'Canada'
                          WHEN 'GBP'
                          THEN 'United Kingdom'
                          WHEN 'USD'
                          THEN 'United States'
                          WHEN 'EUR'
                          THEN 'European Union'
                          WHEN 'CNY'
                          THEN 'China'
                          WHEN 'JPY'
                          THEN 'Japan'
                          WHEN 'CHF'
                          THEN 'Switzerland'
                          ELSE ''
                     END, '') AS CNTRY_DESC
            , isnull(CAL.CNTRY_CDE, '') AS CRNCY_CDE
            , isnull(CAL.ANNCE_DESC, '') AS ANNCE_DESC
            , isnull(CASE CAL.IMPACT
                          WHEN 'LOW'
                          THEN 1
                          WHEN 'MED'
                          THEN 2
                          WHEN 'HIGH'
                          THEN 3
                          ELSE 0
                     END, '') AS IMPACT_VAL
            , isnull(CAL.IMPACT, '') AS IMPACT
            , isnull(CAL.ACTUAL, '') AS ACTUAL
            , isnull(CAL.FORECAST, '') AS FORECAST
            , isnull(CAL.PREVIOUS, '') AS PREVIOUS
--- CALCULATED VALUE (STRIPPED OF TEXT)
            , CASE
                   WHEN len(LTN.DBO.FN_GETNUMERIC_WTH_DEC ( CAL.PREVIOUS ) ) > 0
                   THEN CASE
                             WHEN charindex('%', CAL.PREVIOUS) > 0
                             THEN 'PRCNT'
                             WHEN charindex('K', CAL.PREVIOUS) > 0
                             THEN 'THOUSANDS (`000)'
                             WHEN charindex('M', CAL.PREVIOUS) > 0
                             THEN 'MILLIONS (`000000)'
                             WHEN charindex('B', CAL.PREVIOUS) > 0
                             THEN 'BILLIONS (`000000000)'
                             ELSE 'ACTUAL'
                        END
                   ELSE 'NOVAL'
              END AS VAL_TYPE
            , CASE
                   WHEN len(LTN.DBO.FN_GETNUMERIC_WTH_DEC ( CAL.ACTUAL ) ) = 0
                   THEN cast(0 AS numeric(22, 2))
                   ELSE cast(LTN.DBO.FN_GETNUMERIC_WTH_DEC ( CAL.ACTUAL ) AS numeric(22, 2))
              END AS ACTUAL_STRIPPED
            , CASE
                   WHEN len(LTN.DBO.FN_GETNUMERIC_WTH_DEC ( CAL.FORECAST ) ) = 0
                   THEN cast(0 AS numeric(22, 2))
                   ELSE cast(LTN.DBO.FN_GETNUMERIC_WTH_DEC ( CAL.FORECAST ) AS numeric(22, 2))
              END AS FORECAST_STRIPPED
            , CASE
                   WHEN len(LTN.DBO.FN_GETNUMERIC_WTH_DEC ( CAL.PREVIOUS ) ) = 0
                   THEN cast(0 AS numeric(22, 2))
                   ELSE cast(LTN.DBO.FN_GETNUMERIC_WTH_DEC ( CAL.PREVIOUS ) AS numeric(22, 2))
              END AS PREVIOUS_STRIPPED
         FROM LTN.DBO.DIM_DTE AS DTE
              LEFT OUTER JOIN LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W AS CAL
              ON DTE.MSMT_DTE_ID = CAL.MSMT_DTE_ID
        WHERE 1 = 1
              AND DTE.MSMT_DTE_ID >= 20170118
       ) AS DAT;

 
GO