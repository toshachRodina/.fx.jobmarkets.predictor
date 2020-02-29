/*
=======================================================================================================================================================================================================
SUBJECT		 : runs a FULL backup on the LTN database
OBJECT TYPE	 : db backup
OBJECT NAME     : ltn.bak
CREATED BY	 : Harold Delaney
CREATED ON	 : 20180416
SOURCE		 : 
PREPERATION	 : 
			   
REMARKS		 : 1) 
			   2) 
			   3)
=======================================================================================================================================================================================================

exec create_ltn_bak   @p_env = 'DEV', @p_task_nme = 'CREATE_LTN_BAK', @p_pkg_nme = 'LTN_BAK'

=======================================================================================================================================================================================================
*/

use master
GO

IF OBJECT_ID('create_ltn_bak') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_ltn_bak AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_ltn_bak -- Alter the SP Always
(
      @p_env      nvarchar(10)
    , @p_task_nme nvarchar(100)
    , @p_pkg_nme  nvarchar(100))
AS
BEGIN

--SET LANGUAGE 'british english'; -- sets the date viewer to show dates as YYYY-MM-DD
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;

/*
=======================================================================================================================================================================================================
DECLARATIONS & INITIALISATIONS
=======================================================================================================================================================================================================
*/
DECLARE
       @backup_nme varchar(1000);

SELECT @backup_nme =
       (
           SELECT 'D:\Sync\__lanoitan_docs\@db_bak\LTN.BAK'  --'Z:\__ltn_bak\LTN.BAK'
       );


/*
=======================================================================================================================================================================================================
TRY BLOACK - START
=======================================================================================================================================================================================================
*/
BEGIN TRY

/*
=======================================================================================================================================================================================================
BACKUP SCRIPT
=======================================================================================================================================================================================================
*/

BACKUP DATABASE LTN TO DISK = @backup_nme WITH NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 25;

/*
=======================================================================================================================================================================================================
VERIFY THE DATABASE BACKUP FILE ONCE THE BACKUP HAS COMPLETED SUCCESSFULLY 
=======================================================================================================================================================================================================
*/

RESTORE VERIFYONLY FROM DISK = @backup_nme;


/*
=======================================================================================================================================================================================================
WRITE RESULTS TO FILE.  USED TO INDICATE TO USERS THE LATEST DOWNLOAD DATA

DROP TABLE #TMP_HIST_LIST
=======================================================================================================================================================================================================
*/

/* CAPTURE CURRENT FILE CONTENTS */
CREATE TABLE #TMP_HIST_LIST
( NBR int NOT NULL
, line  varchar (1000) NOT NULL
);

insert into #TMP_HIST_LIST(nbr, line)
select nbr, line from (
select rank() over (partition by 1 order by nbr) nbr
, line
from (
select [LineNo] as nbr, line 
  from  ltn.Dbo.uft_ReadFileAsTable('D:\Sync\__lanoitan_docs\@db_bak','LTN_sqlbak.log') 
 where 1 = 1
   and left(upper(line),8) = 'DATABASE' ) dat
   ) dat2
   where 1 = 1
    and dat2.nbr <= 20;

declare @trgt_txt as varchar (max);

SELECT @trgt_txt =
       (
           SELECT 
  'CURRENT DATABASE BACKUP DATE' + CHAR(13)+CHAR(10)
+ '----------------------------' + CHAR(13)+CHAR(10)
+ 'Database LTN : backed up on ' + upper(cast(getdate() as varchar(23))) + CHAR(13)+CHAR(10)
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

exec sp_WriteStringToFile @trgt_txt , 'D:\Sync\__lanoitan_docs\@db_bak\','LTN_sqlbak.log'


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

BEGIN
   CATCH;
   INSERT INTO LTN.DBO.CTL_SSIS_ERR_LOG ( MSMT_DTE_ID
                                        , ENV
                                        , JOB_NME
                                        , TASK_NME
                                        , TASK_TP
                                        , TASK_START_DATETIME
                                        , TASK_END_DATETIME
                                        , TASK_STATUS
                                        , TASK_OUTPUT
                                        )
   SELECT convert(varchar(10), cast(getdate() AS date), 112) AS MSMT_DTE_ID
        , @p_env
        , @p_pkg_nme
        , @p_task_nme
        , 'SQLSCRIPT'
        , getdate()
        , getdate()
        , CASE
               WHEN error_message() IS NULL
               THEN 'SUCCESS'
               ELSE 'ERROR'
          END
        , 'msmt_dte_id variable used : '+convert(varchar(10), cast(getdate() AS date), 112)+' --- error msg : '+error_message();

END CATCH;

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/
END;