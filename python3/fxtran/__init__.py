"""fxtran: Fortran source to XML.

The core, run(), help() and the exceptions, needs only the _fxtran extension:
it returns the XML as a str, as before the DOM layer existed.

The DOM layer (parse, s, e, t, n, setOptions, fxtran.parser, fxtran.xpath)
returns xml_libxml nodes, and needs xml_libxml and xpath_parser
(pip install fxtran[dom]). These modules are imported when it is first used.
"""

import importlib

import _fxtran

FXTRAN_NS = 'http://fxtran.net/#syntax'

# Exported as in Perl (@EXPORT); setOptions, help and run are fxtran.setOptions, ...
__all__ = ['parse', 's', 't', 'e', 'n']

# The exception of the extension, as before the DOM layer existed
error = _fxtran.error


class Error(_fxtran.error):
    """Error of fxtran, or of the fxtran command that parseString and parseLocation run."""


def _require(*modules):
    """Import the modules of the DOM layer, with a clear message if one is missing."""
    for module in modules:
        try:
            importlib.import_module(module)
        except ImportError as err:
            raise ImportError(
                "{} is not installed: it is needed by the DOM layer of fxtran "
                "(parse, s, e, t, n, setOptions, fxtran.parser, fxtran.xpath); "
                "install fxtran[dom], or xml_libxml and xpath-parser. "
                "fxtran.run() works without it.".format(module),
                name=module) from err


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
    _require('xml_libxml')
    from xml_libxml import Text
    return Text(content)


def s(statement):
    """Parse a statement."""
    return parse(statement=statement)


def e(expr):
    """Parse an expression."""
    return parse(expr=expr)


_xml_parser = None


def n(xml):
    """Nodes from fxtran XML: one node, or a list if there are several."""
    global _xml_parser
    if _xml_parser is None:
        _require('xml_libxml')
        from xml_libxml import Parser
        _xml_parser = Parser()
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
