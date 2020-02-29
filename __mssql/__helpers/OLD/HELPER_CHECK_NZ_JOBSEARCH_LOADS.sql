-- JOBSEARCH
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_nz_myjobspace_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_nz_trademe_d] group by msmt_dte_id order by 1 desc
select top 5 msmt_dte_id, count(*) from ltn.[dbo].[f_dtl_jobsearch_nz_seek2_d] group by msmt_dte_id order by 1 desc



SELECT msmt_dte_id
     , job_site_nme
     , job_category
     , SUM(job_count) AS job_count
       FROM
            ltn.[dbo].[f_dtl_jobsearch_nz_seek_d]
       GROUP BY msmt_dte_id
              , job_site_nme
              , job_category
       ORDER BY 3;


-------------------------------
declare @dte_id as int

set @dte_id = CONVERT(varchar(8), GETDATE(), 112) --20161123


SELECT 'MYJOBSPACE' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_nz_myjobspace_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'SEEK' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_nz_seek2_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id
UNION ALL
SELECT 'TRADEME' AS jobs_site_desc
     , msmt_dte_id
     , COUNT(*) AS rec_cnt
       FROM
            ltn.dbo.[f_dtl_jobsearch_nz_trademe_d] AS dat
       WHERE 1 = 1
             AND dat.msmt_dte_id = @dte_id --CONVERT(varchar(8), GETDATE(), 112)
       GROUP BY msmt_dte_id

	  ;	 

