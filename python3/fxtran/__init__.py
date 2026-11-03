import _fxtran
from xml_libxml import Parser as _XMLParser, Text

_xml_parser = _XMLParser()

FXTRAN_NS = 'http://fxtran.net/#syntax'

# Exported as in Perl (@EXPORT); setOptions, help and run are fxtran.setOptions, ...
__all__ = ['parse', 's', 't', 'e', 'n']


class Error(_fxtran.error):
    """Error of fxtran, or of the fxtran command that parseString and parseLocation run."""


def run(*args):
    """Run fxtran on the text, with options: run(option, ..., text)."""
    try:
        return _fxtran.run(*args)
    except Error:
        raise
    except _fxtran.error as err:
        raise Error(*err.args) from None


def t(content):
    """A text node."""
    return Text(content)


def s(statement):
    """Parse a statement."""
    return parse(statement=statement)


def e(expr):
    """Parse an expression."""
    return parse(expr=expr)


def n(xml):
    """Nodes from fxtran XML: one node, or a list if there are several."""
    doc = _xml_parser.load_xml(
        string='<?xml version="1.0"?><object xmlns="' + FXTRAN_NS + '">' + xml + '</object>'
    )
    children = list(doc.documentElement.childNodes())
    if len(children) > 1:
        return children
    else:
        return children[0]


def parse(**kwargs):
    """Parse Fortran code: parse(string=...), program, location, fragment, statement or expr."""
    from fxtran.parser import PARSER
    return PARSER.parse(**kwargs)


def setOptions(*args):
    """Change the options of the parser."""
    from fxtran.parser import PARSER
    return PARSER.setOptions(*args)


def help():
    """The help of fxtran, as XML."""
    return _fxtran.run('-help-xml', '')
