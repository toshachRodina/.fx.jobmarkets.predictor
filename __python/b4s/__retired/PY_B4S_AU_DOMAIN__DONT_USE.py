# =======================================================================================================================================================================================================
# SUBJECT        : domain - job search site summary job listing data by work category
# OBJECT TYPE    : python - BeautifulSoup
# OBJECT NAME    : py_b4s_au_domain
# CREATED BY     : Harold Delaney
# CREATED ON     : 20170219
# SOURCE         : domain [ http://business.domain.com.au ]
# PREPERATION    : SCRAPE - python - BeautifulSoup - scrapes summary data from site and stores in sqlite in preparation for etl to sqlserver
# FREQUENCY      : DAILY
#               
# REMARKS        : 1) 
#                  2) 
#                  3)
# =======================================================================================================================================================================================================

from urllib.request import Request, urlopen  # Python 3
from selenium import webdriver # parse the full scripted results of websites (for sites that are javascript heavy)
from bs4 import BeautifulSoup

import os 
import time # date time operations
import datetime # date subtractions
import re # regex
import sqlite3 # database operations
from random import randint 

__version__ = "1.0.0"
__author__ = "Harold Delaney"

def main():
    #get the directory of the current running script. "__file__" is its full path
    path, fileName = os.path.split(os.path.realpath(__file__))
    #use path to create the fully classified path to your data
    fullPath = os.path.join(path, fileName)
    
    ltnDb = os.path.join(path, '../@data/LTN_WEB_DATA.db')
    ltnDb = os.path.abspath(os.path.realpath(ltnDb))    
    searchConfig = os.path.join(path, '__config/location_search_au.txt')
    searchConfig = os.path.abspath(os.path.realpath(searchConfig))
    chromeDrvr = os.path.join(path, '../@drivers/chromedriver.exe')
    chromeDrvr = os.path.abspath(os.path.realpath(chromeDrvr))
    
    # vars list specific to scrape job
    url = 'http://business.domain.com.au/search/buy/?ltype=business&searchtype=business'
    tbl_nme = 'PY_B4S_DATA'
    data_type = 'B4S'
    cntry_cde = 'AU'
    site_cde = 'DOMAIN'
    date_retention_days = 60
    
    # time vars list
    msmt_dte_id = time.strftime('%Y%m%d')
    started_at = time.strftime("%Y-%m-%d %H:%M:%S")    
    retention_date = datetime.date.today() + datetime.timedelta(-date_retention_days)
    retention_date_id = retention_date.strftime('%Y%m%d')
    rndm_sleep = randint(1,7)
    
    # ===========================================
    # EXTRACT URL PAGE 
    # addheaders mimics a browser opening the page
    # ===========================================
    html = Request(url)
    html.add_header = [('User-agent', 'Google Chrome')]
    html = urlopen(html).read()
    
    # pass html object to BeautifulSoup parser
    soup = BeautifulSoup(html, "html.parser")
    print(soup)
    
    # connect to database
    db = sqlite3.connect(ltnDb)
    
    #delete any records for given date (usually means a rerun is being attempted
    q = r"""DELETE FROM {} WHERE (msmt_dte_id = {} or msmt_dte_id <= {}) and data_type = '{}' and cntry_cde = '{}' and site_cde = '{}'""".format(
        tbl_nme,
        msmt_dte_id,
        retention_date_id,  # removes data from database older than 'n' number of days
        data_type,
        cntry_cde,
        site_cde
        ) 
    db.execute(q)
    #db.commit()
    print("operation complete: {}".format(q))

    for div in soup.find_all('div',id="searchrefine"):
        for li in div.find_all('li'):
            
            if r'STATE"' in str(li).upper():
                facet_type = 'REGION'
            elif r'CATEGORY"' in str(li).upper():
                facet_type = 'INDUSTRY'
            else:
                facet_type = 'NOT IDENTIFIED'
            
            if r'VALUE=""' in str(li).upper() or r'VALUE="ANY"' in str(li).upper():
                None
            else:
                txt = re.search(r'"/>(.*?)<SPAN>', str(li).upper()).group(1)
                facet_desc = txt.replace("'",'').replace('&AMP;','&').replace(';','').strip()
                
                nbr = re.search('<SPAN>(.*?)</SPAN>', str(li).upper()).group(1)
                nbr = nbr.replace('(','').replace(')','')
                facet_count = int(nbr)
                
                q = r"""INSERT INTO {} VALUES ({}, '{}', '{}', '{}', '{}', '{}', '{}', '{}', {})""".format(
                    tbl_nme,
                    msmt_dte_id,
                    started_at,
                    '',
                    data_type,
                    cntry_cde,
                    site_cde,
                    facet_type,
                    facet_desc,
                    facet_count
                    )
                #print(q)                            
                db.execute(q)
                #db.commit()                
                print("operation complete: {}".format(q))

    # ===========================================
    # UPDATE FINISHED TIME AND CLOSE DB OPERATION
    # updates the finish time to current site entries
    # ===========================================
    finished_at = time.strftime("%Y-%m-%d %H:%M:%S")
    
    q = r"""UPDATE {} SET finished_at = '{}' WHERE msmt_dte_id = {} and data_type = '{}' and cntry_cde = '{}' and site_cde = '{}'""".format(
        tbl_nme,
        finished_at,
        msmt_dte_id,
        data_type,
        cntry_cde,
        site_cde
        )
    db.execute(q)
    db.commit()
    print("operation complete: {}".format(q))  
                
    db.close()
    print("database operations completed") 
    
if __name__ == "__main__": main()