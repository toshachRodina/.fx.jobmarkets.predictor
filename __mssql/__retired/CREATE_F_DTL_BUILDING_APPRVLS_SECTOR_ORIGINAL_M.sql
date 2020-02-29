/*
=======================================================================================================================================================================================================
SUBJECT		 : Table 11. Number of Dwelling Units Approved, By Sector, Original - Australia
TABLE NAME	 : ltn.dbo.f_dtl_building_apprvls_sector_original_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20161124
SOURCE		 : ABS [ http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/8731.0Sep%202016?OpenDocument ]
			   ID - 87310011
PREPERATION	 : COPY	   - "Data1" (just the data - no headings) to new workbook
			   TRANSFORM - format date so that is yyyy-mm-dd
			   TRANSFORM - leave all values as found (no transformation required)
			   SAVE	   - as .csv as same name to F:\__lanoitan\__data

REMARKS		 : 1) data refreshed approximately the 18th of every month for previous month.  eg.  18-AUG-2016 - data for July is posted
			   2)
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------


DROP TABLE ltn.dbo.stg_building_apprvls_sector_original;

CREATE TABLE ltn.dbo.stg_building_apprvls_sector_original
             (
             capture_period                                                                         varchar(50) NOT NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_houses_new__original                             varchar(50) NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_other_rsdntl_new__original                   varchar(50) NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_rsdntl_alterations_and_additions__original   varchar(50) NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_rsdntl_conversions__original                 varchar(50) NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_nonrsdntl_ttl_work__original                 varchar(50) NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_type_of_bldng_ttl_work__original             varchar(50) NULL
           , ttl_nbr_of_dwelling_units_public_sector_houses_new__original                           varchar(50) NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_other_rsdntl_new__original                 varchar(50) NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_rsdntl_alterations_and_additions__original varchar(50) NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_rsdntl_conversions__original               varchar(50) NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_nonrsdntl_ttl_work__original               varchar(50) NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_type_of_bldng_ttl_work__original           varchar(50) NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_houses_new__original                             varchar(50) NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_other_rsdntl_new__original                   varchar(50) NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_rsdntl_alterations_and_additions__original   varchar(50) NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_rsdntl_conversions__original                 varchar(50) NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_nonrsdntl_ttl_work__original                 varchar(50) NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_type_of_bldng_ttl_work__original             varchar(50) NULL
             );

DROP TABLE ltn.dbo.f_dtl_building_apprvls_sector_original_m;

CREATE TABLE ltn.dbo.f_dtl_building_apprvls_sector_original_m
             (
             msmt_dte_id                                                                            int NOT NULL
           , capture_period                                                                         date NOT NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_houses_new__original                             int NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_other_rsdntl_new__original                   int NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_rsdntl_alterations_and_additions__original   int NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_rsdntl_conversions__original                 int NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_nonrsdntl_ttl_work__original                 int NULL
           , ttl_nbr_of_dwelling_units_prvt_sector_ttl_type_of_bldng_ttl_work__original             int NULL
           , ttl_nbr_of_dwelling_units_public_sector_houses_new__original                           int NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_other_rsdntl_new__original                 int NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_rsdntl_alterations_and_additions__original int NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_rsdntl_conversions__original               int NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_nonrsdntl_ttl_work__original               int NULL
           , ttl_nbr_of_dwelling_units_public_sector_ttl_type_of_bldng_ttl_work__original           int NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_houses_new__original                             int NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_other_rsdntl_new__original                   int NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_rsdntl_alterations_and_additions__original   int NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_rsdntl_conversions__original                 int NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_nonrsdntl_ttl_work__original                 int NULL
           , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_type_of_bldng_ttl_work__original             int NULL
           , prces_dte_id                                                                           int NOT NULL
             );

CREATE UNIQUE INDEX ux_f_dtl_building_apprvls_sector_original_m ON ltn.dbo.f_dtl_building_apprvls_sector_original_m (msmt_dte_id);

ALTER TABLE ltn.dbo.f_dtl_building_apprvls_sector_original_m REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================


*/

USE [ltn]
GO

IF OBJECT_ID('create_f_dtl_building_apprvls_sector_original_m') IS NULL -- Check if SP Exists
 EXEC('CREATE PROCEDURE create_f_dtl_building_apprvls_sector_original_m AS SET NOCOUNT ON;') -- Create dummy/empty SP
GO
 
alter procedure create_f_dtl_building_apprvls_sector_original_m -- Alter the SP Always
(
  @p_env nvarchar (10) 
, @p_task_nme nvarchar (100) 
, @p_pkg_nme nvarchar (100)
) 
as

BEGIN

--SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;

/*
=======================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS
=======================================================================================================================================================================================================
*/
-- TABLES ----------------------------------------------------------------
declare @l_tbl_nme as nvarchar (50);
declare @l_tmp_tbl_nme as nvarchar (50);
declare @l_prces_dte_id as nvarchar(8);
      
set @l_tbl_nme = 'f_dtl_building_apprvls_sector_original_m';
set @l_prces_dte_id = CONVERT( VARCHAR(10), CAST(cast(getdate() as date) AS DATE), 112);
	 
/*
=======================================================================================================================================================================================================
IDENTIFY RELEVANT DATE ID'S TO INSERT
=======================================================================================================================================================================================================
*/
CREATE TABLE #msmt_dte_is_lst
             (
             msmt_dte_id INT NOT NULL
             );

INSERT INTO #msmt_dte_is_lst(msmt_dte_id)
SELECT CONVERT( varchar(10), CAST(stg.capture_period AS date), 112) AS msmt_dte_id
       FROM
            ltn.dbo.stg_building_apprvls_sector_original AS stg
EXCEPT
SELECT dtl.msmt_dte_id
       FROM
            ltn.dbo.f_dtl_building_apprvls_sector_original_m AS dtl;


		  /*
=======================================================================================================================================================================================================
MAIN CODE BLOCK
- TABLE TIDY UP (IF NEEDED)
- INSERT NEW DATA
- SWITCH INTO EMPTY PARTITIONS (IF USING TABLE PARTITIONS
=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
TRY BLOACK - START
=======================================================================================================================================================================================================
*/

BEGIN TRY

INSERT INTO ltn.dbo.f_dtl_building_apprvls_sector_original_m
       (msmt_dte_id
      , capture_period
      , ttl_nbr_of_dwelling_units_prvt_sector_houses_new__original
      , ttl_nbr_of_dwelling_units_prvt_sector_ttl_other_rsdntl_new__original
      , ttl_nbr_of_dwelling_units_prvt_sector_ttl_rsdntl_alterations_and_additions__original
      , ttl_nbr_of_dwelling_units_prvt_sector_ttl_rsdntl_conversions__original
      , ttl_nbr_of_dwelling_units_prvt_sector_ttl_nonrsdntl_ttl_work__original
      , ttl_nbr_of_dwelling_units_prvt_sector_ttl_type_of_bldng_ttl_work__original
      , ttl_nbr_of_dwelling_units_public_sector_houses_new__original
      , ttl_nbr_of_dwelling_units_public_sector_ttl_other_rsdntl_new__original
      , ttl_nbr_of_dwelling_units_public_sector_ttl_rsdntl_alterations_and_additions__original
      , ttl_nbr_of_dwelling_units_public_sector_ttl_rsdntl_conversions__original
      , ttl_nbr_of_dwelling_units_public_sector_ttl_nonrsdntl_ttl_work__original
      , ttl_nbr_of_dwelling_units_public_sector_ttl_type_of_bldng_ttl_work__original
      , ttl_nbr_of_dwelling_units_ttl_sectors_houses_new__original
      , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_other_rsdntl_new__original
      , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_rsdntl_alterations_and_additions__original
      , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_rsdntl_conversions__original
      , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_nonrsdntl_ttl_work__original
      , ttl_nbr_of_dwelling_units_ttl_sectors_ttl_type_of_bldng_ttl_work__original
      , prces_dte_id
       )
SELECT CONVERT( varchar(10), CAST(stg.capture_period AS date), 112) AS msmt_dte_id
     , CAST(stg.capture_period AS    date) AS capture_period
     , stg.ttl_nbr_of_dwelling_units_prvt_sector_houses_new__original
     , stg.ttl_nbr_of_dwelling_units_prvt_sector_ttl_other_rsdntl_new__original
     , stg.ttl_nbr_of_dwelling_units_prvt_sector_ttl_rsdntl_alterations_and_additions__original
     , stg.ttl_nbr_of_dwelling_units_prvt_sector_ttl_rsdntl_conversions__original
     , stg.ttl_nbr_of_dwelling_units_prvt_sector_ttl_nonrsdntl_ttl_work__original
     , stg.ttl_nbr_of_dwelling_units_prvt_sector_ttl_type_of_bldng_ttl_work__original
     , stg.ttl_nbr_of_dwelling_units_public_sector_houses_new__original
     , stg.ttl_nbr_of_dwelling_units_public_sector_ttl_other_rsdntl_new__original
     , stg.ttl_nbr_of_dwelling_units_public_sector_ttl_rsdntl_alterations_and_additions__original
     , stg.ttl_nbr_of_dwelling_units_public_sector_ttl_rsdntl_conversions__original
     , stg.ttl_nbr_of_dwelling_units_public_sector_ttl_nonrsdntl_ttl_work__original
     , stg.ttl_nbr_of_dwelling_units_public_sector_ttl_type_of_bldng_ttl_work__original
     , stg.ttl_nbr_of_dwelling_units_ttl_sectors_houses_new__original
     , stg.ttl_nbr_of_dwelling_units_ttl_sectors_ttl_other_rsdntl_new__original
     , stg.ttl_nbr_of_dwelling_units_ttl_sectors_ttl_rsdntl_alterations_and_additions__original
     , stg.ttl_nbr_of_dwelling_units_ttl_sectors_ttl_rsdntl_conversions__original
     , stg.ttl_nbr_of_dwelling_units_ttl_sectors_ttl_nonrsdntl_ttl_work__original
     , stg.ttl_nbr_of_dwelling_units_ttl_sectors_ttl_type_of_bldng_ttl_work__original
     , @l_prces_dte_id AS prces_dte_id
       FROM
            ltn.dbo.stg_building_apprvls_sector_original AS stg
       WHERE 1 = 1
             AND CONVERT(varchar(10), CAST(stg.capture_period AS date), 112) IN
                                                                                (
                                                                                    SELECT msmt_dte_id
                                                                                           FROM
                                                                                                #msmt_dte_is_lst
                                                                                );

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

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/

end