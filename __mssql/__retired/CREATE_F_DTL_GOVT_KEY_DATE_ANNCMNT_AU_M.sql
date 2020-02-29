/*
=======================================================================================================================================================================================================
SUBJECT		 : australian govt announcement calendar - list of when key announcements are to occur
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_govt_key_date_anncmnt_au_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161222
SOURCE		 : abs [ http://www.abs.gov.au/ausstats/abs@.nsf/webpages/ABS+Release+Calendar ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed monthly to get upcoming months announcement dates
			   2) 
			   3)
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.stg_govt_key_date_anncmnt_au_raw;

CREATE TABLE ltn.dbo.stg_govt_key_date_anncmnt_au_raw
             (
              msmt_dte_id nvarchar ( 8 ) not null
		   ,key_date varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_au_m;

CREATE TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_au_m
             (
             msmt_dte_id       int NOT NULL
           , cntry_cde         varchar(2) NOT NULL
           , anncmnt_cde       varchar(30) NOT NULL
           , anncmnt_desc      varchar(2000) NOT NULL
           , last_updtd_dte_id int NOT NULL
             );

CREATE NONCLUSTERED INDEX ux_f_dtl_govt_key_date_anncmnt_au_m ON ltn.dbo.f_dtl_govt_key_date_anncmnt_au_m(msmt_dte_id, anncmnt_cde);

ALTER TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_au_m REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_govt_key_date_anncmnt_au_m @p_env = 'DEV', @p_task_nme = '', @p_pkg_nme = ''

select * from ltn.dbo.f_dtl_govt_key_date_anncmnt_au_m order by 1
=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_govt_key_date_anncmnt_au_m') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_govt_key_date_anncmnt_au_m AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE CREATE_F_DTL_GOVT_KEY_DATE_ANNCMNT_AU_M -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
     BEGIN
         SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD

         SET ANSI_NULLS ON;
         SET QUOTED_IDENTIFIER ON;

/*=====================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS

=====================================================================================================================================================================================================*/

         -- TABLES ----------------------------------------------------------------
         DECLARE
                @l_tbl_nme AS nvarchar(50);
         DECLARE
                @l_prces_dte_id AS nvarchar(8);

         SET @l_tbl_nme = 'f_dtl_govt_key_date_anncmnt_au_m';
         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_msmt_dte_id AS nvarchar(8);

         SET @l_msmt_dte_id =
             (
                 SELECT MAX(msmt_dte_id)
                        FROM
                             ltn.dbo.stg_govt_key_date_anncmnt_au_raw
             );

/*=====================================================================================================================================================================================================
MAIN CODE BLOCK
- TABLE TIDY UP (IF NEEDED)
- INSERT NEW DATA
- SWITCH INTO EMPTY PARTITIONS (IF USING TABLE PARTITIONS

=====================================================================================================================================================================================================*/

/*=====================================================================================================================================================================================================
TRY BLOACK - START

=====================================================================================================================================================================================================*/

    BEGIN TRY

/*=================================================================================================
STEP 1
** tidy up raw output
** remove unwanted rows and data
=================================================================================================*/

	   CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_au_s1
				 (
				 msmt_dte_id      int NOT NULL
			    , key_date_anncmnt varchar(max) NOT NULL
				 );

	   INSERT INTO #tmp_dtl_govt_key_date_anncmnt_au_s1
			(msmt_dte_id
		    , key_date_anncmnt
			)
	   SELECT stg.msmt_dte_id
		   , LTRIM(RTRIM( SUBSTRING(upper(stg.key_date), CHARINDEX('ADVERTISED ON THE ABS WEBSITE.', upper( stg.key_date))+LEN('advertised on the ABS website.'), LEN(stg.key_date)) )) AS key_date
			FROM
				ltn.dbo.stg_govt_key_date_anncmnt_au_raw AS stg;

/*=================================================================================================
STEP 2 
** replace any CF and LF characters with <BR> to find the month seperators

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_au_s2
					(
					msmt_dte_id      int NOT NULL
				   , key_date_anncmnt varchar(max) NOT NULL
					);

		  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_au_s2
			    (msmt_dte_id
			   , key_date_anncmnt
			    )
		  SELECT dat.msmt_dte_id
			  , REPLACE(dat.key_date_anncmnt, '~ ~ ~ ~', '<BR>') AS key_date_anncmnt
			    FROM
				    (
					   SELECT stg.msmt_dte_id
						   , STUFF(REPLACE(REPLACE(stg.key_date_anncmnt, CHAR(13), '~'), CHAR(10), '~'), 1, CHARINDEX('~', REPLACE(REPLACE(stg.key_date_anncmnt, CHAR(13), '~'), CHAR(10), '~')+'~'), '') AS key_date_anncmnt
							FROM
								#tmp_dtl_govt_key_date_anncmnt_au_s1 AS stg
				    ) AS dat;

/*=================================================================================================
STEP 3
** recursively splits the announcements by month into seperate rows. 

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_au_s3
					(
					msmt_dte_id      int NOT NULL
				   , key_date_anncmnt varchar(max) NOT NULL
					);

		  WITH row_dat(msmt_dte_id
				   , list_item
				   , key_date_anncmnt)
			  AS (
			  SELECT stg.msmt_dte_id
				  , LEFT(REPLACE(stg.key_date_anncmnt, '<BR>', '/'), CHARINDEX('/', REPLACE(stg.key_date_anncmnt, '<BR>', '/')+'~')-1) AS list_item
				  , STUFF(REPLACE(stg.key_date_anncmnt, '<BR>', '/'), 1, CHARINDEX('/', REPLACE(stg.key_date_anncmnt, '<BR>', '/')+'~'), '') AS key_date_anncmnt
				    FROM
					    #tmp_dtl_govt_key_date_anncmnt_au_s2 AS stg
			  UNION ALL
			  SELECT dat.msmt_dte_id
				  , LEFT(REPLACE(dat.key_date_anncmnt, '<BR>', '/'), CHARINDEX('/', REPLACE(dat.key_date_anncmnt, '<BR>', '/')+'~')-1) AS list_item
				  , STUFF(REPLACE(dat.key_date_anncmnt, '<BR>', '/'), 1, CHARINDEX('/', REPLACE(dat.key_date_anncmnt, '<BR>', '/')+'~'), '') AS key_date_anncmnt
				    FROM
					    row_dat AS dat
				    WHERE
						1 = 1
						AND REPLACE(dat.key_date_anncmnt, '<BR>', '/') > '')
			  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_au_s3
				    (msmt_dte_id
				   , key_date_anncmnt
				    )
			  SELECT dat.msmt_dte_id
				  , LTRIM(RTRIM(dat.list_item)) AS key_date_anncmnt
				    FROM
					    row_dat AS dat
				    WHERE
						1 = 1
						AND LTRIM(RTRIM(dat.list_item)) != ''
				    OPTION(MAXRECURSION 0);
				 -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option	


/*=================================================================================================
STEP 4
** replace any '~ ~' characters with / to find the date seperator.

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_au_s4
					(
					msmt_dte_id      int NOT NULL
				   , dte_month        varchar(25) NOT NULL
				   , key_date_anncmnt varchar(max) NOT NULL
					);

		  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_au_s4
			    (msmt_dte_id
			   , dte_month
			   , key_date_anncmnt
			    )
		  SELECT stg.msmt_dte_id
			  , ltrim(rtrim(LEFT(REPLACE(stg.key_date_anncmnt, '~ ~', '/'), CHARINDEX('/', REPLACE(stg.key_date_anncmnt, '~ ~', '/')+'~')-1))) AS dte_month
			  , STUFF(REPLACE(stg.key_date_anncmnt, '~ ~', '/'), 1, CHARINDEX('/', REPLACE(stg.key_date_anncmnt, '~ ~', '/')+'~'), '') AS key_date_anncmnt
			    FROM
				    #tmp_dtl_govt_key_date_anncmnt_au_s3 AS stg;

/*=================================================================================================
STEP 5
** recursively splits the announcements by dates into seperate rows. 

=================================================================================================*/
		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_au_s5
					(
					msmt_dte_id      int NOT NULL
				   , dte_month        varchar(25) NOT NULL
				   , key_date_anncmnt varchar(max) NOT NULL
					);

		  WITH row_dat(msmt_dte_id
				   , dte_month
				   , list_item
				   , key_date_anncmnt)
			  AS (
			  SELECT stg.msmt_dte_id
			       , stg.dte_month
				  , LEFT(REPLACE(stg.key_date_anncmnt, '/', '/'), CHARINDEX('/', REPLACE(stg.key_date_anncmnt, '/', '/')+'/')-1) AS list_item
				  , STUFF(REPLACE(stg.key_date_anncmnt, '/', '/'), 1, CHARINDEX('/', REPLACE(stg.key_date_anncmnt, '/', '/')+'/'), '') AS key_date_anncmnt
				   FROM
					    #tmp_dtl_govt_key_date_anncmnt_au_s4 AS stg
			  UNION ALL
			  SELECT dat.msmt_dte_id
			       , dat.dte_month
				  , LEFT(REPLACE(dat.key_date_anncmnt, '/', '/'), CHARINDEX('/', REPLACE(dat.key_date_anncmnt, '/', '/')+'/')-1) AS list_item
				  , STUFF(REPLACE(dat.key_date_anncmnt, '/', '/'), 1, CHARINDEX('/', REPLACE(dat.key_date_anncmnt, '/', '/')+'/'), '') AS key_date_anncmnt
				    FROM
					    row_dat AS dat
				    WHERE
						1 = 1
						AND REPLACE(dat.key_date_anncmnt, '/', '/') > '')
			  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_au_s5
				    (msmt_dte_id
                       , dte_month
				   , key_date_anncmnt
				    )
			  SELECT dat.msmt_dte_id
			       , dat.dte_month
				  , LTRIM(RTRIM(dat.list_item)) AS key_date_anncmnt
				    FROM
					    row_dat AS dat
				    WHERE
						1 = 1
						AND LTRIM(RTRIM(dat.list_item)) != ''
				    OPTION(MAXRECURSION 0);
				 -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option


/*=================================================================================================
STEP 6
** general data tidy up in preperation for final recursive pass

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_au_s6
					(
					msmt_dte_id      int NOT NULL
				   , dte_year         varchar(4) NOT NULL
				   , month_nme        varchar(25) NOT NULL
				   , start_dte_id     int NOT NULL
				   , end_dte_id       int NOT NULL
				   , day_dte          int NOT NULL
				   , key_date_anncmnt varchar(max) NOT NULL
					);

		  WITH dat(msmt_dte_id
			    , dte_year
			    , month_nme
			    , dte_month
			    , start_dte_id
			    , end_dte_id
			    , key_date_anncmnt)
			  AS (SELECT s5.msmt_dte_id
					 , dt.dte_year
					 , dt.month_nme
					 , s5.dte_month
					 , CONVERT( varchar(10), dt.first_day_of_month, 112) AS start_dte_id
					 , CONVERT( varchar(10), dt.last_day_of_month, 112) AS end_dte_id
					 , LTRIM(RTRIM(s5.key_date_anncmnt)) AS key_date_anncmnt
					   FROM
						   #tmp_dtl_govt_key_date_anncmnt_au_s5 AS s5
						   LEFT OUTER JOIN
						   (
							  SELECT DISTINCT
								    dt.month_nme
								  , dt.dte_year
								  , dt.first_day_of_month
								  , dt.last_day_of_month
								  , dt.month_nme+' '+CAST(dt.dte_year AS char) AS dte_lnk
								    FROM
									    ltn.dbo.dim_dte AS dt
						   ) AS dt
						   ON s5.dte_month = dt.dte_lnk)
			  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_au_s6
				    (msmt_dte_id
				   , dte_year
				   , month_nme
				   , start_dte_id
				   , end_dte_id
				   , day_dte
				   , key_date_anncmnt
				    )
			  SELECT dat2.msmt_dte_id
				  , dat2.dte_year
				  , dat2.month_nme
				  , dat2.start_dte_id
				  , dat2.end_dte_id
				    ------
				  , CAST(CASE
						   WHEN dat2.day_dte = ''
						   THEN lag( dat2.day_dte ) OVER(PARTITION BY dat2.end_dte_id ORDER BY dat2.rnum)
						   ELSE dat2.day_dte
					    END AS int) AS day_dte
				  , REPLACE(dat2.key_date_anncmnt,
							  CASE
								 WHEN dat2.day_dte = ''
								 THEN lag( dat2.day_dte ) OVER(PARTITION BY dat2.end_dte_id ORDER BY dat2.rnum)
								 ELSE dat2.day_dte
							  END+' '+dat2.month_nme, '') AS key_date_anncmnt
				    FROM
					    (
						   SELECT dat.msmt_dte_id
							   , dat.dte_year
							   , dat.month_nme
							   , dat.start_dte_id
							   , dat.end_dte_id
								------
								--CAST(
							   , CASE
								    WHEN CHARINDEX(dat.month_nme, dat.key_date_anncmnt) = 0
								    THEN ''
								    ELSE LTRIM(RTRIM(REPLACE(LEFT(dat.key_date_anncmnt, CHARINDEX(dat.month_nme, dat.key_date_anncmnt)-1), '~', '')))
								END
								--AS int)
								AS day_dte
							   , dat.key_date_anncmnt
							   , ROW_NUMBER() OVER(PARTITION BY dat.dte_year
													    , dat.month_nme ORDER BY dat.end_dte_id) AS rnum
								FROM
									dat
								WHERE 1 = 1
					    ) AS dat2
				    WHERE 1 = 1
				    ORDER BY dat2.end_dte_id
						 , CAST(CASE
								  WHEN dat2.day_dte = ''
								  THEN lag( dat2.day_dte ) OVER(PARTITION BY dat2.end_dte_id ORDER BY dat2.rnum)
								  ELSE dat2.day_dte
							   END AS int);

/*=================================================================================================
STEP 7
** final recursive pass - split multiple announcements on a given day into their own discrete row

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_au_s7
					(
					msmt_dte_id      int NOT NULL
				   , dte_year         varchar(4) NOT NULL
				   , month_nme        varchar(25) NOT NULL
				   , start_dte_id     int NOT NULL
				   , end_dte_id       int NOT NULL
				   , day_dte          int NOT NULL
				   , key_date_anncmnt varchar(max) NOT NULL
					);

				 -- recursively splits the job_category field into seperate rows. 
				 WITH row_dat(msmt_dte_id
					      , dte_year
						 , month_nme
						 , start_dte_id
						 , end_dte_id
						 , day_dte
						 , list_item
						 , key_date_anncmnt)
					 AS (
					 SELECT stg.msmt_dte_id
					      , stg.dte_year
						 , stg.month_nme
						 , stg.start_dte_id
						 , stg.end_dte_id
						 , stg.day_dte
						 , LEFT(REPLACE(stg.key_date_anncmnt, '~', '~'), CHARINDEX('~', REPLACE(stg.key_date_anncmnt, '~', '~')+'~')-1) AS list_item
						 , STUFF(REPLACE(stg.key_date_anncmnt, '~', '~'), 1, CHARINDEX('~', REPLACE(stg.key_date_anncmnt, '~', '~')+'~'), '') AS key_date_anncmnt
					 	   FROM
							   #tmp_dtl_govt_key_date_anncmnt_au_s6 AS stg
					 UNION ALL
					 SELECT dat.msmt_dte_id
					      , dat.dte_year
						 , dat.month_nme
						 , dat.start_dte_id
						 , dat.end_dte_id
						 , dat.day_dte
						 , LEFT(REPLACE(dat.key_date_anncmnt, '~', '~'), CHARINDEX('~', REPLACE(dat.key_date_anncmnt, '~', '~')+'~')-1) AS list_item
						 , STUFF(REPLACE(dat.key_date_anncmnt, '~', '~'), 1, CHARINDEX('~', REPLACE(dat.key_date_anncmnt, '~', '~')+'~'), '') AS key_date_anncmnt
						   FROM
							   row_dat AS dat
						   WHERE 1 = 1
							    AND REPLACE(dat.key_date_anncmnt, '~', '~') > ''
							 )
					 INSERT INTO #tmp_dtl_govt_key_date_anncmnt_au_s7
						   (msmt_dte_id
					      , dte_year
						 , month_nme
						 , start_dte_id
						 , end_dte_id
						 , day_dte
						  , key_date_anncmnt
						   )
					 SELECT dat.msmt_dte_id
					      , dat.dte_year
						 , dat.month_nme
						 , dat.start_dte_id
						 , dat.end_dte_id
						 , dat.day_dte
						 , LTRIM(RTRIM(dat.list_item)) AS key_date_anncmnt
						   FROM
							   row_dat AS dat
						   WHERE 1 = 1
							    AND LTRIM(RTRIM(dat.list_item)) != ''
					--	   OPTION(MAXRECURSION 0);
				 -- normally recursion is limited to 100. If you know you have very long strings, uncomment the option	


/*=================================================================================================
STEP 8
** remove stored dates from f_dtl table which will be re-inserted in new batch
** insert cleansed data into fact table

=================================================================================================*/
     	  DECLARE
			    @start_dte_id AS int;

		  DECLARE
			    @end_dte_id AS int;

		  SELECT @start_dte_id = MIN(dt.msmt_dte_id)
			  , @end_dte_id = MAX(dt.msmt_dte_id)
			    FROM
				    #tmp_dtl_govt_key_date_anncmnt_au_s7 AS stg
				    LEFT OUTER JOIN
				    ltn.dbo.dim_dte AS dt
				    ON
					  1 = 1
					  AND stg.dte_year = dt.dte_year
					  AND stg.month_nme = dt.month_nme
					  AND stg.day_dte = dt.dte_day;


-- REMOVE DATES TO BE RE-NSERTED IN BATCH
		  DELETE FROM ltn.dbo.f_dtl_govt_key_date_anncmnt_au_m
		  WHERE
			   1 = 1
			   AND msmt_dte_id >= @start_dte_id;

-- INSERT NEW DATES IDENTIFIED IN BATCH
		  INSERT INTO ltn.dbo.f_dtl_govt_key_date_anncmnt_au_m
			    (msmt_dte_id
			   , cntry_cde
			   , anncmnt_cde
			   , anncmnt_desc
			   , last_updtd_dte_id
			    ) 
		  SELECT dt.msmt_dte_id
			  , 'AU' AS cntry_cde
			  , CASE
				   WHEN LEFT(stg.key_date_anncmnt, PATINDEX('%[A-Z]%', stg.key_date_anncmnt)-1) = ''
				   THEN 'NOVAL'
				   ELSE isnull(LEFT(stg.key_date_anncmnt, PATINDEX('%[A-Z]%', stg.key_date_anncmnt)-1),'NOVAL')
			    END AS anncmnt_cde
			  , ISNULL(REPLACE(SUBSTRING(stg.key_date_anncmnt, PATINDEX('%[A-Z]%', stg.key_date_anncmnt), LEN(stg.key_date_anncmnt)),'.',''), 'NO SCHEDULED RELEASES TODAY') AS anncmnt_desc
			  , @l_msmt_dte_id AS last_updtd_dte_id
			    FROM
				    ltn.dbo.dim_dte AS dt
				    LEFT OUTER JOIN
				    #tmp_dtl_govt_key_date_anncmnt_au_s7 AS stg
				    ON
					  1 = 1
					  AND dt.dte_year = stg.dte_year
					  AND dt.month_nme = stg.month_nme
					  AND dt.dte_day = stg.day_dte
			    WHERE
					1 = 1
					AND dt.msmt_dte_id BETWEEN @start_dte_id AND @end_dte_id
			    ORDER BY 1;
            
	    END TRY

/*=====================================================================================================================================================================================================
TRY BLOACK - END

=====================================================================================================================================================================================================*/

/*=====================================================================================================================================================================================================
CATCH BLOACK - START

=====================================================================================================================================================================================================*/

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
             SELECT CONVERT( varchar(10), CAST(GETDATE() AS date), 112) AS msmt_dte_id
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

/*=====================================================================================================================================================================================================
CATCH BLOACK - END

=====================================================================================================================================================================================================*/

     END;

