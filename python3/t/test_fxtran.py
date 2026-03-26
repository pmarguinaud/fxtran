"""
Tests de base pour fxtran Python.
Transcription de perl5/t/fxtran.t
"""
import os
import sys
import tempfile
import pytest

# conftest.py ajoute les chemins nécessaires
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
    n = parser.parse_expression('N + 1')
    assert n is not None


def test_parse_expression_with_canonic():
    parser = Parser()
    n1 = parser.parse_expression('N + 1')
    assert n1 is not None
    parser.set_options('Expression', '-canonic')
    n2 = parser.parse_expression('N + 1')
    assert n2 is not None
    parser.set_options('Expression', '+canonic')
    n3 = parser.parse_expression('N + 1')
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
        fxtran.set_options('Location', '-line_numbers', '1')
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
        fxtran.set_options('Location', '-line_numbers', '1')
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
# F() — xpath avec namespace auto et ANY-stmt
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
        fxtran.set_options('Location', '-line_numbers', '1')
        d = fxtran.parse(location=fname)
    finally:
        os.unlink(fname)
        xml_file = fname + '.xml'
        if os.path.exists(xml_file):
            os.unlink(xml_file)
    stmts = F('.//ANY-stmt', d)
    assert len(stmts) == 3  # program-stmt, call-stmt, end-program-stmt
