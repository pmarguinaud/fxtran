from xml_libxml import XPathContext as _XPathContext
from xpath_parser import Parser as _XPathParserCls, Step, Expr, LocationPath, Function

FXTRAN_NS = 'http://fxtran.net/#syntax'

# ---------------------------------------------------------------------------
# AST walker : transforme les noms de tags en ajoutant le préfixe f:
# ---------------------------------------------------------------------------

def _walk(node, seen=None):
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

    method = globals().get('_walk_' + cls_name)
    if method is not None:
        method(node, seen)
    else:
        raise RuntimeError('Missing walker for ' + cls_name)


def _walk_Expr(node, seen):
    _walk(node.lhs, seen)
    _walk(node.rhs, seen)
    for p in node.predicates:
        _walk(p, seen)


def _walk_LocationPath(node, seen):
    for step in node.steps:
        _walk(step, seen)


def _walk_Number(node, seen):
    pass


def _walk_Root(node, seen):
    pass


def _walk_Step(node, seen):
    if node.literal is not None:
        if node.axis == 'attribute' and node.literal == 'NAME':
            # @NAME → f:N/f:n/text()
            p = _XPathParserCls()
            t = p.parse('f:N/f:n/text()')
            seen.discard(id(node))
            node.__class__ = t.__class__
            node.__dict__ = dict(t.__dict__)
            _walk(node, seen)
            return
        elif node.literal.startswith('ANY-'):
            saved_preds = list(node.predicates)
            type_ = node.literal[4:]  # supprimer 'ANY-'
            size = len(type_)
            p = _XPathParserCls()
            xpath = './f:*[substring(name(),string-length(name())-{})="-{}"]'.format(size, type_)
            t = p.parse(xpath)
            # t.lhs est un LocationPath ; on veut t.lhs[1] (le deuxième pas)
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

            _walk(node, seen)
            return
        elif node.literal not in ('.', '..', '*') and ':' not in node.literal and not node.test:
            node.literal = 'f:' + node.literal

    for p in node.predicates:
        _walk(p, seen)


def _walk_Literal(node, seen):
    pass


def _walk_Function(node, seen):
    for p in node.params:
        _walk(p, seen)


def _walk_VariableReference(node, seen):
    pass


# ---------------------------------------------------------------------------
# Cache des expressions XPath préprocessées
# ---------------------------------------------------------------------------

_cache = {}
_xpath_parser = _XPathParserCls()


def _preprocess(xpath):
    if xpath not in _cache:
        tree = _xpath_parser.parse(xpath)
        _walk(tree)
        _cache[xpath] = tree.as_string()
    return _cache[xpath]


# ---------------------------------------------------------------------------
# XPathContext global avec namespace f:
# ---------------------------------------------------------------------------

_xpc = _XPathContext()
_xpc.registerNs('f', FXTRAN_NS)


# ---------------------------------------------------------------------------
# API publique
# ---------------------------------------------------------------------------

def F(xpath, *args):
    """Comme f(), mais préprocesse le xpath : ajoute f: sur les noms sans préfixe,
    gère @NAME et ANY-xxx."""
    xpath = _preprocess(xpath)
    return f(xpath, *args)


def f(xpath, *args):
    """Évalue un xpath sur un nœud XML fxtran.

    Signatures :
      f(xpath, node)           → liste de nœuds
      f(xpath, node, 1)        → liste de str (textContent, sans espaces, upper-case)
      f(xpath, node, 2)        → liste de str (textContent brut)
      f(xpath, '?', val, node) → remplace les '?' par des valeurs littérales
    """
    args = list(args)

    # Remplacer les '?' par les valeurs successives
    while args and '?' in xpath:
        val = args.pop(0)
        xpath = xpath.replace('?', str(val), 1)

    if not args:
        raise TypeError("f() : nœud de contexte manquant")

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
