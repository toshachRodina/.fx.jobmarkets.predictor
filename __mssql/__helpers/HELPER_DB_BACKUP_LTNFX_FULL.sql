DECLARE
       @backup_nme varchar(1000);

SELECT @backup_nme =
       (
           SELECT 'D:\Sync\__lanoitan_docs\@db_bak\LTNFX.BAK' --'Z:\__ltn_bak\LTNFX.BAK'
       );

BACKUP DATABASE LTNFX TO DISK = @backup_nme WITH NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 25;

/*==========================================================================
 Verify the Database Backup File Once the Backup has completed successfully 
==========================================================================*/

RESTORE VERIFYONLY FROM DISK = @backup_nme;
GO

/*==========================================================================
 Write results to file.  Used to indicate to users the lates download data
==========================================================================*/

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
  from  ltn.Dbo.uft_ReadFileAsTable('D:\Sync\__lanoitan_docs\@db_bak','LTNFX_sqlbak.log') 
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
+ 'Database LTNFX : backed up on ' + upper(cast(getdate() as varchar(23))) + CHAR(13)+CHAR(10)
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

exec sp_WriteStringToFile @trgt_txt , 'D:\Sync\__lanoitan_docs\@db_bak\','LTNFX_sqlbak.log'
GO

