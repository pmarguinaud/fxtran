from xml_libxml import XPathContext as _XPathContext
from xpath_parser import Parser as _XPathParserCls, Step, Expr, LocationPath, Function

FXTRAN_NS = 'http://fxtran.net/#syntax'

# Exported as in Perl (@EXPORT)
__all__ = ['F', 'f']

# ---------------------------------------------------------------------------
# AST walker: puts the f: prefix on element names
# ---------------------------------------------------------------------------

def walk(node, seen=None):
    if node is None:
        return
    if not hasattr(node, '__class__'):
        return

    if seen is None:
        seen = set()
    node_id = id(node)
    if node_id in seen:
        return
    seen.add(node_id)

    cls_name = type(node).__name__

    method = globals().get('walk_' + cls_name)
    if method is not None:
        method(node, seen)
    else:
        raise RuntimeError('Missing walker for ' + cls_name)


def walk_Expr(node, seen):
    walk(node.lhs, seen)
    walk(node.rhs, seen)
    for p in node.predicates:
        walk(p, seen)


def walk_LocationPath(node, seen):
    for step in node.steps:
        walk(step, seen)


def walk_Number(node, seen):
    pass


def walk_Root(node, seen):
    pass


def walk_Step(node, seen):
    if node.literal is not None:
        if node.axis == 'attribute' and node.literal == 'NAME':
            # @NAME → f:N/f:n/text()
            p = _XPathParserCls()
            t = p.parse('f:N/f:n/text()')
            seen.discard(id(node))
            node.__class__ = t.__class__
            node.__dict__ = dict(t.__dict__)
            walk(node, seen)
            return
        elif node.literal.startswith('ANY-'):
            saved_preds = list(node.predicates)
            type_ = node.literal[4:]  # supprimer 'ANY-'
            size = len(type_)
            p = _XPathParserCls()
            xpath = './f:*[substring(name(),string-length(name())-{})="-{}"]'.format(size, type_)
            t = p.parse(xpath)
            # t.lhs is a LocationPath; t.lhs[1] is its second step
            new_step = t.lhs[1]

            saved_axis = node.axis
            saved_axis_method = node.axis_method

            seen.discard(id(node))
            node.__class__ = new_step.__class__
            node.__dict__ = dict(new_step.__dict__)
            node.predicates = list(node.predicates) + saved_preds
            if saved_axis:
                node.axis = saved_axis
            if saved_axis_method:
                node.axis_method = saved_axis_method

            walk(node, seen)
            return
        elif (node.literal not in ('.', '..', '*') and ':' not in node.literal and not node.test
              and node.axis != 'attribute'):
            # Attributes have no namespace: XML::XPath gives them a test code
            # (test_attr_qname), which keeps Perl from prefixing them.
            node.literal = 'f:' + node.literal

    for p in node.predicates:
        walk(p, seen)


def walk_Literal(node, seen):
    pass


def walk_Function(node, seen):
    for p in node.params:
        walk(p, seen)


def walk_VariableReference(node, seen):
    pass


# ---------------------------------------------------------------------------
# Cache of the preprocessed expressions
# ---------------------------------------------------------------------------

_cache = {}
_xpath_parser = _XPathParserCls()


def preprocess(xpath):
    if xpath not in _cache:
        tree = _xpath_parser.parse(xpath)
        walk(tree)
        _cache[xpath] = tree.as_string()
    return _cache[xpath]


# ---------------------------------------------------------------------------
# XPath context with the f: namespace
# ---------------------------------------------------------------------------

_xpc = _XPathContext()
_xpc.registerNs('f', FXTRAN_NS)


# ---------------------------------------------------------------------------
# API publique
# ---------------------------------------------------------------------------

def F(xpath, *args):
    """f() on a preprocessed expression: f: on names without a prefix, @NAME and
    ANY-xxx."""
    xpath = preprocess(xpath)
    return f(xpath, *args)


def f(xpath, *args):
    """Evaluate an XPath expression on a node of an fxtran document.

    Signatures :
      f(xpath, node)           -> list of nodes
      f(xpath, node, 1)        -> list of str (textContent, no spaces, upper case)
      f(xpath, node, 2)        -> list of str (textContent)
      f(xpath, val, ..., node) -> each '?' of xpath replaced by the next val
    """
    args = list(args)

    # Each '?' takes the next value
    while args and '?' in xpath:
        val = args.pop(0)
        xpath = xpath.replace('?', str(val), 1)

    if not args:
        raise TypeError("f(): expected node")

    node = args[0]
    mode = args[1] if len(args) > 1 else None

    results = list(_xpc.findnodes(xpath, node))

    if mode is None:
        return results
    elif mode == 1:
        texts = [r.textContent for r in results]
        return [''.join(t.split()).upper() for t in texts]
    elif mode == 2:
        return [r.textContent for r in results]
    else:
        return results
