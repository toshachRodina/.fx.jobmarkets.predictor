# =======================================================================================================================================================================================================
# SUBJECT        : orchestration file for running py scripts for package
# OBJECT TYPE    : python
# OBJECT NAME    : py_batch
# CREATED BY     : Harold Delaney
# CREATED ON     : 20170410
# SOURCE         : 
# PREPERATION    : 
# FREQUENCY      : DAILY
#               
# REMARKS        : 1) 
#                  2) 
#                  3)
# =======================================================================================================================================================================================================
# =============================================================================
# ENVIRNMENT AND LIBRARY SETUP -- START
# =============================================================================
import os
import sys
import subprocess
import time # DATE TIME OPERATIONS
import re # REGEX
# PYTHON EXE PATH
pyPath = sys.executable.replace('pythonw','python')
# GET THE DIRECTORY OF THE CURRENT RUNNING SCRIPT. "__file__" IS ITS FULL PATH
path, fileName = os.path.split(os.path.realpath(__file__))
fullPath = os.path.join(path, fileName)
# LIBRARY FILE PATH
utilPath = os.path.join(path, '../__utils/')
utilPath = os.path.abspath(os.path.realpath(utilPath))  
# ADDS ABOVE NOMINATED DIRECTORIES TO IMPORT SEARCH PATH
sys.path.insert(0, utilPath)
sys.path.insert(0, os.path.dirname(os.path.abspath(os.path.realpath(__file__))) ) 
# CALL LIBRARY FUNCTIONS IDENTIFIED IN ABOVE PATHS
from PY_UTIL_EMAIL import pyMail
from PY_UTIL_DB import pyDB
from PY_UTIL_CONFIG import pyConfig
# =============================================================================
# ENVIRNMENT AND LIBRARY SETUP -- END
# =============================================================================
__version__ = "1.0.0"
__author__ = "Harold Delaney"

g = dict(
    CONFIG_FILE = utilPath + '\PY_DB.conf',
    #VARS_TABLE_NAME = 'PY_VARS_CTL',
    PKG_NME = fileName.replace('.py','').upper()
)

def main():
    init()
    get_vars()
    email_status('START')
    script_run()
    email_status('END')
    write_log() # SUCCESS
    
def init():
    pathLength = len(fullPath.split('\\'))- 2
    g['PKG_NME_PRNT'] = str(fullPath.split('\\')[pathLength]).upper()
    g['CONFIG'] = pyConfig(g['CONFIG_FILE']).recs()
    g['DB_SHRT'] = g['CONFIG']['DB'].replace('.db','')
    g['ENV'] = g['CONFIG']['ENV']
    # CHANGE - 20171128 ==================================================================================
    g['DB'] = g['CONFIG']['DB_DIR'] + g['CONFIG']['DB']    #dbPath + '\\' + g['CONFIG']['DB']
    g['DRVR_PATH'] = g['CONFIG']['DRVR_DIR']    #drvrPath
    # CHANGE - 20200412 ==================================================================================
    g['CTL_TBL'] = g['CONFIG']['CTL_TBL']
    # CHANGE =============================================================================================
    g['MSMT_DTE_ID'] = time.strftime('%Y%m%d') 
    g['STARTED_AT'] = time.strftime("%Y-%m-%d %H:%M:%S") 

def get_vars():
    dbmgr = pyDB(g['DB']) 
    rslt = dbmgr.get_vars(**g)
        # ADD RESULTS FROM GET_VARS CALL TO DICTIONARY (g)
    for r in rslt:
        g[str(r[0])] = str(r[1])
        #print(r)
    #print([g])   
   
def script_run():
    # =============================================================================
    # CONVERT STR TO LIST TO ARRAY FOR TABLE LIST RUNNING 
    # =============================================================================
    pkgs_to_run = g['PKGS_TO_RUN']
    pkgs_to_run_array = []
    # CONVERTS LIST OBJECT TO ARRAY FOR LOOPING
    for item in pkgs_to_run.split(','): # COMMA, OR OTHER
        pkgs_to_run_array.append(item)    
    try:
        # LOOP THROUGH ALL THE PACKAGES/SCRIPTS FOR THIS FOLDER
        for pkg in pkgs_to_run_array:
            subprocess.call([pyPath, str(path + r"\\" + pkg + '.py')])
    except:
        # capture a finish time to be entered into the db
        finished_at = time.strftime("%Y-%m-%d %H:%M:%S")
        # =============================================================================
        # WRITE RESULTS OF ERROR TO LOCAL DB 
        # =============================================================================   
        e = sys.exc_info()
        dbmgr = pyDB(db)
        dbmgr.write_log(finished_at,'EMAIL ERROR: ' + str(e),**g)
                    
def email_status(step):
    if step == 'START':
        # SUBJECT & RECIPIENTS
        mymail = pyMail(g['PKG_NME_PRNT'] + ' : CA - STARTED @ ' + time.strftime("%Y-%m-%d %H:%M:%S"), **g)
        # START HTML BODY (GREETING / OPENING LINE OF EMAIL)
        mymail.htmladd('End Of Message')
        # SEND
        mymail.send(**g)
    elif step == 'END':
        # =============================================================================
        # LOOPS THROUGH TABLE LIST AND GENERATES SUMMARY DATA FOR EMAIL
        # =============================================================================   
        dbmgr = pyDB(g['DB'])
        q = r"""SELECT msmt_dte_id, cntry_cde, count( * ) AS row_cnt, sum(facet_cnt) as job_count FROM {0} WHERE cntry_cde = 'CA' GROUP BY msmt_dte_id, cntry_cde ORDER BY msmt_dte_id DESC LIMIT 5""".format(
            'WEBDATA_JOBADS'
            ) 
        rslt = dbmgr.query(q)
        # =============================================================================
        # EMAIL SUMMARY OF RESULTS TO DISTRIBUTION LIST
        # =============================================================================
        htmlRes = '''<table cellpadding="8" cellspacing="3" border="1">
                    <tr>
                    <th>msmt_date_id</th>
                    <th>cntry_cde</th>
                    <th>row_cnt</th>
                    <th>job_cnt</th>
                    </tr>'''
        for r in rslt:
            htmlRes = htmlRes + '<tr><td>' + str(r[0]) + '</td><td>' + str(r[1])  + '</td><td>' + str(r[2])  + '</td><td>' + str(r[3])  + '</td></tr>'
        htmlRes = htmlRes + '</table>'
        # =============================================================================
        # LOOPS THROUGH TABLE LIST AND GENERATES SECONDARY SUMMARY DATA FOR EMAIL
        # =============================================================================
        dbmgr = pyDB(g['DB'])
        q = r"""select max(MSMT_DTE_ID) as msmt_dte_id, CNTRY_CDE,    SITE_CDE, SUM( CURR_ROW_CNT ) AS CURR_ROW_CNT, SUM( PREV_ROW_CNT ) AS PREV_ROW_CNT,    SUM( CURR_FACET_CNT ) AS CURR_FACET_CNT, SUM( PREV_FACET_CNT ) AS PREV_FACET_CNT
                from 
                    (
                        select msmt_dte_id,    cntry_cde, site_cde,
                           case
                                when MSMT_DTE_ID = strftime(
                                    '%Y%m%d',
                                    date(
                                        'now',
                                        'localtime'
                                    )
                                ) then count(*)
                                else 0
                            end as CURR_ROW_CNT,
                            case
                                when MSMT_DTE_ID = strftime(
                                    '%Y%m%d',
                                    date(
                                        'now',
                                        'localtime',
                                        '-1 day'
                                    )
                                ) then count(*)
                                else 0
                            end as PREV_ROW_CNT,
                            cast(case
                                when MSMT_DTE_ID = strftime(
                                    '%Y%m%d',
                                    date(
                                        'now',
                                        'localtime'
                                    )
                                ) then sum( FACET_CNT )
                                else 0
                            end as INTEGER) as CURR_FACET_CNT,
                            cast(case
                                when MSMT_DTE_ID = strftime(
                                    '%Y%m%d',
                                    date(
                                        'now',
                                        'localtime',
                                        '-1 day'
                                    )
                                ) then sum( FACET_CNT )
                                else 0
                            end as INTEGER) as PREV_FACET_CNT
                        from
                            WEBDATA_JOBADS
                        where
                            1 = 1
                            and cntry_cde = 'CA'
                            and MSMT_DTE_ID >= strftime(
                                '%Y%m%d',
                                date(
                                    'now',
                                    'localtime',
                                    '-1 day'
                                )
                            )
                        group by
                            msmt_dte_id,
                            cntry_cde,
                            site_cde
                    )
                    group BY
                    CNTRY_CDE,
                    SITE_CDE
                order by
                    1,
                    3""".format(
            'WEBDATA_JOBADS'
            ) 
        rslt = dbmgr.query(q)
        # =============================================================================
        # EMAIL SUMMARY OF RESULTS TO DISTRIBUTION LIST
        # =============================================================================
        htmlRes2 = '''<table cellpadding="8" cellspacing="3" border="1">
                    <tr>
                    <th>msmt_date_id</th>
                    <th>cntry_cde</th>
                    <th>site_cde</th>
                    <th>curr_row_cnt</th>
                    <th>prev_row_cnt</th>
                    <th>curr_facet_cnt</th>
                    <th>prev_facet_cnt</th>
                    </tr>'''
        for r in rslt:
            htmlRes2 = htmlRes2 + '<tr><td>' + str(r[0]) + '</td><td>' + str(r[1])  + '</td><td>' + str(r[2])  + '</td><td>' + str(r[3])  + '</td><td>' + str(r[4])  + '</td><td>' + str(r[5])  + '</td><td>' + str(r[6])  + '</td></tr>'
        htmlRes2 = htmlRes2 + '</table>'
        # SUBJECT & RECIPIENTS
        mymail = pyMail(g['PKG_NME_PRNT'] + ' : CA - ENDED @ ' + time.strftime("%Y-%m-%d %H:%M:%S"), **g)
        # START HTML BODY (GREETING / OPENING LINE OF EMAIL)
        mymail.htmladd('Scrape has completed for : ' + g['PKG_NME_PRNT'] + ' : CA')
        # FURTHER DETAILS ADDED TO BODY (SEPERATED BY A PARAGRAPH SO LINE FEEDS NOT REQUIRED)
        # ADD LINE OF TEXT
        mymail.htmladd('Summary of Scrape for ' + g['PKG_NME_PRNT'] + ' : CA')
        # ADD HTML TABLE CONSTRUCTED ABOVE
        mymail.htmladd(htmlRes)
        # ADD LINE OF TEXT
        mymail.htmladd('CURR and PREV days comparison')
        # ADD HTML TABLE CONSTRUCTED ABOVE
        mymail.htmladd(htmlRes2)
        # SEND
        mymail.send(**g)

def write_log():
    finished_at = time.strftime("%Y-%m-%d %H:%M:%S") # capture a finish time to be entered into the db
    # =============================================================================
    # WRITE RESULTS OF SUCCESS TO LOCAL DB 
    # =============================================================================   
    dbmgr = pyDB(g['DB'])
    dbmgr.write_log(finished_at,None,**g)
    
if __name__ == "__main__": main()
