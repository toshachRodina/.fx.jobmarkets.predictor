# =======================================================================================================================================================================================================
# SUBJECT        : sentiment analysis from twitter
# OBJECT TYPE    : python
# OBJECT NAME    : py_twitter_streaming
# CREATED BY     : Harold Delaney
# CREATED ON     : 20170706
# SOURCE         : twitter (tweepy python library)
# PREPERATION    : 
# FREQUENCY      : STREAMING
#               
# REMARKS        : 1) THESE PHRASES NEED TO BE FURTHER FILTERED ON POST PROCESSING
#                     EG. job NEEDS TO BE COMBINED WITH A PATTERN MATCH FOR lost|*|job (lost MY job or lost MY F%&$ING job)
#                     ** hiring
#                     ** job
#                     ** jobs
#                     ** position
#                     ** work
#                     ** sack
#                     ** jobs in
#                     ** jobs near
#                     ** job in
#                     ** job near
#                     ** work in
#                     ** work near
#                  2) 
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
dbPath = os.path.join(path, '../@data/')
dbPath = os.path.abspath(os.path.realpath(dbPath)) 
# ADD ABOVE NOMINATED DIRECTORIES TO IMPORT SEARCH PATH
sys.path.insert(0, utilPath)
sys.path.insert(0, os.path.dirname(os.path.abspath(os.path.realpath(__file__))) ) 
# CALL USER DEFINED MODULES/FUNCTIONS
from PY_UTIL_EMAIL import pyMail
from PY_UTIL_DB import pyDB
from PY_UTIL_CONFIG import pyConfig
from PY_UTIL_TWEEPY_SLISTENER import pySListener
# =============================================================================
# ENVIRNMENT AND LIBRARY SETUP -- END
# =============================================================================
__version__ = "1.0.0"
__author__ = "Harold Delaney"

g = dict(
    CONFIG_FILE = utilPath + '\PY_DB.conf',
    VARS_TABLE_NAME = 'PY_VARS_TWEEP_CTL',
    PKG_NME = fileName.replace('.py','').upper()
)

def main():
    init()
    get_vars()
    stream()
    #write_log() # SUCCESS
    
def init():
    g['CONFIG'] = pyConfig(g['CONFIG_FILE']).recs()
    g['PKG_PATH'] = path
    g['DB'] = dbPath + '\\' + g['CONFIG']['DB_TWEEP']
    g['ENV'] = g['CONFIG']['ENV']
    g['STARTED_AT'] = time.strftime("%Y-%m-%d %H:%M:%S")
      
def get_vars():
    dbmgr = pyDB(g['DB']) 
    rslt = dbmgr.get_vars(**g)
    # ADD RESULTS FROM GET_VARS CALL TO DICTIONARY (g)
    for r in rslt:
        g[str(r[0])] = str(r[1])
        #print(r)
    print([g])

def stream():
    # TWITTER API SECURITY CONFIG
    auth = tweepy.OAuthHandler(g['TWIT_CNSMR_KEY'], g['TWIT_CNSMR_SECRET']) # tweepy.OAuthHandler(settings.TWITTER_APP_KEY, settings.TWITTER_APP_SECRET)
    auth.set_access_token(g['TWIT_ACCESS_TOKEN'], g['TWIT_ACCESS_SECRET']) #auth.set_access_token(settings.TWITTER_KEY, settings.TWITTER_SECRET)
    api = tweepy.API(auth)
    
    # TAKE CONFIG LISTING AND CONVERT IT TO A SEARCHABLE LIST
    kp_array = []
    kps_jlu = g['KEY_PHRASES_JLU']
    kps_jsjp = g['KEY_PHRASES_JSJP']
    #kps_cryptoccy = g['KEY_PHRASES_CRYPTOCCY']
    # CONVERTS LIST OBJECT TO ARRAY FOR LOOPING
    for item in kps_jlu.split(','): # COMMA, OR OTHER
        kp_array.append(item) 
    # CONVERTS LIST OBJECT TO ARRAY FOR LOOPING
    for item in kps_jsjp.split(','): # COMMA, OR OTHER
        kp_array.append(item)  
    # CONVERTS LIST OBJECT TO ARRAY FOR LOOPING
    '''for item in kps_cryptoccy.split(','): # COMMA, OR OTHER
        kp_array.append(item)'''  
    
    #kp_list = '"' + '","'.join(kp_array) + '"'
    
    # CONFIGURE LISTENER USING TWITTER API AUTH CREDENTIALS
    listen = pySListener(api, 'streaming', **g)
    stream = tweepy.Stream(auth, listen)
    
    print ('Streaming started...')
    try: 
        stream.filter(track=kp_array)
    except BaseException as e:
        print('error! : ' + str(e))
        stream.disconnect()

if __name__ == "__main__": main()


