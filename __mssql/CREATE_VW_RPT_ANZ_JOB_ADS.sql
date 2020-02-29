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
           WHERE NAME = 'VW_RPT_ANZ_JOB_ADS'
                 AND TYPE = 'v'
          )
   BEGIN
      DROP VIEW DBO.VW_RPT_ANZ_JOB_ADS
   END;
GO

/* 
===================================================================================================
CREATE VIEW
===================================================================================================
*/


CREATE VIEW DBO.VW_RPT_ANZ_JOB_ADS
AS
SELECT DAT.MSMT_DTE_ID
    , convert(date, convert(varchar(10), DAT.MSMT_DTE_ID,120),112) as MSMT_DTE
    , DAT.RPT_DTE_ID
    , convert(date, convert(varchar(10), DAT.RPT_DTE_ID,120),112) as RPT_DTE_FULL
    , DAT.RPT_DTE
    , DAT.DATA_TYPE
    , DAT.CNTRY_CDE
    , DAT.SITE_CDE
    , DAT.ORIGINAL_NBR
    , DAT.SEASONALLY_ADJUSTED_NBR
    , DAT.SEASONALLY_ADJUSTED_MTH_PCNT_CHNG
    , DAT.SEASONALLY_ADJUSTED_YR_PCNT_CHNG
    , DAT.TREND_NBR
    , DAT.TREND_MTH_PCNT_CHNG
    , DAT.TREND_YR_PCNT_CHNG
    , DAT.CAPTR_DTE_ID
FROM LTN.DBO.F_DTL_JOB_AU_ANZ_SCRAPE_ACTUAL_M AS DAT
WHERE 1 = 1

GO