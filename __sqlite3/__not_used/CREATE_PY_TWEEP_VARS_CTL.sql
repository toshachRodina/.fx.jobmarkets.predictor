/*
=======================================================================================================================================================================================================
SUBJECT		 : Control table housing variables required for automating/running python packages
OBJECT TYPE	 : TABLE
OBJECT NAME	 : PY_TWEEP_VARS_CTL
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170627
SOURCE	 : 
PREPERATION	 : CREATE TABLE INSERT VALUES REQUIRED FOR SSIS RUNNING
REMARKS	 : 1) 
           2)
           3)
 
=======================================================================================================================================================================================================
TABLE CREATION
-----------------------------

DROP TABLE PY_TWEEP_VARS_CTL;

CREATE TABLE PY_TWEEP_VARS_CTL (
    id        INTEGER        PRIMARY KEY AUTOINCREMENT,
    ENV       VARCHAR (6)    NOT NULL,
    PKG_NME   VARCHAR (150),
    VAR_TYPE  VARCHAR (6)    NOT NULL,
    VAR_NME   VARCHAR (150)  NOT NULL,
    VAR_VAL   VARCHAR (2000) NOT NULL,
    VAR_CMNTS VARCHAR (2000) NOT NULL
);
=======================================================================================================================================================================================================

select * from PY_TWEEP_VARS_CTL

*/

delete from PY_TWEEP_VARS_CTL;

-- ENVIRONMENT PARAMETERS
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_SNDR_USRNME','lanoitan17@gmail.com','email sender username/address for email notifications');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_SNDR_PWORD','500BourkeStreet','email sender password');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_DSTRBTN_LST','toshach@gmail.com','email distribution list for email notifications');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','DATA_RETENTION_DAYS','10','number of days to keep data within sqlite tables.  is overridden if a pkg variable is present');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_MSG','','generic email message. is overridden if pkg variable is present');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_CNSMR_KEY','EO3DcdljWwxN4TKrUUB27Nn96','api key');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_CNSMR_SECRET','H9XFfndnoGXrepH5RQA9N2hCaSWJHNV66t9DXXz5DDF1CPXJWp','api secret');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_ACCESS_TOKEN','12577272-frRvqnqx1IfaKuwy5aOe172ppKeBL2ta6AAUtsQns','access token');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','TWIT_ACCESS_SECRET','qfneff6FA12lz3otz4jdXFEQZqyplrrAJuqlZUAe7hEpI','access token secret');

/* 
==============================================================================================================================
TWITTER - JOB SIGNALS
============================================================================================================================== 
*/
-- PY_BATCH_MARKETS (CONTROLS WHAT SCRIPTS IN THE "COMPETITOR" FOLDER ARE RUN)
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','PKGS_TO_RUN','PY_COMMODITIES','list of packages to be run within the current folder (comma(,) delimeted)');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_BATCH_MARKETS','PKG','SMRY_DESC','(NA)','batch controller - this package is used to fire packages located in same folder and listed in the PKG_TO_RUN variable');
-- PY_COMMODITIES
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','SMRY_DESC','(NA)','using the yahoo finance API, retrieve various commoditiy prices per day');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_COMMODITIES','PKG','TBL_NME','PY_COMMODITY_DATA','table name for the scrape results to be posted to');
-- PY_CCY_PAIRS_TICK_FX
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','SMRY_DESC','(NA)','retrieves monthly tick currency and idx pairs from histdata.com in compressed folder form.  unpack and import spreadsheet data');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','URL','http://www.histdata.com','source url to scrape');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','URL_PART1','/download-free-forex-data/?/ascii/tick-data-quotes','additional url parts - typical used for search paramaters');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','CCY_PAIRS','AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,AUXAUD,EURAUD,EURUSD,GBPAUD,GBPUSD,NZDUSD,USDCAD,USDCZK,XAUAUD','ccy pairs to retrieve from histdata');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_TICK_FX','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- PY_CCY_PAIRS_MBAR_FX
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','SMRY_DESC','(NA)','retrieves monthly minute bar currency and idx pairs from histdata.com in compressed folder form.  unpack and import spreadsheet data');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','URL','http://www.histdata.com','source url to scrape');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','URL_PART1','/download-free-forex-data/?/metastock/1-minute-bar-quotes','additional url parts - typical used for search paramaters');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','CCY_PAIRS','AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,EURAUD,GBPAUD,AUXAUD,XAUAUD','ccy pairs to retrieve from histdata');
insert into PY_TWEEP_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','PY_CCY_PAIRS_MBAR_FX','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');



