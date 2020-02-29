import tweepy

auth = tweepy.OAuthHandler('EO3DcdljWwxN4TKrUUB27Nn96', 'H9XFfndnoGXrepH5RQA9N2hCaSWJHNV66t9DXXz5DDF1CPXJWp')
auth.set_access_token('12577272-frRvqnqx1IfaKuwy5aOe172ppKeBL2ta6AAUtsQns', 'qfneff6FA12lz3otz4jdXFEQZqyplrrAJuqlZUAe7hEpI')



# AU = AU
# CA = CANADA
# NZ = New Zealand
# UK = United Kingdom
# US = USA 

#"donald trump" OR "australian survivor" AND "place:3f14ce28dc7c4566"
#"Donald Trump" AND "place:96683cc9126741d1"
api = tweepy.API(auth)
places = api.geo_search(query="USA", granularity="country")
place_id = places[0].id

print('"Donald Trump" AND "place:%s"' % place_id)
tweets = api.search(q='"Donald Trump" AND "place:%s"' % place_id)
for tweet in tweets:
    #print (tweet) #place_id + ' : ' + tweet.text + " | " + tweet.place.name + " | " + str(tweet.id) if tweet.place else "Undefined place")
    print (   'created_at: ' + str(tweet.created_at)
    + " | " + 'id : ' + tweet.id_str
    + " | " + 'user_id : ' + tweet.user.id_str
    + " | " + 'user_name : ' + str(tweet.user.name.encode('ascii', 'replace')).replace('?','').rstrip()   #.encode("utf-8"))
    + " | " + 'user_screen_name : ' + str(tweet.user.screen_name.encode('ascii', 'replace')).replace('?','').rstrip()
    + " | " + 'user_location : ' + tweet.user.location
    + " | " + 'place_id (country_id) : ' + str(place_id)
    + " | " + 'country_cde : ' + tweet.place.country_code
    + " | " + 'place_name : ' + tweet.place.name
    + " | " + 'text : ' + str(tweet.text.encode('ascii', 'replace')).replace('?','')
    + " | " + 'in_reply_to : ' + ('NOVAL' if tweet.in_reply_to_status_id_str is None else tweet.in_reply_to_status_id_str)    
    + " | " + 're-tweeted : ' + str(tweet.retweeted)
    + " | " + 'retweet_count : ' + ('0' if str(tweet.retweet_count) is None else str(tweet.retweet_count))  
    )