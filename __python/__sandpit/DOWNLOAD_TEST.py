import requests

r = requests.get('http://www.histdata.com/download-free-forex-historical-data/?/ascii/tick-data-quotes/eurusd/2017/10/get')
r.status_code

#with open('/Users/scott/Downloads/cat3.jpg', 'wb') as f:  
#    f.write(r.content)

# Retrieve HTTP meta-data
print(r.status_code)  
print(r.headers['content-type'])  
print(r.encoding)  


