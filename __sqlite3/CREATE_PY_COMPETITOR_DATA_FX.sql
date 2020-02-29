/*
=======================================================================================================================================================================================================
SUBJECT       : Control table housing variables required for automating/running python packages
OBJECT TYPE	 : TABLE
OBJECT NAME	 : PY_COMPETITOR_DATA_FX
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170330
SOURCE	 : 
PREPERATION	 : CREATE TABLE INSERT VALUES REQUIRED FOR SSIS RUNNING
REMARKS	 : 1) 
	   2)
	   3)
 
select * from PY_COMPETITOR_DATA_FX
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE PY_COMPETITOR_DATA_FX;

CREATE TABLE PY_COMPETITOR_DATA_FX (
    ID                  INTEGER        PRIMARY KEY AUTOINCREMENT,
    MSMT_DTE_ID         INTEGER        NOT NULL,
    COMPETITOR_NAME     VARCHAR (100)  NOT NULL,
    COMPETITOR_SHRT_URL VARCHAR (1000) NOT NULL,
    CCY_PAIR            VARCHAR (6)    NOT NULL,
    HOME_CCY            VARCHAR (3)    NOT NULL,
    HOME_CCY_AMT        VARCHAR (20)   NOT NULL,
    RATE                FLOAT          NOT NULL,
    AWAY_CCY            VARCHAR (3)    NOT NULL,
    AWAY_CCY_AMT        VARCHAR (20)   NOT NULL,
    STARTED_AT          VARCHAR (20)   NOT NULL,
    FINISHED_AT          VARCHAR (20)   NOT NULL
);




