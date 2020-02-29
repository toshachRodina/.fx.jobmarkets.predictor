/*
=======================================================================================================================================================================================================
SUBJECT		 : py_vars_tweep_ctl - control/paramater table held in sqlite3 structure for control of python scripts
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.py_vars_tweep_ctl
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170830
SOURCE		 : sqlite3 database
PREPERATION	 : 
                  
			   
REMARKS		 : 1) backs up the vars table
			   2) allows use within sqlserver for further querying of data
			   3)
INDEXES
PK_ for primary keys
UK_ for unique keys
IX_ for non clustered non unique indexes
UX_ for unique indexes
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.py_vars_tweep_ctl;

CREATE TABLE LTN.DBO.PY_VARS_TWEEP_CTL
( ENV       varchar(6) NOT NULL
, PKG_NME   varchar(150)
, VAR_TYPE  varchar(6) NOT NULL
, VAR_NME   varchar(150) NOT NULL
, VAR_VAL   varchar(2000) NOT NULL
, VAR_CMNTS varchar(max) NOT NULL
);

ALTER TABLE ltn.dbo.py_vars_tweep_ctl REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_py_vars_tweep_ctl   @p_env = 'DEV', @p_task_nme = 'CREATE_PY_VARS_TWEEP_CTL', @p_pkg_nme = 'PKG_PY_VARS_TWEEP_CTL'

select * from LTN.DBO.PY_VARS_TWEEP_CTL
=======================================================================================================================================================================================================
*/


USE [ltn];
GO


IF OBJECT_ID('create_py_vars_tweep_ctl') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_py_vars_tweep_ctl AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_py_vars_tweep_ctl -- Alter the SP Always
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
         -- TABLES ----------------------------------------------------------------
         DECLARE
                @l_tbl_nme AS nvarchar(50);
         DECLARE
                @l_stg_tbl_nme AS nvarchar(50);
         
         SET @l_tbl_nme = 'py_vars_tweep_ctl';
	    SET @l_stg_tbl_nme = 'stg_py_vars_tweep_ctl' 
	                       
         
         -- DATES -----------------------------------------------------------------
         DECLARE
                @l_prces_dte_id AS nvarchar(8);
	    DECLARE 
			 @l_min_date_id_to_keep as nvarchar(8)

         SET @l_prces_dte_id = CONVERT(varchar(10), CAST(CAST(GETDATE() AS date) AS date), 112);

/*
=======================================================================================================================================================================================================
MAIN CODE BLOCK
- TABLE TIDY UP (IF NEEDED)
- INSERT NEW DATA
- SWITCH INTO EMPTY PARTITIONS (IF USING TABLE PARTITIONS)
=======================================================================================================================================================================================================
*/

/*
=======================================================================================================================================================================================================
TRY BLOACK - START
=======================================================================================================================================================================================================
*/
         BEGIN TRY

/*
STEP 1 
---------------------------------------------------------------------------------------------------
** load data from sqlite3 database to sqlserver temp table
** there are duplicate records shown from various sites - distinct removes these
*/
		  
		  CREATE TABLE #TMP_PY_VARS_TWEEP_CTL
		  ( ENV       varchar(6) NOT NULL
		  , PKG_NME   varchar(150)
		  , VAR_TYPE  varchar(6) NOT NULL
		  , VAR_NME   varchar(150) NOT NULL
		  , VAR_VAL   varchar(2000) NOT NULL
		  , VAR_CMNTS varchar(max)
		  );

		  INSERT INTO #TMP_PY_VARS_TWEEP_CTL ( ENV
									  , PKG_NME
									  , VAR_TYPE
									  , VAR_NME
									  , VAR_VAL
									  , VAR_CMNTS
									  )
		  SELECT ENV
			  , PKG_NME
			  , VAR_TYPE
			  , VAR_NME
			  , VAR_VAL
			  , VAR_CMNTS
		    FROM openquery(PY_TWEEP_DATA, '
									SELECT   DAT.ENV
										  , DAT.PKG_NME
										  , DAT.VAR_TYPE
										  , DAT.VAR_NME
										  , DAT.VAR_VAL
										  , DAT.VAR_CMNTS
									    FROM PY_VARS_TWEEP_CTL AS DAT');


/*
STEP 2 
---------------------------------------------------------------------------------------------------
** insert into final f_dtl table 
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)
*/
		  TRUNCATE TABLE LTN.DBO.PY_VARS_TWEEP_CTL;

		  INSERT INTO LTN.DBO.PY_VARS_TWEEP_CTL ( ENV
										, PKG_NME
										, VAR_TYPE
										, VAR_NME
										, VAR_VAL
										, VAR_CMNTS
										)
		  SELECT TMP.ENV
			  , TMP.PKG_NME
			  , TMP.VAR_TYPE
			  , TMP.VAR_NME
			  , TMP.VAR_VAL
			  , TMP.VAR_CMNTS
		    FROM #TMP_PY_VARS_TWEEP_CTL AS TMP;
						 
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

         BEGIN CATCH

             INSERT INTO ltn.dbo.ctl_ssis_err_log
                    (msmt_dte_id
                   , env
                   , job_nme
                   , task_nme
                   , task_tp
                   , task_start_datetime
                   , task_end_datetime
                   , task_status
                   , task_output
                    )
             SELECT CONVERT(varchar(10), CAST(GETDATE() AS date), 112) AS msmt_dte_id
                  , @p_env
                  , @p_pkg_nme
                  , @p_task_nme
                  , 'SQLSCRIPT'
                  , GETDATE()
                  , GETDATE()
                  , CASE
                        WHEN ERROR_MESSAGE() IS NULL
                        THEN 'SUCCESS'
                        ELSE 'ERROR'
                    END
                  , 'msmt_dte_id variable used : '+CONVERT( varchar(10), CAST(GETDATE() AS date), 112)+' --- error msg : '+ERROR_MESSAGE();

         END CATCH;

/*
=======================================================================================================================================================================================================
CATCH BLOACK - END
=======================================================================================================================================================================================================
*/

     END;