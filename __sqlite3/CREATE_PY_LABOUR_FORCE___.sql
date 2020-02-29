/*
===================================================================================================
TABLE CREATION
===================================================================================================

drop table PY_LABOUR_FORCE_AU;

CREATE TABLE PY_LABOUR_FORCE_AU
( MSMT_DTE_ID                                         INTEGER NOT NULL
, CAPTURE_PERIOD                                      DATE NOT NULL
, CNTRY_CDE                                           VARCHAR(2) NOT NULL
, SITE_CDE                                            VARCHAR(20) NOT NULL
, EMPLD_TOTAL_PRSNS__TRND                             DECIMAL(22, 4) NULL
, EMPLD_TOTAL_PRSNS__SA                               DECIMAL(22, 4) NULL
, EMPLD_TOTAL_PRSNS__ORIG                             DECIMAL(22, 4) NULL
, EMPLD_TOTAL_MALES__TRND                             DECIMAL(22, 4) NULL
, EMPLD_TOTAL_MALES__SA                               DECIMAL(22, 4) NULL
, EMPLD_TOTAL_MALES__ORIG                             DECIMAL(22, 4) NULL
, EMPLD_TOTAL_FEMALES__TRND                           DECIMAL(22, 4) NULL
, EMPLD_TOTAL_FEMALES__SA                             DECIMAL(22, 4) NULL
, EMPLD_TOTAL_FEMALES__ORIG                           DECIMAL(22, 4) NULL
, EMPLD_FT_PRSNS__TRND                                DECIMAL(22, 4) NULL
, EMPLD_FT_PRSNS__SA                                  DECIMAL(22, 4) NULL
, EMPLD_FT_PRSNS__ORIG                                DECIMAL(22, 4) NULL
, EMPLD_FT_MALES__TRND                                DECIMAL(22, 4) NULL
, EMPLD_FT_MALES__SA                                  DECIMAL(22, 4) NULL
, EMPLD_FT_MALES__ORIG                                DECIMAL(22, 4) NULL
, EMPLD_FT_FEMALES__TRND                              DECIMAL(22, 4) NULL
, EMPLD_FT_FEMALES__SA                                DECIMAL(22, 4) NULL
, EMPLD_FT_FEMALES__ORIG                              DECIMAL(22, 4) NULL
, EMPLD_PT_PRSNS__TRND                                DECIMAL(22, 4) NULL
, EMPLD_PT_PRSNS__SA                                  DECIMAL(22, 4) NULL
, EMPLD_PT_PRSNS__ORIG                                DECIMAL(22, 4) NULL
, EMPLD_PT_MALES__TRND                                DECIMAL(22, 4) NULL
, EMPLD_PT_MALES__SA                                  DECIMAL(22, 4) NULL
, EMPLD_PT_MALES__ORIG                                DECIMAL(22, 4) NULL
, EMPLD_PT_FEMALES__TRND                              DECIMAL(22, 4) NULL
, EMPLD_PT_FEMALES__SA                                DECIMAL(22, 4) NULL
, EMPLD_PT_FEMALES__ORIG                              DECIMAL(22, 4) NULL
, EMPLMT_TO_POPULATION_RATIO_PRSNS__TRND              DECIMAL(12, 9) NULL
, EMPLMT_TO_POPULATION_RATIO_PRSNS__SA                DECIMAL(12, 9) NULL
, EMPLMT_TO_POPULATION_RATIO_PRSNS__ORIG              DECIMAL(12, 9) NULL
, EMPLMT_TO_POPULATION_RATIO_MALES__TRND              DECIMAL(12, 9) NULL
, EMPLMT_TO_POPULATION_RATIO_MALES__SA                DECIMAL(12, 9) NULL
, EMPLMT_TO_POPULATION_RATIO_MALES__ORIG              DECIMAL(12, 9) NULL
, EMPLMT_TO_POPULATION_RATIO_FEMALES__TRND            DECIMAL(12, 9) NULL
, EMPLMT_TO_POPULATION_RATIO_FEMALES__SA              DECIMAL(12, 9) NULL
, EMPLMT_TO_POPULATION_RATIO_FEMALES__ORIG            DECIMAL(12, 9) NULL
, UNEMPLD_TOTAL_PRSNS__TRND                           DECIMAL(22, 4) NULL
, UNEMPLD_TOTAL_PRSNS__SA                             DECIMAL(22, 4) NULL
, UNEMPLD_TOTAL_PRSNS__ORIG                           DECIMAL(22, 4) NULL
, UNEMPLD_TOTAL_MALES__TRND                           DECIMAL(22, 4) NULL
, UNEMPLD_TOTAL_MALES__SA                             DECIMAL(22, 4) NULL
, UNEMPLD_TOTAL_MALES__ORIG                           DECIMAL(22, 4) NULL
, UNEMPLD_TOTAL_FEMALES__TRND                         DECIMAL(22, 4) NULL
, UNEMPLD_TOTAL_FEMALES__SA                           DECIMAL(22, 4) NULL
, UNEMPLD_TOTAL_FEMALES__ORIG                         DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_PRSNS__TRND              DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_PRSNS__SA                DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_PRSNS__ORIG              DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_MALES__TRND              DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_MALES__SA                DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_MALES__ORIG              DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_FEMALES__TRND            DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_FEMALES__SA              DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_FT_WORK_FEMALES__ORIG            DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_PRSNS__TRND         DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_PRSNS__SA           DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_PRSNS__ORIG         DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_MALES__TRND         DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_MALES__SA           DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_MALES__ORIG         DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_FEMALES__TRND       DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_FEMALES__SA         DECIMAL(22, 4) NULL
, UNEMPLD_LOOKED_FOR_ONLY_PT_WORK_FEMALES__ORIG       DECIMAL(22, 4) NULL
, UNEMPLMT_RATE_PRSNS__TRND                           DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_PRSNS__SA                             DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_PRSNS__ORIG                           DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_MALES__TRND                           DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_MALES__SA                             DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_MALES__ORIG                           DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_FEMALES__TRND                         DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_FEMALES__SA                           DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_FEMALES__ORIG                         DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_PRSNS__TRND        DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_PRSNS__SA          DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_PRSNS__ORIG        DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_MALES__TRND        DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_MALES__SA          DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_MALES__ORIG        DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_FEMALES__TRND      DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_FEMALES__SA        DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_FT_WORK_FEMALES__ORIG      DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_PRSNS__TRND   DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_PRSNS__SA     DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_PRSNS__ORIG   DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_MALES__TRND   DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_MALES__SA     DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_MALES__ORIG   DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_FEMALES__TRND DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_FEMALES__SA   DECIMAL(12, 9) NULL
, UNEMPLMT_RATE_LOOKED_FOR_ONLY_PT_WORK_FEMALES__ORIG DECIMAL(12, 9) NULL
, LABOUR_FORCE_TOTAL_PRSNS__TRND                      DECIMAL(22, 4) NULL
, LABOUR_FORCE_TOTAL_PRSNS__SA                        DECIMAL(22, 4) NULL
, LABOUR_FORCE_TOTAL_PRSNS__ORIG                      DECIMAL(22, 4) NULL
, LABOUR_FORCE_TOTAL_MALES__TRND                      DECIMAL(22, 4) NULL
, LABOUR_FORCE_TOTAL_MALES__SA                        DECIMAL(22, 4) NULL
, LABOUR_FORCE_TOTAL_MALES__ORIG                      DECIMAL(22, 4) NULL
, LABOUR_FORCE_TOTAL_FEMALES__TRND                    DECIMAL(22, 4) NULL
, LABOUR_FORCE_TOTAL_FEMALES__SA                      DECIMAL(22, 4) NULL
, LABOUR_FORCE_TOTAL_FEMALES__ORIG                    DECIMAL(22, 4) NULL
, PRTCPTN_RATE_PRSNS__TRND                            DECIMAL(12, 9) NULL
, PRTCPTN_RATE_PRSNS__SA                              DECIMAL(12, 9) NULL
, PRTCPTN_RATE_PRSNS__ORIG                            DECIMAL(12, 9) NULL
, PRTCPTN_RATE_MALES__TRND                            DECIMAL(12, 9) NULL
, PRTCPTN_RATE_MALES__SA                              DECIMAL(12, 9) NULL
, PRTCPTN_RATE_MALES__ORIG                            DECIMAL(12, 9) NULL
, PRTCPTN_RATE_FEMALES__TRND                          DECIMAL(12, 9) NULL
, PRTCPTN_RATE_FEMALES__SA                            DECIMAL(12, 9) NULL
, PRTCPTN_RATE_FEMALES__ORIG                          DECIMAL(12, 9) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_PRSNS__ORIG            DECIMAL(22, 4) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_MALES__ORIG            DECIMAL(22, 4) NULL
, NOT_IN_THE_LABOUR_FORCE_NILF_FEMALES__ORIG          DECIMAL(22, 4) NULL
, CIV_PPLTN_AGED_15_YEARS_AND_OVER_PRSNS__ORIG        DECIMAL(22, 4) NULL
, CIV_PPLTN_AGED_15_YEARS_AND_OVER_MALES__ORIG        DECIMAL(22, 4) NULL
, CIV_PPLTN_AGED_15_YEARS_AND_OVER_FEMALES__ORIG      DECIMAL(22, 4) NULL
, STARTED_AT                                          VARCHAR(20) NOT NULL
, FINISHED_AT                                         VARCHAR(20) NOT NULL
);



=====================================================================================================================================================

CREATE TABLE PY_LABOUR_FORCE_AU_HRS_WRKD
             (
             MSMT_DTE_ID                                                                      INT 
           , CAPTURE_PERIOD                                                                   DATE 
           , CNTRY_CDE                                                                        VARCHAR (2)
           , SITE_CDE                                                                         VARCHAR (20)
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_PERSONS__TREND                                  DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_PERSONS__SEASONALLY_ADJUSTED                    DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_MALES__TREND                                    DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_MALES__SEASONALLY_ADJUSTED                      DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_FEMALES__TREND                                  DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_FEMALES__SEASONALLY_ADJUSTED                    DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_FULL_TIME_PERSONS__TREND               DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_FULL_TIME_PERSONS__SEASONALLY_ADJUSTED DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_FULL_TIME_MALES__TREND                 DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_FULL_TIME_MALES__SEASONALLY_ADJUSTED   DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_FULL_TIME_FEMALES__TREND               DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_FULL_TIME_FEMALES__SEASONALLY_ADJUSTED DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_PART_TIME_PERSONS__TREND               DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_PART_TIME_PERSONS__SEASONALLY_ADJUSTED DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_PART_TIMEMALES__TREND                  DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_PART_TIMEMALES__SEASONALLY_ADJUSTED    DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_PART_TIME_FEMALES__TREND               DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_EMPLOYED_PART_TIME_FEMALES__SEASONALLY_ADJUSTED DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_NEW_SOUTH_WALES__TREND                          DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_NEW_SOUTH_WALES__SEASONALLY_ADJUSTED            DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_VICTORIA__TREND                                 DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_VICTORIA__SEASONALLY_ADJUSTED                   DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_QUEENSLAND__TREND                               DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_QUEENSLAND__SEASONALLY_ADJUSTED                 DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_SOUTH_AUSTRALIA__TREND                          DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_SOUTH_AUSTRALIA__SEASONALLY_ADJUSTED            DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_WESTERN_AUSTRALIA__TREND                        DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_WESTERN_AUSTRALIA__SEASONALLY_ADJUSTED          DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_TASMANIA__TREND                                 DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_TASMANIA__SEASONALLY_ADJUSTED                   DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_NORTHERN_TERRITORY__TREND                       DECIMAL(22, 4) 
           , MONTHLY_HOURS_WORKED_IN_ALL_JOBS_AUSTRALIAN_CAPITAL_TERRITORY__TREND             DECIMAL(22, 4) 
           , STARTED_AT                                                                       VARCHAR (20) 
		   , FINISHED_AT                                                                      VARCHAR (20)
             );
             
             
             
			 
CREATE TABLE PY_LABOUR_FORCE_AU_UNDERUTIL_PRSNS
             (
             MSMT_DTE_ID                                                                                       INT 
           , CAPTURE_PERIOD                                                                                    VARCHAR(10) 
           , CNTRY_CDE                                                                                         VARCHAR (2)
           , SITE_CDE                                                                                          VARCHAR (20)
           , EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                                  DECIMAL(22, 4) 
           , EMPLOYED_TOTAL_MALES__ORIGINAL                                                                    DECIMAL(22, 4) 
           , EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                                  DECIMAL(22, 4) 
           , UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                             DECIMAL(22, 4) 
           , UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                               DECIMAL(22, 4) 
           , UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                             DECIMAL(22, 4) 
           , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL                   DECIMAL(22, 4) 
           , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL                     DECIMAL(22, 4) 
           , UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL                   DECIMAL(22, 4) 
           , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                                       DECIMAL(22, 4) 
           , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                                         DECIMAL(22, 4) 
           , UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                                       DECIMAL(22, 4) 
           , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                                    DECIMAL(12, 9) 
           , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                                      DECIMAL(12, 9) 
           , UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                                    DECIMAL(12, 9) 
           , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                                 DECIMAL(12, 9) 
           , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                                   DECIMAL(12, 9) 
           , UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                                 DECIMAL(12, 9) 
           , UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                                DECIMAL(22, 4) 
           , UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                                  DECIMAL(22, 4) 
           , UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                                DECIMAL(22, 4) 
           , UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                               DECIMAL(12, 9) 
           , UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                                 DECIMAL(12, 9) 
           , UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                               DECIMAL(12, 9) 
           , LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                              DECIMAL(22, 4) 
           , LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                                DECIMAL(22, 4) 
           , LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                              DECIMAL(22, 4) 
           , UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                                           DECIMAL(12, 9) 
           , UNDERUTILISATION_RATE_MALES__ORIGINAL                                                             DECIMAL(12, 9) 
           , UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                                           DECIMAL(12, 9) 
           , YEARS_15_24_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_15_24_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        DECIMAL(22, 4) 
           , YEARS_15_24_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           DECIMAL(22, 4) 
           , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        DECIMAL(12, 9) 
           , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          DECIMAL(12, 9) 
           , YEARS_15_24_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        DECIMAL(12, 9) 
           , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     DECIMAL(12, 9) 
           , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       DECIMAL(12, 9) 
           , YEARS_15_24_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     DECIMAL(12, 9) 
           , YEARS_15_24_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_15_24_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_15_24_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_15_24_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   DECIMAL(12, 9) 
           , YEARS_15_24_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     DECIMAL(12, 9) 
           , YEARS_15_24_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   DECIMAL(12, 9) 
           , YEARS_15_24_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_15_24_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_15_24_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_15_24_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_15_24_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 DECIMAL(12, 9) 
           , YEARS_15_24_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_25_34_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_25_34_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        DECIMAL(22, 4) 
           , YEARS_25_34_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           DECIMAL(22, 4) 
           , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        DECIMAL(12, 9) 
           , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          DECIMAL(12, 9) 
           , YEARS_25_34_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        DECIMAL(12, 9) 
           , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     DECIMAL(12, 9) 
           , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       DECIMAL(12, 9) 
           , YEARS_25_34_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     DECIMAL(12, 9) 
           , YEARS_25_34_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_25_34_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_25_34_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_25_34_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   DECIMAL(12, 9) 
           , YEARS_25_34_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     DECIMAL(12, 9) 
           , YEARS_25_34_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   DECIMAL(12, 9) 
           , YEARS_25_34_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_25_34_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_25_34_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_25_34_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_25_34_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 DECIMAL(12, 9) 
           , YEARS_25_34_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_35_44_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_35_44_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        DECIMAL(22, 4) 
           , YEARS_35_44_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           DECIMAL(22, 4) 
           , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        DECIMAL(12, 9) 
           , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          DECIMAL(12, 9) 
           , YEARS_35_44_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        DECIMAL(12, 9) 
           , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     DECIMAL(12, 9) 
           , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       DECIMAL(12, 9) 
           , YEARS_35_44_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     DECIMAL(12, 9) 
           , YEARS_35_44_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_35_44_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_35_44_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_35_44_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   DECIMAL(12, 9) 
           , YEARS_35_44_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     DECIMAL(12, 9) 
           , YEARS_35_44_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   DECIMAL(12, 9) 
           , YEARS_35_44_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_35_44_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_35_44_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_35_44_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_35_44_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 DECIMAL(12, 9) 
           , YEARS_35_44_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_45_54_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_45_54_EMPLOYED_TOTAL_MALES__ORIGINAL                                                        DECIMAL(22, 4) 
           , YEARS_45_54_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                                 DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                                   DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                                 DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL       DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL         DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL       DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                           DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                             DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                           DECIMAL(22, 4) 
           , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                        DECIMAL(12, 9) 
           , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                          DECIMAL(12, 9) 
           , YEARS_45_54_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                        DECIMAL(12, 9) 
           , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL                     DECIMAL(12, 9) 
           , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                       DECIMAL(12, 9) 
           , YEARS_45_54_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL                     DECIMAL(12, 9) 
           , YEARS_45_54_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_45_54_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                      DECIMAL(22, 4) 
           , YEARS_45_54_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_45_54_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                                   DECIMAL(12, 9) 
           , YEARS_45_54_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                                     DECIMAL(12, 9) 
           , YEARS_45_54_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                                   DECIMAL(12, 9) 
           , YEARS_45_54_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_45_54_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                                    DECIMAL(22, 4) 
           , YEARS_45_54_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_45_54_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_45_54_UNDERUTILISATION_RATE_MALES__ORIGINAL                                                 DECIMAL(12, 9) 
           , YEARS_45_54_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_EMPLOYED_TOTAL_PERSONS__ORIGINAL                                                DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_EMPLOYED_TOTAL_MALES__ORIGINAL                                                  DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_EMPLOYED_TOTAL_FEMALES__ORIGINAL                                                DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_PERSONS__ORIGINAL                                           DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_MALES__ORIGINAL                                             DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_TOTAL_FEMALES__ORIGINAL                                           DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_PERSONS__ORIGINAL DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_MALES__ORIGINAL   DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_FULL_TIME_WORKED_PART_TIME_FOR_ECONOMIC_REASONS_FEMALES__ORIGINAL DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_PERSONS__ORIGINAL                     DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_MALES__ORIGINAL                       DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYED_PART_TIME_PREFER_MORE_HOURS_FEMALES__ORIGINAL                     DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_PERSONS__ORIGINAL                  DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_MALES__ORIGINAL                    DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATIO_PROPORTION_OF_EMPLOYED_FEMALES__ORIGINAL                  DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_PERSONS__ORIGINAL               DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_MALES__ORIGINAL                 DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNDEREMPLOYMENT_RATE_PROPORTION_OF_LABOUR_FORCE_FEMALES__ORIGINAL               DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_PERSONS__ORIGINAL                                              DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_MALES__ORIGINAL                                                DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNEMPLOYED_TOTAL_FEMALES__ORIGINAL                                              DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_PERSONS__ORIGINAL                                             DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_MALES__ORIGINAL                                               DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNEMPLOYMENT_RATE_FEMALES__ORIGINAL                                             DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_PERSONS__ORIGINAL                                            DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_MALES__ORIGINAL                                              DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_LABOUR_FORCE_TOTAL_FEMALES__ORIGINAL                                            DECIMAL(22, 4) 
           , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_PERSONS__ORIGINAL                                         DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_MALES__ORIGINAL                                           DECIMAL(12, 9) 
           , YEARS_55_AND_OVER_UNDERUTILISATION_RATE_FEMALES__ORIGINAL                                         DECIMAL(12, 9) 
           , STARTED_AT                                                                                        VARCHAR (20) 
		   , FINISHED_AT                                                                                       VARCHAR (20)
             );
			 
===================================================================================================
*/



SELECT dat.msmt_dte_id
     , dat.capture_period
     , dat.cntry_cde
     , dat.site_cde
     , dat.empld_total_prsns__trnd
     , dat.empld_total_prsns__sa
     , dat.empld_total_prsns__orig
     , dat.empld_total_males__trnd
     , dat.empld_total_males__sa
     , dat.empld_total_males__orig
     , dat.empld_total_females__trnd
     , dat.empld_total_females__sa
     , dat.empld_total_females__orig
     , dat.empld_ft_prsns__trnd
     , dat.empld_ft_prsns__sa
     , dat.empld_ft_prsns__orig
     , dat.empld_ft_males__trnd
     , dat.empld_ft_males__sa
     , dat.empld_ft_males__orig
     , dat.empld_ft_females__trnd
     , dat.empld_ft_females__sa
     , dat.empld_ft_females__orig
     , dat.empld_pt_prsns__trnd
     , dat.empld_pt_prsns__sa
     , dat.empld_pt_prsns__orig
     , dat.empld_pt_males__trnd
     , dat.empld_pt_males__sa
     , dat.empld_pt_males__orig
     , dat.empld_pt_females__trnd
     , dat.empld_pt_females__sa
     , dat.empld_pt_females__orig
     , dat.emplmt_to_population_ratio_prsns__trnd
     , dat.emplmt_to_population_ratio_prsns__sa
     , dat.emplmt_to_population_ratio_prsns__orig
     , dat.emplmt_to_population_ratio_males__trnd
     , dat.emplmt_to_population_ratio_males__sa
     , dat.emplmt_to_population_ratio_males__orig
     , dat.emplmt_to_population_ratio_females__trnd
     , dat.emplmt_to_population_ratio_females__sa
     , dat.emplmt_to_population_ratio_females__orig
     , dat.unempld_total_prsns__trnd
     , dat.unempld_total_prsns__sa
     , dat.unempld_total_prsns__orig
     , dat.unempld_total_males__trnd
     , dat.unempld_total_males__sa
     , dat.unempld_total_males__orig
     , dat.unempld_total_females__trnd
     , dat.unempld_total_females__sa
     , dat.unempld_total_females__orig
     , dat.unempld_looked_for_ft_work_prsns__trnd
     , dat.unempld_looked_for_ft_work_prsns__sa
     , dat.unempld_looked_for_ft_work_prsns__orig
     , dat.unempld_looked_for_ft_work_males__trnd
     , dat.unempld_looked_for_ft_work_males__sa
     , dat.unempld_looked_for_ft_work_males__orig
     , dat.unempld_looked_for_ft_work_females__trnd
     , dat.unempld_looked_for_ft_work_females__sa
     , dat.unempld_looked_for_ft_work_females__orig
     , dat.unempld_looked_for_only_pt_work_prsns__trnd
     , dat.unempld_looked_for_only_pt_work_prsns__sa
     , dat.unempld_looked_for_only_pt_work_prsns__orig
     , dat.unempld_looked_for_only_pt_work_males__trnd
     , dat.unempld_looked_for_only_pt_work_males__sa
     , dat.unempld_looked_for_only_pt_work_males__orig
     , dat.unempld_looked_for_only_pt_work_females__trnd
     , dat.unempld_looked_for_only_pt_work_females__sa
     , dat.unempld_looked_for_only_pt_work_females__orig
     , dat.unemplmt_rate_prsns__trnd
     , dat.unemplmt_rate_prsns__sa
     , dat.unemplmt_rate_prsns__orig
     , dat.unemplmt_rate_males__trnd
     , dat.unemplmt_rate_males__sa
     , dat.unemplmt_rate_males__orig
     , dat.unemplmt_rate_females__trnd
     , dat.unemplmt_rate_females__sa
     , dat.unemplmt_rate_females__orig
     , dat.unemplmt_rate_looked_for_ft_work_prsns__trnd
     , dat.unemplmt_rate_looked_for_ft_work_prsns__sa
     , dat.unemplmt_rate_looked_for_ft_work_prsns__orig
     , dat.unemplmt_rate_looked_for_ft_work_males__trnd
     , dat.unemplmt_rate_looked_for_ft_work_males__sa
     , dat.unemplmt_rate_looked_for_ft_work_males__orig
     , dat.unemplmt_rate_looked_for_ft_work_females__trnd
     , dat.unemplmt_rate_looked_for_ft_work_females__sa
     , dat.unemplmt_rate_looked_for_ft_work_females__orig
     , dat.unemplmt_rate_looked_for_only_pt_work_prsns__trnd
     , dat.unemplmt_rate_looked_for_only_pt_work_prsns__sa
     , dat.unemplmt_rate_looked_for_only_pt_work_prsns__orig
     , dat.unemplmt_rate_looked_for_only_pt_work_males__trnd
     , dat.unemplmt_rate_looked_for_only_pt_work_males__sa
     , dat.unemplmt_rate_looked_for_only_pt_work_males__orig
     , dat.unemplmt_rate_looked_for_only_pt_work_females__trnd
     , dat.unemplmt_rate_looked_for_only_pt_work_females__sa
     , dat.unemplmt_rate_looked_for_only_pt_work_females__orig
     , dat.labour_force_total_prsns__trnd
     , dat.labour_force_total_prsns__sa
     , dat.labour_force_total_prsns__orig
     , dat.labour_force_total_males__trnd
     , dat.labour_force_total_males__sa
     , dat.labour_force_total_males__orig
     , dat.labour_force_total_females__trnd
     , dat.labour_force_total_females__sa
     , dat.labour_force_total_females__orig
     , dat.prtcptn_rate_prsns__trnd
     , dat.prtcptn_rate_prsns__sa
     , dat.prtcptn_rate_prsns__orig
     , dat.prtcptn_rate_males__trnd
     , dat.prtcptn_rate_males__sa
     , dat.prtcptn_rate_males__orig
     , dat.prtcptn_rate_females__trnd
     , dat.prtcptn_rate_females__sa
     , dat.prtcptn_rate_females__orig
     , dat.not_in_the_labour_force_nilf_prsns__orig
     , dat.not_in_the_labour_force_nilf_males__orig
     , dat.not_in_the_labour_force_nilf_females__orig
     , dat.civ_ppltn_aged_15_years_and_over_prsns__orig
     , dat.civ_ppltn_aged_15_years_and_over_males__orig
     , dat.civ_ppltn_aged_15_years_and_over_females__orig
     , dat.started_at
     , dat.finished_at
  FROM py_labour_force_au dat;
