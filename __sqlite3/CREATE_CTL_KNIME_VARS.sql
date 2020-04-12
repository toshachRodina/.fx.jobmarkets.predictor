/*
=======================================================================================================================================================================================================
SUBJECT		 : Control table housing variables required for automating/running knime packages
OBJECT TYPE	 : TABLE
OBJECT NAME	 : KNIME_VARS_CTL
CREATED BY	 : Harold Delaney
CREATED ON	 : 20180716
SOURCE	 : 
PREPERATION	 : CREATE TABLE INSERT VALUES REQUIRED FOR KNIME RUNNING
REMARKS	 : 1) 
           2)
           3)
 
=======================================================================================================================================================================================================

PRAGMA auto_vacuum = FULL;

TABLE CREATION
-----------------------------

DROP TABLE KNIME_VARS_CTL;

CREATE TABLE KNIME_VARS_CTL (
    id        INTEGER        PRIMARY KEY AUTOINCREMENT,
    ENV       VARCHAR (6)    NOT NULL,
    PKG_NME   VARCHAR (150),
    VAR_TYPE  VARCHAR (6)    NOT NULL,
    VAR_NME   VARCHAR (150)  NOT NULL,
    VAR_VAL   VARCHAR (2000) NOT NULL,
    VAR_CMNTS VARCHAR (2000) NOT NULL
);

=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
DO NOT DELETE AND RERUN BELOW INSERTS
DATE PARAMS DRIVE PARTS OF THE KNIME DATA PROCESSING AND ANY DATES SHOW BELOW SHOULD BE VIEWED AS NOT CURRENT
AMEND AND RUN UPDATE SCRIPTS TO ALTER EXISTING ENTRIES
=======================================================================================================================================================================================================
*/
/*
UPDATE
	KNIME_VARS_CTL
SET
	VAR_VAL = 20180601
WHERE
	1 = 1
	AND PKG_NME = 'FX_PAIRS_TICK'
	AND ENV = 'PROD'
	AND VAR_NME = 'EXTRACT_DTE_ID'
*/


--delete from KNIME_VARS_CTL;

/*
ENVIRONMENT PARAMETERS
-------------------------------------------------
SELECT
	*
FROM
	KNIME_VARS_CTL
WHERE
	1 = 1
	AND env = 'PROD'
	AND var_type = 'ENV'

*/
-- PROD
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_CMDLINE','C:\Windows\System32\cmd.exe','file path to the windows command executable');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_7ZIP','P:\PortableApps\PortableApps\7-ZipPortable\App\7-Zip64\7z.exe','file path to the 7zip portableApps executable');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_BATCH_FILES','D:\Sync\__lanoitan\__scripts\__batch','file path to the batch command files used to run 3rd party scripts');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_PYTHON_EXE','C:\Users\tosha\Anaconda3\envs\lanoitan\python.exe','python executable path');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_CHROME_WEB_DRVR','D:\Sync\__lanoitan\@drivers\chromedriver.exe','the web driver used for the selenium parser');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_SSIS_PKGS','F:\__lanoitan\__ssis','file path to the ssis packages used to process tasks');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_DEFAULT_SYS_DOWNLOAD_DIR','D:\Downloads','file path to default system download folder');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_PREPROCESSED','D:\Desktop\@preproc.data','file path to the data folder used to prepare files for extraction and import');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_PROCESSED','E:\Lanoitan\__data\__processed','file path to the data folder used to archived post processed  external flat files');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','FILEPATH_FX','D:\Sync\__lanoitan\@data\__fx','file path to the data folder used to store HISDATA zip files for fx pairs');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','MYSQL_DB_DRIVER','com.mysql.cj.jdbc.Driver','jdbc driver used for connecting to mysql');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','MYSQL_DB_URL_LTN','jdbc:mysql://localhost:3306/ltn','db url for connection');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','MYSQL_DB_URL_LTNFX','jdbc:mysql://localhost:3306/ltnfx','db url for connection');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','MYSQL_DB_USER','lanoitan','user sign on');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','MYSQL_DB_PWRD','lanoitan$00','user password');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_GMAIL_SENDER_NME','lanoitan17@gmail.com','email sender username/address for email notifications');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_GMAIL_SENDER_PWD','500BourkeStreet','email sender password');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_GMAIL_SMTP_HOST','smtp.gmail.com','smtp host details for gmail');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_GMAIL_SMTP_PORT','587','smtp port number for gmail');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_DSTRBTN_LST','toshach@protonmail.com','email distribution list for email notifications');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','EMAIL_MSG','','generic email message if not specified in package variables');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','KEY_ALPHAVANTAGE_API','56K58AYA092DZZPA','api key');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','KEY_QUANDL_API','-7YMD_XEY7yvNsYDX92s','api key');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','DATA_RETENTION_DAYS','30','number of days to keep data within sqlite tables.  is overridden if a pkg variable is present');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','LOOP_RNDM_SLEEP_LOW','1','sets the lower limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','','ENV','LOOP_RNDM_SLEEP_HIGH','5','sets the higher limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');

-- DEV
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_CMDLINE','C:\Windows\System32\cmd.exe','file path to the windows command executable');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_7ZIP','P:\PortableApps\PortableApps\7-ZipPortable\App\7-Zip64\7z.exe','file path to the 7zip portableApps executable');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_BATCH_FILES','D:\Sync\__lanoitan\__scripts\__batch','file path to the batch command files used to run 3rd party scripts');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_PYTHON_EXE','C:\Users\tosha\Anaconda3\envs\lanoitan\python.exe','python executable path');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_CHROME_WEB_DRVR','D:\Sync\__lanoitan\@drivers\chromedriver.exe','the web driver used for the selenium parser');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_SSIS_PKGS','F:\__lanoitan\__ssis','file path to the ssis packages used to process tasks');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_DEFAULT_SYS_DOWNLOAD_DIR','D:\Downloads','file path to default system download folder');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_PREPROCESSED','D:\Desktop\@preproc.data','file path to the data folder used to prepare files for extraction and import');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_PROCESSED','E:\Lanoitan\__data\__processed','file path to the data folder used to archived post processed  external flat files');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','FILEPATH_FX','D:\Sync\__lanoitan\@data\__fx','file path to the data folder used to store HISDATA zip files for fx pairs');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','MYSQL_DB_DRIVER','com.mysql.cj.jdbc.Driver','jdbc driver used for connecting to mysql');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','MYSQL_DB_URL_LTN','jdbc:mysql://localhost:3306/ltn','db url for connection');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','MYSQL_DB_URL_LTNFX','jdbc:mysql://localhost:3306/ltnfx','db url for connection');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','MYSQL_DB_USER','lanoitan','user sign on');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','MYSQL_DB_PWRD','lanoitan$00','user password');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_GMAIL_SENDER_NME','lanoitan17@gmail.com','email sender username/address for email notifications');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_GMAIL_SENDER_PWD','500BourkeStreet','email sender password');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_GMAIL_SMTP_HOST','smtp.gmail.com','smtp host details for gmail');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_GMAIL_SMTP_PORT','587','smtp port number for gmail');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_DSTRBTN_LST','toshach@protonmail.com','email distribution list for email notifications');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','EMAIL_MSG','','generic email message if not specified in package variables');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','KEY_ALPHAVANTAGE_API','56K58AYA092DZZPA','api key');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','KEY_QUANDL_API','-7YMD_XEY7yvNsYDX92s','api key');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','DATA_RETENTION_DAYS','30','number of days to keep data within sqlite tables.  is overridden if a pkg variable is present');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','LOOP_RNDM_SLEEP_LOW','1','sets the lower limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','','ENV','LOOP_RNDM_SLEEP_HIGH','5','sets the higher limit of the random wait time function accross all packages that rely on looping through web pages on the site (assists in reflecting human interaction on website');

/* 
==============================================================================================================================
TABLEAU REPORT UPDATE (CHANGE SQLSERVER CONNECTIONS DEPENDING ON PLATFORM BEING RUN ON)
** NO PYTHON BATCH REQUIRED - WILL BE RUN INDIVIDUALLY FROM REPORTING DIRECTORY USING CMD BATCH
============================================================================================================================== 
*/

/*
PY_CCY_PAIRS_TICK_FX
-------------------------------------------------
SELECT
	*
FROM
	KNIME_VARS_CTL
WHERE
	1 = 1
	AND env = 'PROD'
	AND var_type = 'PKG'
	AND pkg_nme = 'FX_PAIRS_TICK'
	
*/
-- PROD
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','SMRY_DESC','(NA)','retrieves monthly tick currency and idx pairs from histdata.com in compressed folder form.  unpack and import spreadsheet data');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','EXTRACT_DTE_ID','20180601','used to track the date perion in which to extract data for');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','NEXT_RUN_DTE_ID','20180710','set for the day of month to run when setting next run date');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','DOM_TO_RUN','10','set for the day of month to run when setting next run date');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','PREPROCESSED_FOLDER_NME','fx','name of folder in which files are to be processed');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','URL','http://www.histdata.com/download-free-forex-historical-data/?/ascii/tick-data-quotes/','source url to scrape');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','SLEEP_VAL','20','sets wait time function (assists in reflecting human interaction on website');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','FILE_NAME_SEARCH','HISTDATA','part or all of the file name required for moving');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','FILE_EXTENSION','zip','file extension of the files being moved');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','DOWNLOAD_ID','a_file','id tag for the download element');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_TICK','PKG','FX_PAIRS','AUDCAD,AUDCHF','ccy pairs to retrieve from histdata'); -- ,AUDJPY,AUDNZD,AUDUSD,CADCHF,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURCZK,EURDKK,EURGBP,EURUSD,GBPAUD,GBPCAD,GBPCHF,GBPJPY,GBPUSD,NZDCAD,NZDJPY,NZDUSD,USDCAD,USDCZK,USDDKK,USDHKD,USDJPY,WTIUSD,AUXAUD,ETXEUR,FRXEUR,GRXEUR,HKXHKD,JPXJPY,NSXUSD,SPXUSD,UDXUSD,UKXGBP,XAGUSD,XAUAUD,XAUCHF,XAUEUR,XAUGBP,XAUUSD

-- DEV
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','SMRY_DESC','(NA)','retrieves monthly tick currency and idx pairs from histdata.com in compressed folder form.  unpack and import spreadsheet data');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','EXTRACT_DTE_ID','20180601','used to track the date perion in which to extract data for');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','NEXT_RUN_DTE_ID','20180710','set for the day of month to run when setting next run date');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','DOM_TO_RUN','10','set for the day of month to run when setting next run date');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','PREPROCESSED_FOLDER_NME','fx','name of folder in which files are to be processed');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','URL','http://www.histdata.com/download-free-forex-historical-data/?/ascii/tick-data-quotes/','source url to scrape');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','SLEEP_VAL','20','sets wait time function (assists in reflecting human interaction on website');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','FILE_NAME_SEARCH','HISTDATA','part or all of the file name required for moving');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','FILE_EXTENSION','zip','file extension of the files being moved');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','DOWNLOAD_ID','a_file','id tag for the download element');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_TICK','PKG','FX_PAIRS','AUDCAD,AUDCHF','ccy pairs to retrieve from histdata'); -- ,AUDJPY,AUDNZD,AUDUSD,CADCHF,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURCZK,EURDKK,EURGBP,EURUSD,GBPAUD,GBPCAD,GBPCHF,GBPJPY,GBPUSD,NZDCAD,NZDJPY,NZDUSD,USDCAD,USDCZK,USDDKK,USDHKD,USDJPY,WTIUSD,AUXAUD,ETXEUR,FRXEUR,GRXEUR,HKXHKD,JPXJPY,NSXUSD,SPXUSD,UDXUSD,UKXGBP,XAGUSD,XAUAUD,XAUCHF,XAUEUR,XAUGBP,XAUUSD

/*
PY_CCY_PAIRS_MBAR_FX
-------------------------------------------------
SELECT
	*
FROM
	KNIME_VARS_CTL
WHERE
	1 = 1
	AND env = 'PROD'
	AND var_type = 'PKG'
	AND pkg_nme = 'FX_PAIRS_MBAR'
	
*/
-- PROD
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','SMRY_DESC','(NA)','retrieves monthly minute bar currency and idx pairs from histdata.com in compressed folder form.  unpack and import spreadsheet data');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','URL','http://www.histdata.com','source url to scrape');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','URL_PART1','/download-free-forex-data/?/metastock/1-minute-bar-quotes','additional url parts - typical used for search paramaters');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','SLEEP_VAL','20','sets wait time function (assists in reflecting human interaction on website');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','FILE_MOVE_DEST_PATH','D:\Sync\__lanoitan\@data\__fx','destination folder path to store files temporarily');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','FILE_NAME_SEARCH','HISTDATA','part or all of the file name required for moving');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','FILE_EXTENSION','zip','file extension of the files being moved');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','DOWNLOAD_ID','a_file','id tag for the download element');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','CCY_PAIRS','AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,AUXAUD,CADCHF,CADJPY,EURAUD,EURCAD,EURGBP,EURNZD,EURUSD,GBPAUD,GBPCAD,GBPCHF,GBPJPY,GBPNZD,GBPUSD,NZDCAD,NZDCHF,NZDJPY,NZDUSD,USDCAD,USDCHF,USDCZK,USDJPY,XAUAUD','ccy pairs to retrieve from histdata');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','FX_PAIRS_MBAR','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','SMRY_DESC','(NA)','retrieves monthly minute bar currency and idx pairs from histdata.com in compressed folder form.  unpack and import spreadsheet data');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','URL','http://www.histdata.com','source url to scrape');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','URL_PART1','/download-free-forex-data/?/metastock/1-minute-bar-quotes','additional url parts - typical used for search paramaters');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','SLEEP_VAL','20','sets wait time function (assists in reflecting human interaction on website');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','FILE_MOVE_DEST_PATH','D:\Sync\__lanoitan\@data\__fx','destination folder path to store files temporarily');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','FILE_NAME_SEARCH','HISTDATA','part or all of the file name required for moving');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','FILE_EXTENSION','zip','file extension of the files being moved');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','DOWNLOAD_ID','a_file','id tag for the download element');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','CCY_PAIRS','AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,AUXAUD,CADCHF,CADJPY,EURAUD,EURCAD,EURGBP,EURNZD,EURUSD,GBPAUD,GBPCAD,GBPCHF,GBPJPY,GBPNZD,GBPUSD,NZDCAD,NZDCHF,NZDJPY,NZDUSD,USDCAD,USDCHF,USDCZK,USDJPY,XAUAUD','ccy pairs to retrieve from histdata');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','FX_PAIRS_MBAR','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');

/* 
==============================================================================================================================
JOBADS
============================================================================================================================== 
*/

/*
JOBADS
-------------------------------------------------
SELECT
	*
FROM
	KNIME_VARS_CTL
WHERE
	1 = 1
	AND env = 'PROD'
	AND var_type = 'PKG'
	AND pkg_nme = 'JOBADS_JOBS'
	
*/
-- PROD
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','JOBADS_JOBS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','JOBADS_JOBS','PKG','SMRY_DESC','(NA)','reads in data captured and stored in sqlite3 db and writes to mysql db for main storage');
-- DEV
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','JOBADS_JOBS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','JOBADS_JOBS','PKG','SMRY_DESC','(NA)','reads in data captured and stored in sqlite3 db and writes to mysql db for main storage');
 


/*
BUSINESSES FOR SALE
-------------------------------------------------
SELECT
	*
FROM
	KNIME_VARS_CTL
WHERE
	1 = 1
	AND env = 'PROD'
	AND var_type = 'PKG'
	AND pkg_nme = 'JOBADS_B4S'
	
*/
-- PROD
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','JOBADS_B4S','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','JOBADS_B4S','PKG','SMRY_DESC','(NA)','reads in data captured and stored in sqlite3 db and writes to mysql db for main storage');
-- DEV
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','JOBADS_B4S','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','JOBADS_B4S','PKG','SMRY_DESC','(NA)','reads in data captured and stored in sqlite3 db and writes to mysql db for main storage');
 

/* 
==============================================================================================================================
GOVERNMENT KEY DATE ANNOUNCEMENTS
============================================================================================================================== 
*/

/*
PY_ECONOMIC_CALENDAR
-------------------------------------------------
SELECT
	*
FROM
	KNIME_VARS_CTL
WHERE
	1 = 1
	AND env = 'PROD'
	AND var_type = 'PKG'
	AND pkg_nme = 'ECONOMIC_CALENDAR_BABYPIPS'
	
*/
-- PROD 
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','ECONOMIC_CALENDAR_BABYPIPS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','ECONOMIC_CALENDAR_BABYPIPS','PKG','SMRY_DESC','(NA)','scrapes key dates listed on various world economic calendars');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','ECONOMIC_CALENDAR_BABYPIPS','PKG','URL','https://www.babypips.com/economic-calendar?timezone=Australia%2FMelbourne','source url to scrape');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','ECONOMIC_CALENDAR_BABYPIPS','PKG','TBL_NME','PY_ECONOMIC_CALENDAR','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','ECONOMIC_CALENDAR_BABYPIPS','PKG','DATA_TYPE','ECONOMIC ANNOUNCEMENT','data type entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','ECONOMIC_CALENDAR_BABYPIPS','PKG','SITE_CDE','FXCM','site code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','ECONOMIC_CALENDAR_BABYPIPS','PKG','WEEK_NBR','50','calendar site is driven on week number.  use this to determine current and previous week (to pick up the ACTUAL values)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','ECONOMIC_CALENDAR_BABYPIPS','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV 
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','ECONOMIC_CALENDAR_BABYPIPS','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','ECONOMIC_CALENDAR_BABYPIPS','PKG','SMRY_DESC','(NA)','scrapes key dates listed on various world economic calendars');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','ECONOMIC_CALENDAR_BABYPIPS','PKG','URL','https://www.babypips.com/economic-calendar?timezone=Australia%2FMelbourne','source url to scrape');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','ECONOMIC_CALENDAR_BABYPIPS','PKG','TBL_NME','PY_ECONOMIC_CALENDAR','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','ECONOMIC_CALENDAR_BABYPIPS','PKG','DATA_TYPE','ECONOMIC ANNOUNCEMENT','data type entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','ECONOMIC_CALENDAR_BABYPIPS','PKG','SITE_CDE','FXCM','site code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','ECONOMIC_CALENDAR_BABYPIPS','PKG','WEEK_NBR','50','calendar site is driven on week number.  use this to determine current and previous week (to pick up the ACTUAL values)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','ECONOMIC_CALENDAR_BABYPIPS','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');

/* 
==============================================================================================================================
GOVERNMENT DATA
============================================================================================================================== 
*/

/*
PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE
-------------------------------------------------
SELECT
	*
FROM
	KNIME_VARS_CTL
WHERE
	1 = 1
	AND env = 'PROD'
	AND var_type = 'PKG'
	AND pkg_nme = 'GOVT_DATA_AU_MEDIA_RELEASE'
	
*/
-- PROD
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_MEDIA_RELEASE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_MEDIA_RELEASE','PKG','SMRY_DESC','(NA)','scrapes key data from the media release details on the day of announcement');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_MEDIA_RELEASE','PKG','URL','http://www.abs.gov.au/latest','source url to scrape ----- old url for returning historical announcement on loop ----- http://www.abs.gov.au/AUSSTATS/abs@.nsf/second+level+view?ReadForm&prodno=6202.0&viewtitle=Labour%20Force,%20Australia~May%202017~Latest~15/06/2017&&tabname=Past%20Future%20Issues&prodno=6202.0&issue=May%202017&num=&view=&');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_MEDIA_RELEASE','PKG','TBL_NME','PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_MEDIA_RELEASE','PKG','DATA_TYPE','GOVT DATA MEDIA RELEASE','data type entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_MEDIA_RELEASE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_MEDIA_RELEASE','PKG','SITE_CDE','ABS','site code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_MEDIA_RELEASE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
-- DEV
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_MEDIA_RELEASE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_MEDIA_RELEASE','PKG','SMRY_DESC','(NA)','scrapes key data from the media release details on the day of announcement');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_MEDIA_RELEASE','PKG','URL','http://www.abs.gov.au/latest','source url to scrape ----- old url for returning historical announcement on loop ----- http://www.abs.gov.au/AUSSTATS/abs@.nsf/second+level+view?ReadForm&prodno=6202.0&viewtitle=Labour%20Force,%20Australia~May%202017~Latest~15/06/2017&&tabname=Past%20Future%20Issues&prodno=6202.0&issue=May%202017&num=&view=&');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_MEDIA_RELEASE','PKG','TBL_NME','PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_MEDIA_RELEASE','PKG','DATA_TYPE','GOVT DATA MEDIA RELEASE','data type entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_MEDIA_RELEASE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_MEDIA_RELEASE','PKG','SITE_CDE','ABS','site code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_MEDIA_RELEASE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');

/*
PY_GOVT_DATA_AU_LABOUR_FORCE
-------------------------------------------------
SELECT
	*
FROM
	KNIME_VARS_CTL
WHERE
	1 = 1
	AND env = 'PROD'
	AND var_type = 'PKG'
	AND pkg_nme = 'GOVT_DATA_AU_LABOUR_FORCE'
	
*/
-- PROD
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','SMRY_DESC','(NA)','scrapes data from the australian government website specific labour force related material');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','URL','http://www.abs.gov.au','source url to scrape');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','URL_PART1','/AUSSTATS/abs@.nsf/DetailsPage/6202.0','additional url parts - typical used for search paramaters');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_STATUS','PY_LABOUR_FORCE_AU_STATUS','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_HRS_WRKD','PY_LABOUR_FORCE_AU_HRS_WRKD','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_UNDRUTIL_PRSNS','PY_LABOUR_FORCE_AU_UNDERUTIL_PRSNS','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_STATUS','6202001','file name of the target spreadsheet on website to be scraped');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_HRS_WRKD','6202019','file name of the target spreadsheet on website to be scraped');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_UNDRUTIL_PRSNS','6202024','file name of the target spreadsheet on website to be scraped');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_MOVE_DEST_PATH','D:\Sync\__lanoitan\@data\__labour_force\\','destination folder path to store files temporarily');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','DATA_TYPE','LABOUR FORCE','data type entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','SITE_CDE','ABS','site code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('PROD','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILES_TO_GET_EXT','.xls','extension (file type) of the files to retrieve from web page');
-- DEV
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in BATCH script)');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','SMRY_DESC','(NA)','scrapes data from the australian government website specific labour force related material');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','URL','http://www.abs.gov.au','source url to scrape');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','URL_PART1','/AUSSTATS/abs@.nsf/DetailsPage/6202.0','additional url parts - typical used for search paramaters');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_STATUS','PY_LABOUR_FORCE_AU_STATUS','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_HRS_WRKD','PY_LABOUR_FORCE_AU_HRS_WRKD','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','TBL_NME_LABOUR_FORCE_UNDRUTIL_PRSNS','PY_LABOUR_FORCE_AU_UNDERUTIL_PRSNS','table name for the scrape results to be posted to');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_STATUS','6202001','file name of the target spreadsheet on website to be scraped');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_HRS_WRKD','6202019','file name of the target spreadsheet on website to be scraped');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_NME_LABOUR_FORCE_UNDRUTIL_PRSNS','6202024','file name of the target spreadsheet on website to be scraped');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILE_MOVE_DEST_PATH','D:\Sync\__lanoitan\@data\__labour_force\\','destination folder path to store files temporarily');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','DATA_TYPE','LABOUR FORCE','data type entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','CNTRY_CDE','AU','country code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','SITE_CDE','ABS','site code entry for results');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','USES_WEB_DRVR','N','indicates whether web driver (selenium) is used or html can be parsed directly');
insert into KNIME_VARS_CTL (ENV, PKG_NME, VAR_TYPE, VAR_NME, VAR_VAL, VAR_CMNTS) values ('DEV','GOVT_DATA_AU_LABOUR_FORCE','PKG','FILES_TO_GET_EXT','.xls','extension (file type) of the files to retrieve from web page');

--=========
/*
WITH DAT AS( SELECT
	UN.VAR_NME, MIN(UN.ENV_FLG) AS ENV_FLG
FROM
	( SELECT
		VARS.VAR_NME, VARS.VAR_VAL,
		CASE
			VARS.VAR_TYPE
			WHEN 'ENV' THEN 2
			WHEN 'PKG' THEN 1
		END AS ENV_FLG
	FROM
		KNIME_VARS_CTL VARS
	WHERE
		VARS.ENV = 'PROD'
		AND VARS.VAR_TYPE = 'ENV'
UNION ALL SELECT
		VARS.VAR_NME, VARS.VAR_VAL,
		CASE
			VARS.VAR_TYPE
			WHEN 'ENV' THEN 2
			WHEN 'PKG' THEN 1
		END AS ENV_FLG
	FROM
		KNIME_VARS_CTL VARS
	WHERE
		VARS.ENV = 'PROD'
		AND VARS.PKG_NME = 'FX_PAIRS_TICK'
		AND VARS.VAR_TYPE = 'PKG' ) UN
GROUP BY
	VAR_NME ) SELECT
	VARS.VAR_NME,
	VARS.VAR_VAL
FROM
	DAT,
	KNIME_VARS_CTL VARS
WHERE
	VARS.ENV = 'PROD'
	AND VARS.VAR_NME != 'SMRY_DESC'
	AND VARS.PKG_NME =
	CASE
		DAT.ENV_FLG
		WHEN 1 THEN 'FX_PAIRS_TICK'
		WHEN 2 THEN ''
	END
	AND VARS.VAR_TYPE =
	CASE
		DAT.ENV_FLG
		WHEN 1 THEN 'PKG'
		WHEN 2 THEN 'ENV'
	END
	AND VARS.VAR_NME = DAT.VAR_NME

*/


/*
MOVING DATA FROM 1 DATABASE TO ANOTHER
-- HELPFUL WHEN CONFLICT DB HAS DATA THAT HASNT BEEN APPLIED TO ACTUAL DB
*/
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
		PY_JOBADS_JOBS_DATA(
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
