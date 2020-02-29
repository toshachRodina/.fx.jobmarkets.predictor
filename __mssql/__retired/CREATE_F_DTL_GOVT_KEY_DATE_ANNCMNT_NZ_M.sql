/*
=======================================================================================================================================================================================================
SUBJECT		 : new zealand govt announcement calendar - list of when key announcements are to occur
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_govt_key_date_anncmnt_nz_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170102
SOURCE		 : statistics new zealand [ http://www.stats.govt.nz/about_us/news_and_events/release-calendar.aspx ]
PREPERATION	 : SCRAPE    - webharvy scrapes summary data from site and stores in csv
			   
REMARKS		 : 1) data refreshed monthly to get upcoming months announcement dates
			   2) 
			   3)
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.stg_govt_key_date_anncmnt_nz_raw;

CREATE TABLE ltn.dbo.stg_govt_key_date_anncmnt_nz_raw
             (
              msmt_dte_id nvarchar ( 8 ) not null
		   ,key_date varchar(max) NOT NULL
             );

DROP TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_nz_m;

CREATE TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_nz_m
             (
             msmt_dte_id       int NOT NULL
           , cntry_cde         varchar(2) NOT NULL
           , anncmnt_cde       varchar(30) NOT NULL
           , anncmnt_desc      varchar(2000) NOT NULL
           , last_updtd_dte_id int NOT NULL
             );

CREATE NONCLUSTERED INDEX ux_f_dtl_govt_key_date_anncmnt_nz_m ON ltn.dbo.f_dtl_govt_key_date_anncmnt_nz_m(msmt_dte_id, anncmnt_cde);

ALTER TABLE ltn.dbo.f_dtl_govt_key_date_anncmnt_nz_m REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_govt_key_date_anncmnt_nz_m @p_env = 'DEV', @p_task_nme = '', @p_pkg_nme = ''

select * from ltn.dbo.f_dtl_govt_key_date_anncmnt_nz_m order by 1

select * from [dbo].[ctl_ssis_err_log] order by task_end_datetime desc
=======================================================================================================================================================================================================
*/
USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_govt_key_date_anncmnt_nz_m') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_govt_key_date_anncmnt_nz_m AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_govt_key_date_anncmnt_nz_m -- Alter the SP Always
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

         SET @l_tbl_nme = 'f_dtl_govt_key_date_anncmnt_nz_m';
         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_msmt_dte_id AS nvarchar(8);

         SET @l_msmt_dte_id =
             (
                 SELECT MAX(msmt_dte_id)
                        FROM
                             ltn.dbo.stg_govt_key_date_anncmnt_nz_raw
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

	   CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_nz_s1
				 (
				 msmt_dte_id      int NOT NULL
			    , key_date_anncmnt varchar(max) NOT NULL
				 );

	   INSERT INTO #tmp_dtl_govt_key_date_anncmnt_nz_s1
			(msmt_dte_id
		    , key_date_anncmnt
			) 
	   SELECT stg.msmt_dte_id
		   , LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(UPPER(stg.key_date), 'PUBLISHED RELEASES', ''), 'UPCOMING RELEASES', ''),'Â€“','-'),'Â€™',''),CHAR(13), '~'), CHAR(10), '~'))) AS key_date_anncmnt
			FROM
				ltn.dbo.stg_govt_key_date_anncmnt_nz_raw AS stg;

/*=================================================================================================
STEP 2
** recursively splits the announcements by month into seperate rows. 

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_nz_s2
					(
					msmt_dte_id      int NOT NULL
				   , key_date_anncmnt varchar(max) NOT NULL
					);

		  WITH row_dat(msmt_dte_id
				   , list_item
				   , key_date_anncmnt)
			  AS (
			  SELECT stg.msmt_dte_id
				  , LEFT(REPLACE(stg.key_date_anncmnt, '~ ~ ~', '^'), CHARINDEX('^', REPLACE(stg.key_date_anncmnt, '~ ~ ~', '^')+'^')-1) AS list_item
				  , STUFF(REPLACE(stg.key_date_anncmnt, '~ ~ ~', '^'), 1, CHARINDEX('^', REPLACE(stg.key_date_anncmnt, '~ ~ ~', '^')+'^'), '') AS key_date_anncmnt
				    FROM
					    #tmp_dtl_govt_key_date_anncmnt_nz_s1 AS stg
			  UNION ALL
			  SELECT dat.msmt_dte_id
				  , LEFT(REPLACE(dat.key_date_anncmnt, '~ ~ ~', '^'), CHARINDEX('^', REPLACE(dat.key_date_anncmnt, '~ ~ ~', '^')+'^')-1) AS list_item
				  , STUFF(REPLACE(dat.key_date_anncmnt, '~ ~ ~', '^'), 1, CHARINDEX('^', REPLACE(dat.key_date_anncmnt, '~ ~ ~', '^')+'^'), '') AS key_date_anncmnt
				    FROM
					    row_dat AS dat
				    WHERE
						1 = 1
						AND REPLACE(dat.key_date_anncmnt, '~ ~ ~', '^') > '')
			  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_nz_s2
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
** generate a unique code based on the announcement description (to fall in line with au format
** link to dim_dte to get the msmt_dte_id for each key date

=================================================================================================*/

		  CREATE TABLE #tmp_dtl_govt_key_date_anncmnt_nz_s3
					(
					msmt_dte_id       int NOT NULL
				   , anncmnt_cde       int NOT NULL
				   , key_date_anncmnt  varchar(2000) NOT NULL
				   , last_updtd_dte_id int NOT NULL
					);

		  INSERT INTO #tmp_dtl_govt_key_date_anncmnt_nz_s3
			    (msmt_dte_id
			   , anncmnt_cde
			   , key_date_anncmnt
			   , last_updtd_dte_id
			    )
		  SELECT dat4.msmt_dte_id
			  , dat4.anncmnt_cde
			  , dat4.key_date_anncmnt
			  , dat4.last_updtd_dte_id
			    FROM
				    (
					   SELECT CONVERT( varchar(10), CAST(dat3.key_dte AS date), 112) AS msmt_dte_id
						   , CAST(dat3.key_dte AS    date) AS key_dte
						   , dat3.dy_part
						   , dat3.mth_part
						   , dat3.yr_part
						   ,abs((CAST(ISNULL(CAST(ASCII(LEFT(dat3.cap_anncmnt_cde, 1)) AS varchar), '0') as decimal(10, 0))
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 2, 1)) AS varchar), '0') as decimal(10, 0))
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 3, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 4, 1)) AS varchar), '0') as decimal(10, 0))
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 5, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 6, 1)) AS varchar), '0') as decimal(10, 0))
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 7, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 8, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 9, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 10, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 11, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 12, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 13, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 14, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 15, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 16, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 17, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 18, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 19, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(dat3.cap_anncmnt_cde, 20, 1)) AS varchar), '0') as decimal(10, 0)) 
						    )  
						   - (CAST(ISNULL(CAST(ASCII(right(dat3.cap_anncmnt_cde, 1)) AS   varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 2, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 3, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 4, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 5, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 6, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 7, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 8, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 9, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 10, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 11, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 12, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 13, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 14, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 15, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 16, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 17, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 18, 1)) AS varchar), '0') as decimal(10, 0)) 
						   - CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 19, 1)) AS varchar), '0') as decimal(10, 0)) 
						   + CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 20, 1)) AS varchar), '0') as decimal(10, 0)) 
						   )) * dat3.len_key_date_anncmnt * CAST(ISNULL(CAST(ASCII(SUBSTRING(REVERSE(dat3.cap_anncmnt_cde), 5, 1)) AS varchar), 5) as decimal(10, 0))
						   AS anncmnt_cde
						   , dat3.cap_anncmnt_cde
						   , dat3.key_date_anncmnt
						   , dat3.last_updtd_dte_id
							FROM
								(
								    SELECT dat2.key_dte
									    , CAST(LEFT(dat2.key_dte, CHARINDEX(' ', dat2.key_dte)-1) AS int) AS dy_part
									    , [dbo].[fn_getalpha]( dat2.key_dte ) AS mth_part
									    , CAST(RIGHT(dat2.key_dte, CHARINDEX(' ', dat2.key_dte)) AS int) AS yr_part
									    , dat2.key_date_anncmnt
									    , dat2.last_updtd_dte_id
									    , REPLACE(REPLACE([dbo].[fn_getlastletters]
										 ( CASE
											  WHEN dat2.key_date_anncmnt LIKE '%:%'
											  THEN LEFT(dat2.key_date_anncmnt, CHARINDEX(':', dat2.key_date_anncmnt)-1)
											  WHEN dat2.key_date_anncmnt LIKE '%-%'
											  THEN LEFT(dat2.key_date_anncmnt, CHARINDEX('-', dat2.key_date_anncmnt)-1)
											  ELSE dat2.key_date_anncmnt
										   END, 2 -- number of characters to select from end of each word
										 ), '(', ''), ')', '')
										 +REPLACE(REPLACE([dbo].[fn_getfirstletters]
										 ( CASE
											  WHEN dat2.key_date_anncmnt LIKE '%:%'
											  THEN LEFT(dat2.key_date_anncmnt, CHARINDEX(':', dat2.key_date_anncmnt)-1)
											  WHEN dat2.key_date_anncmnt LIKE '%-%'
											  THEN LEFT(dat2.key_date_anncmnt, CHARINDEX('-', dat2.key_date_anncmnt)-1)
											  ELSE dat2.key_date_anncmnt
										   END, 2 -- number of characters to select from end of each word
										 ), '(', ''), ')', '') AS cap_anncmnt_cde
										 ,len(CASE
											  WHEN dat2.key_date_anncmnt LIKE '%:%'
											  THEN LEFT(dat2.key_date_anncmnt, CHARINDEX(':', dat2.key_date_anncmnt)-1)
											  WHEN dat2.key_date_anncmnt LIKE '%-%'
											  THEN LEFT(dat2.key_date_anncmnt, CHARINDEX('-', dat2.key_date_anncmnt)-1)
											  ELSE dat2.key_date_anncmnt
										   END) as len_key_date_anncmnt
										 FROM
											 (
												SELECT LTRIM(RTRIM(LEFT(dat.key_date_anncmnt, CHARINDEX('~ ~', dat.key_date_anncmnt)-1))) AS key_dte
													, LTRIM(RTRIM(SUBSTRING(dat.key_date_anncmnt, CHARINDEX('~ ~', dat.key_date_anncmnt)+3, LEN(dat.key_date_anncmnt)))) AS key_date_anncmnt
													, dat.msmt_dte_id AS last_updtd_dte_id
													  FROM
														  (
															 SELECT stg.msmt_dte_id
																 , CASE
																	  WHEN LEFT(stg.key_date_anncmnt, 3) = '~ ~'
																	  THEN LTRIM(RTRIM(SUBSTRING(stg.key_date_anncmnt, CHARINDEX('~ ~', stg.key_date_anncmnt)+3, LEN(stg.key_date_anncmnt))))
																	  ELSE stg.key_date_anncmnt
																   END AS key_date_anncmnt
																   FROM
																	   #tmp_dtl_govt_key_date_anncmnt_nz_s2 AS stg
														  ) AS dat
													  WHERE 1 = 1
											 ) AS dat2
										 WHERE 1 = 1
								) AS dat3
							WHERE 1 = 1
				    ) AS dat4;

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
				    #tmp_dtl_govt_key_date_anncmnt_nz_s3 AS stg
				   ;

-- REMOVE DATES TO BE RE-NSERTED IN BATCH
		  DELETE FROM ltn.dbo.f_dtl_govt_key_date_anncmnt_nz_m
		  WHERE
			   1 = 1
			   AND msmt_dte_id >= @start_dte_id;

-- INSERT NEW DATES IDENTIFIED IN BATCH
		 INSERT INTO ltn.dbo.f_dtl_govt_key_date_anncmnt_nz_m
			    (msmt_dte_id
			   , cntry_cde
			   , anncmnt_cde
			   , anncmnt_desc
			   , last_updtd_dte_id
			    ) 
		  SELECT dt.msmt_dte_id
			  , 'NZ' AS cntry_cde
			  , isnull(cast(stg.anncmnt_cde as varchar),'NOVAL') as anncmnt_cde
			  , isnull(stg.key_date_anncmnt,'NO SCHEDULED RELEASES TODAY') as anncmnt_desc
			  , @l_msmt_dte_id AS last_updtd_dte_id
			    FROM
				    ltn.dbo.dim_dte AS dt
				    LEFT OUTER JOIN
				    #tmp_dtl_govt_key_date_anncmnt_nz_s3 AS stg
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


