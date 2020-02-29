/*
=======================================================================================================================================================================================================
SUBJECT		 : rollover vars date to run only on or after specific dates
OBJECT TYPE	 : stored procedure
OBJECT NAME     : ltn.dbo.sp_rollover_dte
CREATED BY	 : Harold Delaney
CREATED ON	 : 20180201
SOURCE		 : 
PREPERATION	 : 
                  
			   
REMARKS		 : 1) stored procedure to be called (usually) from ssis.
                  2) using a rule id to run for specific scenarios
			      eg.  if using the economic calendar table to drive a target run date - run rule id 001
				      if just rolling the date by a certain amount - run rule id 000
			   3)
INDEXES
PK_ for primary keys
UK_ for unique keys
IX_ for non clustered non unique indexes
UX_ for unique indexes
=======================================================================================================================================================================================================

exec [dbo].sp_rollover_dte @p_env = 'DEV' ,@p_pkg_nme = 'LTN_PKG_JOBS_3RD_PARTY'

*/

USE [LTN]
GO

if object_id ('dbo.sp_rollover_dte') is null

    begin -- Check if SP Exists
        exec ('CREATE PROCEDURE dbo.sp_rollover_dte AS SET NOCOUNT ON;') 
    end; -- Create dummy/empty SP

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE DBO.SP_ROLLOVER_DTE -- Alter the SP Always
( @p_env     varchar(10)
, @p_pkg_nme varchar(100)
)
AS
BEGIN

/*
  LOCAL DECLERATIONS - GENERIC
  - MUST HAVE NEXT_RUN_DTE_ID set in vars
  - MUST HAVE DT_ROLLOVER_RULE_ID set in vars
*/
declare @l_new_next_run_dte_id varchar (10)
declare @l_next_run_dte_id varchar (10)
declare @l_last_run_dte_id varchar (10)
declare @l_dt_rollover_rule_id varchar (3)
declare @l_prcess_dte_id varchar (10)

set @l_prcess_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112)

SELECT @l_dt_rollover_rule_id = max(CASE
                                     WHEN VAR_NME = 'PKG_DT_ROLLOVER_RULE_ID'
                                     THEN VAR_VAL
                                END)
  FROM LTN.DBO.CTL_SSIS_VARS
 WHERE 1 = 1
       AND ENV = replace(@p_env, char(0), '')
       AND VAR_TYPE = 'PKG'
       AND PKG_NME = replace(@p_pkg_nme, char(0), '')
       AND VAR_NME IN ( 'PKG_DT_ROLLOVER_RULE_ID'
                      );

/*
   FROM THE DELTA VARS TABLE
*/
SELECT @l_next_run_dte_id = max(CASE
                                     WHEN VAR_NME = 'PKG_NEXT_RUN_DTE_ID'
                                     THEN VAR_VAL
                                END)
     , @l_last_run_dte_id = max(CASE
                                     WHEN VAR_NME = 'PKG_LAST_RUN_DTE_ID'
                                     THEN VAR_VAL
                                END)
  FROM LTN.DBO.CTL_SSIS_VARS_DLTA
 WHERE 1 = 1
       AND ENV = replace(@p_env, char(0), '')
       AND VAR_TYPE = 'PKG'
       AND PKG_NME = replace(@p_pkg_nme, char(0), '')
       AND VAR_NME IN ( 'PKG_NEXT_RUN_DTE_ID'
                      , 'PKG_LAST_RUN_DTE_ID'
                      );						  				  


--Display what we're running
raiserror (@l_next_run_dte_id, 0, 0) ;
raiserror (@l_last_run_dte_id, 0, 0) ;
raiserror (@l_dt_rollover_rule_id, 0, 0) ;

 /*
  LOCAL DECLERATIONS - PKG SPECIFIC
  - SET NEW NEXT_RUN_DTE_ID BASED ON THE DT_ROLLOVER_RULE_ID
    eg. '000' = GENERIC - SET TO TOMORROWS DATE 
	   '001' = ANZ JOB ADS (M/M)
*/

IF @l_dt_rollover_rule_id = '000' -- GENERIC - SET TO TOMORROWS DATE
   BEGIN
      SELECT @l_new_next_run_dte_id = convert(varchar(10), cast(cast(dateadd(DAY, 1, getdate()) AS date) AS date), 112); -- ROLLOVER DATE BY 1 DAY
   END;
     ELSE
   BEGIN
      IF @l_dt_rollover_rule_id = '001' -- ANZ JOB ADS (M/M)
         BEGIN
            SELECT @l_new_next_run_dte_id = DTE.MSMT_DTE_ID
              FROM (
                   SELECT DAT.MSMT_DTE_ID
                        , DAT.ANNCE_DTE
                        , DAT.ANNCE_CDE
                        , DAT.ANNCE_DESC
                        , rank() OVER(PARTITION BY 1 ORDER BY DAT.MSMT_DTE_ID) AS RNK
                     FROM LTN.DBO.F_DTL_ECONOMIC_CALENDAR_W AS DAT
                    WHERE 1 = 1
                          AND DAT.ANNCE_CDE = '642.12' -- ANZ JOB ADS (M/M)
                          AND DAT.MSMT_DTE_ID > @l_next_run_dte_id 
                   ) AS DTE
             WHERE 1 = 1
                   AND DTE.RNK = 1;
         END;
   END;


 /*
  UPDATE VARS TABLE WITH 2 NEW DATES
  - NEXT_RUN_DTE_ID
  - LAST_RUN_DTE_ID
*/

-- NEXT_RUN_DTE_ID
UPDATE LTN.DBO.CTL_SSIS_VARS_DLTA
   SET VAR_VAL = @l_new_next_run_dte_id
 WHERE 1 = 1
       AND VAR_NME = 'PKG_NEXT_RUN_DTE_ID'
       AND PKG_NME = upper(@p_pkg_nme)
       AND ENV = upper(@p_env);


-- LAST_RUN_DTE_ID
UPDATE LTN.DBO.CTL_SSIS_VARS_DLTA
   SET VAR_VAL = @l_prcess_dte_id
 WHERE 1 = 1
       AND VAR_NME = 'PKG_LAST_RUN_DTE_ID'
       AND PKG_NME = upper(@p_pkg_nme)
       AND ENV = upper(@p_env);

END;

