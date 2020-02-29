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
           WHERE NAME = 'VW_RPT_COMMODITY_DAT'
                 AND TYPE = 'v'
          )
   BEGIN
      DROP VIEW DBO.VW_RPT_COMMODITY_DAT
   END;
GO

/* 
===================================================================================================
CREATE VIEW
===================================================================================================
*/

CREATE VIEW DBO.VW_RPT_COMMODITY_DAT
AS
SELECT DTL.MSMT_DTE_ID
     , DTL.DATA_TYPE
     , DTL.TRADE_DT
     , DTL.INDEX_VAL
     , DTL.HIGH_VAL
     , DTL.LOW_VAL
     , DTL.TTL_MRKT_VAL
  FROM LTN.DBO.F_DTL_COMMODITY_PRICE_D AS DTL
  WHERE 1 = 1
    and dtl.MSMT_DTE_ID >= 20170101;
 
GO
