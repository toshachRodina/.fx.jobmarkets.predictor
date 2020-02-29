# =======================================================================================================================================================================================================
# SUBJECT        : sentiment analysis from twitter
# OBJECT TYPE    : python
# OBJECT NAME    : py_twitter_rest_jobs_au
# CREATED BY     : Harold Delaney
# CREATED ON     : 20170828
# SOURCE         : twitter (tweepy python library)
# PREPERATION    : 
# FREQUENCY      : STREAMING
#               
# REMARKS        : 1) http://140dev.com/twitter-api-programming-tutorials/aggregating-tweets-search-api-vs-streaming-api/
#                  2) https://www.karambelkar.info/2015/01/how-to-use-twitters-search-rest-api-most-effectively./
#                  3)
# =======================================================================================================================================================================================================
# =============================================================================
# ENVIRNMENT AND LIBRARY SETUP -- START
# =============================================================================
import time, tweepy, sys, os, datetime, re
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
from PY_UTIL_TWEEPY_SEARCH import pyTweepySearch
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
    VARS_TABLE_NAME = 'PY_VARS_CTL',
    PKG_NME = fileName.replace('.py','').upper()
)

def main():
    init()
    get_vars()
    get_tweets()
    write_log() # SUCCESS
    
def init():
    g['CONFIG'] = pyConfig(g['CONFIG_FILE']).recs()
    g['PKG_PATH'] = path
    g['ENV'] = g['CONFIG']['ENV']
    # CHANGE - 20171128 ==================================================================================
    g['DB'] = g['CONFIG']['DB_DIR'] + g['CONFIG']['DB_TWEEP']    #dbPath + '\\' + g['CONFIG']['DB']
    g['DRVR_PATH'] = g['CONFIG']['DRVR_DIR']    #drvrPath
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
    print([g])

def get_tweets():
    # SETUP TWITTER AUTHORISATION
    Oauth = tweepy.OAuthHandler(g['TWIT_CNSMR_KEY'], g['TWIT_CNSMR_SECRET'])
    Oauth.set_access_token(g['TWIT_ACCESS_TOKEN'], g['TWIT_ACCESS_SECRET'])
    Oapi = tweepy.API(Oauth)

    if (not Oapi):
        print ('UNABLE TO AUTHENTICATE')
        sys.exit(-1)
            
    # CALCULATE RETENTION DATE FROM RETENTION DAYS VARIABLE IN VARS TABLE
    retention_date = datetime.date.today() + datetime.timedelta(-int(g['DATA_RETENTION_DAYS']))
    retention_date_id = retention_date.strftime('%Y%m%d')
      
    # ====================================================================
    # CONTINUE WITH REMAINDER OF SCRIPT
    # ==================================================================== 
    # BEGIN SEARCH FOR TERMS AND PLACE
    # THERE SEEMS TO BE A 500 (MAYBE 1000) CHARACTER LIMIT ON THE SEARCH CRITERIA ALLOWED TO BE PASSED IN
    # BELOW BREAKS THE SEARCH TERMS INTO SMALLER GROUPS (SUB 500)
    srch_neg1 = g['KEY_PHRASES_NEG_1'].split(',')
    srch_neg2 = g['KEY_PHRASES_NEG_2'].split(',')
    srch_neg3 = g['KEY_PHRASES_NEG_3'].split(',')
    srch_pos1 = g['KEY_PHRASES_POS_1'].split(',')
    srch_pos2 = g['KEY_PHRASES_POS_2'].split(',')
    srch_pos3 = g['KEY_PHRASES_POS_3'].split(',')
    srch_pos4 = g['KEY_PHRASES_POS_4'].split(',')
    srch_pos5 = g['KEY_PHRASES_POS_5'].split(',')
    srch_pos6 = g['KEY_PHRASES_POS_6'].split(',')
    srch_pos7 = g['KEY_PHRASES_POS_7'].split(',')
    srch_pos8 = g['KEY_PHRASES_POS_8'].split(',')
    
    #srch_test = g['KEY_PHRASES_TEST'].split(',')
    
    cntryCde = g['CNTRY_CDE'].split(',')
    
    for cc in cntryCde:
        # =============================================================================
        # DELETE FROM LOCAL DB WHERE A RERUN WOULD REPRODUCE "DUPLICATE" DATA
        # =============================================================================
        dbmgr = pyDB(g['DB'])
        q = r"""DELETE FROM {0} WHERE msmt_dte_id <= {1} and cntry_cde = '{2}'""".format(
            g['TBL_NME'], #[0]
            retention_date_id,  #[1]
            cc, #[3]
            ) 
        dbmgr.query(q)
        
        if cc == 'AU':
            cntry_cnvrsn = 'AUSTRALIA'
        elif cc == 'CA':
            cntry_cnvrsn = 'CANADA'
        elif cc == 'NZ':
            cntry_cnvrsn = 'NEW ZEALAND'
        elif cc == 'UK':
            cntry_cnvrsn = 'UNITED KINGDOM'
        elif cc == 'US':
            cntry_cnvrsn = 'USA'
        else:
            None
            
        places = Oapi.geo_search(query = cntry_cnvrsn, granularity='country')
        place_id = places[0].id

        # =============================================================================
        # RETURN MOST RECENT TWEET_ID TO BE USED FOR THE SINCEID PARAM
        # =============================================================================
        dbmgr = pyDB(g['DB'])
        q = r"SELECT min(TWEET_ID) as min_tweet_id, max(TWEET_ID) as max_tweet_id FROM {0} WHERE 1 = 1 and cntry_cde = '{1}'".format(
            g['TBL_NME'], #[0]
            cc, #[1]
            )
        rslt = dbmgr.query(q)
        for r in rslt:
            min_tweet_id = r[0]
            max_tweet_id = r[1]
        
        if max_tweet_id == None:
            sinceId = None
        else:  
            sinceId = int(max_tweet_id)
            
        # SET/RESET DICTIONARY OF SEARCH TERMS
        srch_dict = {}
        srch_dict.clear()
        srch_dict.update({'neg1': srch_neg1, 'neg2': srch_neg2, 'neg3': srch_neg3
                         ,'pos1': srch_pos1, 'pos2': srch_pos2, 'pos3': srch_pos3, 'pos4': srch_pos4, 'pos5': srch_pos5, 'pos6': srch_pos6, 'pos7': srch_pos7, 'pos8': srch_pos8
         #                ,'tst1': srch_test
                         }
                        )
            
        for key, value in srch_dict.items():            
            # SET SENTMT_MATCH (POS OR NEG) AND searchQuery TO BE PASSED TO FUNCTION CALL
            sentmnt_mtch = str(key).upper()[:3]
            val_str = ' OR '.join(value)
            searchQuery = val_str + ' AND "place:{0}"'.format(place_id) 
            print(searchQuery)        
            # =============================================================================
            # CALL TWEEPY SEARCH FUNCTION
            # PASSING VARIABLES:
            # (searchQuery, sinceId, sentmnt_mtch, cc (country_cde))
            # =============================================================================        
            searchTweet = pyTweepySearch.tweepySearch(searchQuery, sinceId, sentmnt_mtch, place_id, cc, **g) 
    
        # =============================================================================
        # UPDATE LOCAL DB WITH A FINISH TIME
        # =============================================================================
        finished_at = time.strftime("%Y-%m-%d %H:%M:%S") # capture a finish time to be entered into the db
        dbmgr = pyDB(g['DB'])
        q = r"""UPDATE {0} SET finished_at = '{1}' WHERE cntry_cde = '{2}' and prces_dte_id = {3}""".format(
            g['TBL_NME'], #[0]
            finished_at, #[1]
            cc, #[2]
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


