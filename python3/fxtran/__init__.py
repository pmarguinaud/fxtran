import _fxtran
from xml_libxml import Parser as _XMLParser, Text

_xml_parser = _XMLParser()

FXTRAN_NS = 'http://fxtran.net/#syntax'

__all__ = ['parse', 'set_options', 'help', 'run', 't', 's', 'e', 'n']


def run(*args):
    """Appel direct à fxtran.run() (module C)."""
    return _fxtran.run(*args)


def t(content):
    """Crée un nœud texte XML (équivalent de XML::LibXML::Text->new)."""
    return Text(content)


def s(statement):
    """Parse un statement Fortran, retourne le nœud XML."""
    return parse(statement=statement)


def e(expr):
    """Parse une expression Fortran, retourne le nœud XML."""
    return parse(expr=expr)


def n(xml):
    """Parse un fragment XML fxtran, retourne un ou plusieurs nœuds."""
    doc = _xml_parser.load_xml(
        string='<?xml version="1.0"?><object xmlns="' + FXTRAN_NS + '">' + xml + '</object>'
    )
    children = list(doc.documentElement.childNodes())
    if len(children) > 1:
        return children
    else:
        return children[0]


def parse(**kwargs):
    """Parse du code Fortran. Délègue à parser.PARSER.parse()."""
    from fxtran.parser import PARSER
    return PARSER.parse(**kwargs)


def set_options(*args):
    """Modifie les options du parser. Délègue à parser.PARSER.set_options()."""
    from fxtran.parser import PARSER
    return PARSER.set_options(*args)


def help():
    """Retourne le XML d'aide de fxtran."""
    return _fxtran.run('-help-xml', '')
