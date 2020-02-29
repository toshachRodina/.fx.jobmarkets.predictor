import pip
import sys, os, platform

# PYTHON PACKAGE DETAILS
print('INSTALLED PYTHON PACKAGES')
print('====================================================================================================')
installed_packages = pip.get_installed_distributions()
installed_packages_list = sorted(["%s==%s" % (i.key, i.version)
     for i in installed_packages])

for itm in installed_packages_list:
    print(itm)

try:
    user_paths = os.environ['PYTHONPATH'].split(os.pathsep)
except KeyError:
    user_paths = []


#print(installed_packages_list)
print('')
print('PYTHON ENVIRONMENT DETAILS')
print('====================================================================================================')
# SYSTEM AND PYTHON ENVIRONMENT DETAILS
print('PYTHON VERSION         | ' + sys.version)
print('PYTHON ARCHITECTURE    | ' + str(platform.architecture()))
print('PYTHON PATHS           | ' + str(sys.path))
print('PYTHON EXECUTABLE PATH | ' + sys.executable)
print('PYTHONPATH             | ' + str(user_paths))


