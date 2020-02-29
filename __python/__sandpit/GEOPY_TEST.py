from geopy.geocoders import Nominatim
from geopy.exc import GeocoderTimedOut
import time

geolocator = Nominatim()

def geocode(country, recursion=0):
    try:
        return geolocator.geocode(country)
    except GeocoderTimedOut as e:
        if recursion > 10:      # max recursions
            raise e

        time.sleep(1) # wait a bit
        # try country again
        return geocode(country, recursion=recursion + 1)

cntryAU = geocode("Australia")
cntryCA = geocode("Canada")
cntryNZ = geocode("NZ")
cntryUK = geocode("UK")
cntryUS = geocode("USA")


print(cntryAU.address)
print((cntryAU.latitude, cntryAU.longitude))
print(cntryAU.raw)
print()
print(cntryCA.address)
print((cntryCA.latitude, cntryCA.longitude))
print(cntryCA.raw)
print()
print(cntryNZ.address)
print((cntryNZ.latitude, cntryNZ.longitude))
print(cntryNZ.raw)
print()
print(cntryUK.address)
print((cntryUK.latitude, cntryUK.longitude))
print(cntryUK.raw)
print()
print(cntryUS.address)
print((cntryUS.latitude, cntryUS.longitude))
print(cntryUS.raw)