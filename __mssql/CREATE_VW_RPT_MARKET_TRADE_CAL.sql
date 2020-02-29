/*
THIS VIEW IS TO PROVIDE THE OPEN HOURS OF THE VARIOUS FOREX MARKETS
EG.  TOKYO MARKET BY DATE AND HOUR OF DAY

ONLY SHOWS PREVIOUS 1 DAY, CURRENT DAY AND FOLLOWING 7 DAYS (FEED WILL NEED TO BE REFRESHED TO GET CURRENT DATA)

SUPPORTING INFORMATION FOR CALENDAR
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
           WHERE NAME = 'VW_RPT_MARKET_TRADE_CAL'
                 AND TYPE = 'v'
          )
   BEGIN
      DROP VIEW DBO.VW_RPT_MARKET_TRADE_CAL
   END;
GO

/* 
===================================================================================================
CREATE VIEW
===================================================================================================
*/

CREATE VIEW DBO.VW_RPT_MARKET_TRADE_CAL
AS
WITH DY
     AS (
     SELECT CASE
                 WHEN DTE.DTE_ID < cast(getdate() AS date)
                 THEN-1
                 ELSE
                      row_number() OVER(PARTITION BY 1 ORDER BY DTE.DTE_ID)
                      - 2
            END AS ROWNUM
          , DTE.DTE_ID
          , DTE.WEEKDAY_NME
          , DTE.WEEKDAY_NME_SHRT
          , DTE.WORKDAY_IND
       FROM LTN.DBO.DIM_DTE AS DTE
      WHERE 1 = 1
            AND DTE.DTE_ID BETWEEN dateadd(day, -1, cast(getdate() AS date)) AND dateadd(day, 7, cast(getdate() AS date)))
     SELECT DAT1.MARKET_CDE
          , DAT1.CNTRY_CDE
          , DAT1.ROWNUM AS DAY_OFFSET
          , DAT1.WEEKDAY_NME
          , DAT1.WEEKDAY_NME_SHRT
          , DAT1.WORKDAY_IND
          , DAT1.GMT_DTTM_STAMP
          , DAT1.GMT_HOUR_OF_DAY
          , convert(datetime, DAT1.GMT_DTTM_STAMP) AT TIME ZONE 'GMT Standard Time' -- TIME ZONE OF DATETIME BEING EVALUATED
            AT TIME ZONE 'AUS Eastern Standard Time' -- TIME ZONE TO CONVERT TO
            AS AEST_DTTM_STAMP
          , datepart(HOUR, convert(datetime, DAT1.GMT_DTTM_STAMP) AT TIME ZONE 'GMT Standard Time' -- TIME ZONE OF DATETIME BEING EVALUATED
            AT TIME ZONE 'AUS Eastern Standard Time' -- TIME ZONE TO CONVERT TO
            ) AS AEST_HOUR_OF_DAY
       FROM (
            SELECT CASE DY.WEEKDAY_NME_SHRT
                        WHEN 'SUN'
                        THEN 'START'
                        WHEN 'FRI'
                        THEN 'END'
                        ELSE 'ERR'
                   END AS MARKET_CDE
                 , CASE DY.WEEKDAY_NME_SHRT
                        WHEN 'SUN'
                        THEN 'START'
                        WHEN 'FRI'
                        THEN 'END'
                        ELSE 'ERR'
                   END AS CNTRY_CDE
                 , 'GMT' AS TMZ
                 , 99 AS ROWNUM
                 , DY.WEEKDAY_NME
                 , DY.WEEKDAY_NME_SHRT
                 , DY.WORKDAY_IND
                 , convert(char(23), convert(datetime, cast(DY.DTE_ID AS varchar(10))+' '+cast(left(cast(replace(CASE
                                                                                                                      WHEN len(cast(CASE DY.WEEKDAY_NME_SHRT
                                                                                                                                         WHEN 'SUN'
                                                                                                                                         THEN 22
                                                                                                                                         WHEN 'FRI'
                                                                                                                                         THEN 7
                                                                                                                                         ELSE 0
                                                                                                                                    END AS varchar(2))) = 1
                                                                                                                      THEN '0'+cast(CASE DY.WEEKDAY_NME_SHRT
                                                                                                                                         WHEN 'SUN'
                                                                                                                                         THEN 22
                                                                                                                                         WHEN 'FRI'
                                                                                                                                         THEN 7
                                                                                                                                         ELSE 0
                                                                                                                                    END AS varchar(2))
                                                                                                                      ELSE cast(CASE DY.WEEKDAY_NME_SHRT
                                                                                                                                     WHEN 'SUN'
                                                                                                                                     THEN 22
                                                                                                                                     WHEN 'FRI'
                                                                                                                                     THEN 7
                                                                                                                                     ELSE 0
                                                                                                                                END AS varchar(2))
                                                                                                                 END, '24', '00')+':00' AS time), 12) AS varchar(15)), 101), 121) AS GMT_DTTM_STAMP
                 , CASE DY.WEEKDAY_NME_SHRT
                        WHEN 'SUN'
                        THEN 22
                        WHEN 'FRI'
                        THEN 7
                        ELSE 0
                   END AS GMT_HOUR_OF_DAY
              FROM DY
             WHERE 1 = 1
                   AND DY.WEEKDAY_NME_SHRT IN ( 'SUN'
                                              , 'FRI'
                                              )
            UNION ALL
            SELECT DAT.MARKET_CDE
                 , DAT.CNTRY_CDE
                 , DAT.TMZ
                 , DY.ROWNUM
                 , DY.WEEKDAY_NME
                 , DY.WEEKDAY_NME_SHRT
                 , DY.WORKDAY_IND
                 , convert(char(23), convert(datetime, cast(DY.DTE_ID AS varchar(10))+' '+cast(left(DAT.GMT_TM, 12) AS varchar(15)), 101), 121) AS GMT_DTTM_STAMP
                 , DAT.GMT_HOUR_OF_DAY
              FROM (
                   SELECT MRKT.MARKET_CDE
                        , MRKT.CNTRY_CDE
                        , MRKT.TMZ
                        , MRKT.HOUR_OF_DAY AS GMT_HOUR_OF_DAY
                        , cast(replace(CASE
                                            WHEN len(cast(MRKT.HOUR_OF_DAY AS varchar(2))) = 1
                                            THEN '0'+cast(MRKT.HOUR_OF_DAY AS varchar(2))
                                            ELSE cast(MRKT.HOUR_OF_DAY AS varchar(2))
                                       END, '24', '00')+':00' AS time) AS GMT_TM
                     FROM LTN.DBO.DIM_MARKET_HR AS MRKT
                    WHERE 1 = 1
                          AND MRKT.END_DTE_ID = 29991231
                   ) AS DAT
                   CROSS JOIN DY
            ) AS DAT1
      WHERE 1 = 1;
