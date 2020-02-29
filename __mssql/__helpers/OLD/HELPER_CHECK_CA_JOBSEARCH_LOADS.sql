

-- JOBSEARCH
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_ca_careerbuilder_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_ca_indeed_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_ca_jobbank_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_ca_workopolis_d] group by msmt_dte_id order by 1 desc

-------------------------------
declare @dte_id as int

set @dte_id = CONVERT(varchar(8), GETDATE(), 112) --20161123


SELECT 'CAREERBUILDER' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_ca_careerbuilder_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'INDEED' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_ca_indeed_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'JOBBANK' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_ca_jobbank_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'SIMPLYHIRED' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_ca_workopolis_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
	  
	  ;	 