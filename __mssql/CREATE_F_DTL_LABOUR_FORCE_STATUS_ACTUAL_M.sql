/*
=======================================================================================================================================================================================================
SUBJECT		 : Table 1. Labour force status by Sex, Australia - Trend, Seasonally adjusted and Original
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_labour_force_status_actual_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170918
SOURCE		 : ABS [ http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/6202.0Jun%202016?OpenDocument ]
			   ID - 6202001
PREPERATION	 : 

REMARKS		 : 1) similar to the ltn.dbo.f_dtl_labour_force_status_m table but takes the most recent 2 rows of each months file which should line up with the announcements data
			   2)
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE LTN.DBO.TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M;

CREATE TABLE LTN.DBO.TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M
( RPT_PERIOD_ID                                                                 integer NOT NULL
, CAPTURE_PERIOD                                                                date NOT NULL
, EMPLOYED_TOTAL_PERSONS__TREND                                                 varchar(50) NULL
, EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED                                   varchar(50) NULL
, EMPLOYED_TOTAL_PERSONS__ORIGINAL                                              varchar(50) NULL
, EMPLOYED_TOTAL_MALES__TREND                                                   varchar(50) NULL
, EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED                                     varchar(50) NULL
, EMPLOYED_TOTAL_MALES__ORIGINAL                                                varchar(50) NULL
, EMPLOYED_TOTAL_FEMALES__TREND                                                 varchar(50) NULL
, EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED                                   varchar(50) NULL
, EMPLOYED_TOTAL_FEMALES__ORIGINAL                                              varchar(50) NULL
, EMPLOYED_FULL_TIME_PERSONS__TREND                                             varchar(50) NULL
, EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED                               varchar(50) NULL
, EMPLOYED_FULL_TIME_PERSONS__ORIGINAL                                          varchar(50) NULL
, EMPLOYED_FULL_TIME_MALES__TREND                                               varchar(50) NULL
, EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED                                 varchar(50) NULL
, EMPLOYED_FULL_TIME_MALES__ORIGINAL                                            varchar(50) NULL
, EMPLOYED_FULL_TIME_FEMALES__TREND                                             varchar(50) NULL
, EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED                               varchar(50) NULL
, EMPLOYED_FULL_TIME_FEMALES__ORIGINAL                                          varchar(50) NULL
, EMPLOYED_PART_TIME_PERSONS__TREND                                             varchar(50) NULL
, EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED                               varchar(50) NULL
, EMPLOYED_PART_TIME_PERSONS__ORIGINAL                                          varchar(50) NULL
, EMPLOYED_PART_TIME_MALES__TREND                                               varchar(50) NULL
, EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED                                 varchar(50) NULL
, EMPLOYED_PART_TIME_MALES__ORIGINAL                                            varchar(50) NULL
, EMPLOYED_PART_TIME_FEMALES__TREND                                             varchar(50) NULL
, EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED                               varchar(50) NULL
, EMPLOYED_PART_TIME_FEMALES__ORIGINAL                                          varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND                                 varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED                   varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL                              varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND                                   varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED                     varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL                                varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND                                 varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED                   varchar(50) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL                              varchar(50) NULL
, UNEMPLOYED_TOTAL_PERSONS__TREND                                               varchar(50) NULL
, UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED                                 varchar(50) NULL
, UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                            varchar(50) NULL
, UNEMPLOYED_TOTAL_MALES__TREND                                                 varchar(50) NULL
, UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED                                   varchar(50) NULL
, UNEMPLOYED_TOTAL_MALES__ORIGINAL                                              varchar(50) NULL
, UNEMPLOYED_TOTAL_FEMALES__TREND                                               varchar(50) NULL
, UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED                                 varchar(50) NULL
, UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                            varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND                           varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED             varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL                        varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND                             varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED               varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL                          varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND                           varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED             varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL                        varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND                      varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED        varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL                   varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND                        varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED          varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL                     varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND                      varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED        varchar(50) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL                   varchar(50) NULL
, UNEMPLOYMENT_RATE_PERSONS__TREND                                              varchar(50) NULL
, UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED                                varchar(50) NULL
, UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                           varchar(50) NULL
, UNEMPLOYMENT_RATE_MALES__TREND                                                varchar(50) NULL
, UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED                                  varchar(50) NULL
, UNEMPLOYMENT_RATE_MALES__ORIGINAL                                             varchar(50) NULL
, UNEMPLOYMENT_RATE_FEMALES__TREND                                              varchar(50) NULL
, UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED                                varchar(50) NULL
, UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                           varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND                    varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED      varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL                 varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND                      varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED        varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL                   varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND                    varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED      varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL                 varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND               varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL            varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND                 varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED   varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL              varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND               varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED varchar(50) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL            varchar(50) NULL
, LABOUR_FORCE_TOTAL_PERSONS__TREND                                             varchar(50) NULL
, LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED                               varchar(50) NULL
, LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                          varchar(50) NULL
, LABOUR_FORCE_TOTAL_MALES__TREND                                               varchar(50) NULL
, LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED                                 varchar(50) NULL
, LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                            varchar(50) NULL
, LABOUR_FORCE_TOTAL_FEMALES__TREND                                             varchar(50) NULL
, LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED                               varchar(50) NULL
, LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                          varchar(50) NULL
, PARTICIPATION_RATE_PERSONS__TREND                                             varchar(50) NULL
, PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED                               varchar(50) NULL
, PARTICIPATION_RATE_PERSONS__ORIGINAL                                          varchar(50) NULL
, PARTICIPATION_RATE_MALES__TREND                                               varchar(50) NULL
, PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED                                 varchar(50) NULL
, PARTICIPATION_RATE_MALES__ORIGINAL                                            varchar(50) NULL
, PARTICIPATION_RATE_FEMALES__TREND                                             varchar(50) NULL
, PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED                               varchar(50) NULL
, PARTICIPATION_RATE_FEMALES__ORIGINAL                                          varchar(50) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL                                varchar(50) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL                                  varchar(50) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL                                varchar(50) NULL
, CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL                  varchar(50) NULL
, CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL                    varchar(50) NULL
, CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL                  varchar(50) NULL
);


DROP TABLE LTN.DBO.F_DTL_LABOUR_FORCE_STATUS_ACTUAL_M;

CREATE TABLE LTN.DBO.F_DTL_LABOUR_FORCE_STATUS_ACTUAL_M
( RPT_PERIOD_ID                                                                 integer NOT NULL
, CAPTURE_PERIOD_ID                                                             integer NOT NULL
, CAPTURE_PERIOD                                                                date NOT NULL
, CNTRY_CDE                                                                     varchar(2) NOT NULL
, SITE_CDE                                                                      varchar(20) NOT NULL
, EMPLOYED_TOTAL_PERSONS__TREND                                                 decimal(22, 4) NULL
, EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
, EMPLOYED_TOTAL_PERSONS__ORIGINAL                                              decimal(22, 4) NULL
, EMPLOYED_TOTAL_MALES__TREND                                                   decimal(22, 4) NULL
, EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED                                     decimal(22, 4) NULL
, EMPLOYED_TOTAL_MALES__ORIGINAL                                                decimal(22, 4) NULL
, EMPLOYED_TOTAL_FEMALES__TREND                                                 decimal(22, 4) NULL
, EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
, EMPLOYED_TOTAL_FEMALES__ORIGINAL                                              decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_PERSONS__TREND                                             decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_MALES__TREND                                               decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_MALES__ORIGINAL                                            decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_FEMALES__TREND                                             decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
, EMPLOYED_FULL_TIME_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
, EMPLOYED_PART_TIME_PERSONS__TREND                                             decimal(22, 4) NULL
, EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
, EMPLOYED_PART_TIME_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
, EMPLOYED_PART_TIME_MALES__TREND                                               decimal(22, 4) NULL
, EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
, EMPLOYED_PART_TIME_MALES__ORIGINAL                                            decimal(22, 4) NULL
, EMPLOYED_PART_TIME_FEMALES__TREND                                             decimal(22, 4) NULL
, EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
, EMPLOYED_PART_TIME_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND                                 decimal(12, 9) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED                   decimal(12, 9) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL                              decimal(12, 9) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND                                   decimal(12, 9) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED                     decimal(12, 9) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL                                decimal(12, 9) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND                                 decimal(12, 9) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED                   decimal(12, 9) NULL
, EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL                              decimal(12, 9) NULL
, UNEMPLOYED_TOTAL_PERSONS__TREND                                               decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                            decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_MALES__TREND                                                 decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_MALES__ORIGINAL                                              decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_FEMALES__TREND                                               decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
, UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                            decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND                           decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED             decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL                        decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND                             decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED               decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL                          decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND                           decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED             decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL                        decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND                      decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED        decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL                   decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND                        decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED          decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL                     decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND                      decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED        decimal(22, 4) NULL
, UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL                   decimal(22, 4) NULL
, UNEMPLOYMENT_RATE_PERSONS__TREND                                              decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED                                decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                           decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_MALES__TREND                                                decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED                                  decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_MALES__ORIGINAL                                             decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_FEMALES__TREND                                              decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED                                decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                           decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND                    decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED      decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL                 decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND                      decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED        decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL                   decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND                    decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED      decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL                 decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND               decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL            decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND                 decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED   decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL              decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND               decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED decimal(12, 9) NULL
, UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL            decimal(12, 9) NULL
, LABOUR_FORCE_TOTAL_PERSONS__TREND                                             decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_MALES__TREND                                               decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                            decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_FEMALES__TREND                                             decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
, LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
, PARTICIPATION_RATE_PERSONS__TREND                                             decimal(12, 9) NULL
, PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED                               decimal(12, 9) NULL
, PARTICIPATION_RATE_PERSONS__ORIGINAL                                          decimal(12, 9) NULL
, PARTICIPATION_RATE_MALES__TREND                                               decimal(12, 9) NULL
, PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED                                 decimal(12, 9) NULL
, PARTICIPATION_RATE_MALES__ORIGINAL                                            decimal(12, 9) NULL
, PARTICIPATION_RATE_FEMALES__TREND                                             decimal(12, 9) NULL
, PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED                               decimal(12, 9) NULL
, PARTICIPATION_RATE_FEMALES__ORIGINAL                                          decimal(12, 9) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL                                decimal(22, 4) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL                                  decimal(22, 4) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL                                decimal(22, 4) NULL
, CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL                  decimal(22, 4) NULL
, CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL                    decimal(22, 4) NULL
, CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL                  decimal(22, 4) NULL
);

CREATE UNIQUE INDEX ix_f_dtl_labour_force_status_actual_m ON ltn.dbo.f_dtl_labour_force_status_actual_m(RPT_PERIOD_ID, CAPTURE_PERIOD_ID);

ALTER TABLE ltn.dbo.f_dtl_labour_force_status_actual_m REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================

DATA PREP FROM SPREADSHEET FILES

INSERT INTO LTN.DBO.F_DTL_LABOUR_FORCE_STATUS_ACTUAL_M ( RPT_PERIOD_ID
                                                       , CAPTURE_PERIOD_ID
                                                       , CAPTURE_PERIOD
                                                       , CNTRY_CDE
                                                       , SITE_CDE
                                                       , EMPLOYED_TOTAL_PERSONS__TREND
                                                       , EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_TOTAL_PERSONS__ORIGINAL
                                                       , EMPLOYED_TOTAL_MALES__TREND
                                                       , EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_TOTAL_MALES__ORIGINAL
                                                       , EMPLOYED_TOTAL_FEMALES__TREND
                                                       , EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_TOTAL_FEMALES__ORIGINAL
                                                       , EMPLOYED_FULL_TIME_PERSONS__TREND
                                                       , EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
                                                       , EMPLOYED_FULL_TIME_MALES__TREND
                                                       , EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_FULL_TIME_MALES__ORIGINAL
                                                       , EMPLOYED_FULL_TIME_FEMALES__TREND
                                                       , EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
                                                       , EMPLOYED_PART_TIME_PERSONS__TREND
                                                       , EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_PART_TIME_PERSONS__ORIGINAL
                                                       , EMPLOYED_PART_TIME_MALES__TREND
                                                       , EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_PART_TIME_MALES__ORIGINAL
                                                       , EMPLOYED_PART_TIME_FEMALES__TREND
                                                       , EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
                                                       , EMPLOYED_PART_TIME_FEMALES__ORIGINAL
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
                                                       , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
                                                       , UNEMPLOYED_TOTAL_PERSONS__TREND
                                                       , UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
                                                       , UNEMPLOYED_TOTAL_MALES__TREND
                                                       , UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_TOTAL_MALES__ORIGINAL
                                                       , UNEMPLOYED_TOTAL_FEMALES__TREND
                                                       , UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_PERSONS__TREND
                                                       , UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_MALES__TREND
                                                       , UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_MALES__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_FEMALES__TREND
                                                       , UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
                                                       , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
                                                       , LABOUR_FORCE_TOTAL_PERSONS__TREND
                                                       , LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
                                                       , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
                                                       , LABOUR_FORCE_TOTAL_MALES__TREND
                                                       , LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
                                                       , LABOUR_FORCE_TOTAL_MALES__ORIGINAL
                                                       , LABOUR_FORCE_TOTAL_FEMALES__TREND
                                                       , LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
                                                       , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
                                                       , PARTICIPATION_RATE_PERSONS__TREND
                                                       , PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
                                                       , PARTICIPATION_RATE_PERSONS__ORIGINAL
                                                       , PARTICIPATION_RATE_MALES__TREND
                                                       , PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
                                                       , PARTICIPATION_RATE_MALES__ORIGINAL
                                                       , PARTICIPATION_RATE_FEMALES__TREND
                                                       , PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
                                                       , PARTICIPATION_RATE_FEMALES__ORIGINAL
                                                       , NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
                                                       , NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
                                                       , NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
                                                       , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
                                                       , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
                                                       , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
                                                       )
SELECT TMP.RPT_PERIOD_ID
     , convert( varchar(10), cast(TMP.CAPTURE_PERIOD AS date), 112) AS CAPTURE_PERIOD_ID
     , TMP.CAPTURE_PERIOD
     , 'AU' AS CNTRY_CDE
     , 'ABS' AS SITE_CDE
     , cast(cast(TMP.EMPLOYED_TOTAL_PERSONS__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_TOTAL_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_TOTAL_MALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_TOTAL_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_TOTAL_FEMALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_TOTAL_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_PERSONS__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_MALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_FEMALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_FULL_TIME_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_PERSONS__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_MALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_FEMALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYED_PART_TIME_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_PERSONS__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_MALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_FEMALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_TOTAL_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_PERSONS__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_PERSONS__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_MALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_MALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_FEMALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_FEMALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_PERSONS__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_MALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_FEMALES__TREND AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.PARTICIPATION_RATE_PERSONS__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.PARTICIPATION_RATE_PERSONS__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.PARTICIPATION_RATE_MALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.PARTICIPATION_RATE_MALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.PARTICIPATION_RATE_FEMALES__TREND AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.PARTICIPATION_RATE_FEMALES__ORIGINAL AS    numeric(22, 7)) / 100 AS decimal(12, 9))
     , cast(cast(TMP.NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
     , cast(cast(TMP.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL AS    numeric(22, 7)) * 1000 AS decimal(22, 4))
  FROM LTN.DBO.TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M AS TMP
 WHERE 1 = 1
 ORDER BY 2;

=======================================================================================================================================================================================================

exec create_f_dtl_labour_force_status_actual_m @p_env = 'PROD', @p_task_nme = '', @p_pkg_nme = ''

*/


USE [ltn]
GO

IF OBJECT_ID('create_f_dtl_labour_force_status_actual_m') IS NULL -- Check if SP Exists
 EXEC('CREATE PROCEDURE create_f_dtl_labour_force_status_actual_m AS SET NOCOUNT ON;') -- Create dummy/empty SP
GO
                
alter procedure create_f_dtl_labour_force_status_actual_m -- Alter the SP Always
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
      
set @l_tbl_nme = 'f_dtl_labour_force_status_actual_m';
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
drop table #TMP_DTL_LABOUR_FORCE_STATUS_M
*/ 
	   CREATE TABLE #TMP_DTL_LABOUR_FORCE_STATUS_M
	   ( MSMT_DTE_ID                                                                   integer NOT NULL
	   , CAPTURE_PERIOD_ID                                                             integer NOT NULL
	   , CAPTURE_PERIOD                                                                date NOT NULL
	   , CNTRY_CDE                                                                     varchar(2) NOT NULL
	   , SITE_CDE                                                                      varchar(20) NOT NULL
	   , EMPLOYED_TOTAL_PERSONS__TREND                                                 decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_PERSONS__ORIGINAL                                              decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_MALES__TREND                                                   decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED                                     decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_MALES__ORIGINAL                                                decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_FEMALES__TREND                                                 decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_FEMALES__ORIGINAL                                              decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_PERSONS__TREND                                             decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_MALES__TREND                                               decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_MALES__ORIGINAL                                            decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_FEMALES__TREND                                             decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_PERSONS__TREND                                             decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_MALES__TREND                                               decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_MALES__ORIGINAL                                            decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_FEMALES__TREND                                             decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND                                 decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED                   decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL                              decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND                                   decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED                     decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL                                decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND                                 decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED                   decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL                              decimal(12, 9) NULL
	   , UNEMPLOYED_TOTAL_PERSONS__TREND                                               decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                            decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_MALES__TREND                                                 decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_MALES__ORIGINAL                                              decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_FEMALES__TREND                                               decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                            decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND                           decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED             decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL                        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND                             decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED               decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL                          decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND                           decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED             decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL                        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND                      decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL                   decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND                        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED          decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL                     decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND                      decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL                   decimal(22, 4) NULL
	   , UNEMPLOYMENT_RATE_PERSONS__TREND                                              decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED                                decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                           decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_MALES__TREND                                                decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED                                  decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_MALES__ORIGINAL                                             decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_FEMALES__TREND                                              decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED                                decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                           decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND                    decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED      decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL                 decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND                      decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED        decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL                   decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND                    decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED      decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL                 decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND               decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL            decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND                 decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED   decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL              decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND               decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL            decimal(12, 9) NULL
	   , LABOUR_FORCE_TOTAL_PERSONS__TREND                                             decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_MALES__TREND                                               decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                            decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_FEMALES__TREND                                             decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
	   , PARTICIPATION_RATE_PERSONS__TREND                                             decimal(12, 9) NULL
	   , PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED                               decimal(12, 9) NULL
	   , PARTICIPATION_RATE_PERSONS__ORIGINAL                                          decimal(12, 9) NULL
	   , PARTICIPATION_RATE_MALES__TREND                                               decimal(12, 9) NULL
	   , PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED                                 decimal(12, 9) NULL
	   , PARTICIPATION_RATE_MALES__ORIGINAL                                            decimal(12, 9) NULL
	   , PARTICIPATION_RATE_FEMALES__TREND                                             decimal(12, 9) NULL
	   , PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED                               decimal(12, 9) NULL
	   , PARTICIPATION_RATE_FEMALES__ORIGINAL                                          decimal(12, 9) NULL
	   , NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL                                decimal(22, 4) NULL
	   , NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL                                  decimal(22, 4) NULL
	   , NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL                                decimal(22, 4) NULL
	   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL                  decimal(22, 4) NULL
	   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL                    decimal(22, 4) NULL
	   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL                  decimal(22, 4) NULL
	   , STARTED_AT                                                                    varchar(20) NOT NULL
	   , FINISHED_AT                                                                   varchar(20) NOT NULL
	   );

	   INSERT INTO #TMP_DTL_LABOUR_FORCE_STATUS_M ( MSMT_DTE_ID
										 , CAPTURE_PERIOD_ID
										 , CAPTURE_PERIOD
										 , CNTRY_CDE
										 , SITE_CDE
										 , EMPLOYED_TOTAL_PERSONS__TREND
										 , EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
										 , EMPLOYED_TOTAL_PERSONS__ORIGINAL
										 , EMPLOYED_TOTAL_MALES__TREND
										 , EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
										 , EMPLOYED_TOTAL_MALES__ORIGINAL
										 , EMPLOYED_TOTAL_FEMALES__TREND
										 , EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
										 , EMPLOYED_TOTAL_FEMALES__ORIGINAL
										 , EMPLOYED_FULL_TIME_PERSONS__TREND
										 , EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
										 , EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
										 , EMPLOYED_FULL_TIME_MALES__TREND
										 , EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
										 , EMPLOYED_FULL_TIME_MALES__ORIGINAL
										 , EMPLOYED_FULL_TIME_FEMALES__TREND
										 , EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
										 , EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
										 , EMPLOYED_PART_TIME_PERSONS__TREND
										 , EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
										 , EMPLOYED_PART_TIME_PERSONS__ORIGINAL
										 , EMPLOYED_PART_TIME_MALES__TREND
										 , EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
										 , EMPLOYED_PART_TIME_MALES__ORIGINAL
										 , EMPLOYED_PART_TIME_FEMALES__TREND
										 , EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
										 , EMPLOYED_PART_TIME_FEMALES__ORIGINAL
										 , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
										 , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
										 , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
										 , EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
										 , EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
										 , EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
										 , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
										 , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
										 , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
										 , UNEMPLOYED_TOTAL_PERSONS__TREND
										 , UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
										 , UNEMPLOYED_TOTAL_MALES__TREND
										 , UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_TOTAL_MALES__ORIGINAL
										 , UNEMPLOYED_TOTAL_FEMALES__TREND
										 , UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
										 , UNEMPLOYMENT_RATE_PERSONS__TREND
										 , UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
										 , UNEMPLOYMENT_RATE_MALES__TREND
										 , UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_MALES__ORIGINAL
										 , UNEMPLOYMENT_RATE_FEMALES__TREND
										 , UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
										 , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
										 , LABOUR_FORCE_TOTAL_PERSONS__TREND
										 , LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
										 , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
										 , LABOUR_FORCE_TOTAL_MALES__TREND
										 , LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
										 , LABOUR_FORCE_TOTAL_MALES__ORIGINAL
										 , LABOUR_FORCE_TOTAL_FEMALES__TREND
										 , LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
										 , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
										 , PARTICIPATION_RATE_PERSONS__TREND
										 , PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
										 , PARTICIPATION_RATE_PERSONS__ORIGINAL
										 , PARTICIPATION_RATE_MALES__TREND
										 , PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
										 , PARTICIPATION_RATE_MALES__ORIGINAL
										 , PARTICIPATION_RATE_FEMALES__TREND
										 , PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
										 , PARTICIPATION_RATE_FEMALES__ORIGINAL
										 , NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
										 , NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
										 , NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
										 , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
										 , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
										 , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
										 , STARTED_AT
										 , FINISHED_AT
										 )
	   SELECT MSMT_DTE_ID
	        , convert(varchar(10), cast(CAPTURE_PERIOD AS date), 112) as CAPTURE_PERIOD_ID
		   , CAPTURE_PERIOD
		   , CNTRY_CDE
		   , SITE_CDE
		   , EMPLOYED_TOTAL_PERSONS__TREND
		   , EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
		   , EMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , EMPLOYED_TOTAL_MALES__TREND
		   , EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
		   , EMPLOYED_TOTAL_MALES__ORIGINAL
		   , EMPLOYED_TOTAL_FEMALES__TREND
		   , EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
		   , EMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , EMPLOYED_FULL_TIME_PERSONS__TREND
		   , EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
		   , EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
		   , EMPLOYED_FULL_TIME_MALES__TREND
		   , EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
		   , EMPLOYED_FULL_TIME_MALES__ORIGINAL
		   , EMPLOYED_FULL_TIME_FEMALES__TREND
		   , EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
		   , EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
		   , EMPLOYED_PART_TIME_PERSONS__TREND
		   , EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
		   , EMPLOYED_PART_TIME_PERSONS__ORIGINAL
		   , EMPLOYED_PART_TIME_MALES__TREND
		   , EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
		   , EMPLOYED_PART_TIME_MALES__ORIGINAL
		   , EMPLOYED_PART_TIME_FEMALES__TREND
		   , EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
		   , EMPLOYED_PART_TIME_FEMALES__ORIGINAL
		   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
		   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
		   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
		   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
		   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
		   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
		   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
		   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
		   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
		   , UNEMPLOYED_TOTAL_PERSONS__TREND
		   , UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
		   , UNEMPLOYED_TOTAL_MALES__TREND
		   , UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_TOTAL_MALES__ORIGINAL
		   , UNEMPLOYED_TOTAL_FEMALES__TREND
		   , UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
		   , UNEMPLOYMENT_RATE_PERSONS__TREND
		   , UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
		   , UNEMPLOYMENT_RATE_MALES__TREND
		   , UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_MALES__ORIGINAL
		   , UNEMPLOYMENT_RATE_FEMALES__TREND
		   , UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
		   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
		   , LABOUR_FORCE_TOTAL_PERSONS__TREND
		   , LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
		   , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
		   , LABOUR_FORCE_TOTAL_MALES__TREND
		   , LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
		   , LABOUR_FORCE_TOTAL_MALES__ORIGINAL
		   , LABOUR_FORCE_TOTAL_FEMALES__TREND
		   , LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
		   , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
		   , PARTICIPATION_RATE_PERSONS__TREND
		   , PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
		   , PARTICIPATION_RATE_PERSONS__ORIGINAL
		   , PARTICIPATION_RATE_MALES__TREND
		   , PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
		   , PARTICIPATION_RATE_MALES__ORIGINAL
		   , PARTICIPATION_RATE_FEMALES__TREND
		   , PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
		   , PARTICIPATION_RATE_FEMALES__ORIGINAL
		   , NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
		   , NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
		   , NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
		   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
		   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
		   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
		   , STARTED_AT
		   , FINISHED_AT
		FROM openquery(PY_WEB_DATA, '
					    SELECT  DAT.MSMT_DTE_ID
							 ,DAT.CAPTURE_PERIOD
							 ,DAT.CNTRY_CDE
							 ,DAT.SITE_CDE
							 ,DAT.EMPLOYED_TOTAL_PERSONS__TREND
							 ,DAT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_TOTAL_PERSONS__ORIGINAL
							 ,DAT.EMPLOYED_TOTAL_MALES__TREND
							 ,DAT.EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_TOTAL_MALES__ORIGINAL
							 ,DAT.EMPLOYED_TOTAL_FEMALES__TREND
							 ,DAT.EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_TOTAL_FEMALES__ORIGINAL
							 ,DAT.EMPLOYED_FULL_TIME_PERSONS__TREND
							 ,DAT.EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
							 ,DAT.EMPLOYED_FULL_TIME_MALES__TREND
							 ,DAT.EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_FULL_TIME_MALES__ORIGINAL
							 ,DAT.EMPLOYED_FULL_TIME_FEMALES__TREND
							 ,DAT.EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
							 ,DAT.EMPLOYED_PART_TIME_PERSONS__TREND
							 ,DAT.EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_PART_TIME_PERSONS__ORIGINAL
							 ,DAT.EMPLOYED_PART_TIME_MALES__TREND
							 ,DAT.EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_PART_TIME_MALES__ORIGINAL
							 ,DAT.EMPLOYED_PART_TIME_FEMALES__TREND
							 ,DAT.EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYED_PART_TIME_FEMALES__ORIGINAL
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
							 ,DAT.UNEMPLOYED_TOTAL_PERSONS__TREND
							 ,DAT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
							 ,DAT.UNEMPLOYED_TOTAL_MALES__TREND
							 ,DAT.UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_TOTAL_MALES__ORIGINAL
							 ,DAT.UNEMPLOYED_TOTAL_FEMALES__TREND
							 ,DAT.UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_PERSONS__TREND
							 ,DAT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_MALES__TREND
							 ,DAT.UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_MALES__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_FEMALES__TREND
							 ,DAT.UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
							 ,DAT.LABOUR_FORCE_TOTAL_PERSONS__TREND
							 ,DAT.LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
							 ,DAT.LABOUR_FORCE_TOTAL_MALES__TREND
							 ,DAT.LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
							 ,DAT.LABOUR_FORCE_TOTAL_MALES__ORIGINAL
							 ,DAT.LABOUR_FORCE_TOTAL_FEMALES__TREND
							 ,DAT.LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
							 ,DAT.PARTICIPATION_RATE_PERSONS__TREND
							 ,DAT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
							 ,DAT.PARTICIPATION_RATE_PERSONS__ORIGINAL
							 ,DAT.PARTICIPATION_RATE_MALES__TREND
							 ,DAT.PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
							 ,DAT.PARTICIPATION_RATE_MALES__ORIGINAL
							 ,DAT.PARTICIPATION_RATE_FEMALES__TREND
							 ,DAT.PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
							 ,DAT.PARTICIPATION_RATE_FEMALES__ORIGINAL
							 ,DAT.NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
							 ,DAT.NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
							 ,DAT.NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
							 ,DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
							 ,DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
							 ,DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
							 ,DAT.STARTED_AT
							 ,DAT.FINISHED_AT
						  FROM PY_LABOUR_FORCE_AU_STATUS AS DAT');


/*
STEP 2
---------------------------------------------------------------------------------------------------
** determine most recent 2 periods

drop table #TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M

select * from #TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M
*/ 
	   CREATE TABLE #TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M
	   ( CAPTURE_PERIOD_ID                                                             integer NOT NULL
	   , CAPTURE_PERIOD                                                                date NOT NULL
	   , CNTRY_CDE                                                                     varchar(2) NOT NULL
	   , SITE_CDE                                                                      varchar(20) NOT NULL
	   , EMPLOYED_TOTAL_PERSONS__TREND                                                 decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_PERSONS__ORIGINAL                                              decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_MALES__TREND                                                   decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED                                     decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_MALES__ORIGINAL                                                decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_FEMALES__TREND                                                 decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
	   , EMPLOYED_TOTAL_FEMALES__ORIGINAL                                              decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_PERSONS__TREND                                             decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_MALES__TREND                                               decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_MALES__ORIGINAL                                            decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_FEMALES__TREND                                             decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , EMPLOYED_FULL_TIME_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_PERSONS__TREND                                             decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_MALES__TREND                                               decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_MALES__ORIGINAL                                            decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_FEMALES__TREND                                             decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , EMPLOYED_PART_TIME_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND                                 decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED                   decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL                              decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND                                   decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED                     decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL                                decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND                                 decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED                   decimal(12, 9) NULL
	   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL                              decimal(12, 9) NULL
	   , UNEMPLOYED_TOTAL_PERSONS__TREND                                               decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                            decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_MALES__TREND                                                 decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED                                   decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_MALES__ORIGINAL                                              decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_FEMALES__TREND                                               decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                            decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND                           decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED             decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL                        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND                             decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED               decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL                          decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND                           decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED             decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL                        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND                      decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL                   decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND                        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED          decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL                     decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND                      decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED        decimal(22, 4) NULL
	   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL                   decimal(22, 4) NULL
	   , UNEMPLOYMENT_RATE_PERSONS__TREND                                              decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED                                decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                           decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_MALES__TREND                                                decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED                                  decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_MALES__ORIGINAL                                             decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_FEMALES__TREND                                              decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED                                decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                           decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND                    decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED      decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL                 decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND                      decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED        decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL                   decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND                    decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED      decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL                 decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND               decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL            decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND                 decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED   decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL              decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND               decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED decimal(12, 9) NULL
	   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL            decimal(12, 9) NULL
	   , LABOUR_FORCE_TOTAL_PERSONS__TREND                                             decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                          decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_MALES__TREND                                               decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED                                 decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                            decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_FEMALES__TREND                                             decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED                               decimal(22, 4) NULL
	   , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                          decimal(22, 4) NULL
	   , PARTICIPATION_RATE_PERSONS__TREND                                             decimal(12, 9) NULL
	   , PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED                               decimal(12, 9) NULL
	   , PARTICIPATION_RATE_PERSONS__ORIGINAL                                          decimal(12, 9) NULL
	   , PARTICIPATION_RATE_MALES__TREND                                               decimal(12, 9) NULL
	   , PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED                                 decimal(12, 9) NULL
	   , PARTICIPATION_RATE_MALES__ORIGINAL                                            decimal(12, 9) NULL
	   , PARTICIPATION_RATE_FEMALES__TREND                                             decimal(12, 9) NULL
	   , PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED                               decimal(12, 9) NULL
	   , PARTICIPATION_RATE_FEMALES__ORIGINAL                                          decimal(12, 9) NULL
	   , NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL                                decimal(22, 4) NULL
	   , NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL                                  decimal(22, 4) NULL
	   , NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL                                decimal(22, 4) NULL
	   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL                  decimal(22, 4) NULL
	   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL                    decimal(22, 4) NULL
	   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL                  decimal(22, 4) NULL
	   );

	   WITH DTES
		   AS (SELECT DAT.CAPTURE_PERIOD_ID
			    FROM (
				    SELECT rank() OVER(PARTITION BY 1 ORDER BY CAPTURE_PERIOD_ID DESC) AS RNK_CAPTURE_PERIOD_ID
					    , DTE.CAPTURE_PERIOD_ID
					 FROM #TMP_DTL_LABOUR_FORCE_STATUS_M AS DTE
				    ) AS DAT
			   WHERE 1 = 1
				    AND DAT.RNK_CAPTURE_PERIOD_ID <= 2)
		   INSERT INTO #TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M ( CAPTURE_PERIOD_ID
												   , CAPTURE_PERIOD
												   , CNTRY_CDE
												   , SITE_CDE
												   , EMPLOYED_TOTAL_PERSONS__TREND
												   , EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
												   , EMPLOYED_TOTAL_PERSONS__ORIGINAL
												   , EMPLOYED_TOTAL_MALES__TREND
												   , EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
												   , EMPLOYED_TOTAL_MALES__ORIGINAL
												   , EMPLOYED_TOTAL_FEMALES__TREND
												   , EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
												   , EMPLOYED_TOTAL_FEMALES__ORIGINAL
												   , EMPLOYED_FULL_TIME_PERSONS__TREND
												   , EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
												   , EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
												   , EMPLOYED_FULL_TIME_MALES__TREND
												   , EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
												   , EMPLOYED_FULL_TIME_MALES__ORIGINAL
												   , EMPLOYED_FULL_TIME_FEMALES__TREND
												   , EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
												   , EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
												   , EMPLOYED_PART_TIME_PERSONS__TREND
												   , EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
												   , EMPLOYED_PART_TIME_PERSONS__ORIGINAL
												   , EMPLOYED_PART_TIME_MALES__TREND
												   , EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
												   , EMPLOYED_PART_TIME_MALES__ORIGINAL
												   , EMPLOYED_PART_TIME_FEMALES__TREND
												   , EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
												   , EMPLOYED_PART_TIME_FEMALES__ORIGINAL
												   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
												   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
												   , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
												   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
												   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
												   , EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
												   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
												   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
												   , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
												   , UNEMPLOYED_TOTAL_PERSONS__TREND
												   , UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
												   , UNEMPLOYED_TOTAL_MALES__TREND
												   , UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_TOTAL_MALES__ORIGINAL
												   , UNEMPLOYED_TOTAL_FEMALES__TREND
												   , UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
												   , UNEMPLOYMENT_RATE_PERSONS__TREND
												   , UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
												   , UNEMPLOYMENT_RATE_MALES__TREND
												   , UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_MALES__ORIGINAL
												   , UNEMPLOYMENT_RATE_FEMALES__TREND
												   , UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
												   , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
												   , LABOUR_FORCE_TOTAL_PERSONS__TREND
												   , LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
												   , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
												   , LABOUR_FORCE_TOTAL_MALES__TREND
												   , LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
												   , LABOUR_FORCE_TOTAL_MALES__ORIGINAL
												   , LABOUR_FORCE_TOTAL_FEMALES__TREND
												   , LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
												   , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
												   , PARTICIPATION_RATE_PERSONS__TREND
												   , PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
												   , PARTICIPATION_RATE_PERSONS__ORIGINAL
												   , PARTICIPATION_RATE_MALES__TREND
												   , PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
												   , PARTICIPATION_RATE_MALES__ORIGINAL
												   , PARTICIPATION_RATE_FEMALES__TREND
												   , PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
												   , PARTICIPATION_RATE_FEMALES__ORIGINAL
												   , NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
												   , NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
												   , NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
												   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
												   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
												   , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
												   )
		   SELECT DAT.CAPTURE_PERIOD_ID
			   , DAT.CAPTURE_PERIOD
			   , DAT.CNTRY_CDE
			   , DAT.SITE_CDE
			   , DAT.EMPLOYED_TOTAL_PERSONS__TREND
			   , DAT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_TOTAL_PERSONS__ORIGINAL
			   , DAT.EMPLOYED_TOTAL_MALES__TREND
			   , DAT.EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_TOTAL_MALES__ORIGINAL
			   , DAT.EMPLOYED_TOTAL_FEMALES__TREND
			   , DAT.EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_TOTAL_FEMALES__ORIGINAL
			   , DAT.EMPLOYED_FULL_TIME_PERSONS__TREND
			   , DAT.EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
			   , DAT.EMPLOYED_FULL_TIME_MALES__TREND
			   , DAT.EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_FULL_TIME_MALES__ORIGINAL
			   , DAT.EMPLOYED_FULL_TIME_FEMALES__TREND
			   , DAT.EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
			   , DAT.EMPLOYED_PART_TIME_PERSONS__TREND
			   , DAT.EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_PART_TIME_PERSONS__ORIGINAL
			   , DAT.EMPLOYED_PART_TIME_MALES__TREND
			   , DAT.EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_PART_TIME_MALES__ORIGINAL
			   , DAT.EMPLOYED_PART_TIME_FEMALES__TREND
			   , DAT.EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYED_PART_TIME_FEMALES__ORIGINAL
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
			   , DAT.UNEMPLOYED_TOTAL_PERSONS__TREND
			   , DAT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
			   , DAT.UNEMPLOYED_TOTAL_MALES__TREND
			   , DAT.UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_TOTAL_MALES__ORIGINAL
			   , DAT.UNEMPLOYED_TOTAL_FEMALES__TREND
			   , DAT.UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_PERSONS__TREND
			   , DAT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_MALES__TREND
			   , DAT.UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_MALES__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_FEMALES__TREND
			   , DAT.UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
			   , DAT.LABOUR_FORCE_TOTAL_PERSONS__TREND
			   , DAT.LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
			   , DAT.LABOUR_FORCE_TOTAL_MALES__TREND
			   , DAT.LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
			   , DAT.LABOUR_FORCE_TOTAL_MALES__ORIGINAL
			   , DAT.LABOUR_FORCE_TOTAL_FEMALES__TREND
			   , DAT.LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
			   , DAT.PARTICIPATION_RATE_PERSONS__TREND
			   , DAT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
			   , DAT.PARTICIPATION_RATE_PERSONS__ORIGINAL
			   , DAT.PARTICIPATION_RATE_MALES__TREND
			   , DAT.PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
			   , DAT.PARTICIPATION_RATE_MALES__ORIGINAL
			   , DAT.PARTICIPATION_RATE_FEMALES__TREND
			   , DAT.PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
			   , DAT.PARTICIPATION_RATE_FEMALES__ORIGINAL
			   , DAT.NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
			   , DAT.NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
			   , DAT.NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
			   , DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
			   , DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
			   , DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
			FROM #TMP_DTL_LABOUR_FORCE_STATUS_M AS DAT
				INNER JOIN DTES
				ON DAT.CAPTURE_PERIOD_ID = DTES.CAPTURE_PERIOD_ID
		    WHERE 1 = 1;


/*
STEP 3 
---------------------------------------------------------------------------------------------------
** calculate missing rpt_period_id
** insert into destination table only of rpt_period_id doesnt already exist

select * from #TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M
select * from #TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M
*/

		  INSERT INTO LTN.DBO.F_DTL_LABOUR_FORCE_STATUS_ACTUAL_M ( RPT_PERIOD_ID
													  , CAPTURE_PERIOD_ID
													  , CAPTURE_PERIOD
													  , CNTRY_CDE
													  , SITE_CDE
													  , EMPLOYED_TOTAL_PERSONS__TREND
													  , EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
													  , EMPLOYED_TOTAL_PERSONS__ORIGINAL
													  , EMPLOYED_TOTAL_MALES__TREND
													  , EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
													  , EMPLOYED_TOTAL_MALES__ORIGINAL
													  , EMPLOYED_TOTAL_FEMALES__TREND
													  , EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
													  , EMPLOYED_TOTAL_FEMALES__ORIGINAL
													  , EMPLOYED_FULL_TIME_PERSONS__TREND
													  , EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
													  , EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
													  , EMPLOYED_FULL_TIME_MALES__TREND
													  , EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
													  , EMPLOYED_FULL_TIME_MALES__ORIGINAL
													  , EMPLOYED_FULL_TIME_FEMALES__TREND
													  , EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
													  , EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
													  , EMPLOYED_PART_TIME_PERSONS__TREND
													  , EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
													  , EMPLOYED_PART_TIME_PERSONS__ORIGINAL
													  , EMPLOYED_PART_TIME_MALES__TREND
													  , EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
													  , EMPLOYED_PART_TIME_MALES__ORIGINAL
													  , EMPLOYED_PART_TIME_FEMALES__TREND
													  , EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
													  , EMPLOYED_PART_TIME_FEMALES__ORIGINAL
													  , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
													  , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
													  , EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
													  , EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
													  , EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
													  , EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
													  , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
													  , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
													  , EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
													  , UNEMPLOYED_TOTAL_PERSONS__TREND
													  , UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
													  , UNEMPLOYED_TOTAL_MALES__TREND
													  , UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_TOTAL_MALES__ORIGINAL
													  , UNEMPLOYED_TOTAL_FEMALES__TREND
													  , UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
													  , UNEMPLOYMENT_RATE_PERSONS__TREND
													  , UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
													  , UNEMPLOYMENT_RATE_MALES__TREND
													  , UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_MALES__ORIGINAL
													  , UNEMPLOYMENT_RATE_FEMALES__TREND
													  , UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
													  , UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
													  , LABOUR_FORCE_TOTAL_PERSONS__TREND
													  , LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
													  , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
													  , LABOUR_FORCE_TOTAL_MALES__TREND
													  , LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
													  , LABOUR_FORCE_TOTAL_MALES__ORIGINAL
													  , LABOUR_FORCE_TOTAL_FEMALES__TREND
													  , LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
													  , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
													  , PARTICIPATION_RATE_PERSONS__TREND
													  , PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
													  , PARTICIPATION_RATE_PERSONS__ORIGINAL
													  , PARTICIPATION_RATE_MALES__TREND
													  , PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
													  , PARTICIPATION_RATE_MALES__ORIGINAL
													  , PARTICIPATION_RATE_FEMALES__TREND
													  , PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
													  , PARTICIPATION_RATE_FEMALES__ORIGINAL
													  , NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
													  , NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
													  , NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
													  , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
													  , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
													  , CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
													  )
		  SELECT DAT.RPT_PERIOD_ID
			  , DAT.CAPTURE_PERIOD_ID
			  , DAT.CAPTURE_PERIOD
			  , DAT.CNTRY_CDE
			  , DAT.SITE_CDE
			  , DAT.EMPLOYED_TOTAL_PERSONS__TREND
			  , DAT.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_TOTAL_PERSONS__ORIGINAL
			  , DAT.EMPLOYED_TOTAL_MALES__TREND
			  , DAT.EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_TOTAL_MALES__ORIGINAL
			  , DAT.EMPLOYED_TOTAL_FEMALES__TREND
			  , DAT.EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_TOTAL_FEMALES__ORIGINAL
			  , DAT.EMPLOYED_FULL_TIME_PERSONS__TREND
			  , DAT.EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
			  , DAT.EMPLOYED_FULL_TIME_MALES__TREND
			  , DAT.EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_FULL_TIME_MALES__ORIGINAL
			  , DAT.EMPLOYED_FULL_TIME_FEMALES__TREND
			  , DAT.EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
			  , DAT.EMPLOYED_PART_TIME_PERSONS__TREND
			  , DAT.EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_PART_TIME_PERSONS__ORIGINAL
			  , DAT.EMPLOYED_PART_TIME_MALES__TREND
			  , DAT.EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_PART_TIME_MALES__ORIGINAL
			  , DAT.EMPLOYED_PART_TIME_FEMALES__TREND
			  , DAT.EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYED_PART_TIME_FEMALES__ORIGINAL
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
			  , DAT.UNEMPLOYED_TOTAL_PERSONS__TREND
			  , DAT.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
			  , DAT.UNEMPLOYED_TOTAL_MALES__TREND
			  , DAT.UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_TOTAL_MALES__ORIGINAL
			  , DAT.UNEMPLOYED_TOTAL_FEMALES__TREND
			  , DAT.UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_PERSONS__TREND
			  , DAT.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_MALES__TREND
			  , DAT.UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_MALES__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_FEMALES__TREND
			  , DAT.UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
			  , DAT.LABOUR_FORCE_TOTAL_PERSONS__TREND
			  , DAT.LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
			  , DAT.LABOUR_FORCE_TOTAL_MALES__TREND
			  , DAT.LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
			  , DAT.LABOUR_FORCE_TOTAL_MALES__ORIGINAL
			  , DAT.LABOUR_FORCE_TOTAL_FEMALES__TREND
			  , DAT.LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
			  , DAT.PARTICIPATION_RATE_PERSONS__TREND
			  , DAT.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
			  , DAT.PARTICIPATION_RATE_PERSONS__ORIGINAL
			  , DAT.PARTICIPATION_RATE_MALES__TREND
			  , DAT.PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
			  , DAT.PARTICIPATION_RATE_MALES__ORIGINAL
			  , DAT.PARTICIPATION_RATE_FEMALES__TREND
			  , DAT.PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
			  , DAT.PARTICIPATION_RATE_FEMALES__ORIGINAL
			  , DAT.NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
			  , DAT.NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
			  , DAT.NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
			  , DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
			  , DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
			  , DAT.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
		    FROM (
			    SELECT left(max(TMP.CAPTURE_PERIOD_ID) OVER(PARTITION BY 1), 6) AS RPT_PERIOD_ID
				    , TMP.CAPTURE_PERIOD_ID
				    , TMP.CAPTURE_PERIOD
				    , TMP.CNTRY_CDE
				    , TMP.SITE_CDE
				    , TMP.EMPLOYED_TOTAL_PERSONS__TREND
				    , TMP.EMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_TOTAL_PERSONS__ORIGINAL
				    , TMP.EMPLOYED_TOTAL_MALES__TREND
				    , TMP.EMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_TOTAL_MALES__ORIGINAL
				    , TMP.EMPLOYED_TOTAL_FEMALES__TREND
				    , TMP.EMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_TOTAL_FEMALES__ORIGINAL
				    , TMP.EMPLOYED_FULL_TIME_PERSONS__TREND
				    , TMP.EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_FULL_TIME_PERSONS__ORIGINAL
				    , TMP.EMPLOYED_FULL_TIME_MALES__TREND
				    , TMP.EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_FULL_TIME_MALES__ORIGINAL
				    , TMP.EMPLOYED_FULL_TIME_FEMALES__TREND
				    , TMP.EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_FULL_TIME_FEMALES__ORIGINAL
				    , TMP.EMPLOYED_PART_TIME_PERSONS__TREND
				    , TMP.EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_PART_TIME_PERSONS__ORIGINAL
				    , TMP.EMPLOYED_PART_TIME_MALES__TREND
				    , TMP.EMPLOYED_PART_TIME_MALES__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_PART_TIME_MALES__ORIGINAL
				    , TMP.EMPLOYED_PART_TIME_FEMALES__TREND
				    , TMP.EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYED_PART_TIME_FEMALES__ORIGINAL
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__TREND
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_PERSONS__ORIGINAL
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_MALES__TREND
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_MALES__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_MALES__ORIGINAL
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__TREND
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.EMPLOYMENT_TO_POPULATION_RATIO_FEMALES__ORIGINAL
				    , TMP.UNEMPLOYED_TOTAL_PERSONS__TREND
				    , TMP.UNEMPLOYED_TOTAL_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_TOTAL_PERSONS__ORIGINAL
				    , TMP.UNEMPLOYED_TOTAL_MALES__TREND
				    , TMP.UNEMPLOYED_TOTAL_MALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_TOTAL_MALES__ORIGINAL
				    , TMP.UNEMPLOYED_TOTAL_FEMALES__TREND
				    , TMP.UNEMPLOYED_TOTAL_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_TOTAL_FEMALES__ORIGINAL
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYED_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_PERSONS__TREND
				    , TMP.UNEMPLOYMENT_RATE_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_PERSONS__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_MALES__TREND
				    , TMP.UNEMPLOYMENT_RATE_MALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_MALES__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_FEMALES__TREND
				    , TMP.UNEMPLOYMENT_RATE_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_FEMALES__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__TREND
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_PERSONS__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__TREND
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_MALES__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__TREND
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_FULL_TIME_WORK_FEMALES__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__TREND
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_PERSONS__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__TREND
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_MALES__ORIGINAL
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__TREND
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.UNEMPLOYMENT_RATE_LOOKED_FOR_ONLY_PART_TIME_WORK_FEMALES__ORIGINAL
				    , TMP.LABOUR_FORCE_TOTAL_PERSONS__TREND
				    , TMP.LABOUR_FORCE_TOTAL_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL
				    , TMP.LABOUR_FORCE_TOTAL_MALES__TREND
				    , TMP.LABOUR_FORCE_TOTAL_MALES__SEASONALLY_ADJUSTED
				    , TMP.LABOUR_FORCE_TOTAL_MALES__ORIGINAL
				    , TMP.LABOUR_FORCE_TOTAL_FEMALES__TREND
				    , TMP.LABOUR_FORCE_TOTAL_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL
				    , TMP.PARTICIPATION_RATE_PERSONS__TREND
				    , TMP.PARTICIPATION_RATE_PERSONS__SEASONALLY_ADJUSTED
				    , TMP.PARTICIPATION_RATE_PERSONS__ORIGINAL
				    , TMP.PARTICIPATION_RATE_MALES__TREND
				    , TMP.PARTICIPATION_RATE_MALES__SEASONALLY_ADJUSTED
				    , TMP.PARTICIPATION_RATE_MALES__ORIGINAL
				    , TMP.PARTICIPATION_RATE_FEMALES__TREND
				    , TMP.PARTICIPATION_RATE_FEMALES__SEASONALLY_ADJUSTED
				    , TMP.PARTICIPATION_RATE_FEMALES__ORIGINAL
				    , TMP.NOT_IN_THE_LABOUR_FORCE_NILF_PERSONS__ORIGINAL
				    , TMP.NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIGINAL
				    , TMP.NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIGINAL
				    , TMP.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_PERSONS__ORIGINAL
				    , TMP.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_MALES__ORIGINAL
				    , TMP.CIVILIAN_POPULATION_AGED_15_YEARS_AND_OVER_FEMALES__ORIGINAL
				 FROM #TMP_DTL_LABOUR_FORCE_STATUS_ACTUAL_M AS TMP 
			    ) AS DAT
			    LEFT OUTER JOIN LTN.DBO.F_DTL_LABOUR_FORCE_STATUS_ACTUAL_M AS DTL
			    ON 1 = 1
				  AND DAT.RPT_PERIOD_ID = DTL.RPT_PERIOD_ID
		   WHERE 1 = 1
			    AND DTL.RPT_PERIOD_ID IS NULL;
						 
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
