/*
=======================================================================================================================================================================================================
SUBJECT		 : government media release data - web data from python/beautifulsoup
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.f_dtl_govt_media_release_au_m
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170626
SOURCE		 : sqlite3 database
PREPERATION	 : 
                  
			   
REMARKS		 : 1) 
			   2) 
			   3)
INDEXES
PK_ for primary keys
UK_ for unique keys
IX_ for non clustered non unique indexes
UX_ for unique indexes
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.f_dtl_govt_media_release_au_m;

CREATE TABLE LTN.DBO.F_DTL_GOVT_MEDIA_RELEASE_AU_M
( MSMT_DTE_ID                    integer NOT NULL
, DATA_TYPE                      varchar(30) NOT NULL
, CNTRY_CDE                      varchar(2) NOT NULL
, SITE_CDE                       varchar(20) NOT NULL
, ANNCE_DT_TM_AET                datetime NOT NULL
, ANNCE_PERIOD                   varchar(20) NOT NULL
, TRND_EST_BLOCK                 varchar(2000) NOT NULL
, TRND_EST_EMP_TRND              varchar(10) NOT NULL
, TRND_EST_EMP_DLTA              integer NOT NULL
, TRND_EST_EMP_TTL               integer NOT NULL
, TRND_EST_UNEMP_TRND            varchar(10) NOT NULL
, TRND_EST_UNEMP_DLTA            integer NOT NULL
, TRND_EST_UNEMP_TTL             integer NOT NULL
, TRND_EST_UNEMP_RATE_TRND       varchar(10) NOT NULL
, TRND_EST_UNEMP_RATE_DLTA       decimal(4, 2) NOT NULL
, TRND_EST_UNEMP_RATE_TTL        decimal(4, 2) NOT NULL
, TRND_EST_PRTCPTN_RATE_TRND     varchar(30) NOT NULL
, TRND_EST_PRTCPTN_RATE_DLTA     decimal(4, 2) NOT NULL
, TRND_EST_PRTCPTN_RATE_TTL      decimal(4, 2) NOT NULL
, TRND_EST_MTHLY_HRS_WRKD_TRND   varchar(10) NOT NULL
, TRND_EST_MTHLY_HRS_WRKD_DLTA   integer NOT NULL
, TRND_EST_MTHLY_HRS_WRKD_TTL    integer NOT NULL
, SNLY_ADJ_EST_BLOCK             varchar(2000) NOT NULL
, SNLY_ADJ_EMP_TTL_TRND          varchar(10) NOT NULL
, SNLY_ADJ_EMP_TTL_DLTA          integer NOT NULL
, SNLY_ADJ_EMP_TTL_TTL           integer NOT NULL
, SNLY_ADJ_EMP_FT_TRND           varchar(10) NOT NULL
, SNLY_ADJ_EMP_FT_DLTA           integer NOT NULL
, SNLY_ADJ_EMP_FT_TTL            integer NOT NULL
, SNLY_ADJ_EMP_PT_TRND           varchar(10) NOT NULL
, SNLY_ADJ_EMP_PT_DLTA           integer NOT NULL
, SNLY_ADJ_EMP_PT_TTL            integer NOT NULL
, SNLY_ADJ_UNEMP_TTL_TRND        varchar(10) NOT NULL
, SNLY_ADJ_UNEMP_TTL_DLTA        integer NOT NULL
, SNLY_ADJ_UNEMP_TTL_TTL         integer NOT NULL
, SNLY_ADJ_UNEMP_FT_LOOKING_TRND varchar(10) NOT NULL
, SNLY_ADJ_UNEMP_FT_LOOKING_DLTA integer NOT NULL
, SNLY_ADJ_UNEMP_FT_LOOKING_TTL  integer NOT NULL
, SNLY_ADJ_UNEMP_PT_LOOKING_TRND varchar(10) NOT NULL
, SNLY_ADJ_UNEMP_PT_LOOKING_DLTA integer NOT NULL
, SNLY_ADJ_UNEMP_PT_LOOKING_TTL  integer NOT NULL
, SNLY_ADJ_UNEMP_RATE_TRND       varchar(10) NOT NULL
, SNLY_ADJ_UNEMP_RATE_DLTA       decimal(4, 2) NOT NULL
, SNLY_ADJ_UNEMP_RATE_TTL        decimal(4, 2) NOT NULL
, SNLY_ADJ_PRTCPTN_RATE_TRND     varchar(10) NOT NULL
, SNLY_ADJ_PRTCPTN_RATE_DLTA     decimal(4, 2) NOT NULL
, SNLY_ADJ_PRTCPTN_RATE_TTL      decimal(4, 2) NOT NULL
, SNLY_ADJ_MTHLY_HRS_WRKD_TRND   varchar(10) NOT NULL
, SNLY_ADJ_MTHLY_HRS_WRKD_DLTA   integer NOT NULL
, SNLY_ADJ_MTHLY_HRS_WRKD_TTL    integer NOT NULL
, STARTED_AT                     datetime NOT NULL
, FINISHED_AT                    datetime NOT NULL
);

CREATE NONCLUSTERED INDEX UX_F_DTL_GOVT_MEDIA_RELEASE_AU_M ON LTN.DBO.F_DTL_GOVT_MEDIA_RELEASE_AU_M ( MSMT_DTE_ID, CNTRY_CDE, SITE_CDE );

ALTER TABLE ltn.dbo.F_DTL_GOVT_MEDIA_RELEASE_AU_M REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
exec create_f_dtl_govt_media_release_au_m   @p_env = 'DEV', @p_task_nme = 'CREATE_F_DTL_GOVT_MEDIA_RELEASE_AU_M', @p_pkg_nme = 'F_DTL_GOVT_MEDIA_RELEASE_AU_M'


=======================================================================================================================================================================================================
*/

USE [ltn];
GO

IF OBJECT_ID('create_f_dtl_govt_media_release_au_m') IS NULL -- Check if SP Exists
    EXEC ('CREATE PROCEDURE create_f_dtl_govt_media_release_au_m AS SET NOCOUNT ON;'); -- Create dummy/empty SP
GO

ALTER PROCEDURE create_f_dtl_govt_media_release_au_m -- Alter the SP Always
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
         
         SET @l_tbl_nme = 'f_dtl_govt_media_release_au_m';
	    SET @l_stg_tbl_nme = 'stg_dtl_govt_media_release_au_m';
         
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

drop table #TMP_DTL_GOVT_MEDIA_RELEASE_AU
*/
		  
    CREATE TABLE #TMP_DTL_GOVT_MEDIA_RELEASE_AU
    ( MSMT_DTE_ID                    integer NOT NULL
    , DATA_TYPE                      varchar(30) NOT NULL
    , CNTRY_CDE                      varchar(2) NOT NULL
    , SITE_CDE                       varchar(20) NOT NULL
    , ANNCE_DT_TM_AET                datetime NOT NULL
    , ANNCE_PERIOD                   varchar(20) NOT NULL
    , TRND_EST_BLOCK                 varchar(2000) NOT NULL
    , TRND_EST_EMP_TRND              varchar(10) NOT NULL
    , TRND_EST_EMP_DLTA              integer NOT NULL
    , TRND_EST_EMP_TTL               integer NOT NULL
    , TRND_EST_UNEMP_TRND            varchar(10) NOT NULL
    , TRND_EST_UNEMP_DLTA            integer NOT NULL
    , TRND_EST_UNEMP_TTL             integer NOT NULL
    , TRND_EST_UNEMP_RATE_TRND       varchar(10) NOT NULL
    , TRND_EST_UNEMP_RATE_DLTA       decimal(4, 2) NOT NULL
    , TRND_EST_UNEMP_RATE_TTL        decimal(4, 2) NOT NULL
    , TRND_EST_PRTCPTN_RATE_TRND     varchar(30) NOT NULL
    , TRND_EST_PRTCPTN_RATE_DLTA     decimal(4, 2) NOT NULL
    , TRND_EST_PRTCPTN_RATE_TTL      decimal(4, 2) NOT NULL
    , TRND_EST_MTHLY_HRS_WRKD_TRND   varchar(10) NOT NULL
    , TRND_EST_MTHLY_HRS_WRKD_DLTA   integer NOT NULL
    , TRND_EST_MTHLY_HRS_WRKD_TTL    integer NOT NULL
    , SNLY_ADJ_EST_BLOCK             varchar(2000) NOT NULL
    , SNLY_ADJ_EMP_TTL_TRND          varchar(10) NOT NULL
    , SNLY_ADJ_EMP_TTL_DLTA          integer NOT NULL
    , SNLY_ADJ_EMP_TTL_TTL           integer NOT NULL
    , SNLY_ADJ_EMP_FT_TRND           varchar(10) NOT NULL
    , SNLY_ADJ_EMP_FT_DLTA           integer NOT NULL
    , SNLY_ADJ_EMP_FT_TTL            integer NOT NULL
    , SNLY_ADJ_EMP_PT_TRND           varchar(10) NOT NULL
    , SNLY_ADJ_EMP_PT_DLTA           integer NOT NULL
    , SNLY_ADJ_EMP_PT_TTL            integer NOT NULL
    , SNLY_ADJ_UNEMP_TTL_TRND        varchar(10) NOT NULL
    , SNLY_ADJ_UNEMP_TTL_DLTA        integer NOT NULL
    , SNLY_ADJ_UNEMP_TTL_TTL         integer NOT NULL
    , SNLY_ADJ_UNEMP_FT_LOOKING_TRND varchar(10) NOT NULL
    , SNLY_ADJ_UNEMP_FT_LOOKING_DLTA integer NOT NULL
    , SNLY_ADJ_UNEMP_FT_LOOKING_TTL  integer NOT NULL
    , SNLY_ADJ_UNEMP_PT_LOOKING_TRND varchar(10) NOT NULL
    , SNLY_ADJ_UNEMP_PT_LOOKING_DLTA integer NOT NULL
    , SNLY_ADJ_UNEMP_PT_LOOKING_TTL  integer NOT NULL
    , SNLY_ADJ_UNEMP_RATE_TRND       varchar(10) NOT NULL
    , SNLY_ADJ_UNEMP_RATE_DLTA       decimal(4, 2) NOT NULL
    , SNLY_ADJ_UNEMP_RATE_TTL        decimal(4, 2) NOT NULL
    , SNLY_ADJ_PRTCPTN_RATE_TRND     varchar(10) NOT NULL
    , SNLY_ADJ_PRTCPTN_RATE_DLTA     decimal(4, 2) NOT NULL
    , SNLY_ADJ_PRTCPTN_RATE_TTL      decimal(4, 2) NOT NULL
    , SNLY_ADJ_MTHLY_HRS_WRKD_TRND   varchar(10) NOT NULL
    , SNLY_ADJ_MTHLY_HRS_WRKD_DLTA   integer NOT NULL
    , SNLY_ADJ_MTHLY_HRS_WRKD_TTL    integer NOT NULL
    , STARTED_AT                     datetime NOT NULL
    , FINISHED_AT                    datetime NOT NULL
    );

    INSERT INTO #TMP_DTL_GOVT_MEDIA_RELEASE_AU ( MSMT_DTE_ID
									  , DATA_TYPE
									  , CNTRY_CDE
									  , SITE_CDE
									  , ANNCE_DT_TM_AET
									  , ANNCE_PERIOD
									  , TRND_EST_BLOCK
									  , TRND_EST_EMP_TRND
									  , TRND_EST_EMP_DLTA
									  , TRND_EST_EMP_TTL
									  , TRND_EST_UNEMP_TRND
									  , TRND_EST_UNEMP_DLTA
									  , TRND_EST_UNEMP_TTL
									  , TRND_EST_UNEMP_RATE_TRND
									  , TRND_EST_UNEMP_RATE_DLTA
									  , TRND_EST_UNEMP_RATE_TTL
									  , TRND_EST_PRTCPTN_RATE_TRND
									  , TRND_EST_PRTCPTN_RATE_DLTA
									  , TRND_EST_PRTCPTN_RATE_TTL
									  , TRND_EST_MTHLY_HRS_WRKD_TRND
									  , TRND_EST_MTHLY_HRS_WRKD_DLTA
									  , TRND_EST_MTHLY_HRS_WRKD_TTL
									  , SNLY_ADJ_EST_BLOCK
									  , SNLY_ADJ_EMP_TTL_TRND
									  , SNLY_ADJ_EMP_TTL_DLTA
									  , SNLY_ADJ_EMP_TTL_TTL
									  , SNLY_ADJ_EMP_FT_TRND
									  , SNLY_ADJ_EMP_FT_DLTA
									  , SNLY_ADJ_EMP_FT_TTL
									  , SNLY_ADJ_EMP_PT_TRND
									  , SNLY_ADJ_EMP_PT_DLTA
									  , SNLY_ADJ_EMP_PT_TTL
									  , SNLY_ADJ_UNEMP_TTL_TRND
									  , SNLY_ADJ_UNEMP_TTL_DLTA
									  , SNLY_ADJ_UNEMP_TTL_TTL
									  , SNLY_ADJ_UNEMP_FT_LOOKING_TRND
									  , SNLY_ADJ_UNEMP_FT_LOOKING_DLTA
									  , SNLY_ADJ_UNEMP_FT_LOOKING_TTL
									  , SNLY_ADJ_UNEMP_PT_LOOKING_TRND
									  , SNLY_ADJ_UNEMP_PT_LOOKING_DLTA
									  , SNLY_ADJ_UNEMP_PT_LOOKING_TTL
									  , SNLY_ADJ_UNEMP_RATE_TRND
									  , SNLY_ADJ_UNEMP_RATE_DLTA
									  , SNLY_ADJ_UNEMP_RATE_TTL
									  , SNLY_ADJ_PRTCPTN_RATE_TRND
									  , SNLY_ADJ_PRTCPTN_RATE_DLTA
									  , SNLY_ADJ_PRTCPTN_RATE_TTL
									  , SNLY_ADJ_MTHLY_HRS_WRKD_TRND
									  , SNLY_ADJ_MTHLY_HRS_WRKD_DLTA
									  , SNLY_ADJ_MTHLY_HRS_WRKD_TTL
									  , STARTED_AT
									  , FINISHED_AT
									  )
    SELECT convert( varchar(10), DT.LAST_DAY_OF_MONTH, 112) AS MSMT_DTE_ID
	    , DATA_TYPE
	    , CNTRY_CDE
	    , SITE_CDE
	    , cast(ANNCE_DTE AS    datetime) AS ANNCE_DT_TM_AET
	    , upper(datename(month, dateadd(month, -1, cast(ANNCE_DTE AS   date)))+'-'+cast(datepart(year, dateadd(month, -1, cast(ANNCE_DTE AS date))) AS varchar(4))) AS ANNCE_PERIOD
	    , TRND_EST_BLOCK
	    , TRND_EST_EMP_TRND
	    , TRND_EST_EMP_DLTA
	    , TRND_EST_EMP_TTL
	    , TRND_EST_UNEMP_TRND
	    , TRND_EST_UNEMP_DLTA
	    , TRND_EST_UNEMP_TTL
	    , TRND_EST_UNEMP_RATE_TRND
	    , TRND_EST_UNEMP_RATE_DLTA
	    , TRND_EST_UNEMP_RATE_TTL
	    , TRND_EST_PRTCPTN_RATE_TRND
	    , TRND_EST_PRTCPTN_RATE_DLTA
	    , TRND_EST_PRTCPTN_RATE_TTL
	    , TRND_EST_MTHLY_HRS_WRKD_TRND
	    , TRND_EST_MTHLY_HRS_WRKD_DLTA
	    , TRND_EST_MTHLY_HRS_WRKD_TTL
	    , SNLY_ADJ_EST_BLOCK
	    , SNLY_ADJ_EMP_TTL_TRND
	    , SNLY_ADJ_EMP_TTL_DLTA
	    , SNLY_ADJ_EMP_TTL_TTL
	    , SNLY_ADJ_EMP_FT_TRND
	    , SNLY_ADJ_EMP_FT_DLTA
	    , SNLY_ADJ_EMP_FT_TTL
	    , SNLY_ADJ_EMP_PT_TRND
	    , SNLY_ADJ_EMP_PT_DLTA
	    , SNLY_ADJ_EMP_PT_TTL
	    , SNLY_ADJ_UNEMP_TTL_TRND
	    , SNLY_ADJ_UNEMP_TTL_DLTA
	    , SNLY_ADJ_UNEMP_TTL_TTL
	    , SNLY_ADJ_UNEMP_FT_LOOKING_TRND
	    , SNLY_ADJ_UNEMP_FT_LOOKING_DLTA
	    , SNLY_ADJ_UNEMP_FT_LOOKING_TTL
	    , SNLY_ADJ_UNEMP_PT_LOOKING_TRND
	    , SNLY_ADJ_UNEMP_PT_LOOKING_DLTA
	    , SNLY_ADJ_UNEMP_PT_LOOKING_TTL
	    , SNLY_ADJ_UNEMP_RATE_TRND
	    , SNLY_ADJ_UNEMP_RATE_DLTA
	    , SNLY_ADJ_UNEMP_RATE_TTL
	    , SNLY_ADJ_PRTCPTN_RATE_TRND
	    , SNLY_ADJ_PRTCPTN_RATE_DLTA
	    , SNLY_ADJ_PRTCPTN_RATE_TTL
	    , SNLY_ADJ_MTHLY_HRS_WRKD_TRND
	    , SNLY_ADJ_MTHLY_HRS_WRKD_DLTA
	    , SNLY_ADJ_MTHLY_HRS_WRKD_TTL
	    , cast(STARTED_AT AS    datetime) AS STARTED_AT
	    , cast(FINISHED_AT AS    datetime) AS FINISHED_AT
	 FROM openquery(PY_WEB_DATA, '
						   SELECT  DAT.MSMT_DTE_ID
								,DAT.DATA_TYPE
								,DAT.CNTRY_CDE
								,DAT.SITE_CDE
								,DAT.ANNCE_DTE
								,DAT.TRND_EST_BLOCK
								,DAT.TRND_EST_EMP_TRND
								,DAT.TRND_EST_EMP_DLTA
								,DAT.TRND_EST_EMP_TTL
								,DAT.TRND_EST_UNEMP_TRND
								,DAT.TRND_EST_UNEMP_DLTA
								,DAT.TRND_EST_UNEMP_TTL
								,DAT.TRND_EST_UNEMP_RATE_TRND
								,DAT.TRND_EST_UNEMP_RATE_DLTA
								,DAT.TRND_EST_UNEMP_RATE_TTL
								,DAT.TRND_EST_PRTCPTN_RATE_TRND
								,DAT.TRND_EST_PRTCPTN_RATE_DLTA
								,DAT.TRND_EST_PRTCPTN_RATE_TTL
								,DAT.TRND_EST_MTHLY_HRS_WRKD_TRND
								,DAT.TRND_EST_MTHLY_HRS_WRKD_DLTA
								,DAT.TRND_EST_MTHLY_HRS_WRKD_TTL
								,DAT.SNLY_ADJ_EST_BLOCK
								,DAT.SNLY_ADJ_EMP_TTL_TRND
								,DAT.SNLY_ADJ_EMP_TTL_DLTA
								,DAT.SNLY_ADJ_EMP_TTL_TTL
								,DAT.SNLY_ADJ_EMP_FT_TRND
								,DAT.SNLY_ADJ_EMP_FT_DLTA
								,DAT.SNLY_ADJ_EMP_FT_TTL
								,DAT.SNLY_ADJ_EMP_PT_TRND
								,DAT.SNLY_ADJ_EMP_PT_DLTA
								,DAT.SNLY_ADJ_EMP_PT_TTL
								,DAT.SNLY_ADJ_UNEMP_TTL_TRND
								,DAT.SNLY_ADJ_UNEMP_TTL_DLTA
								,DAT.SNLY_ADJ_UNEMP_TTL_TTL
								,DAT.SNLY_ADJ_UNEMP_FT_LOOKING_TRND
								,DAT.SNLY_ADJ_UNEMP_FT_LOOKING_DLTA
								,DAT.SNLY_ADJ_UNEMP_FT_LOOKING_TTL
								,DAT.SNLY_ADJ_UNEMP_PT_LOOKING_TRND
								,DAT.SNLY_ADJ_UNEMP_PT_LOOKING_DLTA
								,DAT.SNLY_ADJ_UNEMP_PT_LOOKING_TTL
								,DAT.SNLY_ADJ_UNEMP_RATE_TRND
								,DAT.SNLY_ADJ_UNEMP_RATE_DLTA
								,DAT.SNLY_ADJ_UNEMP_RATE_TTL
								,DAT.SNLY_ADJ_PRTCPTN_RATE_TRND
								,DAT.SNLY_ADJ_PRTCPTN_RATE_DLTA
								,DAT.SNLY_ADJ_PRTCPTN_RATE_TTL
								,DAT.SNLY_ADJ_MTHLY_HRS_WRKD_TRND
								,DAT.SNLY_ADJ_MTHLY_HRS_WRKD_DLTA
								,DAT.SNLY_ADJ_MTHLY_HRS_WRKD_TTL
								,DAT.STARTED_AT
								,DAT.FINISHED_AT
							 FROM PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE AS DAT') AS DAT
		 INNER JOIN LTN.DBO.DIM_DTE AS DT
		 ON 1 = 1
		    AND convert( varchar(10), cast(ANNCE_DTE AS date), 112) = DT.DTE_ID;


/*
STEP 2 
---------------------------------------------------------------------------------------------------
** insert into final f_dtl table 
** only insert missing records from the fact table (exist in sqlite3 db but not in sqlserver)

*/

    INSERT INTO LTN.DBO.F_DTL_GOVT_MEDIA_RELEASE_AU_M ( MSMT_DTE_ID
										    , DATA_TYPE
										    , CNTRY_CDE
										    , SITE_CDE
										    , ANNCE_DT_TM_AET
										    , ANNCE_PERIOD
										    , TRND_EST_BLOCK
										    , TRND_EST_EMP_TRND
										    , TRND_EST_EMP_DLTA
										    , TRND_EST_EMP_TTL
										    , TRND_EST_UNEMP_TRND
										    , TRND_EST_UNEMP_DLTA
										    , TRND_EST_UNEMP_TTL
										    , TRND_EST_UNEMP_RATE_TRND
										    , TRND_EST_UNEMP_RATE_DLTA
										    , TRND_EST_UNEMP_RATE_TTL
										    , TRND_EST_PRTCPTN_RATE_TRND
										    , TRND_EST_PRTCPTN_RATE_DLTA
										    , TRND_EST_PRTCPTN_RATE_TTL
										    , TRND_EST_MTHLY_HRS_WRKD_TRND
										    , TRND_EST_MTHLY_HRS_WRKD_DLTA
										    , TRND_EST_MTHLY_HRS_WRKD_TTL
										    , SNLY_ADJ_EST_BLOCK
										    , SNLY_ADJ_EMP_TTL_TRND
										    , SNLY_ADJ_EMP_TTL_DLTA
										    , SNLY_ADJ_EMP_TTL_TTL
										    , SNLY_ADJ_EMP_FT_TRND
										    , SNLY_ADJ_EMP_FT_DLTA
										    , SNLY_ADJ_EMP_FT_TTL
										    , SNLY_ADJ_EMP_PT_TRND
										    , SNLY_ADJ_EMP_PT_DLTA
										    , SNLY_ADJ_EMP_PT_TTL
										    , SNLY_ADJ_UNEMP_TTL_TRND
										    , SNLY_ADJ_UNEMP_TTL_DLTA
										    , SNLY_ADJ_UNEMP_TTL_TTL
										    , SNLY_ADJ_UNEMP_FT_LOOKING_TRND
										    , SNLY_ADJ_UNEMP_FT_LOOKING_DLTA
										    , SNLY_ADJ_UNEMP_FT_LOOKING_TTL
										    , SNLY_ADJ_UNEMP_PT_LOOKING_TRND
										    , SNLY_ADJ_UNEMP_PT_LOOKING_DLTA
										    , SNLY_ADJ_UNEMP_PT_LOOKING_TTL
										    , SNLY_ADJ_UNEMP_RATE_TRND
										    , SNLY_ADJ_UNEMP_RATE_DLTA
										    , SNLY_ADJ_UNEMP_RATE_TTL
										    , SNLY_ADJ_PRTCPTN_RATE_TRND
										    , SNLY_ADJ_PRTCPTN_RATE_DLTA
										    , SNLY_ADJ_PRTCPTN_RATE_TTL
										    , SNLY_ADJ_MTHLY_HRS_WRKD_TRND
										    , SNLY_ADJ_MTHLY_HRS_WRKD_DLTA
										    , SNLY_ADJ_MTHLY_HRS_WRKD_TTL
										    , STARTED_AT
										    , FINISHED_AT
										    )
    SELECT TMP.MSMT_DTE_ID
	    , TMP.DATA_TYPE
	    , TMP.CNTRY_CDE
	    , TMP.SITE_CDE
	    , TMP.ANNCE_DT_TM_AET
	    , TMP.ANNCE_PERIOD
	    , TMP.TRND_EST_BLOCK
	    , TMP.TRND_EST_EMP_TRND
	    , TMP.TRND_EST_EMP_DLTA
	    , TMP.TRND_EST_EMP_TTL
	    , TMP.TRND_EST_UNEMP_TRND
	    , TMP.TRND_EST_UNEMP_DLTA
	    , TMP.TRND_EST_UNEMP_TTL
	    , TMP.TRND_EST_UNEMP_RATE_TRND
	    , TMP.TRND_EST_UNEMP_RATE_DLTA
	    , TMP.TRND_EST_UNEMP_RATE_TTL
	    , TMP.TRND_EST_PRTCPTN_RATE_TRND
	    , TMP.TRND_EST_PRTCPTN_RATE_DLTA
	    , TMP.TRND_EST_PRTCPTN_RATE_TTL
	    , TMP.TRND_EST_MTHLY_HRS_WRKD_TRND
	    , TMP.TRND_EST_MTHLY_HRS_WRKD_DLTA
	    , TMP.TRND_EST_MTHLY_HRS_WRKD_TTL
	    , TMP.SNLY_ADJ_EST_BLOCK
	    , TMP.SNLY_ADJ_EMP_TTL_TRND
	    , TMP.SNLY_ADJ_EMP_TTL_DLTA
	    , TMP.SNLY_ADJ_EMP_TTL_TTL
	    , TMP.SNLY_ADJ_EMP_FT_TRND
	    , TMP.SNLY_ADJ_EMP_FT_DLTA
	    , TMP.SNLY_ADJ_EMP_FT_TTL
	    , TMP.SNLY_ADJ_EMP_PT_TRND
	    , TMP.SNLY_ADJ_EMP_PT_DLTA
	    , TMP.SNLY_ADJ_EMP_PT_TTL
	    , TMP.SNLY_ADJ_UNEMP_TTL_TRND
	    , TMP.SNLY_ADJ_UNEMP_TTL_DLTA
	    , TMP.SNLY_ADJ_UNEMP_TTL_TTL
	    , TMP.SNLY_ADJ_UNEMP_FT_LOOKING_TRND
	    , TMP.SNLY_ADJ_UNEMP_FT_LOOKING_DLTA
	    , TMP.SNLY_ADJ_UNEMP_FT_LOOKING_TTL
	    , TMP.SNLY_ADJ_UNEMP_PT_LOOKING_TRND
	    , TMP.SNLY_ADJ_UNEMP_PT_LOOKING_DLTA
	    , TMP.SNLY_ADJ_UNEMP_PT_LOOKING_TTL
	    , TMP.SNLY_ADJ_UNEMP_RATE_TRND
	    , TMP.SNLY_ADJ_UNEMP_RATE_DLTA
	    , TMP.SNLY_ADJ_UNEMP_RATE_TTL
	    , TMP.SNLY_ADJ_PRTCPTN_RATE_TRND
	    , TMP.SNLY_ADJ_PRTCPTN_RATE_DLTA
	    , TMP.SNLY_ADJ_PRTCPTN_RATE_TTL
	    , TMP.SNLY_ADJ_MTHLY_HRS_WRKD_TRND
	    , TMP.SNLY_ADJ_MTHLY_HRS_WRKD_DLTA
	    , TMP.SNLY_ADJ_MTHLY_HRS_WRKD_TTL
	    , TMP.STARTED_AT
	    , TMP.FINISHED_AT
	 FROM #TMP_DTL_GOVT_MEDIA_RELEASE_AU AS TMP
		 LEFT OUTER JOIN LTN.DBO.F_DTL_GOVT_MEDIA_RELEASE_AU_M AS DTL
		 ON 1 = 1
		    AND TMP.MSMT_DTE_ID = DTL.MSMT_DTE_ID
		    AND TMP.DATA_TYPE = DTL.DATA_TYPE
		    AND TMP.CNTRY_CDE = DTL.CNTRY_CDE
		    AND TMP.SITE_CDE = DTL.SITE_CDE
	WHERE 1 = 1
		 AND DTL.MSMT_DTE_ID IS NULL
		 AND DTL.DATA_TYPE IS NULL
		 AND DTL.CNTRY_CDE IS NULL
		 AND DTL.SITE_CDE IS NULL;
						 
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

