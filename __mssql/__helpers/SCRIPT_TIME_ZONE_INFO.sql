/*
SYS.time_zone_info (Transact-SQL)

Returns information about supported time zones.  All time zones installed on the computer are stored in the following registry hive:
KEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones
*/


select convert(datetime,'20150806 11:30') as EST
      ,'UTC' as TIME_ZONE
      ,convert(datetime,'20150806 11:30') 
			 at time zone 'AUS Eastern Standard Time'
			 at time zone 'UTC' as CALC_TIME
union all
select convert(datetime,'20150806 11:30') as EST
      ,'NZT' as time_zone
      ,convert(datetime,'20150806 11:30') 
			 at time zone 'AUS Eastern Standard Time'
			 at time zone 'New Zealand Standard Time' as CALC_TIME
union all
select convert(datetime,'20150806 11:30') as EST
      ,'EST' as TIME_ZONE
      ,convert(datetime,'20150806 11:30') 
			 at time zone 'AUS Eastern Standard Time'
			 at time zone 'Eastern Standard Time' as CALC_TIME
union all
select convert(datetime,'20150806 11:30') as EST
      ,'GMT' as TIME_ZONE
      ,convert(datetime,'20150806 11:30') 
			 at time zone 'AUS Eastern Standard Time'
			 at time zone 'GMT Standard Time' as CALC_TIME



select '2017-09-14 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-09-14 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2017-08-17 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-08-17 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2017-07-20 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-07-20 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2017-06-15 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-06-15 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2017-05-18 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-05-18 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2017-04-13 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-04-13 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2017-03-16 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-03-16 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2017-02-16 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-02-16 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2017-01-19 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-01-19 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-12-15 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-12-15 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-11-17 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-11-17 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-10-20 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-10-20 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-09-15 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-09-15 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-08-18 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-08-18 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-07-14 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-07-14 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-06-16 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-06-16 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-05-19 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-05-19 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-04-14 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-04-14 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-03-17 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-03-17 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-02-18 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-02-18 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2016-01-14 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-01-14 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2015-12-10 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-12-10 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2015-11-12 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-11-12 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2015-10-15 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-10-15 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2015-09-10 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-09-10 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time union all
select '2015-08-06 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-08-06 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'UTC' as calc_time 



select '2017-09-14 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-09-14 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2017-08-17 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-08-17 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2017-07-20 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-07-20 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2017-06-15 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-06-15 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2017-05-18 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-05-18 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2017-04-13 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-04-13 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2017-03-16 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-03-16 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2017-02-16 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-02-16 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2017-01-19 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2017-01-19 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-12-15 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-12-15 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-11-17 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-11-17 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-10-20 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-10-20 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-09-15 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-09-15 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-08-18 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-08-18 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-07-14 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-07-14 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-06-16 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-06-16 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-05-19 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-05-19 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-04-14 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-04-14 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-03-17 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-03-17 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-02-18 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-02-18 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2016-01-14 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2016-01-14 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2015-12-10 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-12-10 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2015-11-12 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-11-12 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2015-10-15 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-10-15 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2015-09-10 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-09-10 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time union all
select '2015-08-06 11:30:00.000' as est, 'UTC' as time_zone, convert(datetime,'2015-08-06 11:30:00.000') at time zone 'AUS Eastern Standard Time' at time zone 'GMT Standard Time' as calc_time 