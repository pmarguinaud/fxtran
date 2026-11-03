"""
Helpers of the tests, as the subroutines of the Perl .t files.
"""
import os
import sys

# Paths of the modules
_HERE = os.path.dirname(__file__)
_PYTHON3 = os.path.dirname(_HERE)
_ROOT = os.path.dirname(os.path.dirname(_PYTHON3))

# This directory first; xml_libxml and xpath_parser from PYTHONPATH or installed,
# else next to this repository
sys.path.insert(0, _PYTHON3)
sys.path.append(os.path.join(_ROOT, 'python-libxml2'))
sys.path.append(os.path.join(_ROOT, 'python-xpath_parser'))

# fxtran/bin in PATH
_BIN = os.path.join(os.path.dirname(_PYTHON3), 'bin')
os.environ['PATH'] = _BIN + os.pathsep + os.environ.get('PATH', '')

# fxtran/lib in LD_LIBRARY_PATH
_LIB = os.path.join(os.path.dirname(_PYTHON3), 'lib')
os.environ['LD_LIBRARY_PATH'] = _LIB + os.pathsep + os.environ.get('LD_LIBRARY_PATH', '')

import ctypes
try:
    ctypes.CDLL(os.path.join(_LIB, 'libfxtran.so.0'))
except OSError:
    pass

import xml_libxml

FXTRAN_NS = 'http://fxtran.net/#syntax'

def _make_xpc():
    xpc = xml_libxml.XPathContext()
    xpc.registerNs('f', FXTRAN_NS)
    return xpc

def parse_with_opts(code, *extra_opts):
    """Parse Fortran code with these options, and return the document."""
    import _fxtran
    code = code.strip('\n') + '\n'
    xml = _fxtran.run(*extra_opts, code)
    return xml_libxml.Parser().load_xml(string=xml)


def xfind(xpath, doc):
    """The nodes of doc that xpath finds."""
    if doc is None:
        return []
    return list(_make_xpc().findnodes(xpath, doc))


def xval(xpath, doc):
    """The string value of xpath."""
    return _make_xpc().findvalue(xpath, doc)


def has(xpath, doc):
    """xpath finds something."""
    nodes = xfind(xpath, doc)
    assert len(nodes) > 0, f"Expected to find '{xpath}' but found nothing"


def hasnt(xpath, doc):
    """xpath finds nothing."""
    nodes = xfind(xpath, doc)
    assert len(nodes) == 0, f"Expected to find nothing for '{xpath}' but found {len(nodes)} node(s)"


def count(xpath, doc, n):
    """xpath finds n nodes."""
    nodes = xfind(xpath, doc)
    assert len(nodes) == n, f"Expected {n} node(s) for '{xpath}' but found {len(nodes)}"
