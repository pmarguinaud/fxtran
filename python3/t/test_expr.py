"""
Port of perl5/t/expr.t.

Unit tests for the operator trees built by fxtran.

Each case is the right-hand side of an assignment; its tree is printed as the
source text with every op-E wrapped in [ ], so that A + B - C parsed as
A + (B - C) reads [A + [B - C]]. Parentheses of the source stay ( ).

Expected trees follow the Fortran precedence (F2018, 10.1.2), but chains of
equal-precedence operators nest to the right wherever the result is
mathematically equivalent (F2018, 10.1.5.2.4):

  - add-op:  split at the first + ; with no +, nest - to the left
             A - B + C - D -> [[A - B] + [C - D]]
  - mult-op: split at the first * that is not followed by a / ; with none,
             nest to the left: I * J / K is not I * (J / K) for integers
  - ** nests to the right (this is the standard grouping)
  - // .AND. .OR. .EQV. .NEQV. nest to the right (associative)
  - defined binary operators nest to the left (unknown semantics)
"""
import os
import subprocess

import pytest

import xml_libxml
from conftest import FXTRAN_NS

# FXTRAN=path/to/fxtran to test another build, as in Perl
FXTRAN = os.environ.get('FXTRAN') or os.path.join(os.path.dirname(__file__), '..', '..', 'bin', 'fxtran')

CASES = [
    # primaries
    ('A', 'A'),
    ('1.5E0', '1.5E0'),
    ('(A)', '(A)'),
    ('((A + B))', '(([A + B]))'),
    ('F (A + B, C)', 'F ([A + B], C)'),
    ('Z (I + 1, :)', 'Z ([I + 1], :)'),
    ('Y%Z + 1', '[Y%Z + 1]'),
    ('(/ A + B, C /)', '(/ [A + B], C /)'),
    ('1.E-3 * A', '[1.E-3 * A]'),
    ('1.D+0 + A', '[1.D+0 + A]'),
    ('1._JPRB - A', '[1._JPRB - A]'),
    ('.5 + A', '[.5 + A]'),
    ('(1.0, 2.0) * A', '[(1.0, 2.0) * A]'),
    ('.TRUE. .AND. L1', '[.TRUE. .AND. L1]'),
    ("'AB' // 'CD'", "['AB' // 'CD']"),

    # parentheses
    ('(A + B) * C', '[([A + B]) * C]'),
    ('A * (B + C)', '[A * ([B + C])]'),
    ('A - (B - C)', '[A - ([B - C])]'),
    ('A / (B * C)', '[A / ([B * C])]'),
    ('(A ** B) ** C', '[([A ** B]) ** C]'),

    # precedence between levels
    ('A + B * C', '[A + [B * C]]'),
    ('A * B + C', '[[A * B] + C]'),
    ('A * B ** C', '[A * [B ** C]]'),
    ('A ** B * C', '[[A ** B] * C]'),
    ('A + B * C ** D', '[A + [B * [C ** D]]]'),
    ('A ** B / C - D', '[[[A ** B] / C] - D]'),
    ('CA // CB == CC', '[[CA // CB] == CC]'),
    ('CA == CB // CC', '[CA == [CB // CC]]'),
    ('A + B == C', '[[A + B] == C]'),
    ('A + B /= C', '[[A + B] /= C]'),
    ('A /= B + C', '[A /= [B + C]]'),
    ('A * B /= C', '[[A * B] /= C]'),
    ('A /= B * C', '[A /= [B * C]]'),
    ('A ** B /= C', '[[A ** B] /= C]'),
    ('A <= B + C', '[A <= [B + C]]'),
    ('A + B >= C', '[[A + B] >= C]'),
    ('A < B * C', '[A < [B * C]]'),
    ('A > B - C', '[A > [B - C]]'),
    ('A .NE. B + C', '[A .NE. [B + C]]'),
    ('A .LT. B .OR. C .GE. D', '[[A .LT. B] .OR. [C .GE. D]]'),
    ('A == B .AND. C < D', '[[A == B] .AND. [C < D]]'),
    ('L1 .OR. L2 .AND. L3', '[L1 .OR. [L2 .AND. L3]]'),
    ('L1 .AND. L2 .OR. L3', '[[L1 .AND. L2] .OR. L3]'),
    ('L1 .EQV. L2 .OR. L3', '[L1 .EQV. [L2 .OR. L3]]'),
    ('L1 .OR. L2 .NEQV. L3', '[[L1 .OR. L2] .NEQV. L3]'),

    # unary operators
    ('-A', '[-A]'),
    ('+A', '[+A]'),
    ('-A + B', '[[-A] + B]'),
    ('-A - B', '[[-A] - B]'),
    ('-A * B', '[-[A * B]]'),
    ('-A ** B', '[-[A ** B]]'),
    ('-A * B + C', '[[-[A * B]] + C]'),
    ('A * (-B)', '[A * ([-B])]'),
    ('A * -B', '[A * [-B]]'),
    ('A ** -B', '[A ** [-B]]'),
    ('.NOT. L1', '[.NOT. L1]'),
    ('.NOT. L1 .AND. L2', '[[.NOT. L1] .AND. L2]'),
    ('L1 .AND. .NOT. L2', '[L1 .AND. [.NOT. L2]]'),
    ('.NOT. A == B', '[.NOT. [A == B]]'),
    ('.NOT. .NOT. L1', '[.NOT. [.NOT. L1]]'),

    # add-op chains
    ('A + B + C', '[A + [B + C]]'),
    ('A - B - C', '[[A - B] - C]'),
    ('A + B - C', '[A + [B - C]]'),
    ('A - B + C', '[[A - B] + C]'),
    ('A - B + C - D', '[[A - B] + [C - D]]'),
    ('A - B - C + D', '[[[A - B] - C] + D]'),
    ('A + B + C - D', '[A + [B + [C - D]]]'),
    ('A - B - C - D', '[[[A - B] - C] - D]'),

    # mult-op chains
    ('A * B * C', '[A * [B * C]]'),
    ('A / B / C', '[[A / B] / C]'),
    ('A / B * C', '[[A / B] * C]'),
    ('A * B / C', '[[A * B] / C]'),
    ('A * B / C * D', '[[[A * B] / C] * D]'),
    ('A * B * C / D', '[[A * [B * C]] / D]'),
    ('A / B * C * D', '[[A / B] * [C * D]]'),
    ('A / B / C * D', '[[[A / B] / C] * D]'),

    # power chains
    ('A ** B ** C', '[A ** [B ** C]]'),
    ('A ** B ** C ** D', '[A ** [B ** [C ** D]]]'),
    ('A * B ** C ** D', '[A * [B ** [C ** D]]]'),

    # concatenation chains
    ('CA // CB // CC', '[CA // [CB // CC]]'),

    # logical chains
    ('L1 .AND. L2 .AND. L3', '[L1 .AND. [L2 .AND. L3]]'),
    ('L1 .OR. L2 .OR. L3', '[L1 .OR. [L2 .OR. L3]]'),
    ('L1 .EQV. L2 .EQV. L3', '[L1 .EQV. [L2 .EQV. L3]]'),
    ('L1 .NEQV. L2 .NEQV. L3', '[L1 .NEQV. [L2 .NEQV. L3]]'),

    # defined operators
    ('A .X. B', '[A .X. B]'),
    ('.X. A', '[.X. A]'),
    ('.X. A + B', '[[.X. A] + B]'),
    ('A .X. B + C', '[A .X. [B + C]]'),
    ('A .X. B .X. C', '[[A .X. B] .X. C]'),
    ('A .X. B .Y. C', '[[A .X. B] .Y. C]'),
    ('L1 .AND. L2 .X. L3', '[[L1 .AND. L2] .X. L3]'),

    # case and spacing
    ('a + b - c', '[a + [b - c]]'),
    ('a /= b + c', '[a /= [b + c]]'),
    ('l1 .and. l2 .or. l3', '[[l1 .and. l2] .or. l3]'),
    ('A*B/C', '[[A*B]/C]'),
    ('A**B**C', '[A**[B**C]]'),
    ('L1.AND.L2.OR.L3', '[[L1.AND.L2].OR.L3]'),
    ('A/=B', '[A/=B]'),
    ('CA//CB', '[CA//CB]'),
]


def tree(e):
    """Source text with every op-E wrapped in [ ]."""
    if e.nodeType == xml_libxml.XML_TEXT_NODE:
        return e.data
    s = ''.join(tree(c) for c in e.childNodes())
    return '[' + s + ']' if e.localname == 'op-E' else s


@pytest.fixture(scope='module')
def rhs(tmp_path_factory):
    f90 = str(tmp_path_factory.mktemp('expr') / 'expr.F90')
    with open(f90, 'w') as fh:
        fh.write('SUBROUTINE EXPR\n')
        for src, _ in CASES:
            fh.write('X = %s\n' % src)
        fh.write('END SUBROUTINE\n')
    subprocess.check_call([FXTRAN, '-o', f90 + '.xml', f90])
    doc = xml_libxml.Parser().load_xml(location=f90 + '.xml')
    xpc = xml_libxml.XPathContext(doc)
    xpc.registerNs('f', FXTRAN_NS)
    return list(xpc.findnodes('//f:a-stmt/f:E-2'))


def test_number_of_assignments(rhs):
    assert len(rhs) == len(CASES)


@pytest.mark.parametrize('index', range(len(CASES)), ids=[src for src, _ in CASES])
def test_tree(rhs, index):
    src, expected = CASES[index]
    got = tree(rhs[index]).strip() if index < len(rhs) else ''
    assert got == expected
