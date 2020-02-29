rem ===========================================================================================================================================================
rem SUBJECT	 : generic batch call to python - webscrape batch call
rem OBJECT TYPE	 : batch
rem OBJECT NAME  : PYTHON_JS_WEBSCRAPE.bat
rem CREATED BY	 : Harold Delaney
rem CREATED ON	 : 20170212
rem SOURCE		 : 
rem PREPERATION	 : command line call - calls python exe and passes in python scripts for execution
rem 			   
rem REMARKS	 : 1) data refreshed daily to get the summary "balances" at point in time
rem 		   2) designed to get a feel for the delta movements in job postings
rem 		   3) If you'd prefer to never have the command window show, you can use the pythonw executable by exchanging python.exe with pythonw.exe
rem  
rem ===========================================================================================================================================================

@echo off

set pythonPath=%USERPROFILE%\AppData\Local\conda\conda\envs\lanoitan\python.exe
set scritpPath=D:\Sync\__lanoitan\__scripts\__python\jobs\

rem ===========================================================================================================================================================
rem JOBS - UK
rem ===========================================================================================================================================================

%pythonPath% %scritpPath%PY_BATCH_JOBS_UK.py %*

TIMEOUT 30

rem ===========================================================================================================================================================
rem JOBS - CA
rem ===========================================================================================================================================================

%pythonPath% %scritpPath%PY_BATCH_JOBS_CA.py %*

TIMEOUT 30

rem ===========================================================================================================================================================
rem JOBS - US
rem ===========================================================================================================================================================

%pythonPath% %scritpPath%PY_BATCH_JOBS_US.py %*

rem pause
exit
