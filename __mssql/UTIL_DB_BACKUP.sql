/*
=======================================================================================================================================================================================================
SUBJECT		 : database backup
OBJECT TYPE	 : backup - file
OBJECT NAME     : ltn.dbo.UTIL_DB_BACKUP_LTNFX_LITE_M
CREATED BY	 : Harold Delaney
CREATED ON	 : 20171214
SOURCE		 : 
PREPERATION	 : 

REMARKS		 : 1) backs up database and updates logfile for subscriber review
			   2)
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

*/

USE [master]
GO

IF OBJECT_ID('create_util_db_backup') IS NULL -- Check if SP Exists
 EXEC('CREATE PROCEDURE create_util_db_backup AS SET NOCOUNT ON;') -- Create dummy/empty SP
GO
                
alter procedure create_util_db_backup -- Alter the SP Always
(
  @p_env nvarchar (10) 
, @p_task_nme nvarchar (100) 
, @p_pkg_nme nvarchar (100)
, @p_path nvarchar (1000)
, @p_fname nvarchar (100)
, @p_dbname nvarchar (100)
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
-- DB NAMES ----------------------------------------------------------------
DECLARE
       @backup_nme varchar(1000);

SELECT @backup_nme =
       (
           SELECT @p_path + @p_fname --'D:\Sync\__lanoitan_docs\@db_bak\LTNFX_LITE.BAK' --'Z:\__ltn_bak\LTNFX_LITE.BAK'
       );

-- LOG FILE NAME -----------------------------------------------------------
DECLARE @log_file_nme varchar (100)

set @log_file_nme = @p_dbname + '.log'
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

/*==========================================================================
 PERFORM BACK SCRIPT
==========================================================================*/
    BACKUP DATABASE @p_dbname TO DISK = @backup_nme WITH NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 25;

/*==========================================================================
 VERIFY DB BACKUP FILE ONCE BACKUP HAS COMPLETED SUCCESSFULLY
==========================================================================*/

    RESTORE VERIFYONLY FROM DISK = @backup_nme;

/*==========================================================================
 WRITE RESULTS TO FILE.  USED TO INDICATE TO USERS THE LATEST DOWNLOAD DATA
==========================================================================*/

    /* CAPTURE CURRENT FILE CONTENTS */
    CREATE TABLE #TMP_HIST_LIST
    ( NBR  int NOT NULL
    , LINE varchar(1000) NOT NULL
    );

    INSERT INTO #TMP_HIST_LIST ( NBR
						 , LINE
						 )
    SELECT NBR
	    , LINE
	 FROM (
		 SELECT rank() OVER(PARTITION BY 1 ORDER BY NBR) AS NBR
			 , LINE
		   FROM (
			   SELECT [LineNo] AS NBR
				   , LINE
				FROM LTN.DBO.UFT_READFILEASTABLE ( @p_path, @log_file_nme )
			    WHERE 1 = 1
					AND left(upper(LINE), 8) = 'DATABASE'
			   ) AS DAT
		 ) AS DAT2
	WHERE 1 = 1
		 AND DAT2.NBR <= 20;

    declare @trgt_txt as varchar (max);

    SELECT @trgt_txt =
		 (
			SELECT 
	 'CURRENT DATABASE BACKUP DATE' + CHAR(13)+CHAR(10)
    + '----------------------------' + CHAR(13)+CHAR(10)
    + 'Database ' + @p_dbname + ' : backed up on ' + upper(cast(getdate() as varchar(23))) + CHAR(13)+CHAR(10)
    + CHAR(13)+CHAR(10)
    + 'PREVIOUS DATABASE BACKUP DATES (MAX 20)' + CHAR(13)+CHAR(10)
    + '---------------------------------------' + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 1 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 2 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 3 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 4 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 5 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 6 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 7 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 8 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 9 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 10 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 11 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 12 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 13 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 14 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 15 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 16 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 17 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 18 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 19 then hist.line end),'~') + CHAR(13)+CHAR(10)
    + isnull(max(case when hist.nbr = 20 then hist.line end),'~') + CHAR(13)+CHAR(10)
    from  #TMP_HIST_LIST hist
    )

    exec sp_WriteStringToFile @trgt_txt, @p_path, @log_file_nme --'D:\Sync\__lanoitan_docs\@db_bak\','LTNFX_LITE_sqlbak.log'
					 
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


