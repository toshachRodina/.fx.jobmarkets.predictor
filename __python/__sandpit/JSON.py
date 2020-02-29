import requests


url = 'http://stat.data.abs.gov.au/sdmx-json/data/ABS_REGIONAL_LGA2017.json'

response = requests.get(url)
print(response.text)