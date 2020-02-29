# =======================================================================================================================================================================================================
# SUBJECT        : key currency and index pairs
# OBJECT TYPE    : python
# OBJECT NAME    : py_ccy_pairs_mbar_fx
# CREATED BY     : Harold Delaney
# CREATED ON     : 20171205
# SOURCE         : http://www.histdata.com
# PREPERATION    : 
# FREQUENCY      : MONTHLY 
#               
# REMARKS        : 1) METASTOCK minute bar data for month
#                  2) 
#                  3)
# =======================================================================================================================================================================================================

# =============================================================================
# ENVIRNMENT AND LIBRARY SETUP -- START
# =============================================================================
import os 
import sys
import urllib
import time # date time operations
import datetime # date subtractions
import random 
from bs4 import BeautifulSoup

import requests 
from io import BytesIO
from zipfile import ZipFile
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
from PY_UTIL_LIB import pyLIB
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
    # CHANGE =============================================================================================
    g['DB'] = g['CONFIG']['DB_DIR'] + g['CONFIG']['DB']    #dbPath + '\\' + g['CONFIG']['DB']
    g['DRVR_PATH'] = g['CONFIG']['DRVR_DIR']    #drvrPath
    # CHANGE =============================================================================================
    g['MSMT_DTE_ID'] = time.strftime('%Y%m%d') 
    g['MONTH_NBR'] = time.strftime('%m')
    g['STARTED_AT'] = time.strftime("%Y-%m-%d %H:%M:%S") 
    g['MONTH_NBR_CNVRT'] = {'JANUARY': '01'
                            ,'FEBRUARY': '02'
                            ,'MARCH': '03'
                            ,'APRIL': '04'
                            ,'MAY': '05'
                            ,'JUNE': '06'
                            ,'JULY': '07'
                            ,'AUGUST': '08'
                            ,'SEPTEMBER': '09'
                            ,'OCTOBER': '10'
                            ,'NOVEMBER': '11'
                            ,'DECEMBER': '12'
                            }  
  
def get_vars():
    dbmgr = pyDB(g['DB']) 
    rslt = dbmgr.get_vars(**g)
    # ADD RESULTS FROM GET_VARS CALL TO DICTIONARY (g)
    for r in rslt:
        g[str(r[0])] = str(r[1])
        #print(r)
    print([g])
    
def scrape():
    
    # =============================================================================
    # DELETE ANY COMPRESSED OR CSV FILES FOUND IN DATA DIRECTORY READY FOR RETRIEVAL
    # =============================================================================
     
    # =============================================================================
    # PASS URL TO RETURN HTML FROM SITE PAGE
    # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
    # =============================================================================
    url = g['URL'] + g['URL_PART1']
    passedHTML = pyHTMLPass.htmlPass(url,**g)
    soup = BeautifulSoup(passedHTML, "html.parser")
    #print(soup)    
    # ==========================================================================================================================================================
    # SCRAPE PART - START
    # - this should be the primary section of code that changes  
    # - only other sections that "may" change are DELETE and UPDATE DB statements
    # ==========================================================================================================================================================
    # COLLECTS LIST OF TARGET LINKS (SUB PAGES) OF CCY PAIRS
    link_list = []
    for table in soup.find_all('table'):
        for links in table.find_all('a'):
            link = str(links.get('href'))
            ccy_pair = link[-6:] # GET THE CCY PAIR FROM THE LINK TO COMPARE TO ACCEPTED LIST            
            if ccy_pair in str(g['CCY_PAIRS']): #14 pairs
                link_list.append( link );
    # LOOP THROUGH TARGET LINKS TO DETERMINE YEAR LINKS     
    for link in link_list:
        # UPDATE g DICTIONARY SO WEBPAGE WILL NOT USE SELENIUM DRIVER
        g['USES_WEB_DRVR'] = 'N'
        # =============================================================================
        # PASS URL TO RETURN HTML FROM SITE PAGE
        # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
        # =============================================================================
        url = g['URL'] + link
        passedHTML = pyHTMLPass.htmlPass(url,**g)
        soup = BeautifulSoup(passedHTML, "html.parser")
        #print(soup)
        
        # RETURN THE MOST CURRENT/VALID MONTH & YEAR
        dte_list = []
        for div in soup.find_all('div',class_='page-content'):
            # FIRST LOOP - GET THE RELEVANT MONTH (PART OF CURRENT MONTH IS POSTED - WE ONLY WANT THE FULL "PREVIOUS" MONTH)
            for links in div.find_all('a'):
                if 'METASTOCK' in str(links).upper() and 'FULL MONTH DATA' in str(links).upper():  
                    link = str(links.get('href'))
                    yr_mth = link[-7:] # GET THE YEAR AND MONTH PARTS (MAY INCLUDE EXTRA / DEPENDING ON LENGTH (EG.  MONTHS WITH SINGLE DIGIT
                    if yr_mth[:1] == r'/':
                        month = yr_mth[-1:] # GET THE MONTH NBR FROM THE LINK TO COMPARE TO ACCEPTED LIST
                        month = '0' + str(month)
                        year = yr_mth[:5] # GET THE YEAR FROM THE LINK TO COMPARE TO ACCEPTED LIST
                        year = str(year.replace(r'/',''))
                    else:
                        month = yr_mth[-2:] # GET THE MONTH NBR FROM THE LINK TO COMPARE TO ACCEPTED LIST
                        year = yr_mth[:4] # GET THE YEAR FROM THE LINK TO COMPARE TO ACCEPTED LIST
                        year = str(year.replace(r'/',''))
                    dte = year + month
                    dte_list.append(int(dte))
                    
            # RETURN PREVIOUS MONTH NBR (CURRENT MONTH WILL ONLY BE A PART MONTH FILE - WE WANT THE LAST FULL MONTH)
            intDte = max(dte_list) - 1
            
            full_yr_flag = 'N' # NEED TO CHECK IF WE NEED FULL YEAR OR MONTH FILE
            if str(intDte)[-2:] == '00': # WE ARE IN JAN - NEED TO GET FULL YEAR RESULTS
                full_yr_flag = 'Y'
                yr = int(str(intDte)[:4]) - 1
                yr = str(yr)
            else:
                full_yr_flag = 'N'
                mth = str(intDte)[-2:]
                month_long_text = list(g['MONTH_NBR_CNVRT'].keys())[list(g['MONTH_NBR_CNVRT'].values()).index(mth)]
                yr = str(intDte)[:4]
                            
            # SECOND LOOP - GETS THE RELEVANT MONTH/YEAR LINK
            for links in div.find_all('a'):
                curr_link = str(links.get('href'))
                if full_yr_flag == 'N':
                    if month_long_text in str(links).upper() and yr in str(links).upper():
                        link = curr_link
                        searchStr = str(yr) + str(mth)
                        break
                if full_yr_flag == 'Y':
                    if yr in str(links).upper():
                        link = curr_link
                        searchStr = str(yr)
                        break
                        
        # CREATE A SEARCH STRING 
        # USED TO SEARCH FOR THAT FILE AND IF DOWNLOAD HAS COMPLETED
        fileSearchStr = str(searchStr) + '.zip'
        # UPDATE g DICTIONARY SO WEBPAGE WILL USE SELENIUM DRIVER
        g['USES_WEB_DRVR'] = 'Y'
        # =============================================================================
        # PASS URL TO RETURN HTML FROM SITE PAGE
        # CAPTURE ANY ERRORS EXPERIENCED AND PASS TO LOCAL DB
        # =============================================================================
        url = g['URL'] + link
        linkId = g['DOWNLOAD_ID']
        
        dlLink = pyHTMLPass.htmlDownloadLink(url,fileSearchStr,linkId,**g)
        #print(url)
        #print(linkId)
    # =============================================================================
    # MOVE DOWNLOADED FILES
    # CHROME WEBDRIVER DOESNT "CURRENTLY" ALLOW TO SET DOWNLOAD PATH
    # FILES ARE AUTO DOWNLOADED TO THE SYSTEM DOWNLOAD DIRECTORY 
    # =============================================================================
    pyLIB.moveFiles(g['DEFAULT_SYS_DOWNLOAD_PATH'], g['FILE_MOVE_DEST_PATH'], fileSearchStr)
           
def write_log():
    finished_at = time.strftime("%Y-%m-%d %H:%M:%S") # capture a finish time to be entered into the db
    # =============================================================================
    # WRITE RESULTS OF SUCCESS TO LOCAL DB 
    # =============================================================================   
    dbmgr = pyDB(g['DB'])
    dbmgr.write_log(finished_at,None,**g) 
 
if __name__ == "__main__": main()