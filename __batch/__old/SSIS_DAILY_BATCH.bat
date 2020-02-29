@ECHO OFF
CLS
ECHO Executing the DAILY SSIS package to move data from PYTHON to SQLSERVER
rem PAUSE
"C:\Program Files\Microsoft SQL Server\130\DTS\Binn\DTExec.exe" /File "D:\Sync\__lanoitan\__ssis\LTN\LTN_CTL_MASTER.dtsx"
rem "C:\Program Files (x86)\Microsoft Visual Studio\2017\SQL\Common7\IDE\CommonExtensions\Microsoft\SSIS\140\Binn\DTExec.exe" /File "D:\Sync\__lanoitan\__ssis\LTN\LTN_CTL_MASTER.dtsx"
PAUSE