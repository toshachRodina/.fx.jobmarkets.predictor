use master
GO

DECLARE
       @backup_nme varchar(1000);

	  SELECT @backup_nme =
       (
           SELECT 'D:\Sync\__lanoitan_docs\@db_bak\LTNARCH.BAK' -- 'H:\__ltn_db\LTN.BAK'
       );
	  
RESTORE DATABASE LTNARCH FROM DISK = @backup_nme WITH replace;

GO