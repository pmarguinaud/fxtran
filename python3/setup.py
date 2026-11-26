from setuptools import setup, Extension
from setuptools.command.sdist import sdist
import glob
import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TOP = os.path.relpath(os.path.dirname(HERE), os.getcwd())
prefix = TOP

# The oldest Python of the stable ABI used by fxtran.c: the wheel works with it
# and all the later versions
LIMITED_API = (3, 6)

debian = os.getenv ('DEB_BUILD_ARCH')

if (len(sys.argv) > 1) and (sys.argv[1] == 'install') and (debian is not None):
  sys.argv.append ('--prefix=' + prefix + "/debian/tmp/usr")
  sys.argv.append ('--old-and-unmanageable')


# The C sources of fxtran (src/makefile, src/cpp/makefile and src/obstack/makefile
# list them) and the headers, relative to the root of the repository
CSRC_DIRS = ['src', 'src/cpp', 'src/obstack']
CSRC_PATTERNS = [os.path.join (d, p) for d in CSRC_DIRS for p in ('*.c', '*.h')] + ['include/FXTRAN/*.h']

# The root of the C sources: the repository, or the csrc directory of an sdist
CSRC = 'csrc' if os.path.isdir (os.path.join (HERE, 'csrc')) else TOP


class Sdist (sdist):
  """The sdist holds the C sources of fxtran in csrc, and the license."""

  def make_release_tree (self, base_dir, files):
    # Not the sources outside this directory, that setuptools adds as ../src/...
    files = [f for f in files if not os.path.normpath (f).startswith (os.pardir)]
    super ().make_release_tree (base_dir, files)
    if CSRC == 'csrc':
      shutil.copytree (os.path.join (HERE, 'csrc'), os.path.join (base_dir, 'csrc'), dirs_exist_ok=True)
    else:
      for pattern in CSRC_PATTERNS:
        for path in glob.glob (os.path.join (TOP, pattern)):
          dest = os.path.join (base_dir, 'csrc', os.path.relpath (path, TOP))
          os.makedirs (os.path.dirname (dest), exist_ok=True)
          shutil.copy2 (path, dest)
    license = os.path.join (TOP if CSRC == TOP else '.', 'LICENSE.txt')
    if os.path.isfile (license):
      shutil.copy2 (license, os.path.join (base_dir, 'LICENSE.txt'))


options = {}

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
  # extension, which needs neither libfxtran nor make
  def sources (pattern):
    return sorted (glob.glob (os.path.join (CSRC, 'src', pattern)))

  extension = Extension ("_fxtran",
    ["fxtran.c"] + sources ('FXTRAN_*.c') + sources ('cpp/*.c') + sources ('obstack/*.c'),
    include_dirs=[os.path.join (CSRC, d) for d in ['include', 'src', 'src/cpp', 'src/obstack']],
    define_macros=[('NO_OBSTACK', None), ('HAVE_CONFIG_H', None),
                   ('Py_LIMITED_API', '0x{:02x}{:02x}0000'.format (*LIMITED_API))],
    extra_compile_args=['-fsigned-char'],
    py_limited_api=True)
  # One wheel for all the versions of Python: cp36-abi3
  options = {"bdist_wheel": {"py_limited_api": "cp{}{}".format (*LIMITED_API)}}
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
    options = options,
    cmdclass = {"sdist": Sdist},
  );
