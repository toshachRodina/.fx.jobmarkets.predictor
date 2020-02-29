@ECHO OFF

set TIMESTAMP=%date:~6,4%%date:~3,2%%date:~0,2%

REM Export all databases into file E:\Lanoitan\__data\__db_backups\databases.[year][month][day].sql ====================================================================
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" --databases database-ltn database-ltnfx --result-file="E:\Lanoitan\__data\__db_backups\databases.%TIMESTAMP%.sql" --user=ltn1 --password=lanoitan1

REM Change working directory to the location of the DB dump file. ======================================================================================================
E:
CD E:\Lanoitan\__data\__db_backups\

REM Compress DB dump file into CAB file (use "EXPAND file.cab" to decompress). =========================================================================================
MAKECAB "databases.%TIMESTAMP%.sql" "databases.%TIMESTAMP%.sql.cab"

REM Delete uncompressed DB dump file. ==================================================================================================================================
REM DEL /q /f "databases.%TIMESTAMP%.sql"

pause
