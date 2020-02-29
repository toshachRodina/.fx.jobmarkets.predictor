/*
=======================================================================================================================================================================================================
SUBJECT		 : Control table housing variables required for automating/running ssis packages
OBJECT TYPE	 : TABLE
OBJECT NAME	 : ltn.dbo.ctl_ssis_vars
CREATED BY	 : Harold Delaney
CREATED ON	 : 20160818
SOURCE		 : 
PREPERATION	 : CREATE TABLE
			   INSERT VALUES REQUIRED FOR SSIS RUNNING
REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.ctl_ssis_vars;

CREATE TABLE ltn.dbo.ctl_ssis_vars
             (
             env       VARCHAR(6) NOT NULL
           , pkg_nme   VARCHAR(150) NULL
           , var_type  VARCHAR(6) NOT NULL
           , var_nme   VARCHAR(150) NOT NULL
           , var_val   VARCHAR(255) NOT NULL
           , var_cmnts VARCHAR(255) not null
             );

CREATE UNIQUE INDEX ux_ctl_ssis_vars ON ltn.dbo.ctl_ssis_vars(env,pkg_nme,var_nme);

ALTER TABLE ltn.dbo.ctl_ssis_vars REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
*/

truncate table ltn.dbo.ctl_ssis_vars;

-- ENVIRONMENT PARAMETERS
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_FILEPATH_CMDLINE','C:\Windows\System32\cmd.exe','file path to the windows command executable')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_FILEPATH_7ZIP','P:\PortableApps\PortableApps\7-ZipPortable\App\7-Zip64\7z.exe','file path to the 7zip portableApps executable')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_FILEPATH_WEBHARVY','C:\Users\tosha\AppData\Roaming\SysNucleus\WebHarvy\webharvy.exe','file path to the Webharvey web scraping tool executable')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_FILEPATH_DTEXEC','C:\Program Files (x86)\Microsoft SQL Server\110\DTS\Binn\DTExec.exe','file path to the sql server DTExec executable')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_FILEPATH_WEBHARVY_GENRC_BATCH','D:\Sync\__lanoitan\__scripts\__batch\WEBHARVY_WEBSCRAPE.bat','file path to the webharvy scraping batch file')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_CONN_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltn;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_CONN_MSSQL_STR_MASTER','Data Source=HAL-PC;Initial Catalog=master;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_CONN_LTNFX_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltnfx;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_CONN_LTNFX_LITE_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltnfx_lite;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_SSIS_PKGS','F:\__lanoitan\__ssis\','file path to the ssis packages used to process tasks')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_BATCH_FILES','D:\Sync\__lanoitan\__scripts\__batch\','file path to the batch command files used to run 3rd party scripts')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_WEBHARVY_CONFIG_FILES','D:\Sync\__lanoitan\__scripts\__webharvy\','file path to the webharvy scraping config files')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_PREPROCESSED','D:\Desktop\fx\','file path to the data folder used to prepare files for extraction and import')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_PROCESSED','E:\Lanoitan\__data\__processed\','file path to the data folder used to archived post processed  external flat files')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_DB_BAK','D:\Sync\__lanoitan\@data\__db_bak\','folder path to the sqlserver backup location')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_HTML','D:\Sync\__lanoitan\@data\__html\','file path to the html data folder used to capture html page detail for each scrape')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_FX','D:\Sync\__lanoitan\@data\__fx\','file path to the data folder used to store HISDATA zip files for fx pairs')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_EMAIL_DSTRBTN_LST','toshach@protonmail.com','email distribution list for email notifications')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_EMAIL_MSG','','generic email message if not specified in package variables')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_CMDLINE','C:\Windows\System32\cmd.exe','file path to the windows command executable')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_7ZIP','P:\PortableApps\PortableApps\7-ZipPortable\App\7-Zip64\7z.exe','file path to the 7zip portableApps executable')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_WEBHARVY','C:\Users\tosha\AppData\Roaming\SysNucleus\WebHarvy\webharvy.exe','file path to the Webharvey web scraping tool executable')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_DTEXEC','C:\Program Files (x86)\Microsoft SQL Server\110\DTS\Binn\DTExec.exe','file path to the sql server DTExec executable')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_WEBHARVY_GENRC_BATCH','D:\Sync\__lanoitan\__scripts\__batch\WEBHARVY_WEBSCRAPE.bat','file path to the webharvy scraping batch file')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_CONN_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltn;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_CONN_MSSQL_STR_MASTER','Data Source=HAL-PC;Initial Catalog=master;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_CONN_LTNFX_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltnfx;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_CONN_LTNFX_LITE_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltnfx_lite;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_SSIS_PKGS','D:\Sync\__lanoitan\__ssis\LTN\','file path to the ssis packages used to process tasks')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_BATCH_FILES','D:\Sync\__lanoitan\__scripts\__batch\','file path to the batch command files used to run 3rd party scripts')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_WEBHARVY_CONFIG_FILES','D:\Sync\__lanoitan\__scripts\__webharvy\','file path to the webharvy scraping config files')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_PREPROCESSED','D:\Desktop\fx\','file path to the data folder used to prepare files for extraction and import')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_PROCESSED','E:\Lanoitan\__data\__processed\','file path to the data folder used to archived post processed  external flat files')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_DB_BAK','D:\Sync\__lanoitan_dev\@data\__db_bak\','folder path to the sqlserver backup location')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_HTML','D:\Sync\__lanoitan\@data\__html\','file path to the html data folder used to capture html page detail for each scrape')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_FX','D:\Sync\__lanoitan\@data\__fx\','file path to the data folder used to store HISDATA zip files for fx pairs')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_EMAIL_DSTRBTN_LST','toshach@protonmail.com','email distribution list for email notifications')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_EMAIL_MSG','','generic email message if not specified in package variables')

-- LTN_UTIL_DB_BAK
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_UTIL_DB_BAK','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_UTIL_DB_BAK','PKG','PKG_SMRY_DESC','(NA)','run db backups to file system')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_UTIL_DB_BAK','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_UTIL_DB_BAK','PKG','PKG_SMRY_DESC','(NA)','run db backups to file system')


-- LTN_PKG_PYTHON_CTL
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_PYTHON_CTL','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_PYTHON_CTL','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_PYTHON_CTL','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_PYTHON_CTL','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

-- LTN_PKG_PYTHON_TWEEP_CTL
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_PYTHON_TWEEP_CTL','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_PYTHON_TWEEP_CTL','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_PYTHON_TWEEP_CTL','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_PYTHON_TWEEP_CTL','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

-- LTN_PKG_LABOUR_FORCE_STATUS_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_AU_STATUS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_AU_STATUS','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force details')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_AU_STATUS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_AU_STATUS','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force details')

-- LTN_PKG_LABOUR_FORCE_AU_STATUS_ACTUAL_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_AU_STATUS_ACTUAL','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_AU_STATUS_ACTUAL','PKG','PKG_SMRY_DESC','(NA)','captures ACTUIAL monthly labour force details - as data is corrected retrospectively, this process captures data as of announcement')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_AU_STATUS_ACTUAL','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_AU_STATUS_ACTUAL','PKG','PKG_SMRY_DESC','(NA)','captures ACTUIAL monthly labour force details - as data is corrected retrospectively, this process captures data as of announcement')

-- LTN_PKG_LABOUR_FORCE_HRS_WRKD_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_AU_HRS_WRKD','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_AU_HRS_WRKD','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force hours worked details')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_AU_HRS_WRKD','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_AU_HRS_WRKD','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force hours worked details')

-- LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_AU_UNDERUTIL_PRSNS_AGE_GNDR','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_AU_UNDERUTIL_PRSNS_AGE_GNDR','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force underutilised by age and gender')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_AU_UNDERUTIL_PRSNS_AGE_GNDR','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_AU_UNDERUTIL_PRSNS_AGE_GNDR','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force underutilised by age and gender')

-- LTN_PKG_GOVT_DATA_MEDIA_RELEASE
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_DATA_MEDIA_RELEASE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_DATA_MEDIA_RELEASE','PKG','PKG_SMRY_DESC','(NA)','captures the html media release details - to be compared to excel file releases')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_DATA_MEDIA_RELEASE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_DATA_MEDIA_RELEASE','PKG','PKG_SMRY_DESC','(NA)','captures the html media release details - to be compared to excel file releases')

-- LTN_PKG_CCY_PAIRS_T
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_T','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_T','PKG','PKG_SMRY_DESC','(NA)','tick (seconds) data for currency pairs')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_T','PKG','PKG_FILE_NAME_IN_NME','DAT_ASCII','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_T','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_T','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_T','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_T','PKG','PKG_SMRY_DESC','(NA)','tick (seconds) data for currency pairs')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_T','PKG','PKG_FILE_NAME_IN_NME','DAT_ASCII','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_T','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_T','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_CCY_PAIRS_MI
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_SMRY_DESC','(NA)','minute bar data for currency pairs')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_1','DAT_MS','name of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_SMRY_DESC','(NA)','minute data for currency pairs')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_1','DAT_MS','name of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_CCY_PAIRS_T_FXLITE
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_T_FXLITE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_T_FXLITE','PKG','PKG_SMRY_DESC','(NA)','tick data for currency pairs - only importing discrete dates fore the FXLITE DB')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_T_FXLITE','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_T_FXLITE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_T_FXLITE','PKG','PKG_SMRY_DESC','(NA)','tick data for currency pairs - only importing discrete dates fore the FXLITE DB')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_T_FXLITE','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_CCY_PAIRS_MI_FXLITE
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI_FXLITE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI_FXLITE','PKG','PKG_SMRY_DESC','(NA)','minute bar data for currency pairs - only importing discrete dates fore the FXLITE DB')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI_FXLITE','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI_FXLITE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI_FXLITE','PKG','PKG_SMRY_DESC','(NA)','minute data for currency pairs - only importing discrete dates fore the FXLITE DB')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI_FXLITE','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_IDX_PAIRS_MI
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_SMRY_DESC','(NA)','minute bar data for commodoty indexes')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_1','DAT_MS_AUX','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_2','DAT_MS_XAU','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_SMRY_DESC','(NA)','minute bar data for commodoty indexes')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_1','DAT_MS_AUX','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_2','DAT_MS_XAU','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_IDX_PAIRS_MI','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_DIM_DTE
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_DIM_DTE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_DIM_DTE','PKG','PKG_SMRY_DESC','(NA)','creates/refreshes a date reference per run from start of jobsearch capture (OCT-2016) to 1 year from date of run')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_DIM_DTE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_DIM_DTE','PKG','PKG_SMRY_DESC','(NA)','creates/refreshes a date reference per run from start of jobsearch capture (OCT-2016) to 1 year from date of run')

--LTN_PKG_DIM_CCY_PAIR_REF
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_DIM_CCY_PAIR_REF','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_DIM_CCY_PAIR_REF','PKG','FILE_RCVD_IND_CCY_PAIRS_MI','N','indicates that the file for CCY_PAIRS_MI has been received')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_DIM_CCY_PAIR_REF','PKG','FILE_RCVD_IND_CCY_PAIRS_T','N','indicates that the file for CCY_PAIRS_T has been received')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_DIM_CCY_PAIR_REF','PKG','FILE_RCVD_IND_IDX_PAIRS_MI','N','indicates that the file for IDX_PAIRS_MI has been received')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_DIM_CCY_PAIR_REF','PKG','PKG_SMRY_DESC','(NA)','recreates the dim_ccy_pair_ref table based on the current days we have in system for ccy pairs and the measure periods')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_DIM_CCY_PAIR_REF','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_DIM_CCY_PAIR_REF','PKG','FILE_RCVD_IND_CCY_PAIRS_MI','N','indicates that the file for CCY_PAIRS_MI has been received')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_DIM_CCY_PAIR_REF','PKG','FILE_RCVD_IND_CCY_PAIRS_T','N','indicates that the file for CCY_PAIRS_T has been received')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_DIM_CCY_PAIR_REF','PKG','FILE_RCVD_IND_IDX_PAIRS_MI','N','indicates that the file for IDX_PAIRS_MI has been received')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_DIM_CCY_PAIR_REF','PKG','PKG_SMRY_DESC','(NA)','recreates the dim_ccy_pair_ref table based on the current days we have in system for ccy pairs and the measure periods')

-- LTN_PKG_GOVT_KEY_DATE_ANNCMNTS
/* RETIRED - REPLACED BY LTN_PKG_ECONOMIC_CALENDAR
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_SMRY_DESC','(NA)','monthly update of key government announcements using scraped website data')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_SMRY_DESC','(NA)','monthly update of key government announcements using scraped website data')
*/
-- LTN_PKG_ECONOMIC_CALENDAR
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_ECONOMIC_CALENDAR','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_ECONOMIC_CALENDAR','PKG','PKG_SMRY_DESC','(NA)','monthly update of key economic announcements using scraped website data')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_ECONOMIC_CALENDAR','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_ECONOMIC_CALENDAR','PKG','PKG_SMRY_DESC','(NA)','monthly update of key economic announcements using scraped website data')

--LTN_PKG_JOBS_SCRAPE
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_SCRAPE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_SCRAPE','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_SCRAPE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_SCRAPE','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

--LTN_PKG_B4S_SCRAPE
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_B4S_SCRAPE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_B4S_SCRAPE','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_B4S_SCRAPE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_B4S_SCRAPE','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

--LTN_PKG_B4S_SCRAPE
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_COMMODITY_PRICE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_COMMODITY_PRICE','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_COMMODITY_PRICE','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_COMMODITY_PRICE','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

-- LTN_PKG_JOBS_TWITTER_SEARCH
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_TWITTER_SEARCH','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_TWITTER_SEARCH','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_TWITTER_SEARCH','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_TWITTER_SEARCH','PKG','PKG_SMRY_DESC','(NA)','transfers data collected in a sqlite3 database into sqlserver table.  no deletion from source is made - this is handled by the python script where 60 days of information is kept to protect against loss')

-- LTN_PKG_MOVE_HTML_PAGES
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_MOVE_HTML_PAGES','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_MOVE_HTML_PAGES','PKG','PKG_SMRY_DESC','(NA)','moves html files generated from scrapes from SYNC drive to local drive')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_MOVE_HTML_PAGES','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_MOVE_HTML_PAGES','PKG','PKG_SMRY_DESC','(NA)','moves html files generated from scrapes from SYNC drive to local drive')

-- LTN_PKG_MOVE_FX_FILES_PREPROCESS
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_MOVE_FX_FILES_PREPROCESS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_MOVE_FX_FILES_PREPROCESS','PKG','PKG_SMRY_DESC','(NA)','moves fx zip files from HISDATA to PREPROCESSING folder')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_MOVE_FX_FILES_PREPROCESS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_MOVE_FX_FILES_PREPROCESS','PKG','PKG_SMRY_DESC','(NA)','moves fx zip files from HISDATA to PREPROCESSING folder')

-- LTN_PKG_MOVE_FX_FILES_POSTPROCESS
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_MOVE_FX_FILES_POSTPROCESS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_MOVE_FX_FILES_POSTPROCESS','PKG','PKG_SMRY_DESC','(NA)','moves fx zip files from HISDATA to ARCHIVE folder')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_MOVE_FX_FILES_POSTPROCESS','PKG','PKG_FILE_SPEC','*.zip','moves fx zip files from PREPROCESS folder to ARCHIVE folder')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_MOVE_FX_FILES_POSTPROCESS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_MOVE_FX_FILES_POSTPROCESS','PKG','PKG_SMRY_DESC','(NA)','moves fx zip files from HISDATA to ARCHIVE folder')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_MOVE_FX_FILES_POSTPROCESS','PKG','PKG_FILE_SPEC','*.zip','moves fx zip files from PREPROCESS folder to ARCHIVE folder')

-- LTN_PKG_JOBS_3RD_PARTY
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_SMRY_DESC','(NA)','process data from 3rd part job advertisment providers')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_DT_ROLLOVER_RULE_ID','001','date rollover rule id to drive the sp logic')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_FILE_SPEC','*.pdf','moves selected file types')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_PROJ_FILEPATH_PDF','D:\Sync\__lanoitan\@data\__anz_job_ads\','file path to the pdf data folder used to capture anz job add downloads')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_SMRY_DESC','(NA)','process data from 3rd part job advertisment providers')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_DT_ROLLOVER_RULE_ID','001','date rollover rule id to drive the sp logic')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_FILE_SPEC','*.pdf','moves selected file types')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_JOBS_3RD_PARTY','PKG','PKG_PROJ_FILEPATH_PDF','D:\Sync\__lanoitan\@data\__anz_job_ads\','file path to the pdf data folder used to capture anz job add downloads')









-- ====================================================================================================================================================================================================

-- NEED TO THINK ABOUT THIS - CANT JUST RERUN INSERT SCRIPTS AS WE NOW HAVE ITEMS THAT ARE UPDATED FROM SSIS PKG RUNS

SELECT *
       FROM
            ltn.dbo.ctl_ssis_vars
       WHERE 1 = 1
             AND env = 'DEV'
		   AND pkg_nme = 'LTN_PKG_JOBS_3RD_PARTY'
       ORDER BY 1
              , 2
              , 3
              , 4;
