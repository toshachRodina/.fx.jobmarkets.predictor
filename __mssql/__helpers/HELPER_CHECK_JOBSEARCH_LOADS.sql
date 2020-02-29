use ltn

SELECT MSMT_DTE_ID
     , CNTRY_CDE
     , count(*) as row_count
     , sum(FACET_CNT) as jobs_count
  FROM LTN.DBO.F_DTL_JOB_SCRAPE_D
  WHERE MSMT_DTE_ID >= CONVERT( varchar(10),DATEADD(DAY,-4,GETDATE()),112) --20170125
 GROUP BY MSMT_DTE_ID
        , CNTRY_CDE
 ORDER BY case
		CNTRY_CDE
		when 'AU' then 1
		when 'NZ' then 2
		when 'UK' then 3
		when 'CA' then 4
		when 'US' then 5 end
        , 1 desc;


SELECT MSMT_DTE_ID
     , CNTRY_CDE
     , count(*) as row_count
     , sum(FACET_CNT) as jobs_count
  FROM LTN.DBO.F_DTL_B4S_SCRAPE_D
 GROUP BY MSMT_DTE_ID
        , CNTRY_CDE
 ORDER BY 2
        , 1 desc;

select * FROM LTN.DBO.F_DTL_JOB_SCRAPE_D order by 1,5,6,7,8

SELECT MSMT_DTE_ID
     , CNTRY_CDE
     , count(*)
  FROM LTN.DBO.F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D
 WHERE 1 = 1
       AND MSMT_DTE_ID >= convert(varchar(10), dateadd(DAY, -5, getdate()), 112)
 GROUP BY MSMT_DTE_ID
        , CNTRY_CDE
 ORDER BY CASE CNTRY_CDE
               WHEN 'AU'
               THEN 1
               WHEN 'NZ'
               THEN 2
               WHEN 'UK'
               THEN 3
               WHEN 'CA'
               THEN 4
               WHEN 'US'
               THEN 5
          END
        , 1 DESC;






-- ======================================================================================================
-- CHECK CCY PAIRS
SELECT *
  FROM LTNFX.DBO.DIM_CCY_PAIR_REF
 WHERE 1 = 1
       AND PERIOD_MEASURE = 'TICK'
       --AND PAIR LIKE '%AUD%'
	  AND PAIR NOT LIKE '%AUD%'
	  ;


SELECT *
  FROM LTNFX.DBO.DIM_CCY_PAIR_REF
 WHERE 1 = 1
       AND PERIOD_MEASURE = 'MINUTE'
       --AND PAIR LIKE '%AUD%'
	  --AND PAIR NOT LIKE '%AUD%'
 order by case when pair like '%AUD%' then 0
               when pair like '%CAD%' then 1
               when pair like '%GBP%' then 2
			when pair like '%NZD%' then 3
			when pair like '%USD%' then 4
			else 5 end
	   , 2
	  ;
-- ======================================================================================================


-- ======================================================================================================

SELECT top 100 *
  FROM LTN.DBO.F_DTL_COMMODITY_PRICE_D
 WHERE 1 = 1
      -- AND DATA_TYPE = 'COCOA'
 ORDER BY 1 DESC
        , 4;

-- ======================================================================================================


SELECT *
  FROM DBO.CTL_SSIS_ERR_LOG
 ORDER BY TASK_END_DATETIME DESC;


--delete from [dbo].[sysssislog] where endtime <= datediff(day, 2, getdate())
-- select * from [dbo].[sysssislog] where endtime >= datediff(day, 2, getdate())

SELECT *
  FROM DBO.SYSSSISLOG
 ORDER BY ENDTIME DESC;



/* =====================================================================================================
WEBHARVY - NOT USED ANYMORE - FROM 20170315
===================================================================================================== */
SELECT *
  FROM VW_RPT_JOBSEARCH_DAT AS DAT
 WHERE 1 = 1 --and job_site_nme in ('JORA','JORAX2')
 ORDER BY 1
        , 2
        , 3;
	
select * from [dbo].[F_DTL_GOVT_KDA_M]