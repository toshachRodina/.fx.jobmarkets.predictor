from linkedin import linkedin

# TEST CREDS
#API_KEY = 'wFNJekVpDCJtRPFX812pQsJee-gt0zO4X5XmG6wcfSOSlLocxodAXNMbl0_hw3Vl'
#API_SECRET = 'daJDa6_8UcnGMw1yuq9TjoO_PMKukXMo8vEMo7Qv5J-G3SPgrAV0FqFCd0TNjQyG'

# MY CREDS
API_KEY = '788rv4k2hlc2cs'
API_SECRET = 'MCv3QAFRFRLIACUs'


RETURN_URL = 'http://localhost:8000'

authentication = linkedin.LinkedInAuthentication(API_KEY, API_SECRET, RETURN_URL, linkedin.PERMISSIONS.enums.values())
print (authentication.authorization_url)  # open this url on your browser
application = linkedin.LinkedInApplication(authentication)

application.search_profile(selectors=[{'people': ['first-name', 'last-name']}], params={'keywords': 'apple microsoft'})

print(application)









# from linkedin import server
# 
# # TEST CREDS
# #KEY = 'wFNJekVpDCJtRPFX812pQsJee-gt0zO4X5XmG6wcfSOSlLocxodAXNMbl0_hw3Vl'
# #SECRET = 'daJDa6_8UcnGMw1yuq9TjoO_PMKukXMo8vEMo7Qv5J-G3SPgrAV0FqFCd0TNjQyG'
# 

# #application = server.quick_api('788rv4k2hlc2cs', 'MCv3QAFRFRLIACUs')
# 
# application = server.quick_api(KEY, SECRET)
