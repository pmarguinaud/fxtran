"""
Fixtures et helpers partagés pour les tests fxtran Python.
Équivalent des sous-routines communes dans les fichiers .t Perl.
"""
import os
import sys

# Ajout des chemins nécessaires
_HERE = os.path.dirname(__file__)
_PYTHON3 = os.path.dirname(_HERE)
_ROOT = os.path.dirname(os.path.dirname(_PYTHON3))

sys.path.insert(0, _PYTHON3)
sys.path.insert(0, os.path.join(_ROOT, 'python-libxml2'))
sys.path.insert(0, os.path.join(_ROOT, 'python-xpath_parser'))

# Ajouter fxtran/bin au PATH
_BIN = os.path.join(os.path.dirname(_PYTHON3), 'bin')
os.environ['PATH'] = _BIN + os.pathsep + os.environ.get('PATH', '')

# Ajouter fxtran/lib au LD_LIBRARY_PATH
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
    """Parse du code Fortran avec les options données, retourne un Document XML."""
    import _fxtran
    code = code.strip('\n') + '\n'
    xml = _fxtran.run(*extra_opts, code)
    return xml_libxml.Parser().load_xml(string=xml)


def xfind(xpath, doc):
    """Retourne la liste des nœuds correspondant au xpath dans doc."""
    if doc is None:
        return []
    return list(_make_xpc().findnodes(xpath, doc))


def xval(xpath, doc):
    """Retourne la valeur de chaîne d'une expression XPath."""
    return _make_xpc().findvalue(xpath, doc)


def has(xpath, doc):
    """Assert qu'il existe au moins un nœud correspondant."""
    nodes = xfind(xpath, doc)
    assert len(nodes) > 0, f"Expected to find '{xpath}' but found nothing"


def hasnt(xpath, doc):
    """Assert qu'il n'existe aucun nœud correspondant."""
    nodes = xfind(xpath, doc)
    assert len(nodes) == 0, f"Expected to find nothing for '{xpath}' but found {len(nodes)} node(s)"


def count(xpath, doc, n):
    """Assert que le nombre de nœuds correspondants est exactement n."""
    nodes = xfind(xpath, doc)
    assert len(nodes) == n, f"Expected {n} node(s) for '{xpath}' but found {len(nodes)}"
