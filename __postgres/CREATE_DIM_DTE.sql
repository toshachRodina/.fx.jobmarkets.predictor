/*
=======================================================================================================================================================================================================
SUBJECT		 : calendar table - sequentially store calendar dates to assist in query writing and testing
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.dim_dte
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161215
SOURCE		 : [ http://blog.jontav.com/post/9380766884/calendar-tables-are-incredibly-useful-in-sql ]
PREPERATION	 : 
			   
REMARKS		 : 1) also holds calendar dates for key milestones (such as the abs release date of the unemployment figures)
			   2) 
			   3) 
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.dim_dte;

CREATE TABLE ltn.dbo.dim_dte
             (
             msmt_dte_id        int PRIMARY KEY
           , dte_id             date
           , dte_day            tinyint
           , weekday_id         tinyint
           , workday_ind        varchar(1)
           , weekday_nme        varchar(10)
           , weekday_nme_shrt   varchar(3)
           , week_of_month1     tinyint
		 , week_of_month2     tinyint
           , dte_month          tinyint
           , month_nme          varchar(10)
           , month_nme_shrt     varchar(10)
           , quarter_id         tinyint
           , dte_year           smallint
           , day_of_year        smallint
           , week_of_year       tinyint
           , first_day_of_month date
           , last_day_of_month  date
           , start_dts          datetime
           , end_dts            datetime
             );

CREATE UNIQUE INDEX ux_dim_dte ON ltn.dbo.dim_dte(msmt_dte_id, dte_id);

ALTER TABLE ltn.dbo.dim_dte REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_dim_dte @p_env = 'DEV', @p_task_nme = '', @p_pkg_nme = ''

select * from ltn.dbo.dim_dte
=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_dim_dte') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_dim_dte AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_dim_dte -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
BEGIN
    --SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD

    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;
    --SET DATEFIRST 7

/*
=======================================================================================================================================================================================================
MAIN CODE BLOCK
- TABLE TIDY UP (IF NEEDED)
- INSERT NEW DATA
- SWITCH INTO EMPTY PARTITIONS (IF USING TABLE PARTITIONS)
=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
TRY BLOACK - START
=======================================================================================================================================================================================================
*/

BEGIN TRY

/*
=======================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS
=======================================================================================================================================================================================================
*/

declare @start_dt as date = '2015-01-01';		-- Date from which the calendar table will be created [we started data collection in OCT (around the 13th)]
declare @end_dt as date = cast(DATEADD(yy, 1, getdate()) as date);		-- Calendar table will be created up to this date (not including) [set to always provide 1 year from current date]

/*
=======================================================================================================================================================================================================
MAIN DATE TABLE
- inserts all dates from start of jobsearch data capture out to 1 year in advance of current date
=======================================================================================================================================================================================================
*/

    TRUNCATE TABLE ltn.dbo.dim_dte;

    WHILE @start_dt < @end_dt
	   BEGIN
		  INSERT INTO ltn.dbo.dim_dte
			    (msmt_dte_id
			   , dte_id
			   , dte_day
			   , weekday_id
			   , workday_ind
			   , weekday_nme
			   , weekday_nme_shrt
			   , week_of_month1
			   , week_of_month2
			   , dte_month
			   , month_nme
			   , month_nme_shrt
			   , quarter_id
			   , dte_year
			   , day_of_year
			   , week_of_year
			   , first_day_of_month
			   , last_day_of_month
			   , start_dts
			   , end_dts
			    )
		  VALUES
			    ( CONVERT(varchar(10), CAST(@start_dt AS date), 112)
			    , @start_dt
			    , DAY(@start_dt)
			    , DATEPART(weekday, @start_dt)
			    , case when DATEPART(weekday, @start_dt) between 2 and 6 then 'Y' else 'N' end
			    , upper(DATENAME(weekday, @start_dt))
			    , upper(FORMAT(@start_dt,'ddd'))
			    , datediff(week, dateadd(week, datediff(week, 0, dateadd(month, datediff(month, 0, cast(@start_dt as datetime)), 0)), 0),cast(@start_dt as datetime) - 1) + 1 
			    , datepart(day, datediff(day, 0, @start_dt)/7 * 7)/7 + 1
			    , MONTH(@start_dt)
			    , upper(DATENAME(month, @start_dt))
			    , upper(FORMAT(@start_dt,'MMM'))
			    , DATEPART(quarter, @start_dt)
                   , YEAR(@start_dt)
			    , DATEPART(dayofyear, @start_dt)
			    , DATEPART(WEEK, @start_dt)
			    , DATEADD(day, -
							(DAY(@start_dt) - 1
							), @start_dt)
			    , DATEADD(day, -
							(DAY(DATEADD(month, 1, @start_dt))
							), DATEADD(month, 1, @start_dt))
			    , CAST(@start_dt AS    datetime)
			    , DATEADD(second, -1, CAST(DATEADD(day, 1, @start_dt) AS datetime))
			    );
		  SET @start_dt = DATEADD(day, 1, @start_dt);

	   END;


END TRY
/*
=======================================================================================================================================================================================================
TRY BLOACK - END
=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
CATCH BLOACK - START
=======================================================================================================================================================================================================
*/
BEGIN CATCH

    INSERT INTO ltn.dbo.ctl_ssis_err_log
		 (msmt_dte_id
		, env
		, job_nme
		, task_nme
		, task_tp
		, task_start_datetime
		, task_end_datetime
		, task_status
		, task_output
		 )
    SELECT CONVERT(varchar(10), CAST(GETDATE() AS date), 112) AS msmt_dte_id
	    , @p_env
	    , @p_pkg_nme
	    , @p_task_nme
	    , 'SQLSCRIPT'
	    , GETDATE()
	    , GETDATE()
	    , CASE
			WHEN ERROR_MESSAGE() IS NULL
			THEN 'SUCCESS'
			ELSE 'ERROR'
		 END
	    , 'msmt_dte_id variable used : '+CONVERT( varchar(10), CAST(GETDATE() AS date), 112)+' --- error msg : '+ERROR_MESSAGE();
         
END CATCH;

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/

END;