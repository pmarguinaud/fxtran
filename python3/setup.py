from setuptools import setup, Extension
import os
import sys

TOP = ".."
prefix = TOP

debian = os.getenv ('DEB_BUILD_ARCH')

if (sys.argv[1] == 'install') and (debian is not None):
  sys.argv.append ('--prefix=' + prefix + "/debian/tmp/usr")
  sys.argv.append ('--old-and-unmanageable')

if (debian is not None):
  prefix = '/usr'

setup (
    name = "fxtran",
    version = "0.1",
    ext_modules = [Extension ("fxtran", ["fxtran.c"], 
    include_dirs=[TOP + '/include'], 
    libraries=['fxtran'],
    library_dirs=[prefix + "/lib", TOP + "/lib"])],
  );

