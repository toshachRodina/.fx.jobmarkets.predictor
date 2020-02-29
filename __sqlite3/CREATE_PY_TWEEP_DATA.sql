/*
===================================================================================================
TABLE CREATION
===================================================================================================
DROP TABLE PY_EMPL_TWITTER_DATA;

CREATE
	TABLE
		PY_EMPL_TWITTER_DATA(
			ID INTEGER PRIMARY KEY AUTOINCREMENT,
			MSMT_DTE_ID INTEGER,
			CREATED_AT VARCHAR(20),
			TWEET_ID VARCHAR(20),
			USER_ID VARCHAR(20),
			USER_NAME VARCHAR(255),
			USER_SCREEN_NAME VARCHAR(255),
			USER_LOCATION VARCHAR(500),
			CNTRY_ID VARCHAR(20),
			CNTRY_CDE VARCHAR(2),
			PLACE_NAME VARCHAR(255),
			SENTMT_MATCH VARCHAR (50),
			TWEET_TXT VARCHAR(500),
			IN_REPLY_TO VARCHAR(20),
			RE_TWEETED VARCHAR(20),
			PRCES_DTE_ID INTEGER,
			STARTED_AT VARCHAR(20),
			FINISHED_AT VARCHAR(20)
		);


===================================================================================================
*/


SELECT MSMT_DTE_ID
     , CNTRY_CDE
     , count(*)
  FROM PY_TWEEP_DATA
 WHERE 1 = 1
       AND  msmt_dte_id >= strftime(
		'%Y%m%d',
		date(
			'now',
			'localtime',
			'-6 day'
		)
	)
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
