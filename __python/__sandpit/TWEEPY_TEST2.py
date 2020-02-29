import tweepy

auth = tweepy.OAuthHandler('EO3DcdljWwxN4TKrUUB27Nn96', 'H9XFfndnoGXrepH5RQA9N2hCaSWJHNV66t9DXXz5DDF1CPXJWp')
auth.set_access_token('12577272-frRvqnqx1IfaKuwy5aOe172ppKeBL2ta6AAUtsQns','qfneff6FA12lz3otz4jdXFEQZqyplrrAJuqlZUAe7hEpI')

api = tweepy.API(auth)
places = api.geo_search(query="AUSTRALIA", granularity="country")
place_id = places[0].id

print("place:%s" % place_id)


tweets = api.search(q='"Richmond" AND "Martin" AND ' +  "place:%s" % place_id)
for tweet in tweets:
    print (str(tweet.text.upper().encode('utf-8')) + " | " + str(tweet.place.name) if tweet.place else "Undefined place")