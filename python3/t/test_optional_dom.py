"""
fxtran without the DOM layer: run() and error work when xml_libxml and
xpath_parser are not installed, as before the DOM layer existed.
"""
import os
import subprocess
import sys
import textwrap

# conftest.py sets the paths
import conftest

# Make xml_libxml and xpath_parser impossible to import
_BLOCK = textwrap.dedent("""
    import sys
    sys.path.insert(0, {python3!r})
    sys.modules['xml_libxml'] = None
    sys.modules['xpath_parser'] = None
""").format(python3=conftest._PYTHON3)


def _run(code):
    """Run code in a Python without xml_libxml and xpath_parser; return its output."""
    out = subprocess.run([sys.executable, '-c', _BLOCK + textwrap.dedent(code)],
                         stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                         universal_newlines=True, env=os.environ.copy())
    assert out.returncode == 0, out.stdout
    return out.stdout


def test_run_without_dom():
    out = _run("""
        import fxtran
        xml = fxtran.run('REAL :: X (10)\\nEND\\n')
        print(xml.startswith('<?xml') and '<T-decl-stmt>' in xml)
    """)
    assert out.strip() == 'True'


def test_run_without_final_newline():
    # The text was read past its end when its last line had no newline:
    # the XML could lack </file>; it must be the same as with the newline
    out = _run("""
        import fxtran
        opts = ['-construct-tag', '-no-include', '-no-cpp', '-line-length', '9999']
        bad = []
        for n in range(1, 60):
            text = 'SUBROUTINE T; X = ' + 'A' * n + '; END'
            if fxtran.run(*opts, text) != fxtran.run(*opts, text + '\\n'):
                bad.append(n)
        print(bad)
    """)
    assert out.strip() == '[]'


def test_error_without_dom():
    out = _run("""
        import fxtran
        from fxtran import error
        try:
            fxtran.run('X = ..\\nEND\\n')
        except error as err:
            print(type(err).__name__, isinstance(err, fxtran.Error))
    """)
    assert out.strip() == 'Error True'


def test_help_without_dom():
    out = _run("""
        import fxtran
        print('<option>' in fxtran.help())
    """)
    assert out.strip() == 'True'


def test_dom_layer_says_what_is_missing():
    out = _run("""
        import fxtran
        for call in (lambda: fxtran.parse(statement='X = 1'),
                     lambda: fxtran.s('X = 1'),
                     lambda: fxtran.e('X'),
                     lambda: fxtran.t('x'),
                     lambda: fxtran.n('<x/>'),
                     lambda: fxtran.setOptions('Statement', '-line-length', '100'),
                     lambda: __import__('fxtran.xpath')):
            try:
                call()
                print('no error')
            except ImportError as err:
                print(err.name, 'fxtran[dom]' in str(err))
    """)
    assert out.split('\n')[:7] == ['xml_libxml True'] * 7


def test_error_is_the_old_exception():
    import fxtran
    import _fxtran
    assert fxtran.error is _fxtran.error
    assert issubclass(fxtran.Error, fxtran.error)
