/*
=======================================================================================================================================================================================================
SUBJECT		 : Table 24. Underutilised persons by Age and Sex, Monthly
TABLE NAME	 : ltn.dbo.f_dtl_labour_force_underutil_prsns_age_gndr_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20160908
SOURCE		 : ABS [ http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/6202.0Jun%202016?OpenDocument ]
			   ID - 6202024
PREPERATION	 : COPY	   - "Data1" (just the data - no headings) to new workbook
			   TRANSFORM - format date so that is yyyy-mm-dd
			   TRANSFORM - set ALL columns to 7 point data precision (7 decimal places for value and percentages)
			   SAVE	   - as .csv as same name to F:\__lanoitan\__data

REMARKS		 : 1) data refreshed approximately the 18th of every month for previous month.  eg.  18-AUG-2016 - data for July is posted
			   2)
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------


DROP TABLE LTN.DBO.F_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M;

CREATE TABLE LTN.DBO.F_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M
( MSMT_DTE_ID                                                                                       integer NOT NULL
, CAPTURE_PERIOD_ID                                                                                 integer NOT NULL
, CAPTURE_PERIOD                                                                                    date NOT NULL
, CNTRY_CDE                                                                                         varchar(2) NOT NULL
, SITE_CDE                                                                                          varchar(20) NOT NULL
, EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                                  decimal(22, 4) NULL
, EMPLOYED_TOTAL_MALES__ORIGINAL                                                                    decimal(22, 4) NULL
, EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                                  decimal(22, 4) NULL
, UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                             decimal(22, 4) NULL
, UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                               decimal(22, 4) NULL
, UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                             decimal(22, 4) NULL
, UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL                   decimal(22, 4) NULL
, UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL                     decimal(22, 4) NULL
, UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL                   decimal(22, 4) NULL
, UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                                       decimal(22, 4) NULL
, UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                                         decimal(22, 4) NULL
, UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                                       decimal(22, 4) NULL
, UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                                    decimal(12, 9) NULL
, UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                                      decimal(12, 9) NULL
, UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                                    decimal(12, 9) NULL
, UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                                 decimal(12, 9) NULL
, UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                                   decimal(12, 9) NULL
, UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                                 decimal(12, 9) NULL
, UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                                decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                                  decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                                decimal(22, 4) NULL
, UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                               decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                                 decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                               decimal(12, 9) NULL
, LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                              decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                                decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                              decimal(22, 4) NULL
, UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                                           decimal(12, 9) NULL
, UNDERUTILISATION_RATE_MALES__ORIGINAL                                                             decimal(12, 9) NULL
, UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                                           decimal(12, 9) NULL
, YEARS_15_24_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_15_24_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        decimal(22, 4) NULL
, YEARS_15_24_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           decimal(22, 4) NULL
, YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        decimal(12, 9) NULL
, YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          decimal(12, 9) NULL
, YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        decimal(12, 9) NULL
, YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     decimal(12, 9) NULL
, YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       decimal(12, 9) NULL
, YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     decimal(12, 9) NULL
, YEARS_15_24_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_15_24_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_15_24_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_15_24_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   decimal(12, 9) NULL
, YEARS_15_24_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     decimal(12, 9) NULL
, YEARS_15_24_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   decimal(12, 9) NULL
, YEARS_15_24_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_15_24_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_15_24_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_15_24_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_15_24_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 decimal(12, 9) NULL
, YEARS_15_24_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_25_34_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_25_34_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        decimal(22, 4) NULL
, YEARS_25_34_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           decimal(22, 4) NULL
, YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        decimal(12, 9) NULL
, YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          decimal(12, 9) NULL
, YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        decimal(12, 9) NULL
, YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     decimal(12, 9) NULL
, YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       decimal(12, 9) NULL
, YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     decimal(12, 9) NULL
, YEARS_25_34_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_25_34_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_25_34_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_25_34_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   decimal(12, 9) NULL
, YEARS_25_34_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     decimal(12, 9) NULL
, YEARS_25_34_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   decimal(12, 9) NULL
, YEARS_25_34_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_25_34_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_25_34_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_25_34_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_25_34_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 decimal(12, 9) NULL
, YEARS_25_34_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_35_44_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_35_44_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        decimal(22, 4) NULL
, YEARS_35_44_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           decimal(22, 4) NULL
, YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        decimal(12, 9) NULL
, YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          decimal(12, 9) NULL
, YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        decimal(12, 9) NULL
, YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     decimal(12, 9) NULL
, YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       decimal(12, 9) NULL
, YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     decimal(12, 9) NULL
, YEARS_35_44_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_35_44_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_35_44_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_35_44_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   decimal(12, 9) NULL
, YEARS_35_44_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     decimal(12, 9) NULL
, YEARS_35_44_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   decimal(12, 9) NULL
, YEARS_35_44_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_35_44_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_35_44_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_35_44_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_35_44_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 decimal(12, 9) NULL
, YEARS_35_44_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_45_54_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_45_54_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        decimal(22, 4) NULL
, YEARS_45_54_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           decimal(22, 4) NULL
, YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        decimal(12, 9) NULL
, YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          decimal(12, 9) NULL
, YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        decimal(12, 9) NULL
, YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     decimal(12, 9) NULL
, YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       decimal(12, 9) NULL
, YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     decimal(12, 9) NULL
, YEARS_45_54_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_45_54_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      decimal(22, 4) NULL
, YEARS_45_54_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_45_54_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   decimal(12, 9) NULL
, YEARS_45_54_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     decimal(12, 9) NULL
, YEARS_45_54_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   decimal(12, 9) NULL
, YEARS_45_54_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_45_54_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    decimal(22, 4) NULL
, YEARS_45_54_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_45_54_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_45_54_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 decimal(12, 9) NULL
, YEARS_45_54_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_55_AND_OVER_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                decimal(22, 4) NULL
, YEARS_55_AND_OVER_EMPLOYED_TOTAL_MALES__ORIGINAL                                                  decimal(22, 4) NULL
, YEARS_55_AND_OVER_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                           decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                             decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                           decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL   decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                     decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                       decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                     decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                  decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                    decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                  decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL               decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                 decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL               decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                              decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                              decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                             decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                               decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                             decimal(12, 9) NULL
, YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                            decimal(22, 4) NULL
, YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                              decimal(22, 4) NULL
, YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                            decimal(22, 4) NULL
, YEARS_55_AND_OVER_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                         decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNDERUTILISATION_RATE_MALES__ORIGINAL                                           decimal(12, 9) NULL
, YEARS_55_AND_OVER_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                         decimal(12, 9) NULL
, STARTED_AT                                                                                        varchar(20) NOT NULL
, FINISHED_AT                                                                                       varchar(20) NOT NULL
);

CREATE UNIQUE INDEX ux_f_dtl_labour_force_underutil_prsns_age_gndr_m ON ltn.dbo.f_dtl_labour_force_underutil_prsns_age_gndr_m (capture_period_id);

ALTER TABLE ltn.dbo.f_dtl_labour_force_underutil_prsns_age_gndr_m REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================

exec create_f_dtl_labour_force_underutil_prsns_m @p_env = 'PROD', @p_task_nme = '', @p_pkg_nme = ''

select * from ltn.dbo.ctl_ssis_err_log order by task_end_datetime desc
select * from [dbo].[F_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M] order by 2
*/

USE [ltn]
GO

IF OBJECT_ID('create_f_dtl_labour_force_underutil_prsns_m') IS NULL -- Check if SP Exists
 EXEC('CREATE PROCEDURE create_f_dtl_labour_force_underutil_prsns_m AS SET NOCOUNT ON;') -- Create dummy/empty SP
GO
 
alter procedure create_f_dtl_labour_force_underutil_prsns_m -- Alter the SP Always
(
  @p_env nvarchar (10) 
, @p_task_nme nvarchar (100) 
, @p_pkg_nme nvarchar (100)
) 
as

BEGIN

SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD

SET ANSI_NULLS ON;

SET QUOTED_IDENTIFIER ON;

/*
=======================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS
=======================================================================================================================================================================================================
*/
-- TABLES ----------------------------------------------------------------
declare @l_tbl_nme as nvarchar (50);
declare @l_prces_dte_id as nvarchar(8);
      
set @l_tbl_nme = 'f_dtl_labour_force_underutil_prsns_age_gndr_m';
set @l_prces_dte_id = CONVERT( VARCHAR(10), CAST(cast(getdate() as date) AS DATE), 112);
	 
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
STEP 1 
---------------------------------------------------------------------------------------------------
** load data from sqlite3 database to sqlserver temp table
** this step is rquired as there is a char length limitation of 8000 characters for openquery
** below loads bulk into TMP table before continuing as normal
drop table #TMP_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_M
*/ 
	   SELECT *
	   INTO #TMP_TBL
		  FROM openquery(PY_WEB_DATA, 'SELECT * FROM PY_LABOUR_FORCE_AU_UNDERUTIL_PRSNS');

/*
STEP 2 
---------------------------------------------------------------------------------------------------
** load data from TMP_TBL into FULL temp table
drop table #TMP_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_M
*/ 

	   CREATE TABLE #TMP_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_M
	   ( MSMT_DTE_ID                                                                                       integer NOT NULL
	   , CAPTURE_PERIOD_ID                                                                                 integer NOT NULL
	   , CAPTURE_PERIOD                                                                                    date NOT NULL
	   , CNTRY_CDE                                                                                         varchar(2) NOT NULL
	   , SITE_CDE                                                                                          varchar(20) NOT NULL
	   , EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                                  decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_MALES__ORIGINAL                                                                    decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                                  decimal(22, 4) NULL
	   , UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                             decimal(22, 4) NULL
	   , UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                               decimal(22, 4) NULL
	   , UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                             decimal(22, 4) NULL
	   , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL                   decimal(22, 4) NULL
	   , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL                     decimal(22, 4) NULL
	   , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL                   decimal(22, 4) NULL
	   , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                                       decimal(22, 4) NULL
	   , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                                         decimal(22, 4) NULL
	   , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                                       decimal(22, 4) NULL
	   , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                                    decimal(12, 9) NULL
	   , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                                      decimal(12, 9) NULL
	   , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                                    decimal(12, 9) NULL
	   , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                                 decimal(12, 9) NULL
	   , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                                   decimal(12, 9) NULL
	   , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                                 decimal(12, 9) NULL
	   , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                                decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                                  decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                                decimal(22, 4) NULL
	   , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                               decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                                 decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                               decimal(12, 9) NULL
	   , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                              decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                                decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                              decimal(22, 4) NULL
	   , UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                                           decimal(12, 9) NULL
	   , UNDERUTILISATION_RATE_MALES__ORIGINAL                                                             decimal(12, 9) NULL
	   , UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                                           decimal(12, 9) NULL
	   , YEARS_15_24_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_15_24_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        decimal(22, 4) NULL
	   , YEARS_15_24_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           decimal(22, 4) NULL
	   , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        decimal(12, 9) NULL
	   , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          decimal(12, 9) NULL
	   , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        decimal(12, 9) NULL
	   , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     decimal(12, 9) NULL
	   , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       decimal(12, 9) NULL
	   , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     decimal(12, 9) NULL
	   , YEARS_15_24_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_15_24_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_15_24_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_15_24_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   decimal(12, 9) NULL
	   , YEARS_15_24_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     decimal(12, 9) NULL
	   , YEARS_15_24_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   decimal(12, 9) NULL
	   , YEARS_15_24_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_15_24_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_15_24_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_15_24_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_15_24_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 decimal(12, 9) NULL
	   , YEARS_15_24_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_25_34_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_25_34_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        decimal(22, 4) NULL
	   , YEARS_25_34_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           decimal(22, 4) NULL
	   , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        decimal(12, 9) NULL
	   , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          decimal(12, 9) NULL
	   , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        decimal(12, 9) NULL
	   , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     decimal(12, 9) NULL
	   , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       decimal(12, 9) NULL
	   , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     decimal(12, 9) NULL
	   , YEARS_25_34_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_25_34_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_25_34_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_25_34_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   decimal(12, 9) NULL
	   , YEARS_25_34_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     decimal(12, 9) NULL
	   , YEARS_25_34_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   decimal(12, 9) NULL
	   , YEARS_25_34_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_25_34_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_25_34_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_25_34_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_25_34_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 decimal(12, 9) NULL
	   , YEARS_25_34_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_35_44_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_35_44_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        decimal(22, 4) NULL
	   , YEARS_35_44_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           decimal(22, 4) NULL
	   , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        decimal(12, 9) NULL
	   , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          decimal(12, 9) NULL
	   , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        decimal(12, 9) NULL
	   , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     decimal(12, 9) NULL
	   , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       decimal(12, 9) NULL
	   , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     decimal(12, 9) NULL
	   , YEARS_35_44_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_35_44_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_35_44_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_35_44_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   decimal(12, 9) NULL
	   , YEARS_35_44_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     decimal(12, 9) NULL
	   , YEARS_35_44_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   decimal(12, 9) NULL
	   , YEARS_35_44_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_35_44_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_35_44_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_35_44_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_35_44_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 decimal(12, 9) NULL
	   , YEARS_35_44_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_45_54_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_45_54_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        decimal(22, 4) NULL
	   , YEARS_45_54_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           decimal(22, 4) NULL
	   , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        decimal(12, 9) NULL
	   , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          decimal(12, 9) NULL
	   , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        decimal(12, 9) NULL
	   , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     decimal(12, 9) NULL
	   , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       decimal(12, 9) NULL
	   , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     decimal(12, 9) NULL
	   , YEARS_45_54_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_45_54_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      decimal(22, 4) NULL
	   , YEARS_45_54_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_45_54_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   decimal(12, 9) NULL
	   , YEARS_45_54_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     decimal(12, 9) NULL
	   , YEARS_45_54_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   decimal(12, 9) NULL
	   , YEARS_45_54_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_45_54_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    decimal(22, 4) NULL
	   , YEARS_45_54_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_45_54_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_45_54_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 decimal(12, 9) NULL
	   , YEARS_45_54_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_EMPLOYED_TOTAL_MALES__ORIGINAL                                                  decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                           decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                             decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                           decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL   decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                     decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                       decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                     decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                  decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                    decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                  decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL               decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                 decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL               decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                              decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                              decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                             decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                               decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                             decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                            decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                              decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                            decimal(22, 4) NULL
	   , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                         decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_MALES__ORIGINAL                                           decimal(12, 9) NULL
	   , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                         decimal(12, 9) NULL
	   , STARTED_AT                                                                                        varchar(20) NOT NULL
	   , FINISHED_AT                                                                                       varchar(20) NOT NULL
	   );


	   INSERT INTO #TMP_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_M ( MSMT_DTE_ID
												, CAPTURE_PERIOD_ID
												, CAPTURE_PERIOD
												, CNTRY_CDE
												, SITE_CDE
												, EMPLOYED_TOTAL_PERSONS__ORIGINAL
												, EMPLOYED_TOTAL_MALES__ORIGINAL
												, EMPLOYED_TOTAL_FEMALES__ORIGINAL
												, UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
												, UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
												, UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
												, UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
												, UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
												, UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
												, UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
												, UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
												, UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
												, UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
												, UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
												, UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
												, UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
												, UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
												, UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
												, UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
												, UNEMPLOYED_TOTAL_MALES__ORIGINAL
												, UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
												, UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
												, UNEMPLOYMENT_RATE_MALES__ORIGINAL
												, UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
												, LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
												, LABOUR_FORCE_TOTAL_MALES__ORIGINAL
												, LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
												, UNDERUTILISATION_RATE_PERSONS__ORIGINAL
												, UNDERUTILISATION_RATE_MALES__ORIGINAL
												, UNDERUTILISATION_RATE_FEMALES__ORIGINAL
												, YEARS_15_24_EMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_15_24_EMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_15_24_EMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
												, YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
												, YEARS_15_24_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_15_24_UNEMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_15_24_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_15_24_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
												, YEARS_15_24_UNEMPLOYMENT_RATE_MALES__ORIGINAL
												, YEARS_15_24_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
												, YEARS_15_24_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
												, YEARS_15_24_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
												, YEARS_15_24_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
												, YEARS_15_24_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
												, YEARS_15_24_UNDERUTILISATION_RATE_MALES__ORIGINAL
												, YEARS_15_24_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
												, YEARS_25_34_EMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_25_34_EMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_25_34_EMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
												, YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
												, YEARS_25_34_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_25_34_UNEMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_25_34_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_25_34_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
												, YEARS_25_34_UNEMPLOYMENT_RATE_MALES__ORIGINAL
												, YEARS_25_34_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
												, YEARS_25_34_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
												, YEARS_25_34_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
												, YEARS_25_34_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
												, YEARS_25_34_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
												, YEARS_25_34_UNDERUTILISATION_RATE_MALES__ORIGINAL
												, YEARS_25_34_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
												, YEARS_35_44_EMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_35_44_EMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_35_44_EMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
												, YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
												, YEARS_35_44_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_35_44_UNEMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_35_44_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_35_44_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
												, YEARS_35_44_UNEMPLOYMENT_RATE_MALES__ORIGINAL
												, YEARS_35_44_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
												, YEARS_35_44_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
												, YEARS_35_44_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
												, YEARS_35_44_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
												, YEARS_35_44_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
												, YEARS_35_44_UNDERUTILISATION_RATE_MALES__ORIGINAL
												, YEARS_35_44_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
												, YEARS_45_54_EMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_45_54_EMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_45_54_EMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
												, YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
												, YEARS_45_54_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_45_54_UNEMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_45_54_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_45_54_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
												, YEARS_45_54_UNEMPLOYMENT_RATE_MALES__ORIGINAL
												, YEARS_45_54_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
												, YEARS_45_54_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
												, YEARS_45_54_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
												, YEARS_45_54_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
												, YEARS_45_54_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
												, YEARS_45_54_UNDERUTILISATION_RATE_MALES__ORIGINAL
												, YEARS_45_54_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_EMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_EMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_55_AND_OVER_EMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_MALES__ORIGINAL
												, YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_MALES__ORIGINAL
												, YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
												, YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
												, YEARS_55_AND_OVER_UNDERUTILISATION_RATE_MALES__ORIGINAL
												, YEARS_55_AND_OVER_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
												, STARTED_AT
												, FINISHED_AT
												)
	   SELECT MSMT_DTE_ID
		   , convert( varchar(10), cast(CAPTURE_PERIOD AS date), 112) AS CAPTURE_PERIOD_ID
		   , CAPTURE_PERIOD
		   , CNTRY_CDE
		   , SITE_CDE
		   , EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , EMPLOYED_TOTAL_MALES__ORIGINAL
		   , EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , YEARS_15_24_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_15_24_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_15_24_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , YEARS_15_24_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_15_24_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_15_24_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_15_24_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , YEARS_15_24_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , YEARS_15_24_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , YEARS_15_24_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , YEARS_15_24_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , YEARS_15_24_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , YEARS_15_24_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , YEARS_15_24_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , YEARS_15_24_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , YEARS_25_34_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_25_34_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_25_34_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , YEARS_25_34_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_25_34_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_25_34_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_25_34_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , YEARS_25_34_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , YEARS_25_34_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , YEARS_25_34_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , YEARS_25_34_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , YEARS_25_34_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , YEARS_25_34_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , YEARS_25_34_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , YEARS_25_34_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , YEARS_35_44_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_35_44_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_35_44_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , YEARS_35_44_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_35_44_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_35_44_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_35_44_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , YEARS_35_44_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , YEARS_35_44_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , YEARS_35_44_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , YEARS_35_44_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , YEARS_35_44_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , YEARS_35_44_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , YEARS_35_44_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , YEARS_35_44_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , YEARS_45_54_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_45_54_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_45_54_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , YEARS_45_54_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_45_54_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_45_54_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_45_54_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , YEARS_45_54_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , YEARS_45_54_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , YEARS_45_54_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , YEARS_45_54_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , YEARS_45_54_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , YEARS_45_54_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , YEARS_45_54_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , YEARS_45_54_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , STARTED_AT
		   , FINISHED_AT
		FROM #TMP_TBL;

/*
STEP 3 
---------------------------------------------------------------------------------------------------
** insert into final f_dtl table 
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)
truncate table LTN.DBO.F_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M
*/

	   INSERT INTO LTN.DBO.F_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M ( MSMT_DTE_ID
														    , CAPTURE_PERIOD_ID
														    , CAPTURE_PERIOD
														    , CNTRY_CDE
														    , SITE_CDE
														    , EMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , EMPLOYED_TOTAL_MALES__ORIGINAL
														    , EMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
														    , UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
														    , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
														    , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
														    , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
														    , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
														    , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
														    , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
														    , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
														    , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
														    , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
														    , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
														    , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
														    , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , UNEMPLOYED_TOTAL_MALES__ORIGINAL
														    , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
														    , UNEMPLOYMENT_RATE_MALES__ORIGINAL
														    , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
														    , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
														    , LABOUR_FORCE_TOTAL_MALES__ORIGINAL
														    , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
														    , UNDERUTILISATION_RATE_PERSONS__ORIGINAL
														    , UNDERUTILISATION_RATE_MALES__ORIGINAL
														    , UNDERUTILISATION_RATE_FEMALES__ORIGINAL
														    , YEARS_15_24_EMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_15_24_EMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_15_24_EMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
														    , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
														    , YEARS_15_24_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_15_24_UNEMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_15_24_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_15_24_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
														    , YEARS_15_24_UNEMPLOYMENT_RATE_MALES__ORIGINAL
														    , YEARS_15_24_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
														    , YEARS_15_24_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
														    , YEARS_15_24_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
														    , YEARS_15_24_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
														    , YEARS_15_24_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
														    , YEARS_15_24_UNDERUTILISATION_RATE_MALES__ORIGINAL
														    , YEARS_15_24_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
														    , YEARS_25_34_EMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_25_34_EMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_25_34_EMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
														    , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
														    , YEARS_25_34_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_25_34_UNEMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_25_34_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_25_34_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
														    , YEARS_25_34_UNEMPLOYMENT_RATE_MALES__ORIGINAL
														    , YEARS_25_34_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
														    , YEARS_25_34_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
														    , YEARS_25_34_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
														    , YEARS_25_34_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
														    , YEARS_25_34_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
														    , YEARS_25_34_UNDERUTILISATION_RATE_MALES__ORIGINAL
														    , YEARS_25_34_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
														    , YEARS_35_44_EMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_35_44_EMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_35_44_EMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
														    , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
														    , YEARS_35_44_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_35_44_UNEMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_35_44_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_35_44_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
														    , YEARS_35_44_UNEMPLOYMENT_RATE_MALES__ORIGINAL
														    , YEARS_35_44_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
														    , YEARS_35_44_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
														    , YEARS_35_44_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
														    , YEARS_35_44_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
														    , YEARS_35_44_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
														    , YEARS_35_44_UNDERUTILISATION_RATE_MALES__ORIGINAL
														    , YEARS_35_44_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
														    , YEARS_45_54_EMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_45_54_EMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_45_54_EMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
														    , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
														    , YEARS_45_54_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_45_54_UNEMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_45_54_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_45_54_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
														    , YEARS_45_54_UNEMPLOYMENT_RATE_MALES__ORIGINAL
														    , YEARS_45_54_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
														    , YEARS_45_54_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
														    , YEARS_45_54_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
														    , YEARS_45_54_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
														    , YEARS_45_54_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
														    , YEARS_45_54_UNDERUTILISATION_RATE_MALES__ORIGINAL
														    , YEARS_45_54_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_EMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_EMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_EMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
														    , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_MALES__ORIGINAL
														    , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
														    , STARTED_AT
														    , FINISHED_AT
														    )
	   SELECT TMP.MSMT_DTE_ID
		   , TMP.CAPTURE_PERIOD_ID
		   , TMP.CAPTURE_PERIOD
		   , TMP.CNTRY_CDE
		   , TMP.SITE_CDE
		   , TMP.EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.EMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , TMP.UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , TMP.UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , TMP.UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , TMP.UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , TMP.UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , TMP.UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , TMP.UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , TMP.UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , TMP.UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , TMP.UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , TMP.UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , TMP.UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , TMP.UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , TMP.UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , TMP.LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , TMP.LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , TMP.LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , TMP.UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , TMP.UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , TMP.UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_15_24_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_15_24_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , TMP.YEARS_15_24_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_15_24_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_15_24_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , TMP.YEARS_15_24_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_25_34_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_25_34_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , TMP.YEARS_25_34_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_25_34_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_25_34_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , TMP.YEARS_25_34_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_35_44_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_35_44_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , TMP.YEARS_35_44_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_35_44_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_35_44_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , TMP.YEARS_35_44_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_45_54_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_45_54_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , TMP.YEARS_45_54_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_45_54_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_45_54_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , TMP.YEARS_45_54_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_EMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDERUTILISATION_RATE_PERSONS__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDERUTILISATION_RATE_MALES__ORIGINAL
		   , TMP.YEARS_55_AND_OVER_UNDERUTILISATION_RATE_FEMALES__ORIGINAL
		   , TMP.STARTED_AT
		   , TMP.FINISHED_AT
		FROM #TMP_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_M AS TMP
			LEFT OUTER JOIN LTN.DBO.F_DTL_LABOUR_FORCE_UNDERUTIL_PRSNS_AGE_GNDR_M AS DTL
			ON 1 = 1
			   AND TMP.CAPTURE_PERIOD_ID = DTL.CAPTURE_PERIOD_ID
	    WHERE 1 = 1
			AND DTL.CAPTURE_PERIOD_ID IS NULL
	    ORDER BY 2;

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
