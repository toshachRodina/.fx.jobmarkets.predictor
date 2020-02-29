/*
=======================================================================================================================================================================================================
SUBJECT		 : Global Industry Classification Standard
OBJECT TYPE	 : TABLE
OBJECT NAME	 : ltn.dbo.rltshp_facet_desc_indstry_clsfctn
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170816
SOURCE		 : 
PREPERATION	 : CREATE TABLE
			   INSERT VALUES REQUIRED FOR SSIS RUNNING
REMARKS		 : 1) https://en.wikipedia.org/wiki/Global_Industry_Classification_Standard
			   2)
			   3)
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.rltshp_facet_desc_indstry_clsfctn;


CREATE TABLE LTN.DBO.RLTSHP_FACET_DESC_INDSTRY_CLSFCTN
( FACET_DESC   varchar(255) NOT NULL
, SUB_IND_ID   int NOT NULL
, START_DTE_ID int NOT NULL
, END_DTE_ID   int NOT NULL
);

--------------------------------------------------------------------------------------

SELECT 'insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values (''' + dat2.FACET_DESC + ''',' + ltrim(rtrim(str(dat2.SUB_IND_ID))) + ',' + ltrim(rtrim(str(19000101))) + ',' + ltrim(rtrim(str(29991231))) + ');'
  FROM (
       SELECT DAT.FACET_DESC
            , CASE
                   WHEN DAT.FACET_DESC IN ( 'ACCOUNTANCY & FINANCE', 'ACCOUNTING', 'ACCOUNTING - AUDITING', 'ACCOUNTING & FINANCE JOBS', 'FINANCE' )
                   THEN 40201020
                   WHEN DAT.FACET_DESC IN ( 'BANKING', 'BANKING - FINANCIAL SERVICES', 'BANKING & FINANCIAL SERVICES', 'FINANCE, ACCOUNTING & BANKING' )
                   THEN 40101010
                   WHEN DAT.FACET_DESC IN ( 'AGRICULTURE', 'AGRICULTURE - FORESTRY - FISHING', 'AGRICULTURE, ANIMALS & CONSERVATION', 'AGRICULTURE, FORESTRY & FISHING', 'APPAREL - FASHION - TEXTILE', 'FARMING & VETERINARY', 'FARMING, ANIMALS & CONSERVATION' )
                   THEN 30202010
                   WHEN DAT.FACET_DESC IN ( 'MARKETING', 'MARKETING - PUBLIC RELATIONS', 'MARKETING & COMMUNICATIONS', 'MARKETING & DIGITAL', 'PR, ADVERTISING & MARKETING JOBS', 'SALES & MARKETING' )
                   THEN 25502020
                   WHEN DAT.FACET_DESC IN ( 'ARCHITECTURE', 'ARCHITECTURE & DESIGN', 'ART', 'ARTS', 'ARTS - DESIGN - ENTERTAINMENT', 'CREATIVE & DESIGN JOBS', 'DESIGN & ARCHITECTURE', 'MEDIA' )
                   THEN 25401030
                   WHEN DAT.FACET_DESC IN ( 'ADVERTISING, ARTS & MEDIA', 'ADVERTISING, MEDIA & ENTERTAINMENT', 'COMMUNICATIONS, ADVERTISING, ARTS & MEDIA', 'MEDIA - ADVERTISING' )
                   THEN 25401010
                   WHEN DAT.FACET_DESC IN ( 'CALL-CENTRE', 'CALL CENTRE & CUSTOMER SERVICE', 'CALL CENTRE & CUSTOMER SERVICES', 'CUSTOMER SERVICE', 'CUSTOMER SERVICE - CALL CENTERS', 'CUSTOMER SERVICE & CALL CENTRE', 'CUSTOMER SERVICES JOBS', 'CUSTOMER-SERVICE', 'CONTACT CENTRES', 'DATA-ENTRY', 'TRANSLATIONS' )
                   THEN 20201070
                   WHEN DAT.FACET_DESC IN ( 'ADMIN', 'ADMIN JOBS', 'ADMINISTRATION & OFFICE SUPPORT', 'ADMINISTRATIVE', 'OFFICE & ADMINISTRATION', 'OFFICE SUPPORT', 'SECRETARIAL - PAS - ADMINISTRATION', 'RECEPTIONIST', 'QUALITY ASSURANCE' )
                   THEN 20201060
                   WHEN DAT.FACET_DESC IN ( 'AEROSPACE - DEFENCE', 'DEFENCE & PROTECTIVE SERVICES', 'DEFENCE, MILITARY & ARMED FORCES', 'GOVERNMENT & DEFENCE', 'SECURITY', 'LAW ENFORCEMENT', 'LAW ENFORCEMENT - SECURITY' )
                   THEN 20101010
                   WHEN DAT.FACET_DESC IN ( 'CONSTRUCTION', 'CONSTRUCTION & CIVIL ENGINEERING', 'TRADE & CONSTRUCTION JOBS', 'TRADES & LABOUR', 'TRADES & SERVICES', 'WOOD - PAPER - FURNITURE', 'ARCHITECTURE - BUILDING - CONSTRUCTION', 'ENGINEERING', 'ENGINEERING JOBS', 'AUTOMOTIVE - MOTOR VEHICLES', 'MECHANICAL', 'MAINTENANCE', 'MAINTENANCE JOBS' )
                   THEN 20103010
                   WHEN DAT.FACET_DESC IN ( 'TOURISM - TRAVEL - HOSPITALITY', 'TRAVEL', 'TRAVEL & TOURISM', 'TRAVEL JOBS', 'HOSPITALITY & TOURISM', 'SPORT', 'SPORT & RECREATION', 'SPORTS - LEISURE - RECREATION', 'SPORTS & RECREATION', 'COMMUNITY & SPORT', 'FACILITIES MANAGEMENT', 'FACILITIES' )
                   THEN 25301030
                   WHEN DAT.FACET_DESC IN ( 'FOOD & HOSPITALITY', 'FOOD SERVICE', 'RESTAURANT', 'RESTAURANTS - FOOD SERVICE', 'HOSPITALITY', 'HOSPITALITY & CATERING JOBS' )
                   THEN 25301040
                   WHEN DAT.FACET_DESC IN ( 'HOTEL' )
                   THEN 25301020
                   WHEN DAT.FACET_DESC IN ( 'EDUCATION', 'EDUCATION - TRAINING', 'EDUCATION & TEACHING', 'EDUCATION & TRAINING', 'TEACHING', 'TEACHING JOBS', 'TRAINING' )
                   THEN 25302010
                   WHEN DAT.FACET_DESC IN ( 'TRANSPORT & LOGISTICS', 'TRANSPORTATION', 'TRANSPORTATION - LOGISTICS', 'DRIVER', 'DRIVING' )
                   THEN 20304020
                   WHEN DAT.FACET_DESC IN ( 'HEALTH & MEDICAL', 'HEALTH CARE', 'HEALTHCARE', 'HEALTHCARE & MEDICAL', 'HEALTHCARE & NURSING', 'HEALTHCARE & NURSING JOBS', 'PERSONAL CARE', 'SOCIAL CARE', 'SOCIAL WORK JOBS' )
                   THEN 35102015
                   WHEN DAT.FACET_DESC IN ( 'HR', 'HR & RECRUITMENT', 'HR & RECRUITMENT JOBS', 'HUMAN RESOURCES', 'HUMAN RESOURCES & RECRUITMENT', 'RECRUITMENT & HR' )
                   THEN 20202010
                   WHEN DAT.FACET_DESC IN ( 'INSURANCE', 'INSURANCE & SUPERANNUATION' )
                   THEN 40301020
                   WHEN DAT.FACET_DESC IN ( 'COMPUTER', 'INFORMATION & COMMUNICATION TECHNOLOGY', 'INFORMATION & COMMUNICATION TECHNOLOGY (ICT)', 'INFORMATION TECHNOLOGY - TELECOMS', 'IT', 'IT & TELECOMMUNICATIONS', 'IT JOBS' )
                   THEN 45102010
                   WHEN DAT.FACET_DESC IN ( 'MINING', 'RESOURCES & MINING', 'STEELS - METALS' )
                   THEN 15104020
                   WHEN DAT.FACET_DESC IN ( 'MINING & ENERGY', 'MINING, ENERGY, OIL & GAS', 'MINING, RESOURCES & ENERGY', 'OIL - GAS - MINING', 'OIL & GAS', 'ENERGY', 'ENERGY, OIL & GAS JOBS' )
                   THEN 10101010
                   WHEN DAT.FACET_DESC IN ( 'PROPERTY', 'PROPERTY JOBS', 'REAL ESTATE', 'REAL ESTATE & PROPERTY' )
                   THEN 60102010
                   WHEN DAT.FACET_DESC IN ( 'PHARMACEUTICAL', 'SCIENCE, BIOTECH & PHARMACEUTICALS' )
                   THEN 35202010
                   WHEN DAT.FACET_DESC IN ( 'SCIENCE', 'SCIENCE - RESEARCH - DEVELOPMENT', 'SCIENCE & TECHNOLOGY', 'SCIENTIFIC', 'SCIENTIFIC & QA JOBS', 'LIFE SCIENCES' )
                   THEN 35203010
                   WHEN DAT.FACET_DESC IN ( 'DOMESTIC HELP & CLEANING JOBS' )
                   THEN 25201050
                   WHEN DAT.FACET_DESC IN ( 'CONSULTANCY JOBS', 'CONSULTANCY', 'CONSULTING', 'CONSULTING & CORPORATE STRATEGY', 'CONSULTING & STRATEGY', 'POLICY & STRATEGY', 'MANAGEMENT', 'MANAGEMENT - EXECUTIVE', 'EXECUTIVE', 'EXECUTIVE & GENERAL MANAGEMENT', 'BUSINESS', 'CEO & GENERAL MANAGEMENT', 'PUBLIC SECTOR', 'PROCUREMENT', 'PURCHASING' )
                   THEN 20202020
                   WHEN DAT.FACET_DESC IN ( 'RETAIL', 'RETAIL - WHOLESALE', 'RETAIL & CONSUMER PRODUCTS', 'RETAIL JOBS', 'SALES', 'SALES JOBS' )
                   THEN 25503020
                   WHEN DAT.FACET_DESC IN ( 'PUBLISHING', 'PUBLISHING - PRINTING' )
                   THEN 25401040
                   WHEN DAT.FACET_DESC IN ( 'MARITIME - SHIPBUILDING - BOATING' )
                   THEN 20303010
                   WHEN DAT.FACET_DESC IN ( 'MANUFACTURING, TRANSPORT & LOGISTICS' )
                   THEN 20305020
                   WHEN DAT.FACET_DESC IN ( 'MANUFACTURING - MAINTENANCE', 'MANUFACTURING & OPERATIONS', 'MANUFACTURING JOBS', 'MANUFACTURING' )
                   THEN 20106020
                   WHEN DAT.FACET_DESC IN ( 'LEGAL', 'LEGAL - TAX', 'LEGAL JOBS', 'COMMUNITY SERVICES', 'COMMUNITY SERVICES & DEVELOPMENT' )
                   THEN 25302020
                   WHEN DAT.FACET_DESC IN ( 'ELECTRONICS - ROBOTICS' )
                   THEN 45202030
                   WHEN DAT.FACET_DESC IN ( 'FOOD PROCESSING' )
                   THEN 30202030
                   WHEN DAT.FACET_DESC IN ( 'LOGISTICS', 'LOGISTICS & WAREHOUSE JOBS' )
                   THEN 20201050
                   WHEN DAT.FACET_DESC IN ( 'OTHER', 'OTHER JOBS', 'OTHER/GENERAL JOBS' )
                   THEN 77777777
                   WHEN DAT.FACET_DESC IN ( 'GRADUATE', 'GRADUATE JOBS', 'PART TIME JOBS', 'PART-TIME', 'WORK-FROM-HOME', 'ENTRY-LEVEL', 'SELF EMPLOYMENT' )
                   THEN 88888888
                   WHEN DAT.FACET_DESC IN ( 'VOLUNTEERING', 'CHARITY & VOLUNTARY JOBS', 'CHARITIES - NOT FOR PROFIT' )
                   THEN 99999999
                   ELSE NULL
              END AS SUB_IND_ID
         FROM (
              SELECT DISTINCT
                     FACET_DESC
                FROM LTN.DBO.F_DTL_JOB_SCRAPE_D
               WHERE 1 = 1
                     AND CNTRY_CDE = 'AU'
                     AND MSMT_DTE_ID >= 20170816
                     AND FACET_TYPE IN ( 'INDUSTRY'
                                       , 'CATEGORY'
                                       , 'INDUSTRIES'
                                       , 'SECTOR'
                                       , 'SECTORS'
                                       )
              ) AS DAT
        WHERE 1 = 1
       ) AS DAT2
	  order by dat2.SUB_IND_ID, dat2.FACET_DESC;



select * from ltn.dbo.rltshp_facet_desc_indstry_clsfctn


SELECT rel.FACET_DESC
      ,rel.SUB_IND_ID as FACET_SUB_IND_ID
      ,clsf.SECTOR_ID
	 ,clsf.SECTOR_DESC
	 ,clsf.IND_GRP_ID
	 ,clsf.IND_GRP_DESC
	 ,clsf.IND_ID
	 ,clsf.IND_DESC
	 ,clsf.SUB_IND_ID
	 ,clsf.SUB_IND_DESC
  FROM LTN.DBO.RLTSHP_FACET_DESC_INDSTRY_CLSFCTN AS REL
       left outer join
	  ltn.dbo.REF_GLBL_INDSTRY_CLSFCTN_STNDRD as clsf
	  on rel.SUB_IND_ID = clsf.SUB_IND_ID
 WHERE 1 = 1
       AND REL.END_DTE_ID = 29991231;

=======================================================================================================================================================================================================
*/

truncate table ltn.dbo.rltshp_facet_desc_indstry_clsfctn;


insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ENERGY',10101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ENERGY, OIL & GAS JOBS',10101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MINING & ENERGY',10101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MINING, ENERGY, OIL & GAS',10101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MINING, RESOURCES & ENERGY',10101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('OIL - GAS - MINING',10101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('OIL & GAS',10101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MINING',15104020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RESOURCES & MINING',15104020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('STEELS - METALS',15104020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('AEROSPACE - DEFENCE',20101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('DEFENCE & PROTECTIVE SERVICES',20101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('DEFENCE, MILITARY & ARMED FORCES',20101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('GOVERNMENT & DEFENCE',20101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('LAW ENFORCEMENT',20101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('LAW ENFORCEMENT - SECURITY',20101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SECURITY',20101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ARCHITECTURE - BUILDING - CONSTRUCTION',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('AUTOMOTIVE - MOTOR VEHICLES',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CONSTRUCTION',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CONSTRUCTION & CIVIL ENGINEERING',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ENGINEERING',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ENGINEERING JOBS',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MAINTENANCE',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MAINTENANCE JOBS',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MECHANICAL',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRADE & CONSTRUCTION JOBS',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRADES & LABOUR',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRADES & SERVICES',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('WOOD - PAPER - FURNITURE',20103010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MANUFACTURING',20106020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MANUFACTURING - MAINTENANCE',20106020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MANUFACTURING & OPERATIONS',20106020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MANUFACTURING JOBS',20106020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('LOGISTICS',20201050,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('LOGISTICS & WAREHOUSE JOBS',20201050,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ADMIN',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ADMIN JOBS',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ADMINISTRATION & OFFICE SUPPORT',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ADMINISTRATIVE',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('OFFICE & ADMINISTRATION',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('OFFICE SUPPORT',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('QUALITY ASSURANCE',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RECEPTIONIST',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SECRETARIAL - PAS - ADMINISTRATION',20201060,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CALL CENTRE & CUSTOMER SERVICE',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CALL CENTRE & CUSTOMER SERVICES',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CALL-CENTRE',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CONTACT CENTRES',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CUSTOMER SERVICE',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CUSTOMER SERVICE - CALL CENTERS',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CUSTOMER SERVICE & CALL CENTRE',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CUSTOMER SERVICES JOBS',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CUSTOMER-SERVICE',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('DATA-ENTRY',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRANSLATIONS',20201070,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HR',20202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HR & RECRUITMENT',20202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HR & RECRUITMENT JOBS',20202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HUMAN RESOURCES',20202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HUMAN RESOURCES & RECRUITMENT',20202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RECRUITMENT & HR',20202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('BUSINESS',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CEO & GENERAL MANAGEMENT',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CONSULTANCY',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CONSULTANCY JOBS',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CONSULTING',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CONSULTING & CORPORATE STRATEGY',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CONSULTING & STRATEGY',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('EXECUTIVE',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('EXECUTIVE & GENERAL MANAGEMENT',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MANAGEMENT',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MANAGEMENT - EXECUTIVE',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('POLICY & STRATEGY',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PROCUREMENT',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PUBLIC SECTOR',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PURCHASING',20202020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MARITIME - SHIPBUILDING - BOATING',20303010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('DRIVER',20304020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('DRIVING',20304020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRANSPORT & LOGISTICS',20304020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRANSPORTATION',20304020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRANSPORTATION - LOGISTICS',20304020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MANUFACTURING, TRANSPORT & LOGISTICS',20305020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('DOMESTIC HELP & CLEANING JOBS',25201050,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HOTEL',25301020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('COMMUNITY & SPORT',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FACILITIES',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FACILITIES MANAGEMENT',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HOSPITALITY & TOURISM',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SPORT',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SPORT & RECREATION',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SPORTS - LEISURE - RECREATION',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SPORTS & RECREATION',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TOURISM - TRAVEL - HOSPITALITY',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRAVEL',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRAVEL & TOURISM',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRAVEL JOBS',25301030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FOOD & HOSPITALITY',25301040,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FOOD SERVICE',25301040,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HOSPITALITY',25301040,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HOSPITALITY & CATERING JOBS',25301040,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RESTAURANT',25301040,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RESTAURANTS - FOOD SERVICE',25301040,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('EDUCATION',25302010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('EDUCATION - TRAINING',25302010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('EDUCATION & TEACHING',25302010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('EDUCATION & TRAINING',25302010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TEACHING',25302010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TEACHING JOBS',25302010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('TRAINING',25302010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('COMMUNITY SERVICES',25302020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('COMMUNITY SERVICES & DEVELOPMENT',25302020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('LEGAL',25302020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('LEGAL - TAX',25302020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('LEGAL JOBS',25302020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ADVERTISING, ARTS & MEDIA',25401010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ADVERTISING, MEDIA & ENTERTAINMENT',25401010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('COMMUNICATIONS, ADVERTISING, ARTS & MEDIA',25401010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MEDIA - ADVERTISING',25401010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ARCHITECTURE',25401030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ARCHITECTURE & DESIGN',25401030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ART',25401030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ARTS',25401030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ARTS - DESIGN - ENTERTAINMENT',25401030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CREATIVE & DESIGN JOBS',25401030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('DESIGN & ARCHITECTURE',25401030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MEDIA',25401030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PUBLISHING',25401040,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PUBLISHING - PRINTING',25401040,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MARKETING',25502020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MARKETING - PUBLIC RELATIONS',25502020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MARKETING & COMMUNICATIONS',25502020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('MARKETING & DIGITAL',25502020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PR, ADVERTISING & MARKETING JOBS',25502020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SALES & MARKETING',25502020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RETAIL',25503020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RETAIL - WHOLESALE',25503020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RETAIL & CONSUMER PRODUCTS',25503020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('RETAIL JOBS',25503020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SALES',25503020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SALES JOBS',25503020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('AGRICULTURE',30202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('AGRICULTURE - FORESTRY - FISHING',30202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('AGRICULTURE, ANIMALS & CONSERVATION',30202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('AGRICULTURE, FORESTRY & FISHING',30202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('APPAREL - FASHION - TEXTILE',30202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FARMING & VETERINARY',30202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FARMING, ANIMALS & CONSERVATION',30202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FOOD PROCESSING',30202030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HEALTH & MEDICAL',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HEALTH CARE',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HEALTHCARE',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HEALTHCARE & MEDICAL',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HEALTHCARE & NURSING',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('HEALTHCARE & NURSING JOBS',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PERSONAL CARE',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SOCIAL CARE',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SOCIAL WORK JOBS',35102015,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PHARMACEUTICAL',35202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SCIENCE, BIOTECH & PHARMACEUTICALS',35202010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('LIFE SCIENCES',35203010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SCIENCE',35203010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SCIENCE - RESEARCH - DEVELOPMENT',35203010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SCIENCE & TECHNOLOGY',35203010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SCIENTIFIC',35203010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SCIENTIFIC & QA JOBS',35203010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('BANKING',40101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('BANKING - FINANCIAL SERVICES',40101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('BANKING & FINANCIAL SERVICES',40101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FINANCE, ACCOUNTING & BANKING',40101010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ACCOUNTANCY & FINANCE',40201020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ACCOUNTING',40201020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ACCOUNTING - AUDITING',40201020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ACCOUNTING & FINANCE JOBS',40201020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('FINANCE',40201020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('INSURANCE',40301020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('INSURANCE & SUPERANNUATION',40301020,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('COMPUTER',45102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('INFORMATION & COMMUNICATION TECHNOLOGY',45102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('INFORMATION & COMMUNICATION TECHNOLOGY (ICT)',45102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('INFORMATION TECHNOLOGY - TELECOMS',45102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('IT',45102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('IT & TELECOMMUNICATIONS',45102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('IT JOBS',45102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ELECTRONICS - ROBOTICS',45202030,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PROPERTY',60102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PROPERTY JOBS',60102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('REAL ESTATE',60102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('REAL ESTATE & PROPERTY',60102010,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('OTHER',77777777,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('OTHER JOBS',77777777,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('OTHER/GENERAL JOBS',77777777,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('ENTRY-LEVEL',88888888,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('GRADUATE',88888888,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('GRADUATE JOBS',88888888,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PART TIME JOBS',88888888,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('PART-TIME',88888888,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('SELF EMPLOYMENT',88888888,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('WORK-FROM-HOME',88888888,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CHARITIES - NOT FOR PROFIT',99999999,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('CHARITY & VOLUNTARY JOBS',99999999,19000101,29991231);
insert into ltn.dbo.rltshp_facet_desc_indstry_clsfctn values ('VOLUNTEERING',99999999,19000101,29991231);