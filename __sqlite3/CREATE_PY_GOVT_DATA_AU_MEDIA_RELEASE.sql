/*
===================================================================================================
TABLE CREATION
===================================================================================================
drop
	table
		PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE;

CREATE
	TABLE
		PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE
		(
			ID INTEGER PRIMARY KEY AUTOINCREMENT,
			MSMT_DTE_ID INTEGER,
			DATA_TYPE VARCHAR(30),
			CNTRY_CDE VARCHAR(2),
			SITE_CDE VARCHAR(20),
			ANNCE_DTE VARCHAR(20),
			TRND_EST_BLOCK VARCHAR(2000),
			TRND_EST_EMP_TRND VARCHAR(30),
			TRND_EST_EMP_DLTA VARCHAR(30),
			TRND_EST_EMP_TTL VARCHAR(30),
			TRND_EST_UNEMP_TRND VARCHAR(30),
			TRND_EST_UNEMP_DLTA VARCHAR(30),
			TRND_EST_UNEMP_TTL VARCHAR(30),
			TRND_EST_UNEMP_RATE_TRND VARCHAR(30),
			TRND_EST_UNEMP_RATE_DLTA VARCHAR(30),
			TRND_EST_UNEMP_RATE_TTL VARCHAR(30),
			TRND_EST_PRTCPTN_RATE_TRND VARCHAR(30),
			TRND_EST_PRTCPTN_RATE_DLTA VARCHAR(30),
			TRND_EST_PRTCPTN_RATE_TTL VARCHAR(30),
			TRND_EST_MTHLY_HRS_WRKD_TRND VARCHAR(30),
			TRND_EST_MTHLY_HRS_WRKD_DLTA VARCHAR(30),
			--TRND_EST_MTHLY_HRS_WRKD_DLTA_PCNT VARCHAR(30),
			TRND_EST_MTHLY_HRS_WRKD_TTL VARCHAR(30),
			-------------
			SNLY_ADJ_EST_BLOCK VARCHAR(2000),
			SNLY_ADJ_EMP_TTL_TRND VARCHAR(30),
			SNLY_ADJ_EMP_TTL_DLTA VARCHAR(30),
			SNLY_ADJ_EMP_TTL_TTL VARCHAR(30),
			SNLY_ADJ_EMP_FT_TRND VARCHAR(30),
			SNLY_ADJ_EMP_FT_DLTA VARCHAR(30),
			SNLY_ADJ_EMP_FT_TTL VARCHAR(30),
			SNLY_ADJ_EMP_PT_TRND VARCHAR(30),
			SNLY_ADJ_EMP_PT_DLTA VARCHAR(30),
			SNLY_ADJ_EMP_PT_TTL VARCHAR(30),
			SNLY_ADJ_UNEMP_TTL_TRND VARCHAR(30),
			SNLY_ADJ_UNEMP_TTL_DLTA VARCHAR(30),
			SNLY_ADJ_UNEMP_TTL_TTL VARCHAR(30),
			SNLY_ADJ_UNEMP_FT_LOOKING_TRND VARCHAR(30),
			SNLY_ADJ_UNEMP_FT_LOOKING_DLTA VARCHAR(30),
			SNLY_ADJ_UNEMP_FT_LOOKING_TTL VARCHAR(30),
			SNLY_ADJ_UNEMP_PT_LOOKING_TRND VARCHAR(30),
			SNLY_ADJ_UNEMP_PT_LOOKING_DLTA VARCHAR(30),
			SNLY_ADJ_UNEMP_PT_LOOKING_TTL VARCHAR(30),
			SNLY_ADJ_UNEMP_RATE_TRND VARCHAR(30),
			SNLY_ADJ_UNEMP_RATE_DLTA VARCHAR(30),
			SNLY_ADJ_UNEMP_RATE_TTL VARCHAR(30),
			SNLY_ADJ_PRTCPTN_RATE_TRND VARCHAR(30),
			SNLY_ADJ_PRTCPTN_RATE_DLTA VARCHAR(30),
			SNLY_ADJ_PRTCPTN_RATE_TTL VARCHAR(30),
			SNLY_ADJ_MTHLY_HRS_WRKD_TRND VARCHAR(30),
			SNLY_ADJ_MTHLY_HRS_WRKD_DLTA VARCHAR(30),
			--SNLY_ADJ_MTHLY_HRS_WRKD_DLTA_PCNT VARCHAR(30),
			SNLY_ADJ_MTHLY_HRS_WRKD_TTL VARCHAR(30),
			STARTED_AT VARCHAR(20),
			FINISHED_AT VARCHAR(20)
		);

===================================================================================================
*/

select * from PY_GOVT_DATA_MTHLY_CHNG_AU_MEDIA_RELEASE;


