use master
GO

DECLARE
       @backup_nme varchar(1000);

	  SELECT @backup_nme =
       (
           SELECT 'D:\Sync\__lanoitan_docs\@db_bak\LTNFX_LITE.BAK' -- 'H:\__ltn_db\LTNFX_LITE.BAK'
       );
	  
RESTORE DATABASE LTNFX_LITE FROM DISK = @backup_nme WITH replace;

GO
