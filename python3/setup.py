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

# As the Perl module: the library is found where it was built, except for Debian
rpath = [] if (debian is not None) else [os.path.abspath (TOP + "/lib")]

setup (
    name = "fxtran",
    packages = ["fxtran"],
    version = "0.1",
    python_requires = ">=3.6",
    # github.com/pmarguinaud/python-libxml2 and github.com/pmarguinaud/python-xpath_parser
    install_requires = ["xml_libxml", "xpath-parser"],
    ext_modules = [Extension ("_fxtran", ["fxtran.c"],
    include_dirs=[TOP + '/include'], 
    libraries=['fxtran'],
    library_dirs=[prefix + "/lib", TOP + "/lib"],
    runtime_library_dirs=rpath)],
  );

