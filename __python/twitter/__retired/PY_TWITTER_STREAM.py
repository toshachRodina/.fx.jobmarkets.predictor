# =======================================================================================================================================================================================================
# SUBJECT        : sentiment analysis from twitter
# OBJECT TYPE    : python
# OBJECT NAME    : py_twitter_jobs
# CREATED BY     : Harold Delaney
# CREATED ON     : 20170623
# SOURCE         : twitter (tweepy python library)
# PREPERATION    : 
# FREQUENCY      : STREAMIN
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
import time # date time operations
import datetime # date subtractions
import re # regex
import tweepy
import json

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
from PY_UTIL_HTMLPASS import pyHTMLPass
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
    #print('tweeping')
    
    class StreamListener(tweepy.StreamListener):
        
        def on_status(self, status):
            if status.retweeted or 'RT @' in str(status.text).upper(): # IGNORE RETWEETS
                return
            
            print(str(status.text).upper().encode('utf-8'))
            print(str(status.user.location).upper() + '; ' + str(status.geo).upper() + '; ' + str(status.coordinates).upper())

            if 'HTTP' in str(status.text).upper(): # IGNORE TWEETS THAT LOOK LIKE LINKS TO ARTICLES OR OTHER POSTS
                return
            
            #api = tweepy.API(auth)
            '''
            class CustomStreamListener(tweepy.StreamListener):
                def on_status(self, status):
                    if 'manchester united' in status.text.lower():
                        print status.text
            
                def on_error(self, status_code):
                    print >> sys.stderr, 'Encountered error with status code:', status_code
                    return True # Don't kill the stream
            
                def on_timeout(self):
                    print >> sys.stderr, 'Timeout...'
                    return True # Don't kill the stream
            
            sapi = tweepy.streaming.Stream(auth, CustomStreamListener())    
            sapi.filter(locations=[-6.38,49.87,1.77,55.81])
            '''                     
            # GENERATE DICTIONARY PAIRS FOR TABLE CALL AND INSERTION
            tweet = dict(
                MSMT_DTE_ID = time.strftime('%Y%m%d')
               ,DATA_TYPE = ''
               ,CNTRY_CDE = ''
               ,LOCATION = status.user.location
               ,GEO = status.geo
               ,COORDS = status.coordinates
               ,UTC_OFFSET = status.user.utc_offset
               ,TIME_ZONE = status.user.time_zone
               ,LANGUAGE = status.user.lang
               ,DESCRIPTION = status.user.description
               ,TEXT = status.text
               ,USER_NAME = status.user.screen_name
               ,USER_CREATED = status.user.created_at
               ,RETWEET_COUNT = status.retweet_count
               ,RETWEET_STATUS = status.retweeted
            )
            print(tweet)
            
            if tweet['GEO'] is not None:
                tweet['GEO'] = json.dumps(geo)
    
            if tweet['COORDS'] is not None:
                tweet['COORDS'] = json.dumps(coords)
       
            # INSERT DATA INTO TABLE
            filter_tweet(**tweet)
            
        def on_error(self, status_code):
            if status_code == 420:
                #returning False in on_data disconnects the stream
                return False
    
    auth = tweepy.OAuthHandler(g['TWIT_CNSMR_KEY'], g['TWIT_CNSMR_SECRET']) # tweepy.OAuthHandler(settings.TWITTER_APP_KEY, settings.TWITTER_APP_SECRET)
    auth.set_access_token(g['TWIT_ACCESS_TOKEN'], g['TWIT_ACCESS_SECRET']) #auth.set_access_token(settings.TWITTER_KEY, settings.TWITTER_SECRET)
    api = tweepy.API(auth)
    
    print(g['KEY_PHRASES_JLU']) 
    print(g['KEY_PHRASES_JSJP']) 
    
    stream_listener = StreamListener()
    stream = tweepy.Stream(auth=api.auth, listener=stream_listener)
    stream.filter(languages=["en"], track=[g['KEY_PHRASES_JLU'], g['KEY_PHRASES_JSJP']])
        
def filter_tweet(**tweet):
    
    print(tweet)
    # Remove any tweets that don't match our criteria.
    if not tweet_matches_criteria(tweet):
        return
    # Process the remaining tweets.
    #process_tweet(**tweet)
    
def clean_tweet(**tweet):
    # Annotate the tweet dictionary with any other information we need.
    tweet["sentiment"] = get_sentiment(tweet)
    # Store the tweet.
    #store_tweet(**tweet)     

def store_tweet(**tweet): # (tweet)
    # =============================================================================
    # WRITE RESULTS OF TWEEP EXTRACT TO LOCAL DB
    # =============================================================================   
    dbmgr = pyDB(g['DB'])
    q = r"""INSERT INTO {0} (MSMT_DTE_ID, DATA_TYPE, CNTRY_CDE, LOCATION, GEO, COORDS, UTC_OFFSET, TIME_ZONE, LANGUAGE, DESCRIPTION, TEXT, USER_NAME, USER_CREATED, RETWEET_COUNT, POLARITY, SUBJECTIVITY) 
        VALUES ({1}, '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}', {10}, '{11}', '{12}', '{13}', {14})""".format(
         g['TBL_NME'] #[0]
        ,tweet['MSMT_DTE_ID'] #[1]
        ,tweet['DATA_TYPE'] #[2]
        ,tweet['CNTRY_CDE'] #[3]
        ,tweet['LOCATION'] #[4]
        ,tweet['GEO']  #[5]
        ,tweet['COORDS']  #[6]
        ,tweet['UTC_OFFSET']  #[7]
        ,tweet['TIME_ZONE']  #[8]
        ,tweet['LANGUAGE']  #[9]
        ,tweet['DESCRIPTION'] #[10]        
        ,tweet['TEXT'] #[11]
        ,tweet['USER_NAME'] #[12]
        ,tweet['USER_CREATED'] #[13]
        ,tweet['RETWEET_COUNT'] #[14]
        )
    dbmgr.query(q)

if __name__ == "__main__": main()