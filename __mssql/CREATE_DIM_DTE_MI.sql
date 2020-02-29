/*
=======================================================================================================================================================================================================
SUBJECT		 : time of day - minutes table
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.dim_dte_mi
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170518
SOURCE		 : 
PREPERATION	 : 
			   
REMARKS		 : 1) 
			   2) 
			   3) 
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.dim_dte_mi;

CREATE TABLE LTN.DBO.DIM_DTE_MI
( TIME_OF_DAY_KEY          smallint
  PRIMARY KEY
, HOUR_OF_DAY_24           tinyint --0-23, military/European time 
, HOUR_OF_DAY_12           tinyint --1-12, repeating for AM/PM, for us American types 
, AM_PM                    char(2) --AM/PM 
, MIN_OF_HOUR              tinyint --the minute of the hour, reset at the top of each hour. 0-59 
, MIN_5_OF_HOUR            tinyint --1-4, for each quarter hour 
, MIN_5_HOUR_OF_DAY        int --1-48, incremented at the tope of each half hour for the entire day 
, MIN_10_OF_HOUR           tinyint --1-4, for each quarter hour 
, MIN_10_HOUR_OF_DAY       int --1-48, incremented at the tope of each half hour for the entire day 
, MIN_15_OF_HOUR           tinyint --1-4, for each quarter hour 
, MIN_15_HOUR_OF_DAY       tinyint --1-48, incremented at the tope of each half hour for the entire day 
, MIN_30_OF_HOUR           tinyint --1 or 2, if it is the first or second half of the hour 
, MIN_30_HOUR_OF_DAY       tinyint --1-24, incremented at the top of each half hour for the entire day 
, STRING_REPRESENTATION_24 char(5) --military/European textual representation 
, STRING_REPRESENTATION_12 char(5)       --12 hour clock representation sans AM/PM 
); 


CREATE UNIQUE INDEX ux_dim_dte_mi ON ltn.dbo.dim_dte_mi(TIME_OF_DAY_KEY);

ALTER TABLE ltn.dbo.DIM_DTE_MI REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_dim_dte @p_env = 'DEV', @p_task_nme = '', @p_pkg_nme = ''


select * from ltn.dbo.dim_dte_mi;
=======================================================================================================================================================================================================
*/

USE [ltn];
GO

truncate table ltn.dbo.dim_dte_mi;
--digits gives you a set of 10 numbers 0-9 

WITH DIGITS(I)
     AS (
     SELECT 1 AS I
     UNION ALL
     SELECT 2 AS I
     UNION ALL
     SELECT 3
     UNION ALL
     SELECT 4
     UNION ALL
     SELECT 5
     UNION ALL
     SELECT 6
     UNION ALL
     SELECT 7
     UNION ALL
     SELECT 8
     UNION ALL
     SELECT 9
     UNION ALL
     SELECT 0)
--sequence produces a set of integers from 0 - 9999 
,SEQUENCE(I)
     AS (SELECT
                D1.I
                + 10
                * D2.I
                + 100
                * D3.I
                + ( 
                   1000
                   * D4.i )
           FROM DIGITS AS D1
                CROSS JOIN DIGITS AS D2
                CROSS JOIN DIGITS AS D3
                CROSS JOIN DIGITS AS D4) 
     INSERT INTO LTN.DBO.DIM_DTE_MI ( TIME_OF_DAY_KEY
                                    , HOUR_OF_DAY_24
                                    , HOUR_OF_DAY_12
                                    , AM_PM
                                    , MIN_OF_HOUR
                                    , MIN_5_OF_HOUR
                                    , MIN_5_HOUR_OF_DAY
                                    , MIN_10_OF_HOUR
                                    , MIN_10_HOUR_OF_DAY
                                    , MIN_15_OF_HOUR
                                    , MIN_15_HOUR_OF_DAY
                                    , MIN_30_OF_HOUR
                                    , MIN_30_HOUR_OF_DAY
                                    , STRING_REPRESENTATION_24
                                    , STRING_REPRESENTATION_12
                                    ) 
--calculates the different values for the time table 
     SELECT I AS TIME_OF_DAY_KEY
          , datepart(HH, DATEVAL) AS HOUR_OF_DAY_24
          ,
            datepart(HH, DATEVAL)
            % 12
            + CASE
                   WHEN
                        datepart(HH, DATEVAL)
                        % 12 = 0
                   THEN 12
                   ELSE 0
              END AS HOUR_OF_DAY_12
          , CASE
                 WHEN datepart(HH, DATEVAL) BETWEEN 0 AND 11
                 THEN 'AM'
                 ELSE 'PM'
            END AS AM_PM
          , datepart(MI, DATEVAL) AS MIN_OF_HOUR
-----
          ,
            ( 
             I
             / 5 )
            % 12
            + 1 AS MIN_5_OF_HOUR
          ,
            I
            / 5
            + 1 AS MIN_5_HOUR_OF_DAY  --and for the whole day value, they go from 
-----
          ,
            ( 
             I
             / 10 )
            % 6
            + 1 AS MIN_10_OF_HOUR
          ,
            I
            / 10
            + 1 AS MIN_10_HOUR_OF_DAY  --and for the whole day value, they go from 
-----
          ,
            ( 
             I
             / 15 )
            % 4
            + 1 AS MIN_15_OF_HOUR
          ,
            I
            / 15
            + 1 AS MIN_15_HOUR_OF_DAY
-----
          ,
            ( 
             I
             / 30 )
            % 2
            + 1 AS MIN_30_OF_HOUR --note, I made these next 4 values 1 based, not 0. So the first half hour is 1, the second is 2 
          ,
            I
            / 30
            + 1 AS MIN_30_HOUR_OF_DAY  --and for the whole day value, they go from           
          , right('0'+cast(datepart(HH, DATEVAL) AS varchar(2)), 2)+':'+right('0'+cast(datepart(MI, DATEVAL) AS varchar(2)), 2) AS STRING_REPRESENTATION_24
          , right('0'+cast(
                           datepart(HH, DATEVAL)
                           % 12
                           + CASE
                                  WHEN
                                       datepart(HH, DATEVAL)
                                       % 12 = 0
                                  THEN 12
                                  ELSE 0
                             END AS varchar(2)), 2)+':'+right('0'+cast(datepart(MI, DATEVAL) AS varchar(2)), 2) AS STRING_REPRESENTATION_12
       FROM (
            SELECT dateadd(minute, I, '20000101') AS DATEVAL
                 , I
              FROM SEQUENCE AS SEQUENCE
             WHERE I BETWEEN 0 AND 1439 --number of minutes in a day = 1440  
            ) AS DAILYMINUTES
     ORDER BY 1;