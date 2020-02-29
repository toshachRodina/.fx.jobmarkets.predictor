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
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_FILEPATH_WEBHARVY','C:\Users\tosha\AppData\Roaming\SysNucleus\WebHarvy\webharvy.exe','file path to the Webharvey web scraping tool executable')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_FILEPATH_DTEXEC','C:\Program Files (x86)\Microsoft SQL Server\110\DTS\Binn\DTExec.exe','file path to the sql server DTExec executable')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_FILEPATH_WEBHARVY_GENRC_BATCH','D:\Sync\__lanoitan\__scripts\__batch\WEBHARVY_WEBSCRAPE.bat','file path to the webharvy scraping batch file')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_CONN_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltn;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_CONN_LTNFX_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltnfx;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_DATA','F:\__lanoitan\__data\','file path to the data folder used to process external flat files')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_SSIS_PKGS','F:\__lanoitan\__ssis\','file path to the ssis packages used to process tasks')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_BATCH_FILES','D:\Sync\__lanoitan\__scripts\__batch\','file path to the batch command files used to run 3rd party scripts')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_WEBHARVY_CONFIG_FILES','D:\Sync\__lanoitan\__scripts\__webharvy\','file path to the webharvy scraping config files')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_PROJ_FILEPATH_PROCESSED','E:\Lanoitan\__data\__processed\','file path to the data folder used to archived post processed  external flat files')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_EMAIL_DSTRBTN_LST','toshach@protonmail.com','email distribution list for email notifications')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','','ENV','ENV_EMAIL_MSG','','generic email message if not specified in package variables')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_CMDLINE','C:\Windows\System32\cmd.exe','file path to the windows command executable')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_WEBHARVY','C:\Users\tosha\AppData\Roaming\SysNucleus\WebHarvy\webharvy.exe','file path to the Webharvey web scraping tool executable')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_DTEXEC','C:\Program Files (x86)\Microsoft SQL Server\110\DTS\Binn\DTExec.exe','file path to the sql server DTExec executable')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_FILEPATH_WEBHARVY_GENRC_BATCH','D:\Sync\__lanoitan\__scripts\__batch\WEBHARVY_WEBSCRAPE.bat','file path to the webharvy scraping batch file')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_CONN_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltn;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_CONN_LTNFX_MSSQL_STR','Data Source=HAL-PC;Initial Catalog=ltnfx;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;','connection string for the targetted sql server')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_DATA','D:\Sync\__lanoitan\__data\','file path to the data folder used to process external flat files')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_SSIS_PKGS','D:\Sync\__lanoitan\__ssis\LTN\','file path to the ssis packages used to process tasks')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_BATCH_FILES','D:\Sync\__lanoitan\__scripts\__batch\','file path to the batch command files used to run 3rd party scripts')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_WEBHARVY_CONFIG_FILES','D:\Sync\__lanoitan\__scripts\__webharvy\','file path to the webharvy scraping config files')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_PROJ_FILEPATH_PROCESSED','E:\Lanoitan\__data\__processed\','file path to the data folder used to archived post processed  external flat files')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_EMAIL_DSTRBTN_LST','toshach@protonmail.com','email distribution list for email notifications')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','','ENV','ENV_EMAIL_MSG','','generic email message if not specified in package variables')

-- LTN_PKG_LABOUR_FORCE_STATUS_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force details')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_FILE_NAME_IN_NME','6202001','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_FILE_NAME_OUT_NME','LABOUR_FORCE_STATUS','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force details')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_FILE_NAME_IN_NME','6202001','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_FILE_NAME_OUT_NME','LABOUR_FORCE_STATUS','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_STATUS_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_LABOUR_FORCE_HRS_WRKD_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force hours worked details')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_FILE_NAME_IN_NME','6202019','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_FILE_NAME_OUT_NME','LABOUR_FORCE_HRS_WRKD','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force hours worked details')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_FILE_NAME_IN_NME','6202019','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_FILE_NAME_OUT_NME','LABOUR_FORCE_HRS_WRKD','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_HRS_WRKD_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force underutilised by age and gender')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_FILE_NAME_IN_NME','6202024','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_FILE_NAME_OUT_NME','LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly labour force underutilised by age and gender')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_FILE_NAME_IN_NME','6202024','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_FILE_NAME_OUT_NME','LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly building application data by sector')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_FILE_NAME_IN_NME','8731006','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_FILE_NAME_OUT_NME','BUILDING_APPRVLS_SECTOR_ALL','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly building application data by sector')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_FILE_NAME_IN_NME','8731006','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_FILE_NAME_OUT_NME','BUILDING_APPRVLS_SECTOR_ALL','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ALL_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly building application data by sector')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_FILE_NAME_IN_NME','87310011','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_FILE_NAME_OUT_NME','BUILDING_APPRVLS_SECTOR_ORIGINAL','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly building application data by sector')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_FILE_NAME_IN_NME','87310011','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_FILE_NAME_OUT_NME','BUILDING_APPRVLS_SECTOR_ORIGINAL','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_SECTOR_ORIGINAL_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_BUILDING_APRVLS_VALUE_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly building application value data')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_FILE_NAME_IN_NME','87310038','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_FILE_NAME_OUT_NME','BUILDING_APPRVLS_VALUE','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly building application value data')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_FILE_NAME_IN_NME','87310038','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_FILE_NAME_OUT_NME','BUILDING_APPRVLS_VALUE','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_VALUE_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly building application non residential value band data')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_FILE_NAME_IN_NME','87310068','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_FILE_NAME_OUT_NME','BUILDING_APPRVLS_VALUE','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_SMRY_DESC','(NA)','captures monthly building application non residential value band data')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_FILE_NAME_IN_NME','87310068','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_FILE_NAME_OUT_NME','BUILDING_APPRVLS_VALUE','name of file to be stored')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_BUILDING_APRVLS_NONRES_VALUE_BAND_M','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_WEBHARVY_SCRAPE_KEY_DATE_ANNCMNTS_D
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_WEBHARVY_SCRAPE_KEY_DATE_ANNCMNTS_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_WEBHARVY_SCRAPE_KEY_DATE_ANNCMNTS_D','PKG','PKG_SMRY_DESC','(NA)','manages the scraping processes of all govt key date announcement calendars')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_WEBHARVY_SCRAPE_KEY_DATE_ANNCMNTS_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_WEBHARVY_SCRAPE_KEY_DATE_ANNCMNTS_D','PKG','PKG_SMRY_DESC','(NA)','manages the scraping processes of all govt key date announcement calendars ')

-- LTN_PKG_AU_JOBSEARCH_D
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_ADZUNA','JS_AU_ADZUNA','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_CAREERJET','JS_AU_CAREERJET','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_GUMTREE','JS_AU_GUMTREE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_HAYS','JS_AU_HAYS','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_INDEED','JS_AU_INDEED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JOBSEARCH','JS_AU_JOBSEARCH','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JOBSERVE','JS_AU_JOBSERVE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JORA','JS_AU_JORA','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JORAX2','JS_AU_X2JORA','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_SEEK','JS_AU_SEEK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_ADZUNA','JS_AU_ADZUNA','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_CAREERJET','JS_AU_CAREERJET','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_GUMTREE','JS_AU_GUMTREE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_HAYS','JS_AU_HAYS','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_INDEED','JS_AU_INDEED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JOBSEARCH','JS_AU_JOBSEARCH','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JOBSERVE','JS_AU_JOBSERVE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JORA','JS_AU_JORA','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JORAX2','JS_AU_X2JORA','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_SEEK','JS_AU_SEEK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_AU_BUS4SALE_D
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from businesses for sale sites - australia')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_FILE_NAME_IN_NME_BUSINESSFORSALE','B4S_AU_BUSINESS4SALE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_FILE_NAME_IN_NME_DOMAIN','B4S_AU_DOMAIN','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_FILE_NAME_IN_NME_SEEK','B4S_AU_SEEK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from businesses for sale sites - australia')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_FILE_NAME_IN_NME_BUSINESSFORSALE','B4S_AU_BUSINESS4SALE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_FILE_NAME_IN_NME_DOMAIN','B4S_AU_DOMAIN','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_FILE_NAME_IN_NME_SEEK','B4S_AU_SEEK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_AU_BUS4SALE_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_US_JOBSEARCH_D
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites - united states')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_THELADDERS','JS_US_THELADDERS','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_SIMPLYHIRED','JS_US_SIMPLYHIRED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_INDEED','JS_US_INDEED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_CAREERBUILDER','JS_US_CAREERBUILDER','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites - united states')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_THELADDERS','JS_US_THELADDERS','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_SIMPLYHIRED','JS_US_SIMPLYHIRED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_INDEED','JS_US_INDEED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_CAREERBUILDER','JS_US_CAREERBUILDER','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_US_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_UK_JOBSEARCH_D
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites - united kingdom')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_GOV','JS_UK_GOV','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JOBSITE','JS_UK_JOBSITE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_REED','JS_UK_REED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_TOTALJOBS','JS_UK_TOTALJOBS','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites - united kingdom')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_GOV','JS_UK_GOV','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JOBSITE','JS_UK_JOBSITE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_REED','JS_UK_REED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_TOTALJOBS','JS_UK_TOTALJOBS','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_UK_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_NZ_JOBSEARCH_D
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites - new zealand')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_MYJOBSPACE','JS_NZ_MYJOBSPACE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_SEEK','JS_NZ_SEEK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_TRADEME','JS_NZ_TRADEME','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites - new zealand')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_MYJOBSPACE','JS_NZ_MYJOBSPACE','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_SEEK','JS_NZ_SEEK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_TRADEME','JS_NZ_TRADEME','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_NZ_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

-- LTN_PKG_CA_JOBSEARCH_D
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites - canada')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_CAREERBUILDER','JS_CA_CAREERBUILDER','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_INDEED','JS_CA_INDEED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JOBBANK','JS_CA_JOBBANK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_WORKOPOLIS','JS_CA_WORKOPOLIS','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_SMRY_DESC','(NA)','daily processing of scraped website data from job search sites - canada')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_CAREERBUILDER','JS_CA_CAREERBUILDER','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_INDEED','JS_CA_INDEED','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_JOBBANK','JS_CA_JOBBANK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_NME_WORKOPOLIS','JS_CA_WORKOPOLIS','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CA_JOBSEARCH_D','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

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
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_1','DAT_MS_AUD','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_2','DAT_MS_EUR','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_3','DAT_MS_GBP','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_SMRY_DESC','(NA)','minute data for currency pairs')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_1','DAT_MS_AUD','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_2','DAT_MS_EUR','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_NME_3','DAT_MS_GBP','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_CCY_PAIRS_MI','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

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
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_SMRY_DESC','(NA)','monthly update of key government announcements using scraped website data')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_AU','GOVT_KEY_DATE_ANNOUNCEMENTS_AU','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_CA','GOVT_KEY_DATE_ANNOUNCEMENTS_CA','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_NZ','GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_UK','GOVT_KEY_DATE_ANNOUNCEMENTS_UK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_US','GOVT_KEY_DATE_ANNOUNCEMENTS_US','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('PROD','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_ACTIVE_IND','Y','used to bypass from a variables perspective (rather than turning off in SSIS)')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_SMRY_DESC','(NA)','monthly update of key government announcements using scraped website data')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_AU','GOVT_KEY_DATE_ANNOUNCEMENTS_AU','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_CA','GOVT_KEY_DATE_ANNOUNCEMENTS_CA','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_NZ','GOVT_KEY_DATE_ANNOUNCEMENTS_NZ','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_UK','GOVT_KEY_DATE_ANNOUNCEMENTS_UK','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_NME_GOVT_KEY_DATE_ANNCMNTS_US','GOVT_KEY_DATE_ANNOUNCEMENTS_US','name if incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_FILE_NAME_IN_EXT','csv','file extension of incoming file to be processed')
insert into ltn.dbo.ctl_ssis_vars values ('DEV','LTN_PKG_GOVT_KEY_DATE_ANNCMNTS','PKG','PKG_PRCES_DTE_OFFSET','0','change to control date paramater to query.  eg. set to 1 if running for today() - 1 day')

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


-- ====================================================================================================================================================================================================

SELECT *
       FROM
            ltn.dbo.ctl_ssis_vars
       WHERE 1 = 1
             AND env = 'DEV'
       ORDER BY 1
              , 2
              , 3
              , 4;