rem ===========================================================================================================================================================
rem SUBJECT		 : generic batch call to python - webscrape batch call
rem OBJECT TYPE	 : batch
rem OBJECT NAME  : 06_PY_UK.bat
rem CREATED BY	 : Harold Delaney
rem CREATED ON	 : 20170212
rem SOURCE		 : 
rem PREPERATION	 : command line call - calls python exe and passes in python scripts for execution
rem 			   
rem REMARKS		 : 1) data refreshed daily to get the summary "balances" at point in time
rem 			   2) designed to get a feel for the delta movements in job postings
rem 			   3) If you'd prefer to never have the command window show, you can use the pythonw executable by exchanging python.exe with pythonw.exe
rem  
rem ===========================================================================================================================================================

@echo off

set pythonPath=%USERPROFILE%\Anaconda3\envs\lanoitan\python.exe
set scriptPath=D:\Sync\__rodinaFre\.fx.jobmarkets.predictor\__python\jobs\

rem ===========================================================================================================================================================
rem JOBS - UK
rem ===========================================================================================================================================================

%pythonPath% %scriptPath%PY_BATCH_JOBS_UK.py %*

TIMEOUT 10

exit
