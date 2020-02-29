/*
=======================================================================================================================================================================================================
SUBJECT		 : Control table housing variables required for automating/running python packages
OBJECT TYPE	 : TABLE
OBJECT NAME	 : PY_VARS_CTL
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170328
SOURCE	 : 
PREPERATION	 : CREATE TABLE INSERT VALUES REQUIRED FOR SSIS RUNNING
REMARKS	 : 1) 
           2)
           3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE PY_VARS_CTL;

CREATE TABLE PY_VARS_CTL (
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
 from PY_VARS_CTL where pkg_nme in (select pkg_nme from PY_VARS_CTL where var_val = 'JOBS') and var_nme in ('URL','SITE_CDE','CNTRY_CDE') 
 group by pkg_nme

 
select *
 from PY_VARS_CTL where pkg_nme in (select pkg_nme from PY_VARS_CTL where var_val = 'JOBS') and var_nme in ('URL','SITE_CDE') 

select distinct pkg_nme from PY_VARS_CTL where 1 = 1 order by 1
=======================================================================================================================================================================================================
*/

delete from PY_VARS_CTL;

-- ENVIRONMENT PARAMETERS
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_SNDR_USRNME','lanoitan17@gmail.com','email sender username/address for email notifications');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_SNDR_PWORD','500BourkeStreet','email sender password');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','DATA_RETENTION_DAYS','30','number of days to keep data within sqlite tables.  is overridden if a pkg variable is present');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_MSG','','generic email message. is overridden if pkg variable is present');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','LOOP_RNDM_SLEEP_LOW','1','sets the lower limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','LOOP_RNDM_SLEEP_HIGH','5','sets the higher limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','WEB_DRVR_NME','chromedriver.exe','the web driver used for the selenium parser');

/* 
==============================================================================================================================
MARKETS
============================================================================================================================== 
*/
-- PY_BATCH_MARKETS (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','PKGS_TO_RUN','PY_COMMODITIES','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_COMMODITIES
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','SMRY_DESC','(NA)','using the yahoo finance API, retrieve various commoditiy prices per day');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','TBL_NME','PY_COMMODITY_DATA','table name for the scrape results to be posted to');
-- PY_CCY_PAIRS_TICK_FX
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','SMRY_DESC','(NA)','retrieves monthly tick currency and idx pairs from histdata.com in compressed folder form.  unpack and import spreadsheet data');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','URL','http://www.histdata.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','URL_PART1','/download-free-forex-data/?/ascii/tick-data-quotes','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','CCY_PAIRS','AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,AUXAUD,EURAUD,EURUSD,GBPAUD,GBPUSD,NZDUSD,USDCAD,USDCZK,XAUAUD','ccy pairs to retrieve from histdata');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_CCY_PAIRS_MBAR_FX
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','SMRY_DESC','(NA)','retrieves monthly minute bar currency and idx pairs from histdata.com in compressed folder form.  unpack and import spreadsheet data');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','URL','http://www.histdata.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','URL_PART1','/download-free-forex-data/?/metastock/1-minute-bar-quotes','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','CCY_PAIRS','AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,EURAUD,GBPAUD,AUXAUD,XAUAUD','ccy pairs to retrieve from histdata');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
GOVERNMENT KEY DATE ANNOUNCEMENTS
============================================================================================================================== 
*/
-- PY_BATCH_GOVT_KDA (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_KDA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_KDA','PKG','PKGS_TO_RUN','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU,PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK,PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US,PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA,PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_KDA','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU','PKG','SMRY_DESC','(NA)','scrapes key dates listed on the australian governments calendar');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU','PKG','URL','http://www.abs.gov.au/AUSSTATS/abs@.nsf/webpages/Release%20Advice%20for%20ABS%20Publications%20for%20the%20Next%20Six%20Months','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU','PKG','TBL_NME','PY_GOVT_KEY_DATE_ANNOUNCEMENTS','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU','PKG','DATA_TYPE','KEY DATE ANNOUNCEMENT','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU','PKG','SITE_CDE','ABS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_AU','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK','PKG','SMRY_DESC','(NA)','scrapes key dates listed on the uk governments calendar');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK','PKG','URL','https://www.ons.gov.uk/releasecalendar?size=50&view=upcoming&page=','source url to scrape - 20170603 - previously  https://www.ons.gov.uk/releasecalendar?view=upcoming&size=50');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK','PKG','TBL_NME','PY_GOVT_KEY_DATE_ANNOUNCEMENTS','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK','PKG','DATA_TYPE','KEY DATE ANNOUNCEMENT','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK','PKG','SITE_CDE','ONS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_UK','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','SMRY_DESC','(NA)','scrapes key dates listed on the us governments calendar');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','URL','https://www.bls.gov/schedule/','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','URL_PART1','/home.htm','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','TBL_NME','PY_GOVT_KEY_DATE_ANNOUNCEMENTS','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','DATA_TYPE','KEY DATE ANNOUNCEMENT','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','SITE_CDE','BLS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_US','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','SMRY_DESC','(NA)','scrapes key dates listed on the canadian governments calendar');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','URL','http://www.statcan.gc.ca/dai-quo/cal1-eng.htm','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','TBL_NME','PY_GOVT_KEY_DATE_ANNOUNCEMENTS','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','DATA_TYPE','KEY DATE ANNOUNCEMENT','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','CNTRY_CDE','CA','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','SITE_CDE','STATCAN','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','LOOP_RNDM_SLEEP_LOW','30','sets the lower limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','LOOP_RNDM_SLEEP_HIGH','50','sets the higher limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_CA','PKG','LOOP_COUNTER','10','sets the number of times this package will cycle before breaking out of loop');
-- PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','SMRY_DESC','(NA)','scrapes key dates listed on the new zealand governments calendar');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','URL','http://www.stats.govt.nz/about_us/news_and_events/release-calendar.aspx','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','URL_PART1','?releaseMonth=','url is broken up with search paramaters - this represents the first');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','URL_PART2','&releaseYear=','url is broken up with search paramaters - this represents the second');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','TBL_NME','PY_GOVT_KEY_DATE_ANNOUNCEMENTS','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','DATA_TYPE','KEY DATE ANNOUNCEMENT','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','SITE_CDE','STATSNZ','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
GOVERNMENT DATA
============================================================================================================================== 
*/
-- PY_BATCH_GOVT_DATA_MEDIA_RELEASE (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_DATA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_DATA','PKG','PKGS_TO_RUN','PY_GOVT_DATA_AU_LABOUR_FORCE,PY_GOVT_DATA_AU_MEDIA_RELEASE','list of packages to be run within the current folder (comma(,) delimeted)');                                                                                                                                       
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_GOVT_DATA','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_MEDIA_RELEASE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_MEDIA_RELEASE','PKG','SMRY_DESC','(NA)','scrapes key data from the media release details on the day of announcement');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_MEDIA_RELEASE','PKG','URL','http://www.abs.gov.au/latest','source url to scrape ----- old url for returning historical announcement on loop ----- http://www.abs.gov.au/AUSSTATS/abs@.nsf/second+level+view?ReadForm&prodno=6202.0&viewtitle=Labour%20Force,%20Australia~May%202017~Latest~15/06/2017&&tabname=Past%20Future%20Issues&prodno=6202.0&issue=May%202017&num=&view=&');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_MEDIA_RELEASE','PKG','TBL_NME','PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_MEDIA_RELEASE','PKG','DATA_TYPE','GOVT DATA MEDIA RELEASE','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_MEDIA_RELEASE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_MEDIA_RELEASE','PKG','SITE_CDE','ABS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_MEDIA_RELEASE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_GOVT_DATA_AU_LABOUR_FORCE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','SMRY_DESC','(NA)','scrapes data from the australian government website specific labour force related material');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','URL','http://www.abs.gov.au','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','URL_PART1','/AUSSTATS/abs@.nsf/DetailsPage/6202.0','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_STATUS','PY_LABOUR_FORCE_AU_STATUS','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_HRS_WRKD','PY_LABOUR_FORCE_AU_HRS_WRKD','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_UNDRUTIL_PRSNS','PY_LABOUR_FORCE_AU_UNDERUTIL_PRSNS','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_STATUS','6202001','file name of the target spreadsheet on website to be scraped');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_HRS_WRKD','6202019','file name of the target spreadsheet on website to be scraped');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_UNDRUTIL_PRSNS','6202024','file name of the target spreadsheet on website to be scraped');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','DATA_TYPE','LABOUR FORCE','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','SITE_CDE','ABS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_GOVT_DATA_AU_LABOUR_FORCE','PKG','FILES_TO_GET_EXT','.xls','extension (file type) of the files to retrieve from web page');
/* 
==============================================================================================================================
BUSINESS FOR SALE
============================================================================================================================== 
*/
-- PY_BATCH_B4S_AU (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_B4S_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_B4S_AU','PKG','PKGS_TO_RUN','PY_B4S_AU_BUSINESSFORSALE,PY_B4S_AU_SEEK','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_B4S_AU','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_B4S_AU_DOMAIN
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the DOMAIN website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','URL','http://business.domain.com.au/search/buy/?ltype=business&searchtype=business','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','TBL_NME','PY_B4S_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','DATA_TYPE','B4S','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','SITE_CDE','DOMAIN','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_DOMAIN','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- PY_B4S_AU_BUSINESSFORSALE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the BUSINESSFORSALE website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','URL','https://www.businessforsale.com.au','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','TBL_NME','PY_B4S_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','DATA_TYPE','B4S','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','SITE_CDE','BUSINESSFORSALE','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_BUSINESSFORSALE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_B4S_AU_SEEK
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','SMRY_DESC','(NA)','scrapes business for sale listings from the SEEK website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','URL','https://www.seekbusiness.com.au','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','TBL_NME','PY_B4S_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','DATA_TYPE','B4S','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_B4S_AU_SEEK','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');

/* 
==============================================================================================================================
JOBS AU
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_AU (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_AU','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_AU','PKG','PKGS_TO_RUN','PY_JOBS_AU_ADZUNA,PY_JOBS_AU_CAREERJET,PY_JOBS_AU_GUMTREE,PY_JOBS_AU_HAYS,PY_JOBS_AU_INDEED,PY_JOBS_AU_JOBSEARCH,PY_JOBS_AU_JOBSERVE,PY_JOBS_AU_JORA,PY_JOBS_AU_JORAX2,PY_JOBS_AU_SEEK','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_AU','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_AU','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com,sarka.howie@gmail.com','email distribution list for email notifications');
-- PY_JOBS_AU_ADZUNA
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','SMRY_DESC','(NA)','scrapes job listings from the ADZUNA website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','URL','https://www.adzuna.com.au','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','URL_PART1','/search?w=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','SITE_CDE','ADZUNA','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_ADZUNA','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- PY_JOBS_AU_CAREERJET
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','URL','http://www.careerjet.com.au','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_GUMTREE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','SMRY_DESC','(NA)','scrapes job listings from the GUMTREE website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','URL','http://www.gumtree.com.au/s-jobs/c9302?ad=offering','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','SITE_CDE','GUMTREE','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_GUMTREE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_HAYS
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','SMRY_DESC','(NA)','scrapes job listings from the HAYS website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','URL','https://www.hays.com.au/jobs/','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','SITE_CDE','HAYS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_HAYS','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_INDEED
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','URL','https://au.indeed.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_INDEED','PKG','INDUSTRY','RETAIL-JOBS,ACCOUNTING-JOBS,SALES-JOBS,DRIVER-JOBS,PART-TIME-JOBS,GRADUATE-JOBS,DATA-ENTRY-JOBS,RECEPTIONIST-JOBS,MARKETING-JOBS,CONSTRUCTION-JOBS,WORK-FROM-HOME-JOBS,CUSTOMER-SERVICE-JOBS,ADMIN-JOBS,TEACHING-JOBS,INSURANCE-JOBS,HOTEL-JOBS,CALL-CENTRE-JOBS,IT-JOBS,HEALTHCARE-JOBS,FINANCE-JOBS,MEDIA-JOBS,ENTRY-LEVEL-JOBS,DRIVING-JOBS,ART-JOBS','categories used in site search');
-- PY_JOBS_AU_JOBSEARCH
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSEARCH website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','URL','https://jobsearch.gov.au/jobs-by-industry','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','SITE_CDE','JOBSEARCH','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSEARCH','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_JOBSERVE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','URL','https://www.jobserve.com/au/en/JobSearch.aspx','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_JORA
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','URL','https://au.jora.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORA','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- PY_JOBS_AU_JORAX2
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','URL','https://au.jora.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_JORAX2','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_AU_SEEK
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','SMRY_DESC','(NA)','scrapes job listings from the SEEK website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','URL','https://www.seek.com.au','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','URL_PART1','/jobs','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','URL_PART2','/in-','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','CNTRY_CDE','AU','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_AU_SEEK','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
/* 
==============================================================================================================================
JOBS CA
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_CA (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_CA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_CA','PKG','PKGS_TO_RUN','PY_JOBS_CA_CAREERBUILDER,PY_JOBS_CA_CAREERJET,PY_JOBS_CA_INDEED,PY_JOBS_CA_JOBBANK,PY_JOBS_CA_JOBSERVE,PY_JOBS_CA_WORKOPOLIS','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_CA','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_CA','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com,sarka.howie@gmail.com','email distribution list for email notifications');
-- PY_JOBS_CA_CAREERBUILDER
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERBUILDER website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','URL','http://www.careerbuilder.ca/search?q=&loc=','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','CNTRY_CDE','CA','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','SITE_CDE','CAREERBUILDER','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERBUILDER','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
-- PY_JOBS_CA_CAREERJET
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','URL','http://www.careerjet.ca','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','CNTRY_CDE','CA','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_CA_INDEED
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','URL','https://ca.indeed.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','CNTRY_CDE','CA','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','REGIONS','VICTORIA,NEW SOUTH WALES,QUEENSLAND,NORTHERN TERRITORY,SOUTH AUSTRALIA,WESTERN AUSTRALIA,AUSTRALIAN CAPITAL TERRITORY,TASMANIA','regions used in site search');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_INDEED','PKG','INDUSTRY','MARKETING-JOBS,CUSTOMER-SERVICE-JOBS,HUMAN-RESOURCES-JOBS,ADMINISTRATIVE-JOBS,RECEPTIONIST-JOBS,CONSTRUCTION-JOBS,FINANCE-JOBS,NURSE-JOBS,HEALTHCARE-JOBS,SECURITY-JOBS,ACCOUNTING-JOBS,RETAIL-JOBS,SUPPLY-CHAIN-JOBS,LEGAL-ASSISTANT-JOBS,IT-JOBS,GRAPHIC-DESIGN-JOBS,REAL-ESTATE-JOBS,WAREHOUSE-JOBS,CLERK-JOBS,CASHIER-JOBS,MANAGEMENT-JOBS,CLERICAL-JOBS,CALL-CENTER-JOBS,BILINGUAL-JOBS','categories used in site search');
-- PY_JOBS_CA_JOBBANK
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBBANK website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','URL','http://www.jobbank.gc.ca','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','URL_PART1','/jobsearch/jobsearch','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','CNTRY_CDE','CA','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','SITE_CDE','JOBBANK','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBBANK','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_CA_JOBSERVE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','URL','https://www.jobserve.com/ca/en/JobSearch.aspx','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','URL_PART1','/jobsearch/jobsearch','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','CNTRY_CDE','CA','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_CA_WORKOPOLIS
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','SMRY_DESC','(NA)','scrapes job listings from the WORKOPOLIS website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','URL','http://www.workopolis.com/jobsearch/find-jobs','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','CNTRY_CDE','CA','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','SITE_CDE','WORKOPOLIS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_CA_WORKOPOLIS','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
JOBS NZ
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_NZ (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','PKGS_TO_RUN','PY_JOBS_NZ_CAREERJET,PY_JOBS_NZ_INDEED,PY_JOBS_NZ_JORA,PY_JOBS_NZ_JORAX2,PY_JOBS_NZ_MYJOBSPACE,PY_JOBS_NZ_SEEK,PY_JOBS_NZ_TRADEME','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_NZ','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com,sarka.howie@gmail.com','email distribution list for email notifications');
-- PY_JOBS_NZ_CAREERJET
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','URL','http://www.careerjet.co.nz','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_INDEED
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','URL','https://nz.indeed.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_INDEED','PKG','INDUSTRY','GOVERNMENT-JOBS,ACCOUNTING-JOBS,DRIVER-JOBS,ENGINEERING-JOBS,IT-JOBS,RETAIL-JOBS,CONSTRUCTION-JOBS,SALES-JOBS,ADMINISTRATION-JOBS,FINANCE-JOBS,MARKETING-JOBS,NURSE-JOBS,HEALTHCARE-JOBS,MANAGEMENT-JOBS,TEACHING-JOBS,DATA-ENTRY-JOBS,INSURANCE-JOBS,CUSTOMER-SERVICE-JOBS,SCIENCE-JOBS,BANKING-JOBS,RECEPTIONIST-JOBS,HOSPITALITY-JOBS,HR-JOBS,CALL-CENTRE-JOBS','categories used in site search');
-- PY_JOBS_NZ_JORA
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','URL','https://nz.jora.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','URL_PART1','/j?q=&l=New+Zealand&sp=homepage','additional url parts - typical used for search paramaters.... 20170531 - changed from /j?q=&l=&sp=homepage');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORA','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_JORAX2
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','URL','https://nz.jora.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_JORAX2','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_MYJOBSPACE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','SMRY_DESC','(NA)','scrapes job listings from the MYJOBSPACE website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','URL','http://myjobspace.co.nz/','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','SITE_CDE','MYJOBSPACE','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_MYJOBSPACE','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_SEEK
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','SMRY_DESC','(NA)','scrapes job listings from the SEEK website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','URL','https://www.seek.co.nz','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','URL_PART1','/jobs','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','URL_PART2','/in-','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','SITE_CDE','SEEK','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_SEEK','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_NZ_TRADEME
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','SMRY_DESC','(NA)','scrapes job listings from the TRADEME website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','URL','http://www.trademe.co.nz/jobs/jobs','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','CNTRY_CDE','NZ','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','SITE_CDE','TRADEME','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_NZ_TRADEME','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
JOBS UK
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_UK (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_UK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_UK','PKG','PKGS_TO_RUN','PY_JOBS_UK_CAREERJET,PY_JOBS_UK_INDEED,PY_JOBS_UK_JOBSERVE,PY_JOBS_UK_JOBSITE,PY_JOBS_UK_JORA,PY_JOBS_UK_JORAX2,PY_JOBS_UK_REED,PY_JOBS_UK_TOTALJOBS,PY_JOBS_UK_UNIVERSAL','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_UK','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_UK','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com,sarka.howie@gmail.com','email distribution list for email notifications');
-- PY_JOBS_UK_CAREERJET
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','URL','http://www.careerjet.co.uk','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_INDEED
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','URL','https://www.indeed.co.uk','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_INDEED','PKG','INDUSTRY','NHS-JOBS,IT-JOBS,SALES-JOBS,DRIVING-JOBS,RETAIL-JOBS,MEDIA-JOBS,ACCOUNTANCY-JOBS,RECEPTIONIST-JOBS,PUBLIC-SECTOR-JOBS,MARKETING-JOBS,CHARITY-JOBS,SECURITY-JOBS,CUSTOMER-SERVICE-JOBS,HEALTHCARE-JOBS,LEGAL-JOBS,SECRETARIAL-JOBS,FINANCE-JOBS,ARCHITECTURE-JOBS,HOSPITALITY-JOBS,NURSING-JOBS,CATERING-JOBS,ARTS-JOBS,ACCOUNTING-JOBS,TEACHING-JOBS','categories used in site search');
-- PY_JOBS_UK_JOBSERVE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','URL','https://www.jobserve.com/uk/en/JobSearch.aspx','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_JOBSITE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSITE website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','URL','http://www.jobsite.co.uk/jobs','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','SITE_CDE','JOBSITE','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JOBSITE','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_JORA
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','URL','https://uk.jora.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORA','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_JORAX2
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','URL','https://uk.jora.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_JORAX2','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_REED
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','SMRY_DESC','(NA)','scrapes job listings from the REED website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','URL','https://www.reed.co.uk/jobs?keywords=&location=&jobtitleonly=false','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','SITE_CDE','REED','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_REED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_TOTALJOBS
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','SMRY_DESC','(NA)','scrapes job listings from the TOTALJOBS website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','URL','https://www.totaljobs.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','SITE_CDE','TOTALJOBS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_TOTALJOBS','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_UK_UNIVERSAL
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','SMRY_DESC','(NA)','scrapes job listings from the UNIVERSAL website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','URL','https://jobsearch.direct.gov.uk/jobsearch/Browse.aspx?sc=','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','URL_PART1','in','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','URL_PART2','rg','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','CNTRY_CDE','UK','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','SITE_CDE','UNIVERSAL','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_UK_UNIVERSAL','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
JOBS US
============================================================================================================================== 
*/
-- PY_BATCH_JOBS_US (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_US','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_US','PKG','PKGS_TO_RUN','PY_JOBS_US_CAREERBUILDER,PY_JOBS_US_CAREERJET,PY_JOBS_US_INDEED,PY_JOBS_US_JOBSERVE,PY_JOBS_US_JORA,PY_JOBS_US_JORAX2,PY_JOBS_US_SIMPLYHIRED,PY_JOBS_US_THELADDERS','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_US','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_JOBS_US','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com,sarka.howie@gmail.com','email distribution list for email notifications');
-- PY_JOBS_US_CAREERBUILDER
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERBUILDER website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','URL','http://www.careerbuilder.com/jobs','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','SITE_CDE','CAREERBUILDER','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERBUILDER','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_CAREERJET
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','SMRY_DESC','(NA)','scrapes job listings from the CAREERJET website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','URL','http://www.careerjet.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','SITE_CDE','CAREERJET','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_CAREERJET','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_INDEED
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','SMRY_DESC','(NA)','scrapes job listings from the INDEED website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','URL','https://www.indeed.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','URL_PART1','/jobs?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','SITE_CDE','INDEED','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_INDEED','PKG','INDUSTRY','CUSTOMER-SERVICE-JOBS,PART-TIME-JOBS,SALES-JOBS,WAREHOUSE-JOBS,ACCOUNTING-JOBS,CONSTRUCTION-JOBS,HEALTHCARE-JOBS,RETAIL-JOBS,HUMAN-RESOURCES-JOBS,MARKETING-JOBS,CALL-CENTER-JOBS,CLERICAL-JOBS,DATA-ENTRY-JOBS,INSURANCE-JOBS,DRIVER-JOBS,EDUCATION-JOBS,MAINTENANCE-JOBS,ENTRY-LEVEL-JOBS,NURSING-JOBS,IT-JOBS,GRAPHIC-DESIGN-JOBS,SUMMER-JOBS,ONLINE-JOBS,FINANCE-JOBS','categories used in site search');
-- PY_JOBS_US_JOBSERVE
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','SMRY_DESC','(NA)','scrapes job listings from the JOBSERVE website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','URL','https://www.jobserve.com/us/en/JobSearch.aspx','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','SITE_CDE','JOBSERVE','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JOBSERVE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_JORA
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORA website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','URL','https://us.jora.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','URL_PART1','/j?q=&l=&sp=homepage','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','URL_PART2','/j?q=&l=','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','SITE_CDE','JORA','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORA','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_JORAX2
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','SMRY_DESC','(NA)','scrapes job listings from the JORAX2 website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','URL','https://us.jora.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','URL_PART1','/findjobs','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','SITE_CDE','JORAX2','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_JORAX2','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_SIMPLYHIRED
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','SMRY_DESC','(NA)','scrapes job listings from the SIMPLYHIRED website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','URL','http://www.simplyhired.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','URL_PART1','/browse-jobs/titles','additional url parts - typical used for search paramaters');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','SITE_CDE','SIMPLYHIRED','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_SIMPLYHIRED','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_JOBS_US_THELADDERS
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','SMRY_DESC','(NA)','scrapes job listings from the THELADDERS website');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','URL_OLD','https://www.theladders.com','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','URL','https://www.theladders.com/jobs/in/','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','TBL_NME','PY_JOBS_DATA','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','DATA_TYPE','JOBS','data type entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','CNTRY_CDE','US','country code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','SITE_CDE','THELADDERS','site code entry for results');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','USES_WEB_DRVR','Y','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_JOBS_US_THELADDERS','PKG','INDUSTRY','ACCOUNTING,CREATIVE,DESIGN,EDUCATION,ENGINEERING,FINANCE,HEALTHCARE,HUMAN-RESOURCES,LAW,MARKETING,OPERATIONS,PUBLIC-RELATIONS,REAL-ESTATE,SCIENCE-AND-RESEARCH,SALES,SCIENCE-AND-RESEARCH,TECHNOLOGY','categories used in site search');

/*
==============================================================================================================================
COMPETITOR DATA
============================================================================================================================== 
*/
-- PY_BATCH_COMPETITOR (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_COMPETITOR','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_COMPETITOR','PKG','PKGS_TO_RUN','PY_COMPETITOR_DATA_FX','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_COMPETITOR','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_COMPETITOR_DATA_FX
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMPETITOR_DATA_FX','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMPETITOR_DATA_FX','PKG','SMRY_DESC','(NA)','scrapes fx competitor comparison site to collate competitor data on a daily basis');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMPETITOR_DATA_FX','PKG','URL','http://www.fxcompare.com.au/exchange-rate','source url to scrape');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMPETITOR_DATA_FX','PKG','TBL_NME','PY_COMPETITOR_DATA_FX','table name for the scrape results to be posted to');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMPETITOR_DATA_FX','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
/* 
==============================================================================================================================
CAREERJET NOT RUNNING FROM AU SERVERS - MANUALLY RUNNING
============================================================================================================================== 
*/
-- PY_BATCH_FIX_MORNING (CONTROLS WHAT SCRIPTS REQUIRE RERUNNING)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_MORNING','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_MORNING','PKG','PKGS_TO_RUN','PY_JOBS_NZ_CAREERJET,PY_JOBS_AU_CAREERJET','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_MORNING','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_MORNING','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com,sarka.howie@gmail.com','email distribution list for email notifications');
-- PY_BATCH_FIX_LUNCH (CONTROLS WHAT SCRIPTS REQUIRE RERUNNING)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_LUNCH','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_LUNCH','PKG','PKGS_TO_RUN','PY_JOBS_UK_CAREERJET','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_LUNCH','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_LUNCH','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com,sarka.howie@gmail.com','email distribution list for email notifications');
-- PY_BATCH_FIX_AFTERNOON (CONTROLS WHAT SCRIPTS REQUIRE RERUNNING)
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_AFTERNOON','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_AFTERNOON','PKG','PKGS_TO_RUN','PY_JOBS_CA_CAREERJET,PY_JOBS_US_CAREERJET','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_AFTERNOON','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
insert into PY_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_FIX_AFTERNOON','PKG','EMAIL_DSTRBTN_LST','toshach@gmail.com,sarka.howie@gmail.com','email distribution list for email notifications');





