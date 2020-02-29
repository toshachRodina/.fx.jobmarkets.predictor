select * from [dbo].[sysssislog] order by endtime desc

select * from ltn.[dbo].[ctl_ssis_err_log] order by task_end_datetime desc

-- BUSINESSES FOR SALE
select top 5 msmt_dte_id,count(*) from ltn.[dbo].[f_dtl_bus4sale_au_businessforsale_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id,count(*) from ltn.[dbo].[f_dtl_bus4sale_au_seek_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id,count(*) from ltn.[dbo].[f_dtl_bus4sale_au_domain_d] group by msmt_dte_id order by 1 desc
----------------------

declare @dte_id as int

set @dte_id = CONVERT(varchar(8), GETDATE(), 112) --20161123

SELECT 'BUSINESSFORSALE' AS b4s_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.f_dtl_bus4sale_au_businessforsale_d AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'SEEK' AS b4s_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.f_dtl_bus4sale_au_seek_d AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'DOMAIN' AS b4s_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.f_dtl_bus4sale_au_domain_d AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id;

-- JOBSEARCH
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_adzuna_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_careerjet_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_gumtree_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_hays_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_indeed_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_jobsearch_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_jobserve_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_jora_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_jorax2_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_au_seek_d] group by msmt_dte_id order by 1 desc




-------------------------------
declare @dte_id as int

set @dte_id = CONVERT(varchar(8), GETDATE(), 112) --20161123


SELECT 'ADZUNA' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_adzuna_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'CAREERJET' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_careerjet_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'GUMTREE' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_gumtree_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'HAYS' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_hays_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'INDEED' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_indeed_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'JOBSEARCH' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_jobsearch_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'JOBSERVE' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_jobserve_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'JORA' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_jora_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'JORAX2' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_jorax2_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'SEEK' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_au_seek_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id	  
	  ;	 



select * from ltn.dbo.stg_jobsearch_au_seek_raw
/*
======================================================================================================================
JOBSEARCH
======================================================================================================================
*/
SELECT *
       FROM
            (
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_adzuna_d]
                UNION ALL
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_careerjet_d]
                UNION ALL
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_gumtree_d]
                UNION ALL
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_hays_d]
                UNION ALL
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_indeed_d]
                UNION ALL
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_jobsearch_d]
                UNION ALL
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_jobserve_d]
                UNION ALL
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_jora_d]
                UNION ALL
                SELECT *
                       FROM
                            ltn.[dbo].[f_dtl_jobsearch_seek_d]
            ) AS dat
       ORDER BY 2
              , 1
              , 3;

/*
======================================================================================================================
BUS4SALE
======================================================================================================================
*/
SELECT *
       FROM
            (
                SELECT msmt_dte_id
                     , bus4sale_site_nme
                     , bus4sale_category
                     , SUM(bus4sale_count) AS bus4sale_count
                       FROM
                            ltn.[dbo].[f_dtl_bus4sale_businessforsale_d]
                       GROUP BY msmt_dte_id
                              , bus4sale_site_nme
                              , bus4sale_category
                UNION ALL
                SELECT msmt_dte_id
                     , bus4sale_site_nme
                     , bus4sale_category
                     , bus4sale_count
                       FROM
                            ltn.[dbo].[f_dtl_bus4sale_seek_d]
                UNION ALL
                SELECT msmt_dte_id
                     , bus4sale_site_nme
                     , bus4sale_category
                     , bus4sale_count
                       FROM
                            ltn.[dbo].[f_dtl_bus4sale_domain_d]
            ) AS dat
       ORDER BY 2
              , 1
              , 3;




