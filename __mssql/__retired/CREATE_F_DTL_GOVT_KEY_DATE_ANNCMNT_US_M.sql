/*
=======================================================================================================================================================================================================
SUBJECT		 : united states govt announcement calendar - list of when key announcements are to occur
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_govt_key_date_anncmnt_us_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170106
SOURCE		 : bureau of labor statistics [ https://www.bls.gov/schedule/2017/home.htm ]  
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed monthly to get upcoming months announcement dates
			   2) 
			   3)
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.stg_govt_key_date_anncmnt_us_raw;

CREATE TABLE ltn.dbo.stg_govt_key_date_anncmnt_us_raw
             (
              msmt_dte_id nvarchar ( 8 ) not null
		   ,key_date varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_us_m;

CREATE TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_us_m
             (
             msmt_dte_id       int NOT NULL
           , cntry_cde         varchar(2) NOT NULL
           , anncmnt_cde       varchar(30) NOT NULL
           , anncmnt_desc      varchar(2000) NOT NULL
           , last_updtd_dte_id int NOT NULL
             );

CREATE NONCLUSTERED INDEX ux_f_dtl_govt_key_date_anncmnt_us_m ON ltn.dbo.f_dtl_govt_key_date_anncmnt_us_m(msmt_dte_id, anncmnt_cde);

ALTER TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_us_m REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_govt_key_date_anncmnt_us_m @p_env = 'DEV', @p_task_nme = '', @p_pkg_nme = ''

select * from ltn.dbo.f_dtl_govt_key_date_anncmnt_us_m  where anncmnt_cde = '0001' order by 1

select * from [dbo].[ctl_ssis_err_log] order by task_end_datetime desc
=======================================================================================================================================================================================================
*/
USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_govt_key_date_anncmnt_us_m') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_govt_key_date_anncmnt_us_m AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_govt_key_date_anncmnt_us_m -- Alter the SP Always
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

         SET @l_tbl_nme = 'f_dtl_govt_key_date_anncmnt_us_m';
         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_msmt_dte_id AS nvarchar(8);

         SET @l_msmt_dte_id =
             (
                 SELECT MAX(msmt_dte_id)
                        FROM
                             ltn.dbo.stg_govt_key_date_anncmnt_us_raw
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
** replace any CF and LF characters with <BR> to find the month seperators
=================================================================================================*/

/*=================================================================================================
STEP 1
** tidy up raw output
** remove unwanted rows and data 
** replace any CF and LF characters with <BR> to find the month seperators
=================================================================================================*/

	   CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_us_s1
											   (msmt_dte_id      int NOT NULL
											  , key_date_anncmnt varchar(max) NOT NULL);

	   INSERT INTO #tmp_dtl_govt_key_date_anncmnt_us_s1
											 ( msmt_dte_id
											 , key_date_anncmnt )
	   SELECT stg.msmt_dte_id
		   , LTRIM(RTRIM(REPLACE(REPLACE(UPPER(stg.key_date),CHAR(13), '~'), CHAR(10), '~'))) AS key_date_anncmnt
		FROM
			ltn.dbo.stg_govt_key_date_anncmnt_us_raw AS stg;

/*=================================================================================================
STEP 2
** recursively splits the announcements by month into seperate rows. 

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_us_s2
					(
					msmt_dte_id      int NOT NULL
				   , key_date_anncmnt varchar(max) NOT NULL
					);

		  WITH row_dat(msmt_dte_id
				   , list_item
				   , key_date_anncmnt)
			  AS (
			  SELECT stg.msmt_dte_id
				  , LEFT(REPLACE(stg.key_date_anncmnt, '~ ~ ~ ', '^'), CHARINDEX('^', REPLACE(stg.key_date_anncmnt, '~ ~ ~ ', '^')+'^')-1) AS list_item
				  , STUFF(REPLACE(stg.key_date_anncmnt, '~ ~ ~ ', '^'), 1, CHARINDEX('^', REPLACE(stg.key_date_anncmnt, '~ ~ ~ ', '^')+'^'), '') AS key_date_anncmnt
				    FROM
					    #tmp_dtl_govt_key_date_anncmnt_us_s1 AS stg
			  UNION ALL
			  SELECT dat.msmt_dte_id
				  , LEFT(REPLACE(dat.key_date_anncmnt, '~ ~ ~ ', '^'), CHARINDEX('^', REPLACE(dat.key_date_anncmnt, '~ ~ ~ ', '^')+'^')-1) AS list_item
				  , STUFF(REPLACE(dat.key_date_anncmnt, '~ ~ ~ ', '^'), 1, CHARINDEX('^', REPLACE(dat.key_date_anncmnt, '~ ~ ~ ', '^')+'^'), '') AS key_date_anncmnt
				    FROM
					    row_dat AS dat
				    WHERE
						1 = 1
						AND REPLACE(dat.key_date_anncmnt, '~ ~ ~ ', '^') > '')
			  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_us_s2
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
STEP 3
** tidy up the output from the initial recursive pass
** split out the dates and generate a msmt_dte_id
** identify announcements that arent "real" announcements - eg. public holidays
    -- achieved by searching for a time pattern - these are actual announcements

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_us_s3
												  (msmt_dte_id       int NOT NULL
												 , key_dte           date NOT NULL
												 , key_date          varchar(100) NOT NULL
												 , time_ind          varchar(1) NOT NULL
												 , key_date_anncmnt  varchar(max) NOT NULL
												 , last_updtd_dte_id int NOT NULL);

		  WITH dys(dy_nme)
			  AS (
			  SELECT 'SUNDAY'
			  UNION
			  SELECT 'MONDAY'
			  UNION
			  SELECT 'TUESDAY'
			  UNION
			  SELECT 'WEDNESDAY'
			  UNION
			  SELECT 'THURSDAY'
			  UNION
			  SELECT 'FRIDAY'
			  UNION
			  SELECT 'SATURDAY')
			  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_us_s3
													( msmt_dte_id
													, key_dte
													, key_date
													, time_ind
													, key_date_anncmnt
													, last_updtd_dte_id )
			  SELECT CONVERT( varchar(10), CAST(CAST(dat3.dy_dt_part AS varchar)+' '+dat3.mth_dt_part+' '+dat3.yr_dt_part AS date), 112) AS msmt_dte_id
				  , CAST(CAST(dat3.dy_dt_part AS    varchar)+' '+dat3.mth_dt_part+' '+dat3.yr_dt_part AS date) AS key_dte
				  , dat3.key_date
				  , CASE
					    WHEN PATINDEX('%[0-9][0-9][:][0-9][0-9]%', REPLACE(dat3.key_date_anncmnt, dat3.key_date, ''))>0
					    THEN 'Y'
					    ELSE 'N'
				    END AS time_ind
				  , REPLACE(dat3.key_date_anncmnt, dat3.key_date, '') AS key_date_anncmnt
				  , dat3.last_updtd_dte_id
			    FROM
				    (
					   SELECT LTRIM(RTRIM(LEFT(dat2.key_date, CHARINDEX(',', dat2.key_date)-1))) AS dy__nme_dt_part
						   , LTRIM(RTRIM(REVERSE(LEFT(REVERSE(dat2.key_date), CHARINDEX(',', REVERSE(dat2.key_date))-1)))) AS yr_dt_part
						   , dbo.fn_getalpha ( LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(dat2.key_date, LTRIM(RTRIM(LEFT(dat2.key_date, CHARINDEX(',', dat2.key_date)-1))), ''), LTRIM(RTRIM(REVERSE(LEFT(REVERSE(dat2.key_date), CHARINDEX(',', REVERSE(dat2.key_date))-1)))), ''), ',', ''))) ) AS mth_dt_part
						   , CAST(dbo.fn_getnumeric ( LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(dat2.key_date, LTRIM(RTRIM(LEFT(dat2.key_date, CHARINDEX(',', dat2.key_date)-1))), ''), LTRIM(RTRIM(REVERSE(LEFT(REVERSE(dat2.key_date), CHARINDEX(',', REVERSE(dat2.key_date))-1)))), ''), ',', ''))) ) AS int) AS dy_dt_part
						   , dat2.key_date
						   , dat2.key_date_anncmnt
						   , dat2.last_updtd_dte_id
						FROM
							(
							    SELECT LEFT(dat1.key_date_anncmnt, CHARINDEX('~', dat1.key_date_anncmnt)-1) AS key_date
								    , dat1.key_date_anncmnt
								    , dat1.last_updtd_dte_id
								 FROM
									 (
										SELECT CASE
												  WHEN LTRIM(RTRIM(LEFT(stg.key_date_anncmnt, 2))) ='~'
												  THEN LTRIM(RTRIM(SUBSTRING(stg.key_date_anncmnt, CHARINDEX('~', stg.key_date_anncmnt)+1, LEN(stg.key_date_anncmnt))))
												  ELSE LTRIM(RTRIM(stg.key_date_anncmnt))
											  END AS key_date_anncmnt
											, stg.msmt_dte_id AS last_updtd_dte_id
										  FROM
											  #tmp_dtl_govt_key_date_anncmnt_us_s2 AS stg
											  INNER JOIN
											  dys
											  ON 1=1
												AND stg.key_date_anncmnt LIKE '%'+dys.dy_nme+'%'
									 ) AS dat1
								WHERE 1=1
							) AS dat2
					    WHERE 1=1
				    ) AS dat3
			   WHERE 1=1;


/*=================================================================================================
STEP 4
** tidy up the output from the previous pass
** remove any "not" real announcements
** generate a unique code based on the announcement description (to fall in line with au format
** link to dim_dte to get the msmt_dte_id for each key date

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_us_s4
					(
					msmt_dte_id       int NOT NULL
				   , anncmnt_cde       varchar (30) NOT NULL
				   , key_date_anncmnt  varchar(2000) NOT NULL
				   , last_updtd_dte_id int NOT NULL
					);

		  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_us_s4
			    (msmt_dte_id
			   , anncmnt_cde
			   , key_date_anncmnt
			   , last_updtd_dte_id
			    )
		  SELECT dat3.msmt_dte_id
			  , format(cast(dat3.anncmnt_cde as int) + 1, '0000') AS anncmnt_cde
			  , dat3.key_date_anncmnt
			  , dat3.last_updtd_dte_id
		    FROM
			    (
				SELECT dat2.msmt_dte_id
					, ABS(CAST(ISNULL(CAST(ASCII(LEFT(dat2.cap_anncmnt_cde, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 2, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 3, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 4, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 5, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 6, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 7, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 8, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 9, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 10, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 11, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 12, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 13, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 14, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 15, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 16, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 17, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 18, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 19, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(dat2.cap_anncmnt_cde, 20, 1)) AS varchar), '0') AS decimal(10, 0))
					- ( CAST(ISNULL(CAST(ASCII(RIGHT(dat2.cap_anncmnt_cde, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 2, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 3, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 4, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 5, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 6, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 7, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 8, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 9, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 10, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 11, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 12, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 13, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 14, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 15, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 16, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 17, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 18, 1)) AS varchar), '0') AS decimal(10, 0))
					-CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 19, 1)) AS varchar), '0') AS decimal(10, 0))
					+CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 20, 1)) AS varchar), '0') AS decimal(10, 0))
					  ) )
					  *dat2.len_key_date_anncmnt
					  *CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat2.cap_anncmnt_cde), 5, 1)) AS varchar), 5) AS decimal(10, 0)) AS anncmnt_cde
					, dat2.cap_anncmnt_cde
					, dat2.key_date_anncmnt
					, dat2.last_updtd_dte_id
				  FROM
					  (
						 SELECT dat1.msmt_dte_id
							 , dat1.key_date_anncmnt
							 , dat1.last_updtd_dte_id
							 , dbo.fn_getlastletters ( REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(REVERSE(SUBSTRING(REVERSE(dat1.key_date_anncmnt), CHARINDEX('ROF', REVERSE(dat1.key_date_anncmnt))+3, LEN(dat1.key_date_anncmnt))))), '.', ''), '(', ''), ')', ''), 2 ) +dbo.fn_getfirstletters ( REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(REVERSE(SUBSTRING(REVERSE(dat1.key_date_anncmnt), CHARINDEX('ROF', REVERSE(dat1.key_date_anncmnt))+3, LEN(dat1.key_date_anncmnt))))), '.', ''), '(', ''), ')', ''), 2 ) AS cap_anncmnt_cde
							 , LEN(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(REVERSE(SUBSTRING(REVERSE(dat1.key_date_anncmnt), CHARINDEX('ROF', REVERSE(dat1.key_date_anncmnt))+3, LEN(dat1.key_date_anncmnt))))), '.', ''), '(', ''), ')', '')) AS len_key_date_anncmnt
						   FROM
							   (
								  SELECT stg.msmt_dte_id
									  , REVERSE(LEFT(REVERSE(stg.key_date_anncmnt), CHARINDEX('~', REVERSE(stg.key_date_anncmnt))-1))+' [ '+LEFT(LTRIM(RTRIM(REPLACE(stg.key_date_anncmnt, '~ ~', ''))), CHARINDEX('M', LTRIM(RTRIM(REPLACE(stg.key_date_anncmnt, '~ ~', '')))))+' ] ' AS key_date_anncmnt
									  , stg.last_updtd_dte_id
								    FROM
									    #tmp_dtl_govt_key_date_anncmnt_us_s3 AS stg
								   WHERE 1=1
									    AND stg.time_ind='Y'
							   ) AS dat1
						  WHERE 1=1
					  ) AS dat2
				 WHERE 1=1) AS dat3
				 ORDER BY 1;

/*=================================================================================================
STEP 4
** remove stored dates from f_dtl table which will be re-inserted in new batch
** insert cleansed data into fact table

=================================================================================================*/

    		 DECLARE
			    @start_dte_id AS int;

		  DECLARE
			    @end_dte_id AS int;

		  SELECT @start_dte_id = MIN(stg.msmt_dte_id)
			  , @end_dte_id = MAX(stg.msmt_dte_id)
			    FROM
				    #tmp_dtl_govt_key_date_anncmnt_us_s4 AS stg
				   ;

-- REMOVE DATES TO BE RE-NSERTED IN BATCH
		  DELETE FROM ltn.dbo.f_dtl_govt_key_date_anncmnt_us_m
		  WHERE
			   1 = 1
			   AND msmt_dte_id >= @start_dte_id;

-- INSERT NEW DATES IDENTIFIED IN BATCH
		 INSERT INTO ltn.dbo.f_dtl_govt_key_date_anncmnt_us_m
			    (msmt_dte_id
			   , cntry_cde
			   , anncmnt_cde
			   , anncmnt_desc
			   , last_updtd_dte_id
			    ) 
		  SELECT dt.msmt_dte_id
			  , 'US' AS cntry_cde
			  , isnull(cast(ltrim(rtrim(stg.anncmnt_cde)) as varchar),'NOVAL') as anncmnt_cde
			  , isnull(ltrim(rtrim(stg.key_date_anncmnt)),'NO SCHEDULED RELEASES TODAY') as anncmnt_desc
			  , @l_msmt_dte_id AS last_updtd_dte_id
			    FROM
				    ltn.dbo.dim_dte AS dt
				    LEFT OUTER JOIN
				    #tmp_dtl_govt_key_date_anncmnt_us_s4 AS stg
				    ON
					  1 = 1
					  AND dt.msmt_dte_id = stg.msmt_dte_id
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

