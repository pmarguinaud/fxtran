from setuptools import setup, Extension
import glob
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TOP = os.path.relpath(os.path.dirname(HERE), os.getcwd())
prefix = TOP

debian = os.getenv ('DEB_BUILD_ARCH')

if (len(sys.argv) > 1) and (sys.argv[1] == 'install') and (debian is not None):
  sys.argv.append ('--prefix=' + prefix + "/debian/tmp/usr")
  sys.argv.append ('--old-and-unmanageable')

if (debian is not None):
  # Debian: the extension uses libfxtran, of the libfxtran0 package
  prefix = '/usr'
  extension = Extension ("_fxtran", ["fxtran.c"],
    include_dirs=[TOP + '/include'],
    libraries=['fxtran'],
    library_dirs=[prefix + "/lib", TOP + "/lib"])
  entry_points = {}
else:
  # pip install, setup.py build: the fxtran sources are compiled into the
  # extension, which needs neither libfxtran nor make (see src/makefile,
  # src/cpp/makefile and src/obstack/makefile for the lists of sources)
  def sources (pattern):
    return sorted (glob.glob (os.path.join (TOP, 'src', pattern)))

  extension = Extension ("_fxtran",
    ["fxtran.c"] + sources ('FXTRAN_*.c') + sources ('cpp/*.c') + sources ('obstack/*.c'),
    include_dirs=[TOP + '/include', TOP + '/src', TOP + '/src/cpp', TOP + '/src/obstack'],
    define_macros=[('NO_OBSTACK', None), ('HAVE_CONFIG_H', None)],
    extra_compile_args=['-fsigned-char'])
  # The fxtran command, needed by parseString and parseLocation
  entry_points = {"console_scripts": ["fxtran = fxtran:main"]}

setup (
    name = "fxtran",
    packages = ["fxtran"],
    version = "0.1",
    python_requires = ">=3.6",
    # fxtran.run needs nothing else; the DOM layer (parse, fxtran.xpath, ...) needs
    # github.com/pmarguinaud/python-libxml2 and github.com/pmarguinaud/python-xpath_parser:
    # pip install fxtran[dom]
    extras_require = {"dom": ["xml_libxml", "xpath-parser"]},
    ext_modules = [extension],
    entry_points = entry_points,
  );
