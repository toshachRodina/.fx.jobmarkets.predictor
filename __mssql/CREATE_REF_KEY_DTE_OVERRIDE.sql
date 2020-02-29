/*
=======================================================================================================================================================================================================
SUBJECT		 : key dates ref table used to house various key dates from sites that arent predictable
OBJECT TYPE	 : TABLE
OBJECT NAME	 : ltn.dbo.ref_key_dte_override
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161219
SOURCE		 : 
PREPERATION	 : CREATE TABLE
			   INSERT VALUES REQUIRED FOR SSIS RUNNING
REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.ref_key_dte_override;

CREATE TABLE ltn.dbo.ref_key_dte_override
             (
             msmt_dte_id int NOT NULL
           , cntry_cde   varchar(2) NOT NULL
           , announce_dttm datetime NOT NULL
           , tm_zone     varchar(5) NOT NULL
           , key_dte_dtl varchar(255) NOT NULL
             );

CREATE nonclustered INDEX ix_ref_key_dte_override ON ltn.dbo.ref_key_dte_override(msmt_dte_id);

=======================================================================================================================================================================================================
select * from ltn.dbo.ref_key_dte_override
*/

truncate table ltn.dbo.ref_key_dte_override

/*
=======================================================================================================================================================================================================
[2017] CALENDAR YEAR
=======================================================================================================================================================================================================
*/

insert into ltn.dbo.ref_key_dte_override values ('20170124', 'US', '2017-01-24 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170313', 'US', '2017-03-13 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170324', 'US', '2017-03-24 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170421', 'US', '2017-04-21 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170519', 'US', '2017-05-19 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170617', 'US', '2017-06-17 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170721', 'US', '2017-07-21 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170818', 'US', '2017-08-18 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170915', 'US', '2017-09-15 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20171020', 'US', '2017-10-20 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20171117', 'US', '2017-11-17 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20171222', 'US', '2017-12-22 10:00', 'EST', '(US) ANNOUNCEMENT - BLS (BUREAU OF LABOUR STATISTICS) LABOUR FORCE FIGURES RELEASED');

insert into ltn.dbo.ref_key_dte_override values ('20170125', 'NZ', '2017-01-25 00:00', 'NZST', '(NZ) ANNOUNCEMENT - STATSNZ (STATISTICS NEW ZEALAND) HOUSEHOLD LABOUR FORCE SURVEY ESTIMATES RELEASED - QUARTER');
insert into ltn.dbo.ref_key_dte_override values ('20170426', 'NZ', '2017-04-26 00:00', 'NZST', '(NZ) ANNOUNCEMENT - STATSNZ (STATISTICS NEW ZEALAND) HOUSEHOLD LABOUR FORCE SURVEY ESTIMATES RELEASED - QUARTER');
insert into ltn.dbo.ref_key_dte_override values ('20170201', 'NZ', '2017-02-01 00:00', 'NZST', '(NZ) ANNOUNCEMENT - STATSNZ (STATISTICS NEW ZEALAND) LABOUR MARKET STATISTICS RELEASED - QUARTER');
insert into ltn.dbo.ref_key_dte_override values ('20170503', 'NZ', '2017-05-03 00:00', 'NZST', '(NZ) ANNOUNCEMENT - STATSNZ (STATISTICS NEW ZEALAND) LABOUR MARKET STATISTICS RELEASED - QUARTER');


insert into ltn.dbo.ref_key_dte_override values ('20170124', 'CA', '2017-01-06 10:00', 'EST', '(CA) ANNOUNCEMENT - STATCAN (STATISTICS CANADA) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170313', 'CA', '2017-02-10 10:00', 'EST', '(CA) ANNOUNCEMENT - STATCAN (STATISTICS CANADA) LABOUR FORCE FIGURES RELEASED');
insert into ltn.dbo.ref_key_dte_override values ('20170324', 'CA', '2017-03-10 10:00', 'EST', '(CA) ANNOUNCEMENT - STATCAN (STATISTICS CANADA) LABOUR FORCE FIGURES RELEASED');












/*
=======================================================================================================================================================================================================
[2018] CALENDAR YEAR
=======================================================================================================================================================================================================
*/