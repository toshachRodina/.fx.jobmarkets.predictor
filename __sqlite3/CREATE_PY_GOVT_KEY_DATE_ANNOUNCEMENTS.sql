/*
===================================================================================================
TABLE CREATION
===================================================================================================
drop table PY_GOVT_DATA_AU_MEDIA_RELEASE;

CREATE TABLE PY_GOVT_KEY_DATE_ANNOUNCEMENTS (
    ID           INTEGER PRIMARY KEY AUTOINCREMENT,
    MSMT_DTE_ID  INTEGER,
    DATA_TYPE    VARCHAR (30),
    CNTRY_CDE    VARCHAR (2),
    SITE_CDE     VARCHAR (20),
    ANNCE_DTE    VARCHAR (20),
    ANNCE_TM     VARCHAR (20),
    ANNCE_CDE    VARCHAR (20),
    ANNCE_DESC   VARCHAR (1000),
    STARTED_AT   VARCHAR (20),
    FINISHED_AT  VARCHAR (20)    
);

===================================================================================================
*/

select * from PY_GOVT_KEY_DATE_ANNOUNCEMENTS;


