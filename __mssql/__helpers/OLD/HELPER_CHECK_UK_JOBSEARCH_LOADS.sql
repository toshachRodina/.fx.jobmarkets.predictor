
select * from ltn.[dbo].[ctl_ssis_err_log] order by task_end_datetime desc

msmt_dte_id variable used : 20161205 --- error msg : String or binary data would be truncated.
-- JOBSEARCH
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_uk_gov_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_uk_jobsite_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_uk_reed_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_uk_totaljobs_d] group by msmt_dte_id order by 1 desc

-------------------------------
declare @dte_id as int

set @dte_id = CONVERT(varchar(8), GETDATE(), 112) --20161123


SELECT 'GOV' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_uk_gov_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'INDEED' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_uk_jobsite_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'THELADDER' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_uk_reed_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'SIMPLYHIRED' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_uk_totaljobs_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
	  
	  ;	 