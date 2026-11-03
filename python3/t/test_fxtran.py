"""
Port of perl5/t/fxtran.t, and tests of the Python modules.
"""
import os
import sys
import tempfile
import pytest

# conftest.py sets the paths
from conftest import parse_with_opts, xfind, xval, has, hasnt, count, FXTRAN_NS
import xml_libxml
_xml_parser = xml_libxml.Parser()

import fxtran
from fxtran.xpath import F, f
from fxtran.parser import Parser


# ---------------------------------------------------------------------------
# Imports
# ---------------------------------------------------------------------------

def test_import_fxtran():
    import fxtran
    assert fxtran is not None


def test_import_fxtran_xpath():
    from fxtran.xpath import F, f
    assert F is not None


def test_import_fxtran_parser():
    from fxtran.parser import Parser
    assert Parser is not None


# ---------------------------------------------------------------------------
# help()
# ---------------------------------------------------------------------------

def test_help():
    h = fxtran.help()
    assert h is not None
    assert len(h) > 0
    assert 'fxtran-options' in h or 'option' in h


# ---------------------------------------------------------------------------
# s() — parse statement
# ---------------------------------------------------------------------------

def test_s_returns_node():
    stmt = fxtran.s('REAL (KIND=JPRB) :: X (10)')
    assert stmt is not None


def test_s_error_raises():
    with pytest.raises(Exception):
        fxtran.s('X = ..')


# ---------------------------------------------------------------------------
# parse(program=) — parse programme
# ---------------------------------------------------------------------------

def test_parse_program():
    nodes = fxtran.parse(program='SUBROUTINE SUB\n\nEND SUBROUTINE\n')
    assert len(nodes) > 0


# ---------------------------------------------------------------------------
# Parser.parse_expression
# ---------------------------------------------------------------------------

def test_parse_expression():
    parser = Parser()
    n = parser.parseExpression('N + 1')
    assert n is not None


def test_parse_expression_with_canonic():
    parser = Parser()
    n1 = parser.parseExpression('N + 1')
    assert n1 is not None
    parser.setOptions('Expression', '-canonic')
    n2 = parser.parseExpression('N + 1')
    assert n2 is not None
    parser.setOptions('Expression', '+canonic')
    n3 = parser.parseExpression('N + 1')
    assert n3 is not None


def test_parse_expr_shortcut():
    n = fxtran.parse(expr='SIN (X)')
    assert n is not None


def test_e_shortcut():
    n = fxtran.e('0')
    assert n is not None


# ---------------------------------------------------------------------------
# parse(location=) — parse fichier
# ---------------------------------------------------------------------------

def test_parse_location_with_line_numbers():
    code = 'PROGRAM MAIN\n\nCALL SS ()\n\nEND\n'
    with tempfile.NamedTemporaryFile(suffix='.F90', mode='w', delete=False) as fh:
        fh.write(code)
        fname = fh.name

    try:
        fxtran.setOptions('Location', '-line_numbers', '1')
        d = fxtran.parse(location=fname)
    finally:
        os.unlink(fname)
        xml_file = fname + '.xml'
        if os.path.exists(xml_file):
            os.unlink(xml_file)

    assert d is not None
    stmts = F('.//ANY-stmt', d)
    assert len(stmts) > 0
    for stmt in stmts:
        ln = stmt.line_number()
        assert ln > 0


def test_parse_location_stmt_names():
    code = 'PROGRAM MAIN\n\nCALL SS ()\n\nEND\n'
    with tempfile.NamedTemporaryFile(suffix='.F90', mode='w', delete=False) as fh:
        fh.write(code)
        fname = fh.name

    try:
        fxtran.setOptions('Location', '-line_numbers', '1')
        d = fxtran.parse(location=fname)
    finally:
        os.unlink(fname)
        xml_file = fname + '.xml'
        if os.path.exists(xml_file):
            os.unlink(xml_file)

    stmts = F('.//ANY-stmt', d)
    names = [s.nodeName for s in stmts]
    assert 'program-stmt' in names
    assert 'call-stmt' in names
    assert 'end-program-stmt' in names


# ---------------------------------------------------------------------------
# F(): XPath with the f: prefix added, and ANY-stmt
# ---------------------------------------------------------------------------

def test_F_find_EN_decl():
    stmt = fxtran.s('REAL (KIND=JPRB) :: X (10)')
    result = F('.//EN-decl', stmt)
    assert len(result) == 1


def test_F_ANY_stmt():
    code = 'PROGRAM MAIN\n\nCALL SS ()\n\nEND\n'
    with tempfile.NamedTemporaryFile(suffix='.F90', mode='w', delete=False) as fh:
        fh.write(code)
        fname = fh.name
    try:
        fxtran.setOptions('Location', '-line_numbers', '1')
        d = fxtran.parse(location=fname)
    finally:
        os.unlink(fname)
        xml_file = fname + '.xml'
        if os.path.exists(xml_file):
            os.unlink(xml_file)
    stmts = F('.//ANY-stmt', d)
    assert len(stmts) == 3  # program-stmt, call-stmt, end-program-stmt


# ---------------------------------------------------------------------------
# Options, errors and fragments
# ---------------------------------------------------------------------------

BLANK_TEXT = './/text()[normalize-space(.)=""]'
PROGRAM = 'PROGRAM P\n  X = 1\nEND PROGRAM\n'


def test_xopts_reach_the_xml_parser():
    parser = Parser()
    assert parser.parseProgram(PROGRAM)[0].findnodes(BLANK_TEXT)
    assert not parser.parseProgram(PROGRAM, xopts={'no_blanks': 1})[0].findnodes(BLANK_TEXT)
    # a list of pairs, as in Perl
    assert not parser.parseProgram(PROGRAM, xopts=[('no_blanks', 1)])[0].findnodes(BLANK_TEXT)


def test_xml_options_of_set_options():
    parser = Parser()
    parser.setOptions('Program', '-no_blanks', '1')
    assert not parser.parseProgram(PROGRAM)[0].findnodes(BLANK_TEXT)
    # '0' is false, as in Perl
    parser.setOptions('Program', '-no_blanks', '0')
    assert parser.parseProgram(PROGRAM)[0].findnodes(BLANK_TEXT)
    parser.setOptions('Program', '+no_blanks')
    assert parser.parseProgram(PROGRAM)[0].findnodes(BLANK_TEXT)


def test_parse_fragment_keeps_leading_newlines():
    # chomp, as in Perl: only the last newline goes
    nodes = Parser().parseFragment('\n\nIF (A) THEN\n  X = 1\nENDIF\n')
    assert nodes[0].nodeName == '#text' and nodes[0].textContent == '\n\n'
    assert [n.nodeName for n in nodes if n.nodeName != '#text'] == ['if-construct']


def test_errors_are_fxtran_error():
    import _fxtran
    parser = Parser()
    for call in (lambda: parser.parseStatement('X = ..'),
                 lambda: parser.parseExpression('..'),
                 lambda: parser.parseProgram('X = ..\nEND\n'),
                 lambda: parser.parseString('X = ..\nEND\n'),
                 lambda: fxtran.run('X = ..\nEND\n')):
        with pytest.raises(fxtran.Error) as info:
            call()
        assert isinstance(info.value, _fxtran.error)


def test_parse_string_leaves_no_file(tmp_path, monkeypatch):
    monkeypatch.setenv('TMPDIR', str(tmp_path))
    tempfile.tempdir = None
    try:
        Parser().parseString('REAL :: X\nEND\n')
        with pytest.raises(fxtran.Error):
            Parser().parseString('X = ..\nEND\n')
    finally:
        tempfile.tempdir = None
    assert list(tmp_path.iterdir()) == []


def test_F_leaves_attributes_alone():
    from fxtran.xpath import preprocess
    assert preprocess('./@name') == './@name'
    assert preprocess('./object/file/@name') == './f:object/f:file/@name'
    assert preprocess('.//a-stmt[@x]') == './/f:a-stmt[@x]'
    doc = _xml_parser.load_xml(string=fxtran.run('REAL :: X\nEND\n'))
    assert F('./object/file/@name', doc, 2) == ['string']
