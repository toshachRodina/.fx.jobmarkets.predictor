DECLARE
       @backup_nme varchar(1000);

SELECT @backup_nme =
       (
           SELECT 'Z:\__ltn_bak\LTN_'+CONVERT( varchar(10), CAST(GETDATE() AS date), 112)+'.DIF'
       );

BACKUP DATABASE ltn TO DISK = @backup_nme WITH DIFFERENTIAL, NOFORMAT, NOINIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 25;

/*==========================================================================
 Verify the Database Backup File Once the Backup has completed successfully 
==========================================================================*/

RESTORE VERIFYONLY FROM DISK = @backup_nme;
GO