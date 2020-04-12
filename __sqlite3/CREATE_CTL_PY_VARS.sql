/*
=======================================================================================================================================================================================================
SUBJECT		 : Control table housing variables required for automating/running python packages
OBJECT TYPE	 : TABLE
OBJECT NAME	 : CTL_PY_VARS
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170328
SOURCE	 : 
PREPERATION	 : CREATE TABLE INSERT VALUES REQUIRED FOR SSIS RUNNING
REMARKS	 : 1) 
           2)
           3)
 
=======================================================================================================================================================================================================

PRAGMA auto_vacuum = FULL;


TABLE CREATION
-----------------------------

DROP TABLE CTL_PY_VARS;

CREATE TABLE CTL_PY_VARS (
    id        INTEGER        PRIMARY KEY AUTOINCREMENT,
    ENV       VARCHAR (6)    NOT NULL,
    PKG_NME   VARCHAR (150),
    VAR_TYPE  VARCHAR (6)    NOT NULL,
    VAR_NME   VARCHAR (150)  NOT NULL,
    VAR_VAL   VARCHAR (2000) NOT NULL,
    VAR_CMNTS VARCHAR (2000) NOT NULL
);

select pkg_nme,max(case when var_nme = 'SITE_CDE' then var_val else '' end) as site_cde
,max(case when var_nme = 'CNTRY_CDE' then var_val else '' end) as cntry_cde
,max(case when var_nme = 'URL' then var_val else '' end) as site_url
 from CTL_PY_VARS where pkg_nme in (select pkg_nme from CTL_PY_VARS where var_val = 'JOBS') and var_nme in ('URL','SITE_CDE','CNTRY_CDE') 
 group by pkg_nme

 
select *
 from CTL_PY_VARS where pkg_nme ='PY_JOBS_US_SIMPLYHIRED' in (select pkg_nme from CTL_PY_VARS where var_val = 'JOBS') and var_nme in ('URL','SITE_CDE') 

select distinct pkg_nme from CTL_PY_VARS where 1 = 1 order by 1


select * from CTL_PY_VARS where var_nme = 'PYTHON_SCRIPT_PATH_JOBS'
=======================================================================================================================================================================================================
*/

delete from CTL_PY_VARS;
-- ENVIRONMENT PARAMETERS
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_SNDR_USRNME','lanoitan17@gmail.com','email sender username/address for email notifications');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_SNDR_PWORD','500BourkeStreet','email sender password');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','DATA_RETENTION_DAYS','180','number of days to keep data within sqlite tables.  is overridden if a pkg variable is present');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_MSG','','generic email message. is overridden if pkg variable is present');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','LOOP_RNDM_SLEEP_LOW','1','sets the lower limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','LOOP_RNDM_SLEEP_HIGH','5','sets the higher limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','WEB_DRVR_NME','chromedriver.exe','the web driver used for the selenium parser');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','DEFAULT_SYS_DOWNLOAD_PATH','C:\Users\tosha\Downloads','file path to default system download folder');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TABLEAU_RPT_PATH','D:\Sync\__lanoitan_dev\__reports\__tableau\\','file path to tableau reporting folder');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','PYTHON_SCRIPT_PATH_JOBS','D:\Sync\__lanoitan\__scripts\__python\jobs\\','file path to relevant scripts');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','PYTHON_SCRIPT_PATH_B4S','D:\Sync\__lanoitan\__scripts\__python\b4s\\','file path to relevant scripts');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','PYTHON_SCRIPT_PATH_MARKETS','D:\Sync\__lanoitan\__scripts\__python\markets\\','file path to relevant scripts');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','GMAIL_SMTP_HOST','smtp.gmail.com','smtp host details for gmail');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','GMAIL_SMTP_HOST','587','smtp port number for gmail');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','PYTHON_EXE_PATH','C:\Users\tosha\Anaconda3\envs\lanoitan\python.exe','python executable path');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','ALPHAVANTAGE_API_KEY','56K58AYA092DZZPA','api key');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','QUANDL_API_KEY','-7YMD_XEY7yvNsYDX92s','api key');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_CNSMR_KEY','EO3DcdljWwxN4TKrUUB27Nn96','api key');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_CNSMR_SECRET','H9XFfndnoGXrepH5RQA9N2hCaSWJHNV66t9DXXz5DDF1CPXJWp','api secret');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_ACCESS_TOKEN','12577272-frRvqnqx1IfaKuwy5aOe172ppKeBL2ta6AAUtsQns','access token');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_ACCESS_SECRET','qfneff6FA12lz3otz4jdXFEQZqyplrrAJuqlZUAe7hEpI','access token secret');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_MAX_TWEETS','10000000','arbitrary large number to use for the REST api of tweepy to maximise output');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_TWEETS_PER_QRY','100','1009 is the maximum the tweepy api permits');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_SNDR_USRNME','lanoitan17@gmail.com','email sender username/address for email notifications');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_SNDR_PWORD','500BourkeStreet','email sender password');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','DATA_RETENTION_DAYS','180','number of days to keep data within sqlite tables.  is overridden if a pkg variable is present');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_MSG','sent from DEV','generic email message. is overridden if pkg variable is present');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','LOOP_RNDM_SLEEP_LOW','1','sets the lower limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','LOOP_RNDM_SLEEP_HIGH','5','sets the higher limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','WEB_DRVR_NME','chromedriver.exe','the web driver used for the selenium parser');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','DEFAULT_SYS_DOWNLOAD_PATH','E:\Downloads','file path to default system download folder');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','TABLEAU_RPT_PATH','D:\Sync\__lanoitan_dev\__reports\__tableau\\','file path to tableau reporting folder');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','PYTHON_SCRIPT_PATH_JOBS','D:\Sync\__lanoitan_dev\__scripts\__python\jobs\\','file path to relevant scripts');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','PYTHON_SCRIPT_PATH_B4S','D:\Sync\__lanoitan_dev\__scripts\__python\b4s\\','file path to relevant scripts');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','PYTHON_SCRIPT_PATH_MARKETS','D:\Sync\__lanoitan_dev\__scripts\__python\markets\\','file path to relevant scripts');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','GMAIL_SMTP_HOST','smtp.gmail.com','smtp host details for gmail');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','GMAIL_SMTP_HOST','587','smtp port number for gmail');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','PYTHON_EXE_PATH','C:\Users\User\Anaconda3\envs\lanoitan\python.exe','python executable path');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','ALPHAVANTAGE_API_KEY','56K58AYA092DZZPA','api key');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','QUANDL_API_KEY','-7YMD_XEY7yvNsYDX92s','api key');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','TWIT_CNSMR_KEY','EO3DcdljWwxN4TKrUUB27Nn96','api key');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','TWIT_CNSMR_SECRET','H9XFfndnoGXrepH5RQA9N2hCaSWJHNV66t9DXXz5DDF1CPXJWp','api secret');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','TWIT_ACCESS_TOKEN','12577272-frRvqnqx1IfaKuwy5aOe172ppKeBL2ta6AAUtsQns','access token');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','TWIT_ACCESS_SECRET','qfneff6FA12lz3otz4jdXFEQZqyplrrAJuqlZUAe7hEpI','access token secret');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','TWIT_MAX_TWEETS','10000000','arbitrary large number to use for the REST api of tweepy to maximise output');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','TWIT_TWEETS_PER_QRY','100','1009 is the maximum the tweepy api permits');


/* 
==============================================================================================================================
TWITTER 
============================================================================================================================== 
*/
-- PY_BATCH_TWEEPS (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_TWITTER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_TWITTER','PKG','PKGS_TO_RUN','PY_EMP_TWITTER','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_TWITTER','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');

-- PY_TWITTER_REST_JOBS
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','SMRY_DESC','(NA)','using tweepy, scan tweets from twitter for key terms and phrases.  multiple subject areas may be present and seperating these programatically may be necessary');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','TBL_NME','TWITDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','CNTRY_CDE','AU,CA,NZ,UK,US','regions to pull tweets from');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_TEST','"donald trump","australian survivor"','test');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_NEG_1','"am dismissed","am redundant","axed","be fired","been dismissed","been fired","been sacked","being fired","canned","down sized","downsized","fired from","get fired","got fired","got sacked","just fired","laid off","laidoff"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_NEG_2','"lay off","layed off","layoff","made redundant","outsourced","pink slip","pinkslip","unemploy","unemployed","unemployment","was dismissed","was fired","lost job","lost my job","lost the job","fired from job","fired from my job"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_NEG_3','"fired from the job","fired from work","fired from my work","fired from the work","got sack","got the sack"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_1','"job opportunities","job opportunity","work opportunities","work opportunity","jobs near","job near","work near","find a job","find new job","find a new job","find myself a job","find myself a new job","find work","find some work"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_2','"find some new work","find new work","find myself work","find some work","find some new work","look for job","look for a job","look for new job","look for a new job","looking for job","looking for a job","looking for new job"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_3','"looking for a new job","looking for any job","look for work","look for new work","look for some work","look for some new work","looking for work","looking for new work","looking for some work","looking for some new work"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_4','"looking for any work","need new job","need a new job","need a job","need work","need some work","need some new work","search for job","search for a job","search for a new job","looking for job","looking for new job"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_5','"looking for some new job","looking for any job","search for work","search for work","search for new work","searching for work","searching for new work","searching for some work","searching for some new work"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_6','"searching for any work","seek job","seek a job","seek new job","seek a new job","seeking job","seeking a job","seeking a new job","seeking for job","seeking any job","seek position","seek a position","seek new position"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_7','"seek a new position","seeking position","seeking new position","seeking some position","seeking some new position","seeking any position","seek work","seek new work","seek some work","seek some new work","seeking work"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_8','"seeking new work","seeking some work","seeking some new work","seeking any work","hiring for","hiring at","hiring in","jobs near"','key terms and phrases to capture through twitter - specific to job losses and application');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','SMRY_DESC','(NA)','using tweepy, scan tweets from twitter for key terms and phrases.  multiple subject areas may be present and seperating these programatically may be necessary');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','TBL_NME','TWITDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','CNTRY_CDE','AU,CA,NZ,UK,US','regions to pull tweets from');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_TEST','"donald trump","australian survivor"','test');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_NEG_1','"am dismissed","am redundant","axed","be fired","been dismissed","been fired","been sacked","being fired","canned","down sized","downsized","fired from","get fired","got fired","got sacked","just fired","laid off","laidoff"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_NEG_2','"lay off","layed off","layoff","made redundant","outsourced","pink slip","pinkslip","unemploy","unemployed","unemployment","was dismissed","was fired","lost job","lost my job","lost the job","fired from job","fired from my job"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_NEG_3','"fired from the job","fired from work","fired from my work","fired from the work","got sack","got the sack"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_1','"job opportunities","job opportunity","work opportunities","work opportunity","jobs near","job near","work near","find a job","find new job","find a new job","find myself a job","find myself a new job","find work","find some work"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_2','"find some new work","find new work","find myself work","find some work","find some new work","look for job","look for a job","look for new job","look for a new job","looking for job","looking for a job","looking for new job"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_3','"looking for a new job","looking for any job","look for work","look for new work","look for some work","look for some new work","looking for work","looking for new work","looking for some work","looking for some new work"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_4','"looking for any work","need new job","need a new job","need a job","need work","need some work","need some new work","search for job","search for a job","search for a new job","looking for job","looking for new job"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_5','"looking for some new job","looking for any job","search for work","search for work","search for new work","searching for work","searching for new work","searching for some work","searching for some new work"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_6','"searching for any work","seek job","seek a job","seek new job","seek a new job","seeking job","seeking a job","seeking a new job","seeking for job","seeking any job","seek position","seek a position","seek new position"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_7','"seek a new position","seeking position","seeking new position","seeking some position","seeking some new position","seeking any position","seek work","seek new work","seek some work","seek some new work","seeking work"','key terms and phrases to capture through twitter - specific to job losses and application');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_EMP_TWITTER','PKG','KEY_PHRASES_POS_8','"seeking new work","seeking some work","seeking some new work","seeking any work","hiring for","hiring at","hiring in","jobs near"','key terms and phrases to capture through twitter - specific to job losses and application');


/* 
==============================================================================================================================
MARKETS
============================================================================================================================== 
*/
-- PY_BATCH_MARKETS (CONTROLS WHAT SCRIPTS IN THE "MARKETS" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','PKGS_TO_RUN','PY_COMMODITIES','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_MARKETS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_MARKETS','PKG','PKGS_TO_RUN','PY_COMMODITIES','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_MARKETS','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');

-- PY_COMMODITIES
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','SMRY_DESC','(NA)','using the yahoo finance API, retrieve various commoditiy prices per day');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','TBL_NME','WEBDATA_COMMODITY','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','CMDTY_CDES','NASDAQOMX/NQUSB1771AUD,NASDAQOMX/NQUSB1771AUDN,NASDAQOMX/NQUSB1771AUDT,NASDAQOMX/NQUSB1771CAD,NASDAQOMX/NQUSB1771CADT,NASDAQOMX/NQUSB1771GBP,NASDAQOMX/NQUSB1771GBPT,NASDAQOMX/QCOL,NASDAQOMX/NQCICCER,NASDAQOMX/NQCICCTR,NASDAQOMX/NQCIKCER,NASDAQOMX/NQCIKCTR,NASDAQOMX/NQCICUER,NASDAQOMX/NQCICUTR,NASDAQOMX/NQCIHGER,NASDAQOMX/NQCIHGTR,NASDAQOMX/NQAU0001,NASDAQOMX/NQAU0001T,NASDAQOMX/NQCA0001,NASDAQOMX/NQCA0001T,NASDAQOMX/NQCICLER,NASDAQOMX/NQCICLTR,NASDAQOMX/NQG0001,NASDAQOMX/NQG0001T,NASDAQOMX/NQGB0001,NASDAQOMX/NQGB0001T,NASDAQOMX/NQNA0001,NASDAQOMX/NQCIGCER,NASDAQOMX/NQCIGCTR,NASDAQOMX/NQXAUGLD,NASDAQOMX/NQXAUGLD,NASDAQOMX/XAU,NASDAQOMX/NQUSB1757AUD,NASDAQOMX/NQUSB1757AUDN,NASDAQOMX/NQUSB1757AUDT,NASDAQOMX/NQUSB1757CAD,NASDAQOMX/NQUSB1757CADN,NASDAQOMX/NQUSB1757CADT,NASDAQOMX/NQUSB1757GBPN,NASDAQOMX/NQCINGER,NASDAQOMX/NQCINGTR,NASDAQOMX/NQCISIER,NASDAQOMX/NQCISITR','codes used to query api database');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_COMMODITIES','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_COMMODITIES','PKG','SMRY_DESC','(NA)','using the yahoo finance API, retrieve various commoditiy prices per day');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_COMMODITIES','PKG','TBL_NME','WEBDATA_COMMODITY','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_COMMODITIES','PKG','CMDTY_CDES','NASDAQOMX/NQUSB1771AUD,NASDAQOMX/NQUSB1771AUDN,NASDAQOMX/NQUSB1771AUDT,NASDAQOMX/NQUSB1771CAD,NASDAQOMX/NQUSB1771CADT,NASDAQOMX/NQUSB1771GBP,NASDAQOMX/NQUSB1771GBPT,NASDAQOMX/QCOL,NASDAQOMX/NQCICCER,NASDAQOMX/NQCICCTR,NASDAQOMX/NQCIKCER,NASDAQOMX/NQCIKCTR,NASDAQOMX/NQCICUER,NASDAQOMX/NQCICUTR,NASDAQOMX/NQCIHGER,NASDAQOMX/NQCIHGTR,NASDAQOMX/NQAU0001,NASDAQOMX/NQAU0001T,NASDAQOMX/NQCA0001,NASDAQOMX/NQCA0001T,NASDAQOMX/NQCICLER,NASDAQOMX/NQCICLTR,NASDAQOMX/NQG0001,NASDAQOMX/NQG0001T,NASDAQOMX/NQGB0001,NASDAQOMX/NQGB0001T,NASDAQOMX/NQNA0001,NASDAQOMX/NQCIGCER,NASDAQOMX/NQCIGCTR,NASDAQOMX/NQXAUGLD,NASDAQOMX/NQXAUGLD,NASDAQOMX/XAU,NASDAQOMX/NQUSB1757AUD,NASDAQOMX/NQUSB1757AUDN,NASDAQOMX/NQUSB1757AUDT,NASDAQOMX/NQUSB1757CAD,NASDAQOMX/NQUSB1757CADN,NASDAQOMX/NQUSB1757CADT,NASDAQOMX/NQUSB1757GBPN,NASDAQOMX/NQCINGER,NASDAQOMX/NQCINGTR,NASDAQOMX/NQCISIER,NASDAQOMX/NQCISITR','codes used to query api database');


/* 
==============================================================================================================================
ECONOMIC CALENDAR
============================================================================================================================== 
*/
-- PY_BATCH_ECO_CAL (CONTROLS WHAT SCRIPTS IN THE "GOVT_KDA" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_CALENDAR','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_CALENDAR','PKG','PKGS_TO_RUN','PY_ECONOMIC_CALENDAR','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_CALENDAR','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_CALENDAR','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_CALENDAR','PKG','PKGS_TO_RUN','PY_ECONOMIC_CALENDAR','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_CALENDAR','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_ECONOMIC_CALENDAR
-- PROD 
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ECONOMIC_CALENDAR','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ECONOMIC_CALENDAR','PKG','SMRY_DESC','(NA)','scrapes key dates listed on forex factory');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ECONOMIC_CALENDAR','PKG','URL','https://www.forexfactory.com/calendar.php?month=','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ECONOMIC_CALENDAR','PKG','TBL_NME','WEBDATA_ECONOMIC_CALENDAR','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ECONOMIC_CALENDAR','PKG','DATA_TYPE','ECONOMIC ANNOUNCEMENT','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ECONOMIC_CALENDAR','PKG','SITE_CDE','FOREXFACTORY','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ECONOMIC_CALENDAR','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ECONOMIC_CALENDAR','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ECONOMIC_CALENDAR','PKG','SMRY_DESC','(NA)','scrapes key dates listed on forex factory');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ECONOMIC_CALENDAR','PKG','URL','https://www.forexfactory.com/calendar.php?month=','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ECONOMIC_CALENDAR','PKG','TBL_NME','WEBDATA_ECONOMIC_CALENDAR','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ECONOMIC_CALENDAR','PKG','DATA_TYPE','ECONOMIC ANNOUNCEMENT','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ECONOMIC_CALENDAR','PKG','SITE_CDE','FOREXFACTORY','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ECONOMIC_CALENDAR','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');

/* 
==============================================================================================================================
GOVERNMENT DATA
============================================================================================================================== 
*/
-- PY_BATCH_GOVT_DATA_MEDIA_RELEASE (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_DATA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_DATA','PKG','PKGS_TO_RUN','PY_GOVT_DATA_AU_LABOUR_FORCE','list of packages to be run within the current folder (comma(,) delimeted)');                                                                                                                                       
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_DATA','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_GOVT_DATA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_GOVT_DATA','PKG','PKGS_TO_RUN','PY_GOVT_DATA_AU_LABOUR_FORCE','list of packages to be run within the current folder (comma(,) delimeted)');                                                                                                                                       
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_GOVT_DATA','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_GOVT_DATA_AU_LABOUR_FORCE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','SMRY_DESC','(NA)','scrapes data from the australian government website specific labour force related material');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','URL','http://www.abs.gov.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','URL_PART1','/AUSSTATS/abs@.nsf/DetailsPage/6202.0','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','TBL_NME_LABOUR_FORCE_STATUS','ABSDATA_JOBADS_AU','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','FILE_NME_LABOUR_FORCE_STATUS','6202001','file name of the target spreadsheet on website to be scraped');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','FILE_MOVE_DEST_PATH','D:\Sync\__lanoitan\@data\__labour_force\\','destination folder path to store files temporarily');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','DATA_TYPE','LABOUR FORCE','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','SITE_CDE','ABS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_ABS_LABOUR_FORCE_AU','PKG','FILES_TO_GET_EXT','.xls','extension (file type) of the files to retrieve from web page');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','SMRY_DESC','(NA)','scrapes data from the australian government website specific labour force related material');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','URL','http://www.abs.gov.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','URL_PART1','/AUSSTATS/abs@.nsf/DetailsPage/6202.0','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','TBL_NME_LABOUR_FORCE_STATUS','ABSDATA_JOBADS_AU','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','FILE_NME_LABOUR_FORCE_STATUS','6202001','file name of the target spreadsheet on website to be scraped');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','FILE_MOVE_DEST_PATH','D:\Sync\__lanoitan\@data\__labour_force\\','destination folder path to store files temporarily');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','DATA_TYPE','LABOUR FORCE','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','SITE_CDE','ABS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_ABS_LABOUR_FORCE_AU','PKG','FILES_TO_GET_EXT','.xls','extension (file type) of the files to retrieve from web page');
/* 
==============================================================================================================================
BUSINESS FOR SALE
============================================================================================================================== 
*/
-- PY_BATCH_B4S_AU (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_B4S_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_B4S_AU','PKG','PKGS_TO_RUN','B4S_AU_BUSINESSFORSALE,PY_B4S_AU_SEEK','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_B4S_AU','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_B4S_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_B4S_AU','PKG','PKGS_TO_RUN','PY_B4S_AU_BUSINESSFORSALE,PY_B4S_AU_SEEK','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_B4S_AU','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_B4S_AU_DOMAIN
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the DOMAIN website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','URL','http://business.domain.com.au/search/buy/?ltype=business&searchtype=business','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','TBL_NME','WEBDATA_B4SADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','DATA_TYPE','B4S','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','SITE_CDE','DOMAIN','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the DOMAIN website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','URL','http://business.domain.com.au/search/buy/?ltype=business&searchtype=business','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','TBL_NME','WEBDATA_B4SADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','DATA_TYPE','B4S','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','SITE_CDE','DOMAIN','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_DOMAIN','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- PY_B4S_AU_BUSINESSFORSALE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the BUSINESSFORSALE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','URL','https://www.businessforsale.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','TBL_NME','WEBDATA_B4SADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','DATA_TYPE','B4S','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','SITE_CDE','BUSINESSFORSALE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_BUSINESSFORSALE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_BUSINESSFORSALE','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the BUSINESSFORSALE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_BUSINESSFORSALE','PKG','URL','https://www.businessforsale.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_BUSINESSFORSALE','PKG','TBL_NME','WEBDATA_B4SADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_BUSINESSFORSALE','PKG','DATA_TYPE','B4S','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_BUSINESSFORSALE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_BUSINESSFORSALE','PKG','SITE_CDE','BUSINESSFORSALE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_BUSINESSFORSALE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_B4S_AU_SEEK
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the SEEK website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','URL','https://www.seekbusiness.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','TBL_NME','WEBDATA_B4SADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','DATA_TYPE','B4S','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_SEEK','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the SEEK website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_SEEK','PKG','URL','https://www.seekbusiness.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_SEEK','PKG','TBL_NME','WEBDATA_B4SADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_SEEK','PKG','DATA_TYPE','B4S','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_SEEK','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_B4S_AU_SEEK','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
JOBS AU
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_AU (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_AU','PKG','PKGS_TO_RUN','PY_JOBS_AU_ADZUNA,PY_JOBS_AU_CAREERJET,PY_JOBS_AU_GUMTREE,PY_JOBS_AU_HAYS,PY_JOBS_AU_INDEED,PY_JOBS_AU_JOBSEARCH,PY_JOBS_AU_JOBSERVE,PY_JOBS_AU_JORA,PY_JOBS_AU_JORAX2,PY_JOBS_AU_SEEK','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_AU','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_AU','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_AU','PKG','PKGS_TO_RUN','PY_JOBS_AU_ADZUNA,PY_JOBS_AU_CAREERJET,PY_JOBS_AU_GUMTREE,PY_JOBS_AU_HAYS,PY_JOBS_AU_INDEED,PY_JOBS_AU_JOBSEARCH,PY_JOBS_AU_JOBSERVE,PY_JOBS_AU_JORA,PY_JOBS_AU_JORAX2,PY_JOBS_AU_SEEK','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_AU','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_AU','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- PY_JOBS_AU_ADZUNA
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','SMRY_DESC','(NA)','scrapes job listings from the ADZUNA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','URL','https://www.adzuna.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','URL_PART1','/search?w=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','SITE_CDE','ADZUNA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','SMRY_DESC','(NA)','scrapes job listings from the ADZUNA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','URL','https://www.adzuna.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','URL_PART1','/search?w=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','SITE_CDE','ADZUNA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ADZUNA','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- PY_JOBS_AU_CAREERJET
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','URL','http://www.careerjet.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_CAREERJET','PKG','URL','http://www.careerjet.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_CAREERJET','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_GUMTREE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','SMRY_DESC','(NA)','scrapes job listings from the GUMTREE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','URL','http://www.gumtree.com.au/s-jobs/c9302?ad=offering','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','SITE_CDE','GUMTREE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_GUMTREE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_GUMTREE','PKG','SMRY_DESC','(NA)','scrapes job listings from the GUMTREE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_GUMTREE','PKG','URL','http://www.gumtree.com.au/s-jobs/c9302?ad=offering','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_GUMTREE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_GUMTREE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_GUMTREE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_GUMTREE','PKG','SITE_CDE','GUMTREE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_GUMTREE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_HAYS
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','SMRY_DESC','(NA)','scrapes job listings from the HAYS website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','URL','https://www.hays.com.au/jobs/','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','SITE_CDE','HAYS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_HAYS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_HAYS','PKG','SMRY_DESC','(NA)','scrapes job listings from the HAYS website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_HAYS','PKG','URL','https://www.hays.com.au/jobs/','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_HAYS','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_HAYS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_HAYS','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_HAYS','PKG','SITE_CDE','HAYS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_HAYS','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_INDEED
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','URL','https://au.indeed.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','INDUSTRY','RETAIL-JOBS,ACCOUNTING-JOBS,SALES-JOBS,DRIVER-JOBS,PART-TIME-JOBS,GRADUATE-JOBS,DATA-ENTRY-JOBS,RECEPTIONIST-JOBS,MARKETING-JOBS,CONSTRUCTION-JOBS,WORK-FROM-HOME-JOBS,CUSTOMER-SERVICE-JOBS,ADMIN-JOBS,TEACHING-JOBS,INSURANCE-JOBS,HOTEL-JOBS,CALL-CENTRE-JOBS,IT-JOBS,HEALTHCARE-JOBS,FINANCE-JOBS,MEDIA-JOBS,ENTRY-LEVEL-JOBS,DRIVING-JOBS,ART-JOBS','categories used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','URL','https://au.indeed.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_INDEED','PKG','INDUSTRY','RETAIL-JOBS,ACCOUNTING-JOBS,SALES-JOBS,DRIVER-JOBS,PART-TIME-JOBS,GRADUATE-JOBS,DATA-ENTRY-JOBS,RECEPTIONIST-JOBS,MARKETING-JOBS,CONSTRUCTION-JOBS,WORK-FROM-HOME-JOBS,CUSTOMER-SERVICE-JOBS,ADMIN-JOBS,TEACHING-JOBS,INSURANCE-JOBS,HOTEL-JOBS,CALL-CENTRE-JOBS,IT-JOBS,HEALTHCARE-JOBS,FINANCE-JOBS,MEDIA-JOBS,ENTRY-LEVEL-JOBS,DRIVING-JOBS,ART-JOBS','categories used in site search');
-- PY_JOBS_AU_JOBSEARCH
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSEARCH website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','URL','https://jobsearch.gov.au/jobs-by-industry','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','SITE_CDE','JOBSEARCH','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSEARCH','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSEARCH','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSEARCH website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSEARCH','PKG','URL','https://jobsearch.gov.au/jobs-by-industry','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSEARCH','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSEARCH','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSEARCH','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSEARCH','PKG','SITE_CDE','JOBSEARCH','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSEARCH','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_JOBSERVE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','URL','https://www.jobserve.com/au/en/JobSearch.aspx','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSERVE','PKG','URL','https://www.jobserve.com/au/en/JobSearch.aspx','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSERVE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSERVE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_JORA
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','URL','https://au.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','URL','https://au.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORA','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- PY_JOBS_AU_JORAX2
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','URL','https://au.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','URL','https://au.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_JORAX2','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_SEEK
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','SMRY_DESC','(NA)','scrapes job listings from the SEEK website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','URL','https://www.seek.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','URL_PART1','/jobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','URL_PART2','/in-','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','SMRY_DESC','(NA)','scrapes job listings from the SEEK website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','URL','https://www.seek.com.au','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','URL_PART1','/jobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','URL_PART2','/in-','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_SEEK','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
/* 
==============================================================================================================================
JOBS CA
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_CA (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_CA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_CA','PKG','PKGS_TO_RUN','PY_JOBS_CA_CAREERBUILDER,PY_JOBS_CA_CAREERJET,PY_JOBS_CA_INDEED,PY_JOBS_CA_JOBBANK,PY_JOBS_CA_JOBSERVE,PY_JOBS_CA_WORKOPOLIS','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_CA','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_CA','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_CA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_CA','PKG','PKGS_TO_RUN','PY_JOBS_CA_CAREERBUILDER,PY_JOBS_CA_CAREERJET,PY_JOBS_CA_INDEED,PY_JOBS_CA_JOBBANK,PY_JOBS_CA_JOBSERVE,PY_JOBS_CA_WORKOPOLIS','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_CA','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_CA','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- PY_JOBS_CA_CAREERBUILDER
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERBUILDER website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','URL','http://www.careerbuilder.ca/search?q=&loc=','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','SITE_CDE','CAREERBUILDER','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERBUILDER website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','URL','http://www.careerbuilder.ca/search?q=&loc=','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','SITE_CDE','CAREERBUILDER','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERBUILDER','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- PY_JOBS_CA_CAREERJET
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','URL','http://www.careerjet.ca','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERJET','PKG','URL','http://www.careerjet.ca','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERJET','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_CA_INDEED
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','URL','https://ca.indeed.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','INDUSTRY','MARKETING-JOBS,CUSTOMER-SERVICE-JOBS,HUMAN-RESOURCES-JOBS,ADMINISTRATIVE-JOBS,RECEPTIONIST-JOBS,CONSTRUCTION-JOBS,FINANCE-JOBS,NURSE-JOBS,HEALTHCARE-JOBS,SECURITY-JOBS,ACCOUNTING-JOBS,RETAIL-JOBS,SUPPLY-CHAIN-JOBS,LEGAL-ASSISTANT-JOBS,IT-JOBS,GRAPHIC-DESIGN-JOBS,REAL-ESTATE-JOBS,WAREHOUSE-JOBS,CLERK-JOBS,CASHIER-JOBS,MANAGEMENT-JOBS,CLERICAL-JOBS,CALL-CENTER-JOBS,BILINGUAL-JOBS','categories used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','URL','https://ca.indeed.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_INDEED','PKG','INDUSTRY','MARKETING-JOBS,CUSTOMER-SERVICE-JOBS,HUMAN-RESOURCES-JOBS,ADMINISTRATIVE-JOBS,RECEPTIONIST-JOBS,CONSTRUCTION-JOBS,FINANCE-JOBS,NURSE-JOBS,HEALTHCARE-JOBS,SECURITY-JOBS,ACCOUNTING-JOBS,RETAIL-JOBS,SUPPLY-CHAIN-JOBS,LEGAL-ASSISTANT-JOBS,IT-JOBS,GRAPHIC-DESIGN-JOBS,REAL-ESTATE-JOBS,WAREHOUSE-JOBS,CLERK-JOBS,CASHIER-JOBS,MANAGEMENT-JOBS,CLERICAL-JOBS,CALL-CENTER-JOBS,BILINGUAL-JOBS','categories used in site search');
-- PY_JOBS_CA_JOBBANK
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBBANK website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','URL','http://www.jobbank.gc.ca','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','URL_PART1','/jobsearch/jobsearch','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','SITE_CDE','JOBBANK','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBBANK website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','URL','http://www.jobbank.gc.ca','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','URL_PART1','/jobsearch/jobsearch','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','SITE_CDE','JOBBANK','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBBANK','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_CA_JOBSERVE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','URL','https://www.jobserve.com/ca/en/JobSearch.aspx','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','URL_PART1','/jobsearch/jobsearch','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','URL','https://www.jobserve.com/ca/en/JobSearch.aspx','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','URL_PART1','/jobsearch/jobsearch','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_CA_WORKOPOLIS
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','SMRY_DESC','(NA)','scrapes job listings from the WORKOPOLIS website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','URL','https://www.workopolis.com/jobsearch/browse-jobs/','source url to scrape - previous url - http://www.workopolis.com/jobsearch/find-jobs - broke on 20170915'); 
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','SITE_CDE','WORKOPOLIS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_WORKOPOLIS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_WORKOPOLIS','PKG','SMRY_DESC','(NA)','scrapes job listings from the WORKOPOLIS website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_WORKOPOLIS','PKG','URL','https://www.workopolis.com/jobsearch/browse-jobs/','source url to scrape - previous url - http://www.workopolis.com/jobsearch/find-jobs - broke on 20170915'); 
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_WORKOPOLIS','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_WORKOPOLIS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_WORKOPOLIS','PKG','CNTRY_CDE','CA','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_WORKOPOLIS','PKG','SITE_CDE','WORKOPOLIS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_CA_WORKOPOLIS','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
JOBS NZ
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_NZ (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','PKGS_TO_RUN','PY_JOBS_NZ_CAREERJET,PY_JOBS_NZ_INDEED,PY_JOBS_NZ_JORA,PY_JOBS_NZ_JORAX2,PY_JOBS_NZ_MYJOBSPACE,PY_JOBS_NZ_SEEK,PY_JOBS_NZ_TRADEME','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_NZ','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_NZ','PKG','PKGS_TO_RUN','PY_JOBS_NZ_CAREERJET,PY_JOBS_NZ_INDEED,PY_JOBS_NZ_JORA,PY_JOBS_NZ_JORAX2,PY_JOBS_NZ_MYJOBSPACE,PY_JOBS_NZ_SEEK,PY_JOBS_NZ_TRADEME','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_NZ','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_NZ','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_NZ','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- PY_JOBS_NZ_CAREERJET
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','URL','http://www.careerjet.co.nz','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_CAREERJET','PKG','URL','http://www.careerjet.co.nz','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_CAREERJET','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_INDEED
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','URL','https://nz.indeed.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','INDUSTRY','GOVERNMENT-JOBS,ACCOUNTING-JOBS,DRIVER-JOBS,ENGINEERING-JOBS,IT-JOBS,RETAIL-JOBS,CONSTRUCTION-JOBS,SALES-JOBS,ADMINISTRATION-JOBS,FINANCE-JOBS,MARKETING-JOBS,NURSE-JOBS,HEALTHCARE-JOBS,MANAGEMENT-JOBS,TEACHING-JOBS,DATA-ENTRY-JOBS,INSURANCE-JOBS,CUSTOMER-SERVICE-JOBS,SCIENCE-JOBS,BANKING-JOBS,RECEPTIONIST-JOBS,HOSPITALITY-JOBS,HR-JOBS,CALL-CENTRE-JOBS','categories used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','URL','https://nz.indeed.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_INDEED','PKG','INDUSTRY','GOVERNMENT-JOBS,ACCOUNTING-JOBS,DRIVER-JOBS,ENGINEERING-JOBS,IT-JOBS,RETAIL-JOBS,CONSTRUCTION-JOBS,SALES-JOBS,ADMINISTRATION-JOBS,FINANCE-JOBS,MARKETING-JOBS,NURSE-JOBS,HEALTHCARE-JOBS,MANAGEMENT-JOBS,TEACHING-JOBS,DATA-ENTRY-JOBS,INSURANCE-JOBS,CUSTOMER-SERVICE-JOBS,SCIENCE-JOBS,BANKING-JOBS,RECEPTIONIST-JOBS,HOSPITALITY-JOBS,HR-JOBS,CALL-CENTRE-JOBS','categories used in site search');
-- PY_JOBS_NZ_JORA
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','URL','https://nz.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','URL_PART1','/j?q=&l=New+Zealand&sp=homepage','additional url parts - typical used for search paramaters.... 20170531 - changed from /j?q=&l=&sp=homepage');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','URL','https://nz.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','URL_PART1','/j?q=&l=New+Zealand&sp=homepage','additional url parts - typical used for search paramaters.... 20170531 - changed from /j?q=&l=&sp=homepage');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_JORAX2
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','URL','https://nz.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','URL','https://nz.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_JORAX2','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_MYJOBSPACE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','SMRY_DESC','(NA)','scrapes job listings from the MYJOBSPACE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','URL','https://www.myjobspace.co.nz/find-jobs/','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','SITE_CDE','MYJOBSPACE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_MYJOBSPACE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_MYJOBSPACE','PKG','SMRY_DESC','(NA)','scrapes job listings from the MYJOBSPACE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_MYJOBSPACE','PKG','URL','https://www.myjobspace.co.nz/find-jobs/','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_MYJOBSPACE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_MYJOBSPACE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_MYJOBSPACE','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_MYJOBSPACE','PKG','SITE_CDE','MYJOBSPACE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_MYJOBSPACE','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_SEEK
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','SMRY_DESC','(NA)','scrapes job listings from the SEEK website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','URL','https://www.seek.co.nz','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','URL_PART1','/jobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','URL_PART2','/in-','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','SMRY_DESC','(NA)','scrapes job listings from the SEEK website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','URL','https://www.seek.co.nz','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','URL_PART1','/jobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','URL_PART2','/in-','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_SEEK','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_TRADEME
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','SMRY_DESC','(NA)','scrapes job listings from the TRADEME website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','URL','http://www.trademe.co.nz/jobs/jobs','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','SITE_CDE','TRADEME','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_TRADEME','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_TRADEME','PKG','SMRY_DESC','(NA)','scrapes job listings from the TRADEME website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_TRADEME','PKG','URL','http://www.trademe.co.nz/jobs/jobs','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_TRADEME','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_TRADEME','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_TRADEME','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_TRADEME','PKG','SITE_CDE','TRADEME','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_NZ_TRADEME','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
JOBS UK
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_UK (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_UK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_UK','PKG','PKGS_TO_RUN','PY_JOBS_UK_CAREERJET,PY_JOBS_UK_INDEED,PY_JOBS_UK_JOBSERVE,PY_JOBS_UK_JOBSITE,PY_JOBS_UK_JORA,PY_JOBS_UK_JORAX2,PY_JOBS_UK_REED,PY_JOBS_UK_TOTALJOBS,PY_JOBS_UK_UNIVERSAL','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_UK','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_UK','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_UK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_UK','PKG','PKGS_TO_RUN','PY_JOBS_UK_CAREERJET,PY_JOBS_UK_INDEED,PY_JOBS_UK_JOBSERVE,PY_JOBS_UK_JOBSITE,PY_JOBS_UK_JORA,PY_JOBS_UK_JORAX2,PY_JOBS_UK_REED,PY_JOBS_UK_TOTALJOBS,PY_JOBS_UK_UNIVERSAL','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_UK','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_UK','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- PY_JOBS_UK_CAREERJET
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','URL','http://www.careerjet.co.uk','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_CAREERJET','PKG','URL','http://www.careerjet.co.uk','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_CAREERJET','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_INDEED
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','URL','https://www.indeed.co.uk','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','INDUSTRY','NHS-JOBS,IT-JOBS,SALES-JOBS,DRIVING-JOBS,RETAIL-JOBS,MEDIA-JOBS,ACCOUNTANCY-JOBS,RECEPTIONIST-JOBS,PUBLIC-SECTOR-JOBS,MARKETING-JOBS,CHARITY-JOBS,SECURITY-JOBS,CUSTOMER-SERVICE-JOBS,HEALTHCARE-JOBS,LEGAL-JOBS,SECRETARIAL-JOBS,FINANCE-JOBS,ARCHITECTURE-JOBS,HOSPITALITY-JOBS,NURSING-JOBS,CATERING-JOBS,ARTS-JOBS,ACCOUNTING-JOBS,TEACHING-JOBS','categories used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','URL','https://www.indeed.co.uk','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_INDEED','PKG','INDUSTRY','NHS-JOBS,IT-JOBS,SALES-JOBS,DRIVING-JOBS,RETAIL-JOBS,MEDIA-JOBS,ACCOUNTANCY-JOBS,RECEPTIONIST-JOBS,PUBLIC-SECTOR-JOBS,MARKETING-JOBS,CHARITY-JOBS,SECURITY-JOBS,CUSTOMER-SERVICE-JOBS,HEALTHCARE-JOBS,LEGAL-JOBS,SECRETARIAL-JOBS,FINANCE-JOBS,ARCHITECTURE-JOBS,HOSPITALITY-JOBS,NURSING-JOBS,CATERING-JOBS,ARTS-JOBS,ACCOUNTING-JOBS,TEACHING-JOBS','categories used in site search');
-- PY_JOBS_UK_JOBSERVE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','URL','https://www.jobserve.com/uk/en/JobSearch.aspx','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSERVE','PKG','URL','https://www.jobserve.com/uk/en/JobSearch.aspx','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSERVE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSERVE','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_JOBSITE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSITE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','URL_OLD','http://www.jobsite.co.uk/jobs','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','URL','http://www.jobsite.co.uk/advancedsearch?refine=Y&search_referer=external-other&engine=stepmatch','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','URL_SEARCH','http://www.jobsite.co.uk/vacancies?sector=','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','SITE_CDE','JOBSITE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','REGIONS','CHARING CROSS,COVENT GARDEN,EAST ANGLIA,EAST MIDLANDS,HAMPSHIRE,HOME COUNTIES,LANCASHIRE,LONDON,MANCHESTER,MIDDLESEX,MIDLANDS,NORTH EAST,NORTH WEST,SOUTH EAST,SOUTH WEST ENGLAND,SURREY,THAMES VALLEY,VICTORIA,WARWICKSHIRE,WEST MIDLANDS,WESTMINSTER,YORKSHIRE','regions used in site search');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSITE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','URL_OLD','http://www.jobsite.co.uk/jobs','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','URL','http://www.jobsite.co.uk/advancedsearch?refine=Y&search_referer=external-other&engine=stepmatch','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','URL_SEARCH','http://www.jobsite.co.uk/vacancies?sector=','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','SITE_CDE','JOBSITE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','REGIONS','CHARING CROSS,COVENT GARDEN,EAST ANGLIA,EAST MIDLANDS,HAMPSHIRE,HOME COUNTIES,LANCASHIRE,LONDON,MANCHESTER,MIDDLESEX,MIDLANDS,NORTH EAST,NORTH WEST,SOUTH EAST,SOUTH WEST ENGLAND,SURREY,THAMES VALLEY,VICTORIA,WARWICKSHIRE,WEST MIDLANDS,WESTMINSTER,YORKSHIRE','regions used in site search');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JOBSITE','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_JORA
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','URL','https://uk.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','URL','https://uk.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_JORAX2
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','URL','https://uk.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','URL','https://uk.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_JORAX2','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_REED
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','SMRY_DESC','(NA)','scrapes job listings from the REED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','URL_OLD','https://www.reed.co.uk/','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','URL','https://www.reed.co.uk/jobs?keywords=&location=&jobtitleonly=false','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','SITE_CDE','REED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','SMRY_DESC','(NA)','scrapes job listings from the REED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','URL_OLD','https://www.reed.co.uk/','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','URL','https://www.reed.co.uk/jobs?keywords=&location=&jobtitleonly=false','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','SITE_CDE','REED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_REED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_TOTALJOBS
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','SMRY_DESC','(NA)','scrapes job listings from the TOTALJOBS website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','URL','https://www.totaljobs.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','SITE_CDE','TOTALJOBS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_TOTALJOBS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_TOTALJOBS','PKG','SMRY_DESC','(NA)','scrapes job listings from the TOTALJOBS website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_TOTALJOBS','PKG','URL','https://www.totaljobs.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_TOTALJOBS','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_TOTALJOBS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_TOTALJOBS','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_TOTALJOBS','PKG','SITE_CDE','TOTALJOBS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_TOTALJOBS','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_UNIVERSAL
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','SMRY_DESC','(NA)','scrapes job listings from the UNIVERSAL website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','URL','https://jobsearch.direct.gov.uk/jobsearch/Browse.aspx?sc=','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','URL_PART1','in','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','URL_PART2','rg','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','SITE_CDE','UNIVERSAL','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','SMRY_DESC','(NA)','scrapes job listings from the UNIVERSAL website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','URL','https://jobsearch.direct.gov.uk/jobsearch/Browse.aspx?sc=','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','URL_PART1','in','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','URL_PART2','rg','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','CNTRY_CDE','UK','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','SITE_CDE','UNIVERSAL','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_UK_UNIVERSAL','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
JOBS US
============================================================================================================================== 
*/ 
-- PY_BATCH_JOBS_US (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_US','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_US','PKG','PKGS_TO_RUN','PY_JOBS_US_CAREERBUILDER,PY_JOBS_US_CAREERJET,PY_JOBS_US_INDEED,PY_JOBS_US_JOBSERVE,PY_JOBS_US_JORA,PY_JOBS_US_JORAX2,PY_JOBS_US_SIMPLYHIRED,PY_JOBS_US_THELADDERS','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_US','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_US','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_US','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_US','PKG','PKGS_TO_RUN','PY_JOBS_US_CAREERBUILDER,PY_JOBS_US_CAREERJET,PY_JOBS_US_INDEED,PY_JOBS_US_JOBSERVE,PY_JOBS_US_JORA,PY_JOBS_US_JORAX2,PY_JOBS_US_SIMPLYHIRED,PY_JOBS_US_THELADDERS','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_US','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_US','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- PY_JOBS_US_CAREERBUILDER
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERBUILDER website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','URL','http://www.careerbuilder.com/jobs','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','SITE_CDE','CAREERBUILDER','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERBUILDER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERBUILDER','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERBUILDER website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERBUILDER','PKG','URL','http://www.careerbuilder.com/jobs','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERBUILDER','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERBUILDER','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERBUILDER','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERBUILDER','PKG','SITE_CDE','CAREERBUILDER','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERBUILDER','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_CAREERJET
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','URL','http://www.careerjet.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERJET','PKG','URL','http://www.careerjet.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERJET','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERJET','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_INDEED
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','URL','https://www.indeed.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','INDUSTRY','CUSTOMER-SERVICE-JOBS,PART-TIME-JOBS,SALES-JOBS,WAREHOUSE-JOBS,ACCOUNTING-JOBS,CONSTRUCTION-JOBS,HEALTHCARE-JOBS,RETAIL-JOBS,HUMAN-RESOURCES-JOBS,MARKETING-JOBS,CALL-CENTER-JOBS,CLERICAL-JOBS,DATA-ENTRY-JOBS,INSURANCE-JOBS,DRIVER-JOBS,EDUCATION-JOBS,MAINTENANCE-JOBS,ENTRY-LEVEL-JOBS,NURSING-JOBS,IT-JOBS,GRAPHIC-DESIGN-JOBS,SUMMER-JOBS,ONLINE-JOBS,FINANCE-JOBS','categories used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','URL','https://www.indeed.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_INDEED','PKG','INDUSTRY','CUSTOMER-SERVICE-JOBS,PART-TIME-JOBS,SALES-JOBS,WAREHOUSE-JOBS,ACCOUNTING-JOBS,CONSTRUCTION-JOBS,HEALTHCARE-JOBS,RETAIL-JOBS,HUMAN-RESOURCES-JOBS,MARKETING-JOBS,CALL-CENTER-JOBS,CLERICAL-JOBS,DATA-ENTRY-JOBS,INSURANCE-JOBS,DRIVER-JOBS,EDUCATION-JOBS,MAINTENANCE-JOBS,ENTRY-LEVEL-JOBS,NURSING-JOBS,IT-JOBS,GRAPHIC-DESIGN-JOBS,SUMMER-JOBS,ONLINE-JOBS,FINANCE-JOBS','categories used in site search');
-- PY_JOBS_US_JOBSERVE
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','URL','https://www.jobserve.com/us/en/JobSearch.aspx','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JOBSERVE','PKG','URL','https://www.jobserve.com/us/en/JobSearch.aspx','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JOBSERVE','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JOBSERVE','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_JORA
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','URL','https://us.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','URL','https://us.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_JORAX2
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','URL','https://us.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','URL','https://us.jora.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_JORAX2','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_SIMPLYHIRED
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','SMRY_DESC','(NA)','scrapes job listings from the SIMPLYHIRED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','URL','http://www.simplyhired.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','URL_PART1','/browse-jobs/titles','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','SITE_CDE','SIMPLYHIRED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','SMRY_DESC','(NA)','scrapes job listings from the SIMPLYHIRED website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','URL','http://www.simplyhired.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','URL_PART1','/browse-jobs/titles','additional url parts - typical used for search paramaters');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','SITE_CDE','SIMPLYHIRED','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_SIMPLYHIRED','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_THELADDERS
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','SMRY_DESC','(NA)','scrapes job listings from the THELADDERS website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','URL_OLD','https://www.theladders.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','URL','https://us.experteer.com/jobs','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','SITE_CDE','THELADDERS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','INDUSTRY','ACCOUNTING,CREATIVE,DESIGN,EDUCATION,ENGINEERING,FINANCE,HEALTHCARE,HUMAN-RESOURCES,LAW,LEGAL,MARKETING,OPERATIONS,PUBLIC-RELATIONS,REAL-ESTATE,SCIENCE-AND-RESEARCH,SALES,SCIENCE-AND-RESEARCH,TECHNOLOGY','categories used in site search');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','SMRY_DESC','(NA)','scrapes job listings from the THELADDERS website');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','URL_OLD','https://www.theladders.com','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','URL','https://us.experteer.com/jobs','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','TBL_NME','WEBDATA_JOBADS','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','CNTRY_CDE','US','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','SITE_CDE','THELADDERS','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_US_THELADDERS','PKG','INDUSTRY','ACCOUNTING,CREATIVE,DESIGN,EDUCATION,ENGINEERING,FINANCE,HEALTHCARE,HUMAN-RESOURCES,LAW,LEGAL,MARKETING,OPERATIONS,PUBLIC-RELATIONS,REAL-ESTATE,SCIENCE-AND-RESEARCH,SALES,SCIENCE-AND-RESEARCH,TECHNOLOGY','categories used in site search');

/*
==============================================================================================================================
JOBS 3RD PARTY PROVIDERS
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_3RDPARTY_AU (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_3RDPARTY_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_3RDPARTY_AU','PKG','PKGS_TO_RUN','PY_JOBS_AU_ANZ','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_3RDPARTY_AU','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_3RDPARTY_AU','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_3RDPARTY_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_3RDPARTY_AU','PKG','PKGS_TO_RUN','PY_JOBS_AU_ANZ','list of packages to be run within the current folder (comma(,) delimeted)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_3RDPARTY_AU','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_BATCH_JOBS_3RDPARTY_AU','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
-- PY_JOBS_US_CAREERBUILDER
-- PROD
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','SMRY_DESC','(NA)','exctracts pdf from anz compiled job ad figures and extracts table/data details');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','URL','http://www.media.anz.com/phoenix.zhtml?c=248677&p=irol-jobad&nyo=0','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','TBL_NME','PY_JOBS_AU_ANZ_DATA','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','DATA_TYPE','JOBS_3RD_PARTY','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','SITE_CDE','ANZ','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ANZ','PKG','FILE_MOVE_DEST_PATH','D:\Sync\__lanoitan\@data\__anz_job_ads','destination folder path to store files temporarily');
-- DEV
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','SMRY_DESC','(NA)','exctracts pdf from anz compiled job ad figures and extracts table/data details');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','URL','http://www.media.anz.com/phoenix.zhtml?c=248677&p=irol-jobad&nyo=1','source url to scrape');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','TBL_NME','PY_JOBS_AU_ANZ_DATA','table name for the scrape results to be posted to');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','DATA_TYPE','JOBS_3RD_PARTY','data type entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','CNTRY_CDE','AU','country code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','SITE_CDE','ANZ','site code entry for results');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into CTL_PY_VARS (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','PY_JOBS_AU_ANZ','PKG','FILE_MOVE_DEST_PATH','D:\Sync\__lanoitan_dev\@data\__anz_job_ads','destination folder path to store files temporarily');



-- SHRINK/OPTIMISE DATABASE

VACUUM;	

--=========

--WITH DAT AS(
--	SELECT
--		UN.VAR_NME,
--		MIN( UN.ENV_FLG ) AS ENV_FLG
--	FROM
--		(
--			SELECT
--				VARS.VAR_NME,
--				VARS.VAR_VAL,
--				CASE
--					VARS.VAR_TYPE
--					WHEN 'ENV' THEN 2
--					WHEN 'PKG' THEN 1
--				END AS ENV_FLG
--			FROM
--				CTL_PY_VARS VARS
--			WHERE
--				VARS.ENV = 'DEV'
--				AND VARS.VAR_TYPE = 'ENV'
--		UNION ALL SELECT
--				VARS.VAR_NME,
--				VARS.VAR_VAL,
--				CASE
--					VARS.VAR_TYPE
--					WHEN 'ENV' THEN 2
--					WHEN 'PKG' THEN 1
--				END AS ENV_FLG
--			FROM
--				CTL_PY_VARS VARS
--			WHERE
--				VARS.ENV = 'DEV'
--				AND VARS.PKG_NME = 'PY_CCY_PAIRS_TICK_FX'
--				AND VARS.VAR_TYPE = 'PKG'
--		) UN
--	GROUP BY
--		VAR_NME
--) SELECT
--	VARS.VAR_NME,
--	VARS.VAR_VAL
--FROM
--	DAT,
--	CTL_PY_VARS VARS
--WHERE
--	VARS.ENV = 'DEV'
--	AND VARS.VAR_NME != 'SMRY_DESC'
--	AND VARS.PKG_NME = CASE
--		DAT.ENV_FLG
--		WHEN 1 THEN 'PY_CCY_PAIRS_TICK_FX'
--		WHEN 2 THEN ''
--	END
--	AND VARS.VAR_TYPE = CASE
--		DAT.ENV_FLG
--		WHEN 1 THEN 'PKG'
--		WHEN 2 THEN 'ENV'
--	END
--	AND VARS.VAR_NME = DAT.VAR_NME




/*
MOVING DATA FROM 1 DATABASE TO ANOTHER
-- HELPFUL WHEN CONFLICT DB HAS DATA THAT HASNT BEEN APPLIED TO ACTUAL DB

SELECT * FROM PY_B4S_DATA

CREATE
	TABLE
		PY_JOBS_DATA(
			ID INTEGER PRIMARY KEY AUTOINCREMENT,
			MSMT_DTE_ID INTEGER,
			DATA_TYPE VARCHAR(3),
			CNTRY_CDE VARCHAR(2),
			SITE_CDE VARCHAR(30),
			FACET_TYPE VARCHAR(30),
			FACET_DESC VARCHAR(100),
			FACET_CNT INTEGER,
			STARTED_AT VARCHAR(20),
			FINISHED_AT VARCHAR(20)
		);

ATTACH DATABASE 'D:\Sync\__lanoitan\@data\PY_WEB_DATA.db'  AS att_db;
  
insert
	into
		WEBDATA_JOBADS(
			MSMT_DTE_ID,
			DATA_TYPE,
			CNTRY_CDE,
			SITE_CDE,
			FACET_TYPE,
			FACET_DESC,
			FACET_CNT,
			STARTED_AT,
			FINISHED_AT
		) select
			MSMT_DTE_ID,
			DATA_TYPE,
			CNTRY_CDE,
			SITE_CDE,
			FACET_TYPE,
			FACET_DESC,
			FACET_CNT,
			STARTED_AT,
			FINISHED_AT
		from
			att_db.PY_JOBS_DATA a
		where
			1 = 1;


DETACH att_db;

*/


