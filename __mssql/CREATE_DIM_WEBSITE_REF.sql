/*
=======================================================================================================================================================================================================
SUBJECT		 : site ref table
OBJECT TYPE	 : table
OBJECT NAME     : ltn.dbo.dim_website_ref
CREATED BY	 : Harold Delaney
CREATED ON	 : 20170518
SOURCE		 : 
PREPERATION	 : 
			   
REMARKS		 : 1) 
			   2) 
			   3) 
 
=======================================================================================================================================================================================================

TABLE CREATION
-----------------------------

DROP TABLE ltn.dbo.dim_website_ref;

CREATE TABLE LTN.DBO.DIM_WEBSITE_REF
( START_DTE_ID int NOT NULL
, END_DTE_ID   int NOT NULL
, SITE_CDE     varchar(30) NOT NULL
, CNTRY_CDE    varchar(2) NOT NULL
, SITE_URL     varchar(1000) NOT NULL
, SUBSET_IND   varchar(1) NULL
, GOVT_IND     varchar(1) NULL
);

CREATE NONCLUSTERED  INDEX ix_dim_website_ref ON ltn.dbo.dim_website_ref(end_dte_id, site_cde);

ALTER TABLE ltn.dbo.dim_website_ref REBUILD
WITH(DATA_COMPRESSION = ROW);

=======================================================================================================================================================================================================
select * from ltn.dbo.dim_website_ref

=======================================================================================================================================================================================================
*/
truncate table ltn.dbo.dim_website_ref

insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'ADZUNA', 'AU', 'https://www.adzuna.com.au', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'CAREERJET', 'AU', 'http://www.careerjet.com.au', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'GUMTREE', 'AU', 'http://www.gumtree.com.au', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'HAYS', 'AU', 'https://www.hays.com.au', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'INDEED', 'AU', 'https://au.indeed.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JOBSEARCH', 'AU', 'https://jobsearch.gov.au', 'N', 'Y');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JOBSERVE', 'AU', 'https://www.jobserve.com/au/en/JobSearch.aspx', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JORA', 'AU', 'https://au.jora.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JORAX2', 'AU', 'https://au.jora.com', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'SEEK', 'AU', 'https://www.seek.com.au', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'CAREERBUILDER', 'CA', 'http://www.careerbuilder.ca', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'CAREERJET', 'CA', 'http://www.careerjet.ca', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'INDEED', 'CA', 'https://ca.indeed.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JOBBANK', 'CA', 'http://www.jobbank.gc.ca', 'N', 'Y');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JOBSERVE', 'CA', 'https://www.jobserve.com/ca/en/JobSearch.aspx', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'WORKOPOLIS', 'CA', 'http://www.workopolis.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'CAREERJET', 'NZ', 'http://www.careerjet.co.nz', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'INDEED', 'NZ', 'https://nz.indeed.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JORA', 'NZ', 'https://nz.jora.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JORAX2', 'NZ', 'https://nz.jora.com', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'MYJOBSPACE', 'NZ', 'http://myjobspace.co.nz', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'SEEK', 'NZ', 'https://www.seek.co.nz', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'TRADEME', 'NZ', 'http://www.trademe.co.nz', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'CAREERJET', 'UK', 'http://www.careerjet.co.uk', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'INDEED', 'UK', 'https://www.indeed.co.uk', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JOBSERVE', 'UK', 'https://www.jobserve.com/uk/en/JobSearch.aspx', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JOBSITE', 'UK', 'http://www.jobsite.co.uk', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JORA', 'UK', 'https://uk.jora.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JORAX2', 'UK', 'https://uk.jora.com', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'REED', 'UK', 'https://www.reed.co.uk', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'TOTALJOBS', 'UK', 'https://www.totaljobs.com', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'UNIVERSAL', 'UK', 'https://jobsearch.direct.gov.uk', 'N', 'Y');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'CAREERBUILDER', 'US', 'http://www.careerbuilder.com', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'CAREERJET', 'US', 'http://www.careerjet.com', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'INDEED', 'US', 'https://www.indeed.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JOBSERVE', 'US', 'https://www.jobserve.com/us/en/JobSearch.aspx', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JORA', 'US', 'https://us.jora.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'JORAX2', 'US', 'https://us.jora.com', 'N', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'SIMPLYHIRED', 'US', 'http://www.simplyhired.com', 'Y', '');
insert into ltn.dbo.dim_website_ref values (20170518, 29991231, 'THELADDERS', 'US', 'https://www.theladders.com', 'N', '');
