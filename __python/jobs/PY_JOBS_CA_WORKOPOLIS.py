# =======================================================================================================================================================================================================
# SUBJECT        : workopolis - job search site summary job listing data by work category
# OBJECT TYPE    : python - BeautifulSoup
# OBJECT NAME    : py_jobs_ca_workopolis
# CREATED BY     : Harold Delaney
# CREATED ON     : 20170213
# SOURCE         : workopolis [ http://www.workopolis.com/jobsearch/find-jobs ]
# PREPERATION    : SCRAPE - python - BeautifulSoup - scrapes summary data from site and stores in sqlite in preparation for etl to sqlserver
# FREQUENCY      : DAILY
#               
# REMARKS        : 1) NO API
#                  2) 
#                  3)
# =======================================================================================================================================================================================================
# =============================================================================
# ENVIRNMENT AND LIBRARY SETUP -- START
# =============================================================================
import os 
import sys
import time # date time operations
import datetime # date subtractions
import re # regex
import random 
from bs4 import BeautifulSoup
# RETURN CURRENT SCRIPT PATH ("__file__" IS FILES FULL PATH)
path, fileName = os.path.split(os.path.realpath(__file__))
fullPath = os.path.join(path, fileName)
# UTIL FILE PATH
utilPath = os.path.join(path, '../__utils/')
utilPath = os.path.abspath(os.path.realpath(utilPath))
# ADD ABOVE NOMINATED DIRECTORIES TO IMPORT SEARCH PATH
sys.path.insert(0, utilPath)
sys.path.insert(0, os.path.dirname(os.path.abspath(os.path.realpath(__file__))) ) 
# CALL USER DEFINED MODULES/FUNCTIONS
from PY_UTIL_EMAIL import pyMail
from PY_UTIL_DB import pyDB
from PY_UTIL_CONFIG import pyConfig
from PY_UTIL_HTMLPASS import pyHTMLPass
# =============================================================================
# ENVIRNMENT AND LIBRARY SETUP -- END
# =============================================================================
__version__ = "1.0.0"
__author__ = "Harold Delaney"

g = dict(
    CONFIG_FILE = utilPath + '\PY_DB.conf',
    VARS_TABLE_NAME = 'PY_VARS_CTL',
    PKG_NME = fileName.replace('.py','').upper()
)

def main():
    init()
    get_vars()
    scrape()
    write_log() # SUCCESS
    
def init():
    g['CONFIG'] = pyConfig(g['CONFIG_FILE']).recs()
    g['PKG_PATH'] = path
    g['ENV'] = g['CONFIG']['ENV']
    # CHANGE - 20171128 ==================================================================================
    g['DB'] = g['CONFIG']['DB_DIR'] + g['CONFIG']['DB']    #dbPath + '\\' + g['CONFIG']['DB']
    g['DRVR_PATH'] = g['CONFIG']['DRVR_DIR']    #drvrPath
    # CHANGE =============================================================================================
    g['MSMT_DTE_ID'] = time.strftime('%Y%m%d') 
    g['STARTED_AT'] = time.strftime("%Y-%m-%d %H:%M:%S")
    g['ITEM_CHECK'] = [r"'LOCATION'",r"'CATEGORY'",r"'CUSTOMER'",r"'POSITIONTYPE'",r"'INDUSTRY'"]
    g['WRITE_HTML_TO_FILE'] = 'N'
    
def get_vars():
    dbmgr = pyDB(g['DB']) 
    rslt = dbmgr.get_vars(**g)
    # ADD RESULTS FROM GET_VARS CALL TO DICTIONARY (g)
    for r in rslt:
        g[str(r[0])] = str(r[1])
        #print(r)
    #print([g])

def scrape():
    # RANDOM TIMER TO MAKE ANY LOOPING CALLS TO A URL APPEAR MORE "HUMAN"
    rLow = int(g['LOOP_RNDM_SLEEP_LOW'])
    rHigh = int(g['LOOP_RNDM_SLEEP_HIGH'])
    rndm_sleep = random.randint(rLow,rHigh)
    # CALCULATE RETENTION DATE FROM RETENTION DAYS VARIABLE IN VARS TABLE
    retention_date = datetime.date.today() + datetime.timedelta(-int(g['DATA_RETENTION_DAYS']))
    retention_date_id = retention_date.strftime('%Y%m%d')
    # =============================================================================
    # DELETE FROM LOCAL DB WHERE A RERUN WOULD REPRODUCE "DUPLICATE" DATA
    # =============================================================================
    dbmgr = pyDB(g['DB'])
    q = r"""DELETE FROM {0} WHERE (msmt_dte_id = {1} or msmt_dte_id <= {2}) and cntry_cde = '{3}' and site_cde = '{4}'""".format(
        g['TBL_NME'], #[0]
        g['MSMT_DTE_ID'], #[1]
        retention_date_id,  #[2]
        g['CNTRY_CDE'], #[3]
        g['SITE_CDE'] #[4]
        ) 
    dbmgr.query(q)
    # =============================================================================
    # PASS URL TO RETURN HTML FROM SITE PAGE
    # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
    # =============================================================================
    url = g['URL']
    passedHTML = pyHTMLPass.htmlPass(url,**g)
    soup = BeautifulSoup(passedHTML, "html.parser")
    #soup = soup.encode("utf-8","ignore").decode('ascii', 'ignore')
    #print(soup)
    # ==========================================================================================================================================================
    # SCRAPE PART - START
    # - this should be the primary section of code that changes  
    # - only other sections that "may" change are DELETE and UPDATE DB statements
    # ==========================================================================================================================================================
    # COLLECT ALL JOBS RELATED LINKS
    regionLinksList = []
    industryLinksList = []
    jobtypeLinksList = []
    
    # PASS 1 - COLLECT LINKS FOR THE VARIOUS TYPES ====================================
    for ul in soup.find_all('ul', class_='provinceList'):
        for links in ul.find_all('a'):
            link = str(links.get('href')) 
            regionLinksList.append(link)
            #print(regionLinksList)
            
    for ul in soup.find_all('ul', class_='categoryList'):
        for links in ul.find_all('a'):
            link = str(links.get('href')) 
            industryLinksList.append(link)
            #print(industryLinksList)
            
    for ul in soup.find_all('ul', class_='studentsList'):
        for links in ul.find_all('a'):
            link = str(links.get('href')) 
            jobtypeLinksList.append(link)       
    
    # PASS 2 - COLLECT REGION DATA ====================================================
    facet_type = 'REGION'
    for link in regionLinksList:
        time.sleep(rndm_sleep) # INSERTS PAUSE TO ASSIST REFLECTING HUMAN INTERACTION ON WEBPAGE
        # =============================================================================
        # PASS URL TO RETURN HTML FROM SITE PAGE
        # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
        # =============================================================================
        url = g['URL'].lower().replace('/jobsearch/browse-jobs/',link)
        
        #url = link #.replace(href_search_str, '')
        passedHTML = pyHTMLPass.htmlPass(url,**g)
        soup = BeautifulSoup(passedHTML, "html.parser")
        #print(soup)
        
        for h1 in soup.find_all('h1'):
            for links in h1.find_all('a'):
                facet_desc = links.text.upper().replace('JOBS','').strip()
                link = str(links.get('href'))
                # =============================================================================
                # PASS URL TO RETURN HTML FROM SITE PAGE
                # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
                # =============================================================================
                url = g['URL'].lower().replace('/jobsearch/browse-jobs/',link)
                #url = link #.replace(href_search_str, '')
                passedHTML = pyHTMLPass.htmlPass(url,**g)
                soup = BeautifulSoup(passedHTML, "html.parser")
        
                for div in soup.find_all('div', class_='sr-result-count'):  #result-count
                    for strong in div.find_all('strong'):
                        facet_count = re.search(r' of(.*?)</strong>',str(strong)).group(1)
                            
                        #facet_count = strong.text.upper()
                        #facet_count = facet_count.split('OF',1)[1]
                        facet_count = facet_count.strip()
                
                # =============================================================================
                # WRITE RESULTS OF SOUP ANALYISIS/SCRAPE TO LOCAL DB
                # =============================================================================   
                dbmgr = pyDB(g['DB'])
                q = r"""INSERT INTO {0} (MSMT_DTE_ID, DATA_TYPE, CNTRY_CDE, SITE_CDE, FACET_TYPE, FACET_DESC, FACET_CNT, STARTED_AT, FINISHED_AT) VALUES ({1}, '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}')""".format(
                    g['TBL_NME'], #[0]
                    g['MSMT_DTE_ID'], #[1]
                    g['DATA_TYPE'], #[2]
                    g['CNTRY_CDE'], #[3]
                    g['SITE_CDE'], #[4]
                    facet_type, #[5]
                    facet_desc, #[6]
                    facet_count, #[7]
                    g['STARTED_AT'], #[8]
                    '' #[9]
                    )
                dbmgr.query(q)
                # =============================================================================
                # WRITE HTML PAGE TO FILE
                # =============================================================================
                if g['WRITE_HTML_TO_FILE'] == 'Y':
                    file_name = g['MSMT_DTE_ID'] + '_' + g['CNTRY_CDE'] + '_' + g['SITE_CDE'] + '_' + facet_type.replace(' ','_') + '_' + facet_desc.replace(' ','_') + '.html'
                    with open(g['CONFIG']['DB_DIR'] + '__html\\' + file_name,'w+', encoding='utf-8') as f:  
                        f.writelines(str(soup))  
                    f.close()                 
    
    # PASS 3 - COLLECT INDUSTRY DATA ==================================================
    facet_type = 'INDUSTRY'
    for link in industryLinksList:
        time.sleep(rndm_sleep) # INSERTS PAUSE TO ASSIST REFLECTING HUMAN INTERACTION ON WEBPAGE
        # =============================================================================
        # PASS URL TO RETURN HTML FROM SITE PAGE
        # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
        # =============================================================================
        url = g['URL'].lower().replace('/jobsearch/browse-jobs/',link)
        #url = link #.replace(href_search_str, '')
        passedHTML = pyHTMLPass.htmlPass(url,**g)
        soup = BeautifulSoup(passedHTML, "html.parser")
        #print(soup)
        
        for h1 in soup.find_all('h1'):
            for links in h1.find_all('a'):
                facet_desc = links.text.upper().replace('JOBS','').strip()
                link = str(links.get('href'))
                # =============================================================================
                # PASS URL TO RETURN HTML FROM SITE PAGE
                # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
                # =============================================================================
                url = g['URL'].lower().replace('/jobsearch/browse-jobs/',link)
                #url = link #.replace(href_search_str, '')
                passedHTML = pyHTMLPass.htmlPass(url,**g)
                soup = BeautifulSoup(passedHTML, "html.parser")
        
                for div in soup.find_all('div', class_='sr-result-count'):
                    for strong in div.find_all('strong'):
                        facet_count = re.search(r' of(.*?)</strong>',str(strong)).group(1)
                        #facet_count = strong.text.upper()
                        #facet_count = facet_count.split('OF',1)[1]
                        facet_count = facet_count.strip()
                
                # =============================================================================
                # WRITE RESULTS OF SOUP ANALYISIS/SCRAPE TO LOCAL DB
                # =============================================================================   
                dbmgr = pyDB(g['DB'])
                q = r"""INSERT INTO {0} (MSMT_DTE_ID, DATA_TYPE, CNTRY_CDE, SITE_CDE, FACET_TYPE, FACET_DESC, FACET_CNT, STARTED_AT, FINISHED_AT) VALUES ({1}, '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}')""".format(
                    g['TBL_NME'], #[0]
                    g['MSMT_DTE_ID'], #[1]
                    g['DATA_TYPE'], #[2]
                    g['CNTRY_CDE'], #[3]
                    g['SITE_CDE'], #[4]
                    facet_type, #[5]
                    facet_desc, #[6]
                    facet_count, #[7]
                    g['STARTED_AT'], #[8]
                    '' #[9]
                    )
                dbmgr.query(q)
                # =============================================================================
                # WRITE HTML PAGE TO FILE
                # =============================================================================
                if g['WRITE_HTML_TO_FILE'] == 'Y':
                    file_name = g['MSMT_DTE_ID'] + '_' + g['CNTRY_CDE'] + '_' + g['SITE_CDE'] + '_' + facet_type.replace(' ','_') + '_' + facet_desc.replace(' ','_') + '.html'
                    with open(g['CONFIG']['DB_DIR'] + '__html\\' + file_name,'w+', encoding='utf-8') as f:  
                        f.writelines(str(soup)) 
                    f.close()     
                
    # PASS 4 - COLLECT JOBTYPE DATA ===================================================
    facet_type = 'JOB TYPE'
    for link in jobtypeLinksList:
        time.sleep(rndm_sleep) # INSERTS PAUSE TO ASSIST REFLECTING HUMAN INTERACTION ON WEBPAGE
        # =============================================================================
        # PASS URL TO RETURN HTML FROM SITE PAGE
        # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
        # =============================================================================
        url = g['URL'].lower().replace('/jobsearch/browse-jobs/',link)
        #url = link #.replace(href_search_str, '')
        passedHTML = pyHTMLPass.htmlPass(url,**g)
        soup = BeautifulSoup(passedHTML, "html.parser")
        #print(soup)
        
        for h1 in soup.find_all('h1', class_='sr-search-title'):
            facet_desc = h1.text.upper().replace('JOBS','').strip()
            #print(facet_desc)
            
            for div in soup.find_all('div', class_='result-count'):
                for p in div.find_all('p'):
                    facet_count = p.text.upper()
                    facet_count = facet_count.split('OF',1)[1]
                    facet_count = facet_count.strip()
            
            # =============================================================================
            # WRITE RESULTS OF SOUP ANALYISIS/SCRAPE TO LOCAL DB
            # =============================================================================   
            dbmgr = pyDB(g['DB'])
            q = r"""INSERT INTO {0} (MSMT_DTE_ID, DATA_TYPE, CNTRY_CDE, SITE_CDE, FACET_TYPE, FACET_DESC, FACET_CNT, STARTED_AT, FINISHED_AT) VALUES ({1}, '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}')""".format(
                g['TBL_NME'], #[0]
                g['MSMT_DTE_ID'], #[1]
                g['DATA_TYPE'], #[2]
                g['CNTRY_CDE'], #[3]
                g['SITE_CDE'], #[4]
                facet_type, #[5]
                facet_desc, #[6]
                facet_count, #[7]
                g['STARTED_AT'], #[8]
                '' #[9]
                )
            dbmgr.query(q)    
            # =============================================================================
            # WRITE HTML PAGE TO FILE
            # =============================================================================
            if g['WRITE_HTML_TO_FILE'] == 'Y':
                file_name = g['MSMT_DTE_ID'] + '_' + g['CNTRY_CDE'] + '_' + g['SITE_CDE'] + '_' + facet_type.replace(' ','_') + '_' + facet_desc.replace(' ','_') + '.html'
                with open(g['CONFIG']['DB_DIR'] + '__html\\' + file_name,'w+', encoding='utf-8') as f:  
                    f.writelines(str(soup)) 
                f.close() 
 
    # ==========================================================================================================================================================
    # SCRAPE PART - END
    # - this should be the primary section of code that changes  
    # - only other sections that "may" change are DELETE and UPDATE db statements
    # ==========================================================================================================================================================            
    # =============================================================================
    # UPDATE LOCAL DB WITH A FINISH TIME
    # =============================================================================
    finished_at = time.strftime("%Y-%m-%d %H:%M:%S") # capture a finish time to be entered into the db
    dbmgr = pyDB(g['DB'])
    q = r"""UPDATE {0} SET finished_at = '{1}' WHERE cntry_cde = '{2}' and msmt_dte_id = {3}""".format(
        g['TBL_NME'], #[0]
        finished_at, #[1]
        g['CNTRY_CDE'], #[2]
        g['MSMT_DTE_ID'] #[3]
        )
    dbmgr.query(q)

def write_log():
    finished_at = time.strftime("%Y-%m-%d %H:%M:%S") # capture a finish time to be entered into the db
    # =============================================================================
    # WRITE RESULTS OF SUCCESS TO LOCAL DB 
    # =============================================================================   
    dbmgr = pyDB(g['DB'])
    dbmgr.write_log(finished_at,None,**g) 
    
if __name__ == "__main__": main()
