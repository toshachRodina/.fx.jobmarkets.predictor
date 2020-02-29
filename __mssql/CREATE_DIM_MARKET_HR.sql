/*
=======================================================================================================================================================================================================
SUBJECT		 : market trade hours - track market open times (by hour number) accross markets by GMT
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.dim_market_hr
CREATED BY	 : Harold Delaney
CREATED ON	 : 20180120
SOURCE		 : 
PREPERATION	 : 
			   
REMARKS		 : 1) 
			   2) 
			   3)
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE LTN.dbo.DIM_MARKET_HR;

CREATE TABLE LTN.DBO.DIM_MARKET_HR
(START_DTE_ID int
,END_DTE_ID   int
,TMZ          varchar(5)
,HOUR_OF_DAY  int
,MARKET_CDE   varchar(3)
,CNTRY_CDE    varchar(2)
);

insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 1, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 1, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 2, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 2, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 3, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 3, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 4, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 4, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 5, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 5, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 6, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 6, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 7, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 7, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 8, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 8, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 9, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 9, 'TOK', 'JP');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 10, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 11, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 12, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 13, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 13, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 14, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 14, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 15, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 15, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 16, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 16, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 17, 'LON', 'UK');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 17, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 18, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 19, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 20, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 21, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 22, 'NYK', 'US');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 22, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 23, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 24, 'SYD', 'AU');
insert into LTN.dbo.DIM_MARKET_HR values (19000101, 29991231, 'GMT', 24, 'TOK', 'JP');
*/

SELECT *
  FROM LTN.dbo.DIM_MARKET_HR