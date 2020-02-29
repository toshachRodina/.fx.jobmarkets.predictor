
select * from ltn.[dbo].[ctl_ssis_err_log] order by task_end_datetime desc


-- JOBSEARCH
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_us_careerbuilder_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_us_indeed_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_us_theladders_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_us_simplyhired_d] group by msmt_dte_id order by 1 desc

-------------------------------
declare @dte_id as int

set @dte_id = CONVERT(varchar(8), GETDATE(), 112) --20161123


SELECT 'CAREERBUILDER' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_us_indeed_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'INDEED' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_us_indeed_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'THELADDER' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_us_theladders_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'SIMPLYHIRED' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_us_simplyhired_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
	  
	  ;	 