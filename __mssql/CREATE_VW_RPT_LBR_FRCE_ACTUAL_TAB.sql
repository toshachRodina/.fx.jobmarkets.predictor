/*
Results should match the report period shown on the website
http://www.abs.gov.au/AUSSTATS/abs@.nsf/Lookup/6202.0Main+Features1Sep%202017?OpenDocument
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
           WHERE NAME = 'VW_RPT_LBR_FRCE_ACTUAL_TAB'
                 AND TYPE = 'v'
          )
   BEGIN
      DROP VIEW DBO.VW_RPT_LBR_FRCE_ACTUAL_TAB
   END;
GO

/* 
===================================================================================================
CREATE VIEW
===================================================================================================
*/
CREATE VIEW DBO.VW_RPT_LBR_FRCE_ACTUAL_TAB
AS
WITH DAT(RPT_PERIOD_ID
        ,RPT_PERIOD_DT
        ,CNTRY_CDE
-- TREND  -----------------------------------------------------------------------------------------
-- employed_total_persons__trend
        ,PREV_MTH_EMPLOYED_TOTAL_PERSONS__TREND
        ,CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND
        ,EMPLOYED_TOTAL_PERSONS__TREND_DELTA
        ,EMPLOYED_TOTAL_PERSONS__TREND_YOY_DELTA
-- unemployed_total_persons__trend
        ,PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND
        ,CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND
        ,UNEMPLOYED_TOTAL_PERSONS__TREND_DELTA
        ,UNEMPLOYED_TOTAL_PERSONS__TREND_YOY_DELTA
-- unemployment_rate_persons__trend
        ,PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND
        ,CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND
        ,UNEMPLOYMENT_RATE_PERSONS__TREND_DELTA
        ,UNEMPLOYMENT_RATE_PERSONS__TREND_YOY_DELTA
-- participation_rate_persons__trend
        ,PREV_MTH_PARTICIPATION_RATE_PERSONS__TREND
        ,CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND
        ,PARTICIPATION_RATE_PERSONS__TREND_DELTA
        ,PARTICIPATION_RATE_PERSONS__TREND_YOY_DELTA
-- SEASONALLY ADJUSTED ----------------------------------------------------------------------------
-- employed_total_persons__seasonally_adjusted
        ,PREV_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
        ,CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
        ,EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_DELTA
        ,EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA
-- unemployed_total_persons__seasonally_adjusted
        ,PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
        ,CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
        ,UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_DELTA
        ,UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA
-- unemployment_rate_persons__seasonally_adjusted
        ,PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
        ,CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
        ,UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED_DELTA
        ,UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA
-- participation_rate_persons__seasonally_adjusted
        ,PREV_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
        ,CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
        ,PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED_DELTA
        ,PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA)
     AS (
     SELECT DAT2.RPT_PERIOD_ID
           ,cast(cast(cast(DAT2.RPT_PERIOD_ID AS varchar(6))+'01' AS varchar(10)) AS date) AS RPT_PERIOD_DT
           ,DAT2.CNTRY_CDE
-- TREND  -----------------------------------------------------------------------------------------
-- employed_total_persons__trend
           ,DAT2.PREV_MTH_EMPLOYED_TOTAL_PERSONS__TREND
           ,DAT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND
           ,DAT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND - DAT2.PREV_MTH_EMPLOYED_TOTAL_PERSONS__TREND AS EMPLOYED_TOTAL_PERSONS__TREND_DELTA
           ,(DAT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND - ACT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND) / ACT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND AS EMPLOYED_TOTAL_PERSONS__TREND_YOY_DELTA
-- unemployed_total_persons__trend
           ,DAT2.PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND
           ,DAT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND
           ,DAT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND - DAT2.PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND AS UNEMPLOYED_TOTAL_PERSONS__TREND_DELTA
           ,(DAT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND - ACT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND) / ACT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND AS UNEMPLOYED_TOTAL_PERSONS__TREND_YOY_DELTA
-- unemployment_rate_persons__trend
           ,DAT2.PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND
           ,DAT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND
           ,DAT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND - DAT2.PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND AS UNEMPLOYMENT_RATE_PERSONS__TREND_DELTA
           ,(DAT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND - ACT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND) / ACT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND AS UNEMPLOYMENT_RATE_PERSONS__TREND_YOY_DELTA
-- participation_rate_persons__trend
           ,DAT2.PREV_MTH_PARTICIPATION_RATE_PERSONS__TREND
           ,DAT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND
           ,DAT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND - DAT2.PREV_MTH_PARTICIPATION_RATE_PERSONS__TREND AS PARTICIPATION_RATE_PERSONS__TREND_DELTA
           ,(DAT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND - ACT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND) / ACT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND AS PARTICIPATION_RATE_PERSONS__TREND_YOY_DELTA
-- SEASONALLY ADJUSTED ----------------------------------------------------------------------------
-- employed_total_persons__seasonally_adjusted
           ,DAT2.PREV_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
           ,DAT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
           ,DAT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED - DAT2.PREV_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED AS EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_DELTA
           ,(DAT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED - ACT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED) / ACT2.CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED AS EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA
-- unemployed_total_persons__seasonally_adjusted
           ,DAT2.PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
           ,DAT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
           ,DAT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED - DAT2.PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED AS UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_DELTA
           ,(DAT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED - ACT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED) / ACT2.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED AS UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA
-- unemployment_rate_persons__seasonally_adjusted
           ,DAT2.PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
           ,DAT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
           ,DAT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED - DAT2.PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED AS UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED_DELTA
           ,(DAT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED - ACT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED) / ACT2.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED AS UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA
-- participation_rate_persons__seasonally_adjusted
           ,DAT2.PREV_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
           ,DAT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
           ,DAT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED - DAT2.PREV_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED AS PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED_DELTA
           ,(DAT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED - ACT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED) / ACT2.CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED AS PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA
       FROM
           (
               SELECT DAT.RPT_PERIOD_ID
                     ,DAT.CNTRY_CDE
-- TREND  -----------------------------------------------------------------------------------------
-- employed_total_persons__trend
                     ,max(CASE
                              WHEN DAT.RNK = 1
                              THEN DAT.EMPLOYED_TOTAL_PERSONS__TREND
                              ELSE 0
                          END) AS PREV_MTH_EMPLOYED_TOTAL_PERSONS__TREND
                     ,max(CASE
                              WHEN DAT.RNK = 2
                              THEN DAT.EMPLOYED_TOTAL_PERSONS__TREND
                              ELSE 0
                          END) AS CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND
-- unemployed_total_persons__trend
                     ,max(CASE
                              WHEN DAT.RNK = 1
                              THEN DAT.UNEMPLOYED_TOTAL_PERSONS__TREND
                              ELSE 0
                          END) AS PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND
                     ,max(CASE
                              WHEN DAT.RNK = 2
                              THEN DAT.UNEMPLOYED_TOTAL_PERSONS__TREND
                              ELSE 0
                          END) AS CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND
-- unemployment_rate_persons__trend
                     ,max(CASE
                              WHEN DAT.RNK = 1
                              THEN DAT.UNEMPLOYMENT_RATE_PERSONS__TREND
                              ELSE 0
                          END) AS PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND
                     ,max(CASE
                              WHEN DAT.RNK = 2
                              THEN DAT.UNEMPLOYMENT_RATE_PERSONS__TREND
                              ELSE 0
                          END) AS CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND
-- participation_rate_persons__trend
                     ,max(CASE
                              WHEN DAT.RNK = 1
                              THEN DAT.PARTICIPATION_RATE_PERSONS__TREND
                              ELSE 0
                          END) AS PREV_MTH_PARTICIPATION_RATE_PERSONS__TREND
                     ,max(CASE
                              WHEN DAT.RNK = 2
                              THEN DAT.PARTICIPATION_RATE_PERSONS__TREND
                              ELSE 0
                          END) AS CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND
-- SEASONALLY ADJUSTED ----------------------------------------------------------------------------
-- employed_total_persons__seasonally_adjusted
                     ,max(CASE
                              WHEN DAT.RNK = 1
                              THEN DAT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                              ELSE 0
                          END) AS PREV_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                     ,max(CASE
                              WHEN DAT.RNK = 2
                              THEN DAT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                              ELSE 0
                          END) AS CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
-- unemployed_total_persons__seasonally_adjusted
                     ,max(CASE
                              WHEN DAT.RNK = 1
                              THEN DAT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                              ELSE 0
                          END) AS PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                     ,max(CASE
                              WHEN DAT.RNK = 2
                              THEN DAT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                              ELSE 0
                          END) AS CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
-- unemployment_rate_persons__seasonally_adjusted
                     ,max(CASE
                              WHEN DAT.RNK = 1
                              THEN DAT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                              ELSE 0
                          END) AS PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                     ,max(CASE
                              WHEN DAT.RNK = 2
                              THEN DAT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                              ELSE 0
                          END) AS CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
-- participation_rate_persons__seasonally_adjusted
                     ,max(CASE
                              WHEN DAT.RNK = 1
                              THEN DAT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                              ELSE 0
                          END) AS PREV_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                     ,max(CASE
                              WHEN DAT.RNK = 2
                              THEN DAT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                              ELSE 0
                          END) AS CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                 FROM
                     (
                         SELECT ACT.RPT_PERIOD_ID
                               ,rank() OVER(PARTITION BY ACT.RPT_PERIOD_ID ORDER BY ACT.CAPTURE_PERIOD_ID) AS RNK
                               ,ACT.CAPTURE_PERIOD_ID
                               ,ACT.CAPTURE_PERIOD
                               ,ACT.CNTRY_CDE
                               ,ACT.EMPLOYED_TOTAL_PERSONS__TREND
                               ,ACT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                               ,ACT.UNEMPLOYED_TOTAL_PERSONS__TREND
                               ,ACT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                               ,ACT.UNEMPLOYMENT_RATE_PERSONS__TREND
                               ,ACT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                               ,ACT.PARTICIPATION_RATE_PERSONS__TREND
                               ,ACT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                           FROM LTN.DBO.F_DTL_LABOUR_FORCE_STATUS_ACTUAL_M AS ACT
                          WHERE 1 = 1
                     ) AS DAT
                WHERE 1 = 1
                GROUP BY DAT.RPT_PERIOD_ID
                        ,DAT.CNTRY_CDE
           ) AS DAT2
           LEFT OUTER JOIN
                          (
                              SELECT DAT.RPT_PERIOD_ID
                                    ,DAT.CNTRY_CDE
-- TREND  -----------------------------------------------------------------------------------------
-- employed_total_persons__trend
                                    ,max(CASE
                                             WHEN DAT.RNK = 1
                                             THEN DAT.EMPLOYED_TOTAL_PERSONS__TREND
                                             ELSE 0
                                         END) AS PREV_MTH_EMPLOYED_TOTAL_PERSONS__TREND
                                    ,max(CASE
                                             WHEN DAT.RNK = 2
                                             THEN DAT.EMPLOYED_TOTAL_PERSONS__TREND
                                             ELSE 0
                                         END) AS CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND
-- unemployed_total_persons__trend
                                    ,max(CASE
                                             WHEN DAT.RNK = 1
                                             THEN DAT.UNEMPLOYED_TOTAL_PERSONS__TREND
                                             ELSE 0
                                         END) AS PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND
                                    ,max(CASE
                                             WHEN DAT.RNK = 2
                                             THEN DAT.UNEMPLOYED_TOTAL_PERSONS__TREND
                                             ELSE 0
                                         END) AS CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND
-- unemployment_rate_persons__trend
                                    ,max(CASE
                                             WHEN DAT.RNK = 1
                                             THEN DAT.UNEMPLOYMENT_RATE_PERSONS__TREND
                                             ELSE 0
                                         END) AS PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND
                                    ,max(CASE
                                             WHEN DAT.RNK = 2
                                             THEN DAT.UNEMPLOYMENT_RATE_PERSONS__TREND
                                             ELSE 0
                                         END) AS CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND
-- participation_rate_persons__trend
                                    ,max(CASE
                                             WHEN DAT.RNK = 1
                                             THEN DAT.PARTICIPATION_RATE_PERSONS__TREND
                                             ELSE 0
                                         END) AS PREV_MTH_PARTICIPATION_RATE_PERSONS__TREND
                                    ,max(CASE
                                             WHEN DAT.RNK = 2
                                             THEN DAT.PARTICIPATION_RATE_PERSONS__TREND
                                             ELSE 0
                                         END) AS CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND
-- SEASONALLY ADJUSTED ----------------------------------------------------------------------------
-- employed_total_persons__seasonally_adjusted
                                    ,max(CASE
                                             WHEN DAT.RNK = 1
                                             THEN DAT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                             ELSE 0
                                         END) AS PREV_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                    ,max(CASE
                                             WHEN DAT.RNK = 2
                                             THEN DAT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                             ELSE 0
                                         END) AS CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
-- unemployed_total_persons__seasonally_adjusted
                                    ,max(CASE
                                             WHEN DAT.RNK = 1
                                             THEN DAT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                             ELSE 0
                                         END) AS PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                    ,max(CASE
                                             WHEN DAT.RNK = 2
                                             THEN DAT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                             ELSE 0
                                         END) AS CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
-- unemployment_rate_persons__seasonally_adjusted
                                    ,max(CASE
                                             WHEN DAT.RNK = 1
                                             THEN DAT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                                             ELSE 0
                                         END) AS PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                                    ,max(CASE
                                             WHEN DAT.RNK = 2
                                             THEN DAT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                                             ELSE 0
                                         END) AS CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
-- participation_rate_persons__seasonally_adjusted
                                    ,max(CASE
                                             WHEN DAT.RNK = 1
                                             THEN DAT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                                             ELSE 0
                                         END) AS PREV_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                                    ,max(CASE
                                             WHEN DAT.RNK = 2
                                             THEN DAT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                                             ELSE 0
                                         END) AS CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                                FROM
                                    (
                                        SELECT ACT.RPT_PERIOD_ID
                                              ,rank() OVER(PARTITION BY ACT.RPT_PERIOD_ID ORDER BY ACT.CAPTURE_PERIOD_ID) AS RNK
                                              ,ACT.CAPTURE_PERIOD_ID
                                              ,ACT.CAPTURE_PERIOD
                                              ,ACT.CNTRY_CDE
                                              ,ACT.EMPLOYED_TOTAL_PERSONS__TREND
                                              ,ACT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                              ,ACT.UNEMPLOYED_TOTAL_PERSONS__TREND
                                              ,ACT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                              ,ACT.UNEMPLOYMENT_RATE_PERSONS__TREND
                                              ,ACT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                                              ,ACT.PARTICIPATION_RATE_PERSONS__TREND
                                              ,ACT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                                          FROM LTN.DBO.F_DTL_LABOUR_FORCE_STATUS_ACTUAL_M AS ACT
                                         WHERE 1 = 1
                                    ) AS DAT
                               WHERE 1 = 1
                               GROUP BY DAT.RPT_PERIOD_ID
                                       ,DAT.CNTRY_CDE
                          ) AS ACT2 ON cast(left(convert(varchar(10),cast(cast(cast(convert(varchar(8),dateadd(year,-1,cast(cast(cast(DAT2.RPT_PERIOD_ID AS varchar(6))+'01' AS varchar(10)) AS date)),1) AS date) AS date) AS date),112),6) AS int) = ACT2.RPT_PERIOD_ID
      WHERE 1 = 1)
	 -- TREND
     SELECT dat.RPT_PERIOD_ID
		 ,dat.RPT_PERIOD_DT
		 ,'TREND' as group_itm_desc
	      ,'EMPLOYED PERSONS' as itm_desc
		 ,dat.PREV_MTH_EMPLOYED_TOTAL_PERSONS__TREND/ 1000 as prev_mth
		 ,dat.CURR_MTH_EMPLOYED_TOTAL_PERSONS__TREND/ 1000 as curr_mth
		 ,dat.EMPLOYED_TOTAL_PERSONS__TREND_DELTA / 1000 as mth_delta
		 ,dat.EMPLOYED_TOTAL_PERSONS__TREND_YOY_DELTA * 100 as yoy_delta
       FROM DAT
	  union all
	  SELECT dat.RPT_PERIOD_ID
		 ,dat.RPT_PERIOD_DT
		 ,'TREND' as group_itm_desc
	      ,'UNEMPLOYED PERSONS' as itm_desc
		 ,dat.PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND/ 1000  as prev_mth
		 ,dat.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__TREND/ 1000  as curr_mth
		 ,dat.UNEMPLOYED_TOTAL_PERSONS__TREND_DELTA / 1000  as mth_delta
		 ,dat.UNEMPLOYED_TOTAL_PERSONS__TREND_YOY_DELTA * 100 as yoy_delta
       FROM DAT
	  union all
	  SELECT dat.RPT_PERIOD_ID
		 ,dat.RPT_PERIOD_DT
		 ,'TREND' as group_itm_desc
	      ,'UNEMPLOYED RATE' as itm_desc
		 ,dat.PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND * 100 as prev_mth
		 ,dat.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__TREND * 100 as curr_mth
		 ,dat.UNEMPLOYMENT_RATE_PERSONS__TREND_DELTA * 100  as mth_delta
		 ,dat.UNEMPLOYMENT_RATE_PERSONS__TREND_YOY_DELTA * 100  as yoy_delta
		 FROM DAT
       union all
	  SELECT dat.RPT_PERIOD_ID
		 ,dat.RPT_PERIOD_DT
		 ,'TREND' as group_itm_desc
	      ,'PARTICIPATION RATE' as itm_desc
		 ,dat.PREV_MTH_PARTICIPATION_RATE_PERSONS__TREND * 100  as prev_mth
		 ,dat.CURR_MTH_PARTICIPATION_RATE_PERSONS__TREND * 100  as curr_mth
		 ,dat.PARTICIPATION_RATE_PERSONS__TREND_DELTA * 100   as mth_delta
		 ,dat.PARTICIPATION_RATE_PERSONS__TREND_YOY_DELTA * 100   as yoy_delta
       FROM DAT
	  -- SEASONALLY ADJUSTED
	  union all
	  SELECT dat.RPT_PERIOD_ID
		 ,dat.RPT_PERIOD_DT
		 ,'SEASONALLY ADJUSTED' as group_itm_desc
	      ,'EMPLOYED PERSONS' as itm_desc
		 ,dat.PREV_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED/ 1000 as prev_mth
		 ,dat.CURR_MTH_EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED/ 1000  as curr_mth
		 ,dat.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_DELTA/ 1000 as mth_delta
		 ,dat.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA * 100 as yoy_delta
       FROM DAT
	  union all
	  SELECT dat.RPT_PERIOD_ID
		 ,dat.RPT_PERIOD_DT
		 ,'SEASONALLY ADJUSTED' as group_itm_desc
	      ,'UNEMPLOYED PERSONS' as itm_desc
		 ,dat.PREV_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED/ 1000  as prev_mth
		 ,dat.CURR_MTH_UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED/ 1000  as curr_mth
		 ,dat.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_DELTA/ 1000 as mth_delta
		 ,dat.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA * 100  as yoy_delta
       FROM DAT
	  union all
	  SELECT dat.RPT_PERIOD_ID
		 ,dat.RPT_PERIOD_DT
		 ,'SEASONALLY ADJUSTED' as group_itm_desc
	      ,'UNEMPLOYED RATE' as itm_desc
		 ,dat.PREV_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED * 100  as prev_mth
		 ,dat.CURR_MTH_UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED * 100  as curr_mth
		 ,dat.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED_DELTA * 100  as mth_delta
		 ,dat.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA * 100 as yoy_delta
		 FROM DAT
       union all
	  SELECT dat.RPT_PERIOD_ID
		 ,dat.RPT_PERIOD_DT
		 ,'SEASONALLY ADJUSTED' as group_itm_desc
	      ,'PARTICIPATION RATE' as itm_desc
		 ,dat.PREV_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED * 100 as prev_mth
		 ,dat.CURR_MTH_PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED * 100 as curr_mth
		 ,dat.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED_DELTA * 100  as mth_delta
		 ,dat.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED_YOY_DELTA * 100  as yoy_delta
       FROM DAT
	  ;

