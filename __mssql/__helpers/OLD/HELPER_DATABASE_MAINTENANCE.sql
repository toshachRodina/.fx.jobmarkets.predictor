/*
======================================================================================================================
DATABASE BACKUP COMMAND
======================================================================================================================
*/

-- FULL BACKUP
BACKUP DATABASE LTN TO disk  = 'M:\SQLSERVERDB_BAK\LTN.bak'

-- DIFFERENTIAL BACKUP
BACKUP DATABASE LTN TO disk  = 'M:\SQLSERVERDB_BAK\LTN.bak' WITH DIFFERENTIAL