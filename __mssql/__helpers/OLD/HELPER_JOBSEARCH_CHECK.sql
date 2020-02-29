/*
===================================================================================================
-- AU
===================================================================================================
*/
SELECT DAT.*
  FROM (
       SELECT TOP 3 'ADZUNA' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_adzuna_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 3 'CAREERJET' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_careerjet_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 3 'GUMTREE' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_gumtree_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 3 'HAYS' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_hays_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 3 'INDEED' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_indeed_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 3 'JOBSEARCH' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_jobsearch_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 3 'JOBSERVE' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_jobserve_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 3 'JORA' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_jora_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 3 'JORAX2' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_jorax2_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
	   UNION ALL
       SELECT TOP 3 'SEEK' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_au_seek_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       ) AS DAT
 ORDER BY 1 DESC;

/*
===================================================================================================
-- CA
===================================================================================================
*/

 SELECT DAT.*
  FROM (
       SELECT TOP 5 'CAREERBUILDER' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM DBO.F_DTL_JOBSEARCH_CA_CAREERBUILDER_D
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'INDEED' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM DBO.F_DTL_JOBSEARCH_CA_INDEED_D
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'JOBBANK' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM DBO.F_DTL_JOBSEARCH_CA_JOBBANK_D
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'WORKOPOLIS' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM DBO.F_DTL_JOBSEARCH_CA_WORKOPOLIS_D
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       ) AS DAT
 ORDER BY 1 DESC;

/*
===================================================================================================
-- B4S
===================================================================================================
*/

SELECT DAT.*
  FROM (
       SELECT TOP 5 'BUSINESSFORSALE' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM DBO.F_DTL_BUS4SALE_AU_BUSINESSFORSALE_D
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5  'SEEK' AS JOB_SITE
            , MSMT_DTE_ID
            , count(*) AS CNT
         FROM DBO.F_DTL_BUS4SALE_AU_SEEK_D
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'DOMAIN' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM DBO.F_DTL_BUS4SALE_AU_DOMAIN_D
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       ) AS DAT
 ORDER BY 1 DESC;

/*
===================================================================================================
-- NZ
===================================================================================================
*/

SELECT DAT.*
  FROM (
       SELECT TOP 5 'MYJOBSPACE' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_nz_myjobspace_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5  'SEEK' AS JOB_SITE
            , MSMT_DTE_ID
            , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_nz_seek_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'TRADEME' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_nz_trademe_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       ) AS DAT
 ORDER BY 1 DESC;

/*
===================================================================================================
-- UK
===================================================================================================
*/

SELECT DAT.*
  FROM (
       SELECT TOP 5 'GOV' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_uk_gov_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'JOBSITE' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_uk_jobsite_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'REED' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_uk_reed_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'TOTALJOBS' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_uk_totaljobs_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       ) AS DAT
 ORDER BY 1 DESC;

/*
===================================================================================================
-- US
===================================================================================================
*/

SELECT DAT.*
  FROM (
       SELECT TOP 5 'CAREERBUILDER' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_us_careerbuilder_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'INDEED' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_us_indeed_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'SIMPLYHIRED' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_us_simplyhired_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       UNION ALL
       SELECT TOP 5 'THELADDERS' AS JOB_SITE
                  , MSMT_DTE_ID
                  , count(*) AS CNT
         FROM [dbo].[f_dtl_jobsearch_us_theladders_d]
        GROUP BY MSMT_DTE_ID
        ORDER BY 2 DESC
       ) AS DAT
 ORDER BY 1 DESC;