/*
=======================================================================================================================================================================================================
SUBJECT		 : STORED PROCEDURE - error logging for ssis and sql jobs
TABLE NAME	 : ltn.dbo.ctl_ssis_err_log
CREATED BY	 : Harold Delaney
CREATED ON	 : 20160815
SOURCE		 : 
PREPERATION	 : 

REMARKS		 : 1) 
			   2)
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.ctl_ssis_err_log;

CREATE TABLE ltn.dbo.ctl_ssis_err_log
             (
             msmt_dte_id         INT NOT NULL
           , env                 VARCHAR(10) NULL
           , job_nme             VARCHAR(100) NULL
           , task_nme            VARCHAR(100) NULL
           , task_tp             VARCHAR(10) NULL
           , task_start_datetime DATETIME NULL
           , task_end_datetime   DATETIME NULL
           , task_status         VARCHAR(20) NULL
           , task_output         VARCHAR(MAX) NULL
             );
CREATE NONCLUSTERED INDEX ix_ctl_ssis_err_log ON ltn.dbo.ctl_ssis_err_log(msmt_dte_id, task_end_datetime);

ALTER TABLE ltn.dbo.ctl_ssis_err_log REBUILD
WITH(DATA_COMPRESSION = ROW);

*/

USE [ltn];
GO

IF OBJECT_ID('[dbo].sp_ssis_err_log') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE [dbo].sp_ssis_err_log AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE [dbo].sp_ssis_err_log -- Alter the SP Always
(
      @p_env                 VARCHAR(10)
    , @p_job_nme             VARCHAR(100)
    , @p_task_nme            VARCHAR(100)
    , @p_task_tp             VARCHAR(100)
    , @p_prces_dte_id        INT
    , @p_task_start_datetime DATETIME
    , @p_task_end_datetime   DATETIME
    , @p_task_status         VARCHAR(20)
    , @p_task_output         VARCHAR(MAX))
AS
     BEGIN

         SET ANSI_NULLS ON;

         SET QUOTED_IDENTIFIER ON;

         INSERT INTO [dbo].ctl_ssis_err_log
                (
                msmt_dte_id
		      , env
              , job_nme
              , task_nme
              , task_tp
              , task_start_datetime
              , task_end_datetime
              , task_status
              , task_output
                )
         VALUES
                (
                CONVERT( INT, REPLACE(@p_prces_dte_id, CHAR(0), ''))
		    , REPLACE(@p_env, CHAR(0), '')
              , REPLACE(@p_job_nme, CHAR(0), '')
              , REPLACE(@p_task_nme, CHAR(0), '')
              , REPLACE(@p_task_tp, CHAR(0), '') 
              , @p_task_start_datetime
              , @p_task_end_datetime
              , REPLACE(@p_task_status, CHAR(0), '')
              , REPLACE(CASE
                            WHEN CONCAT(ASCII(SUBSTRING(@p_task_output, 1, 1)), ASCII(SUBSTRING(@p_task_output, 2, 1)))
                                 = '1310'
                            THEN SUBSTRING(@p_task_output, 3, LEN(@p_task_output)-2)
                            ELSE @p_task_output
                        END, CHAR(0), '')
                );
     END;