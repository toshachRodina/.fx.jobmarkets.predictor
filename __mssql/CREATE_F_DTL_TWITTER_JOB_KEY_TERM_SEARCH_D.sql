/*
=======================================================================================================================================================================================================
SUBJECT		 : twitter job key terms search data from python/tweepy
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_twitter_job_key_term_search_d
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170830
SOURCE		 : sqlite3 database
PREPERATION	 : 
                  
			   
REMARKS		 : 1) 
			   2) 
			   3)
INDEXES
PK_ for primary keys
UK_ for unique keys
IX_ for non clustered non unique indexes
UX_ for unique indexes
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE LTN.DBO.F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D;

CREATE TABLE LTN.DBO.F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D
( MSMT_DTE_ID            int NOT NULL
, CREATED_AT             datetime NOT NULL
, TWEET_ID               numeric(30, 0) NOT NULL
, TWEET_USER_ID          numeric(30, 0) NOT NULL
, TWEET_USER_NAME        varchar(255) NOT NULL
, TWEET_USER_SCREEN_NAME varchar(255) NULL
, USER_LOCATION          varchar(500) NULL
, CNTRY_ID               varchar(50) NOT NULL
, CNTRY_CDE              varchar(2) NOT NULL
, PLACE_NAME             varchar(255) NOT NULL
, SENTMT_MATCH           varchar(10) NOT NULL
, TWEET_TXT              varchar(500) NOT NULL
, IN_REPLY_TO            varchar(50) NOT NULL
, RE_TWEETED             varchar(10) NOT NULL
, PRCES_DTE_ID           integer NOT NULL
, STARTED_AT             datetime NOT NULL
, FINISHED_AT            datetime NOT NULL
);
CREATE UNIQUE INDEX UX_F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D ON LTN.DBO.F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D ( MSMT_DTE_ID, TWEET_ID, CNTRY_CDE );

ALTER TABLE ltn.dbo.f_dtl_twitter_job_key_term_search_d REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_twitter_job_key_term_search_d   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D', @p_pkg_nme = 'LTN_PKG_F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D'


-- 70,866 day1
-- 80,061 day2
select count(*)
  from LTN.DBO.F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D

select * from ltn.dbo.ctl_ssis_err_log order by task_end_datetime desc
=======================================================================================================================================================================================================
*/


USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_twitter_job_key_term_search_d') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_twitter_job_key_term_search_d AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_twitter_job_key_term_search_d -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
     BEGIN
         --SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD
         SET ANSI_NULLS ON;
         SET QUOTED_IDENTIFIER ON;

/*
=======================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS
=======================================================================================================================================================================================================
*/
         -- TABLES ----------------------------------------------------------------
         DECLARE
                @l_tbl_nme AS nvarchar(50);
         DECLARE
                @l_stg_tbl_nme AS nvarchar(50);
         
         SET @l_tbl_nme = 'f_dtl_twitter_job_key_term_search_d';
	    SET @l_stg_tbl_nme = 'stg_dtl_twitter_job_key_term_search_d' 
	                       
         
         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_prces_dte_id AS nvarchar(8);
	    DECLARE 
			 @l_min_date_id_to_keep as nvarchar(8)

         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

/*
=======================================================================================================================================================================================================
MAIN CODE BLOCK
- TABLE TIDY UP (IF NEEDED)
- INSERT NEW DATA
- SWITCH INTO EMPTY PARTITIONS (IF USING TABLE PARTITIONS)
=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
TRY BLOACK - START
=======================================================================================================================================================================================================
*/
         BEGIN TRY

/*
STEP 1 
---------------------------------------------------------------------------------------------------
** load data from sqlite3 database to sqlserver temp table
** there are duplicate records shown from various sites - distinct removes these
*/
		  
		  CREATE TABLE #TMP_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D
		  ( MSMT_DTE_ID            int NOT NULL
		  , CREATED_AT             datetime NOT NULL
		  , TWEET_ID               numeric (30,0) NOT NULL
		  , TWEET_USER_ID          numeric (30,0) NOT NULL
		  , TWEET_USER_NAME        varchar(255) NOT NULL
		  , TWEET_USER_SCREEN_NAME varchar(255) NULL
		  , USER_LOCATION          varchar(500) NULL
		  , CNTRY_ID               varchar(50) NOT NULL
		  , CNTRY_CDE              varchar(2) NOT NULL
		  , PLACE_NAME             varchar(255) NOT NULL
		  , SENTMT_MATCH           varchar(10) NOT NULL
		  , TWEET_TXT              varchar(500) NOT NULL
		  , IN_REPLY_TO            varchar(50) NOT NULL
		  , RE_TWEETED             varchar(10) NOT NULL
		  , PRCES_DTE_ID           integer NOT NULL
		  , STARTED_AT             datetime NOT NULL
		  , FINISHED_AT            datetime NOT NULL
		  );

		  INSERT INTO #TMP_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D ( MSMT_DTE_ID
												   , CREATED_AT
												   , TWEET_ID
												   , TWEET_USER_ID
												   , TWEET_USER_NAME
												   , TWEET_USER_SCREEN_NAME
												   , USER_LOCATION
												   , CNTRY_ID
												   , CNTRY_CDE
												   , PLACE_NAME
												   , SENTMT_MATCH
												   , TWEET_TXT
												   , IN_REPLY_TO
												   , RE_TWEETED
												   , PRCES_DTE_ID
												   , STARTED_AT
												   , FINISHED_AT
												   )
		  SELECT MSMT_DTE_ID
			  , CREATED_AT
			  , TWEET_ID
			  , TWEET_USER_ID
			  , TWEET_USER_NAME
			  , TWEET_USER_SCREEN_NAME
			  , USER_LOCATION
			  , CNTRY_ID
			  , CNTRY_CDE
			  , PLACE_NAME
			  , SENTMT_MATCH
			  , TWEET_TXT
			  , IN_REPLY_TO
			  , RE_TWEETED
			  , PRCES_DTE_ID
			  , STARTED_AT
			  , FINISHED_AT
		    FROM openquery(PY_TWEEP_DATA, '
								 SELECT   DAT.MSMT_DTE_ID
									   , DAT.CREATED_AT
									   , DAT.TWEET_ID
									   , DAT.USER_ID as TWEET_USER_ID
									   , DAT.USER_NAME as TWEET_USER_NAME
									   , DAT.USER_SCREEN_NAME as TWEET_USER_SCREEN_NAME
									   , DAT.USER_LOCATION
									   , DAT.CNTRY_ID
									   , DAT.CNTRY_CDE
									   , DAT.PLACE_NAME
									   , DAT.SENTMT_MATCH
									   , DAT.TWEET_TXT
									   , DAT.IN_REPLY_TO
									   , DAT.RE_TWEETED
									   , DAT.PRCES_DTE_ID
									   , DAT.STARTED_AT
									   , DAT.FINISHED_AT
								     FROM PY_TWEEP_DATA AS DAT');


/*
STEP 2 
---------------------------------------------------------------------------------------------------
** insert into final f_dtl table 
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)
*/

		  INSERT INTO LTN.DBO.F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D ( MSMT_DTE_ID
													   , CREATED_AT
													   , TWEET_ID
													   , TWEET_USER_ID
													   , TWEET_USER_NAME
													   , TWEET_USER_SCREEN_NAME
													   , USER_LOCATION
													   , CNTRY_ID
													   , CNTRY_CDE
													   , PLACE_NAME
													   , SENTMT_MATCH
													   , TWEET_TXT
													   , IN_REPLY_TO
													   , RE_TWEETED
													   , PRCES_DTE_ID
													   , STARTED_AT
													   , FINISHED_AT
													   )
		  SELECT DISTINCT
			    DAT.MSMT_DTE_ID
			  , DAT.CREATED_AT
			  , DAT.TWEET_ID
			  , DAT.TWEET_USER_ID
			  , DAT.TWEET_USER_NAME
			  , DAT.TWEET_USER_SCREEN_NAME
			  , DAT.USER_LOCATION
			  , DAT.CNTRY_ID
			  , DAT.CNTRY_CDE
			  , DAT.PLACE_NAME
			  , CASE
				    WHEN DAT.MIN_SENTMNT_MATCH != DAT.MAX_SENTMNT_MATCH
				    THEN 'NEG | POS'
				    ELSE DAT.SENTMT_MATCH
			    END AS SENTMT_MATCH
			  , DAT.TWEET_TXT
			  , DAT.IN_REPLY_TO
			  , DAT.RE_TWEETED
			  , DAT.PRCES_DTE_ID
			  , DAT.STARTED_AT
			  , DAT.FINISHED_AT
		    FROM (
			    SELECT TMP.MSMT_DTE_ID
				    , TMP.CREATED_AT
				    , TMP.TWEET_ID
				    , TMP.TWEET_USER_ID
				    , TMP.TWEET_USER_NAME
				    , TMP.TWEET_USER_SCREEN_NAME
				    , TMP.USER_LOCATION
				    , TMP.CNTRY_ID
				    , TMP.CNTRY_CDE
				    , TMP.PLACE_NAME
				    , TMP.SENTMT_MATCH
				    , TMP.TWEET_TXT
				    , TMP.IN_REPLY_TO
				    , TMP.RE_TWEETED
				    , TMP.PRCES_DTE_ID
				    , TMP.STARTED_AT
				    , TMP.FINISHED_AT
				    , min(TMP.SENTMT_MATCH) OVER(PARTITION BY TMP.MSMT_DTE_ID
												    , TMP.TWEET_ID) AS MIN_SENTMNT_MATCH
				    , max(TMP.SENTMT_MATCH) OVER(PARTITION BY TMP.MSMT_DTE_ID
												    , TMP.TWEET_ID) AS MAX_SENTMNT_MATCH
				    , rank() OVER(PARTITION BY TMP.MSMT_DTE_ID
									    , TMP.TWEET_ID ORDER BY TMP.SENTMT_MATCH) AS SENTMT_MATCH_RNK
				    , count(1) OVER(PARTITION BY TMP.MSMT_DTE_ID
										 , TMP.TWEET_ID) AS SENTMT_MATCH_CNT
				 FROM #TMP_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D AS TMP
					 LEFT OUTER JOIN LTN.DBO.F_DTL_TWITTER_JOB_KEY_TERM_SEARCH_D AS DTL
					 ON 1 = 1
					    AND TMP.MSMT_DTE_ID = DTL.MSMT_DTE_ID
					    AND TMP.TWEET_ID = DTL.TWEET_ID
					    AND TMP.CNTRY_CDE = DTL.CNTRY_CDE
				WHERE 1 = 1
					 AND DTL.MSMT_DTE_ID IS NULL
					 AND DTL.TWEET_ID IS NULL
					 AND DTL.CNTRY_CDE IS NULL
			    ) AS DAT
		   WHERE 1 = 1;
						 
         END TRY

/*
=======================================================================================================================================================================================================
TRY BLOACK - END
=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
CATCH BLOACK - START
=======================================================================================================================================================================================================
*/

         BEGIN CATCH

             INSERT INTO ltn.dbo.ctl_ssis_err_log
                    (msmt_dte_id
                   , env
                   , job_nme
                   , task_nme
                   , task_tp
                   , task_start_datetime
                   , task_end_datetime
                   , task_status
                   , task_output
                    )
             SELECT CONVERT(varchar(10), CAST(GETDATE() AS date), 112) AS msmt_dte_id
                  , @p_env
                  , @p_pkg_nme
                  , @p_task_nme
                  , 'SQLSCRIPT'
                  , GETDATE()
                  , GETDATE()
                  , CASE
                        WHEN ERROR_MESSAGE() IS NULL
                        THEN 'SUCCESS'
                        ELSE 'ERROR'
                    END
                  , 'msmt_dte_id variable used : '+CONVERT( varchar(10), CAST(GETDATE() AS date), 112)+' --- error msg : '+ERROR_MESSAGE();

         END CATCH;

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/

     END;

