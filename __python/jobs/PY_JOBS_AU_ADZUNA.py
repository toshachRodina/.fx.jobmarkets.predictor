# =======================================================================================================================================================================================================
# SUBJECT        : adzuna - job search site summary job listing data by work category
# OBJECT TYPE    : python - BeautifulSoup
# OBJECT NAME    : py_jobs_au_adzuna
# CREATED BY     : Harold Delaney
# CREATED ON     : 20170130
# SOURCE         : adzuna [ https://www.adzuna.com.au ]
# PREPERATION    : SCRAPE - python - BeautifulSoup - scrapes summary data from site and stores in sqlite in preparation for etl to sqlserver
# FREQUENCY      : DAILY
#               
# REMARKS        : 1) HAS API
#                  2) 
#                  3)
#
# HISTORY        : 20170621 - website changed and removed counts from the title page.  changed script to follow links to detail page and grab counts from that
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
# UTIL AND DATABASE FILE PATHS
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
    url = g['URL'] + '/browse'
    passedHTML = pyHTMLPass.htmlPass(url,**g)
    soup = BeautifulSoup(passedHTML, "html.parser")
    #print(soup)
    # ==========================================================================================================================================================
    # SCRAPE PART - START
    # - this should be the primary section of code that changes  
    # - only other sections that "may" change are DELETE and UPDATE DB statements
    # ==========================================================================================================================================================
    # PASS 1 - INDUSTRY DETAILS ===================================================================
    rndm_sleep = random.randint(rLow,rHigh)
    facet_type = 'INDUSTRY'
    link_txt_array = []
    
    for href in soup.find_all('a'):
        if '/BROWSE/' in str(href).upper() and '-JOBS' in str(href).upper(): # and 'LINK-DEFAULT' not in str(href).upper():
            full_ref = str(href)
            link_txt = str(href.get('href'))
            if link_txt.count('/') < 5:
                link_txt_array.append(link_txt.replace('/browse',''))
    #print(link_txt_array)   
            
    for link_txt in link_txt_array:
        # =============================================================================
        # PASS URL TO RETURN HTML FROM SITE PAGE
        # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
        # =============================================================================
        url = link_txt
        passedHTML = pyHTMLPass.htmlPass(url,**g)
        soup = BeautifulSoup(passedHTML, "html.parser")
        #print(soup)
    
        for h1 in soup.find_all('h1'):
            facet_desc = str(h1.text).upper().replace('BROWSE','').replace('IN AUSTRALIA','').strip()
        
        for span in soup.find_all('span', class_='c'):
            facet_count = str(span.text)
            facet_count = int(facet_count.replace(',',''))
        
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
            file_name = g['MSMT_DTE_ID'] + '_' + g['CNTRY_CDE'] + '_' + g['SITE_CDE'] + '_' + facet_type.replace(' ','_').replace('/','-') + '_' + facet_desc.replace(' ','_').replace('/','-') + '.html'
            with open(g['CONFIG']['DB_DIR'] + '__html\\' + file_name,'w+', encoding='utf-8') as f:  
                f.writelines(str(soup)) 
            f.close()
            
            
#             for href in soup.find_all('a'):
#                 full_ref = str(href)
#                 link_txt = str(href.get('href'))
#                 if 'VIEW ALL' in str(href).upper():
#                     full_ref = str(href)
#                     link_txt = str(href.get('href'))
#                     # =============================================================================
#                     # PASS URL TO RETURN HTML FROM SITE PAGE
#                     # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
#                     # =============================================================================            
#                     url = link_txt
#                     passedHTML = pyHTMLPass.htmlPass(url,**g)
#                     soup = BeautifulSoup(passedHTML, "html.parser")
#                     #print(soup)                    
#                     for span in soup.find_all('span', class_='c'):
#                         facet_count = str(span.text)
#                         facet_count = int(facet_count.replace(',',''))                    
                    
                        
    # PASS 2 - REGIONAL DETAILS ===================================================================  
    facet_type = 'REGION'
    regions = g['REGIONS']
    regions_array = []
    # CONVERTS LIST OBJECT TO ARRAY FOR LOOPING
    for item in regions.split(','): # COMMA, OR OTHER
        regions_array.append(item)  
    # LOOP THROUGH ALL THE ITEM IN REGIONS
    for region in regions_array:    
        time.sleep(rndm_sleep) # INSERTS PAUSE TO ASSIST REFLECTING HUMAN INTERACTION ON WEBPAGE
        # =============================================================================
        # PASS URL TO RETURN HTML FROM SITE PAGE
        # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
        # =============================================================================
        url = g['URL'] + g['URL_PART1'] + '{}'.format(region.replace(' ','+'))
        passedHTML = pyHTMLPass.htmlPass(url,**g)
        soup = BeautifulSoup(passedHTML, "html.parser")
        #print(soup)   
        soup = soup.encode("utf-8") # CODE PAGE ERROR - CONVERTS   
        soup = str(soup)
        # ==========================================================================================================================================================
        # SCRAPE SUB PART - START
        # ==========================================================================================================================================================
        facet_desc = str(region.upper())
        facet_count = re.search('1-10 of(.*?)</p>', soup).group(1) 
        facet_count = facet_count.replace(',','').strip()
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
            file_name = g['MSMT_DTE_ID'] + '_' + g['CNTRY_CDE'] + '_' + g['SITE_CDE'] + '_' + facet_type.replace(' ','_').replace('/','-') + '_' + facet_desc.replace(' ','_').replace('/','-') + '.html'
            with open(g['CONFIG']['DB_DIR'] + '__html\\' + file_name,'w+', encoding='utf-8') as f:  
                f.writelines(str(passedHTML)) 
            f.close()
    else:
        None
        # ==========================================================================================================================================================
        # SCRAPE SUB PART - END
        # ==========================================================================================================================================================
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