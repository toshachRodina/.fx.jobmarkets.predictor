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
           WHERE NAME = 'VW_RPT_JOBS_ALL'
                 AND TYPE = 'v'
          )
   BEGIN
      DROP VIEW DBO.VW_RPT_JOBS_ALL
   END;
GO

/* 
===================================================================================================
CREATE VIEW
===================================================================================================
*/
CREATE VIEW DBO.VW_RPT_JOBS_ALL
AS
WITH CLSIF
     AS (
     SELECT CLSIF_RLTSHP.FACET_DESC
          , CLSIF.SECTOR_DESC
          , CLSIF.IND_GRP_DESC
          , CLSIF.IND_DESC
          , CLSIF.SUB_IND_DESC
       FROM LTN.DBO.RLTSHP_FACET_DESC_INDSTRY_CLSFCTN AS CLSIF_RLTSHP
            LEFT OUTER JOIN LTN.DBO.REF_GLBL_INDSTRY_CLSFCTN_STNDRD AS CLSIF
            ON CLSIF_RLTSHP.SUB_IND_ID = CLSIF.SUB_IND_ID
      WHERE 1 = 1
            AND convert(varchar(10), cast(cast(getdate() AS date) AS date), 112) BETWEEN CLSIF_RLTSHP.START_DTE_ID AND CLSIF_RLTSHP.END_DTE_ID)
     SELECT DAT.MSMT_DTE_ID
          , DAT.MSMT_DTE
          , DAT.DATA_TYPE
          , DAT.DATA_TYPE_SUB_DESC
          , DAT.CNTRY_CDE
          , CASE DAT.CNTRY_CDE
                 WHEN 'AU'
                 THEN 'Australia'
                 WHEN 'NZ'
                 THEN 'New Zealand'
                 WHEN 'CA'
                 THEN 'Canada'
                 WHEN 'UK'
                 THEN 'United Kingdom'
                 WHEN 'US'
                 THEN 'United States'
                 ELSE 'UNKNOWN'
            END AS CNTRY_DESC
          , CASE DAT.CNTRY_CDE
                 WHEN 'AU'
                 THEN 'AUD'
                 WHEN 'CA'
                 THEN 'CAD'
                 WHEN 'NZ'
                 THEN 'NZD'
                 WHEN 'UK'
                 THEN 'GBP'
                 WHEN 'US'
                 THEN 'USD'
                 ELSE 'UNCLASSIFIED'
            END AS CRNCY_CDE
          , DAT.SITE_CDE
          , DAT.FACET_TYPE
          , DAT.FACET_DESC
          , DAT.FACET_CNT
          , DAT.DATA_SRCE
          , DAT.SITE_URL
          , DAT.SUBSET_IND
          , DAT.GOVT_IND
          , DAT.CLSIF_SECTOR_DESC
          , DAT.CLSIF_IND_GRP_DESC
          , DAT.CLSIF_IND_DESC
          , DAT.CLSIF_SUB_IND_DESC
       FROM (
            SELECT JOB.MSMT_DTE_ID
                 , cast(cast(JOB.MSMT_DTE_ID AS nvarchar(8)) AS date) AS MSMT_DTE
                 , CASE
                        WHEN JOB.DATA_TYPE = 'JOB'
                        THEN 'JOBS'
                        ELSE JOB.DATA_TYPE
                   END AS DATA_TYPE
                 , CASE
                        WHEN JOB.FACET_TYPE IN('INDUSTRY', 'CATEGORY', 'INDUSTRIES', 'SECTOR', 'SECTORS')
                        THEN 'INDUSTRY'
                        WHEN JOB.FACET_TYPE IN('CITY', 'LOCATION', 'LOCATIONS', 'REGION', 'REGIONS')
                        THEN 'LOCATION'
                        WHEN JOB.FACET_TYPE IN('JOB TYPE', 'JOB TYPES', 'JOBTYPE', 'TYPE OF WORK')
                        THEN 'JOBTYPE'
                        WHEN JOB.FACET_TYPE IN('SALARY ESTIMATE', 'SALARY/RATE')
                        THEN 'SALARY'
                        ELSE 'NOT CATEGORISED'
                   END AS DATA_TYPE_SUB_DESC
                 , JOB.CNTRY_CDE
                 , JOB.SITE_CDE
                 , JOB.FACET_TYPE
                 , JOB.FACET_DESC
                 , JOB.FACET_CNT
                 , JOB.DATA_SRCE
                 , REF.SITE_URL
                 , REF.SUBSET_IND
                 , CASE
                        WHEN isnull(REF.GOVT_IND, 'N') = ''
                        THEN 'N'
                        ELSE 'Y'
                   END AS GOVT_IND
                 , isnull(CLSIF.SECTOR_DESC, 'NOVAL') AS CLSIF_SECTOR_DESC
                 , isnull(CLSIF.IND_GRP_DESC, 'NOVAL') AS CLSIF_IND_GRP_DESC
                 , isnull(CLSIF.IND_DESC, 'NOVAL') AS CLSIF_IND_DESC
                 , isnull(CLSIF.SUB_IND_DESC, 'NOVAL') AS CLSIF_SUB_IND_DESC
              FROM LTN.DBO.F_DTL_JOB_SCRAPE_D AS JOB
                   INNER JOIN LTN.DBO.DIM_WEBSITE_REF AS REF
                   ON 1 = 1
                      AND JOB.CNTRY_CDE = REF.CNTRY_CDE
                      AND JOB.SITE_CDE = REF.SITE_CDE
                   LEFT OUTER JOIN CLSIF
                   ON JOB.FACET_DESC = CLSIF.FACET_DESC
             WHERE 1 = 1
                   AND JOB.MSMT_DTE_ID >= 20161101
            ) AS DAT
      WHERE 1 = 1
            AND DAT.DATA_TYPE_SUB_DESC IN ( 'INDUSTRY'
                                          , 'LOCATION'
                                          , 'JOBTYPE'
                                          , 'SALARY'
                                          );





