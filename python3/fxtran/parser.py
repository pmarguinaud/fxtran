import os
import subprocess
import tempfile

import _fxtran
from xml_libxml import Parser as _XMLParser, XPathContext as _XPathContext

_xml_parser = _XMLParser()

# Discover available fxtran options by parsing -help-xml output
_opts = {}

def _load_opts():
    xml = _fxtran.run('-help-xml', '')
    doc = _xml_parser.load_xml(string=xml)
    xpc = _XPathContext(doc)
    for opt in xpc.findnodes('//option'):
        children = list(opt.childNodes())
        if len(children) >= 2:
            name = children[0].textContent
            type_ = children[1].textContent
            help_ = children[2].textContent if len(children) > 2 else ''
            _opts[name] = (type_, help_)

_load_opts()


class Parser:
    def __init__(self):
        self._options = {
            'String':     ['-construct-tag', '-no-include'],
            'Program':    ['-construct-tag', '-no-include'],
            'Location':   ['-construct-tag', '-no-include'],
            'Fragment':   ['-construct-tag', '-no-include'],
            'Statement':  ['-line-length', '512'],
            'Expression': ['-line-length', '512'],
        }
        self._xml_options = {
            'String':     {},
            'Program':    {},
            'Location':   {},
            'Fragment':   {},
            'Statement':  {},
            'Expression': {},
        }

    def set_options(self, *args):
        """set_options(what, ..., -opt [val], +opt, ...)
        what can be ':all' or one or more kind names (String, Program, ...).
        Options starting with '-' are added/set; with '+' are removed.
        """
        args = list(args)
        what = []
        while args and not args[0].startswith(('-', '+')):
            what.append(args.pop(0))

        if len(what) == 1 and what[0] == ':all':
            what = list(self._options.keys())

        opts = args

        for kind in what:
            lst = self._options[kind]
            xml_hash = self._xml_options[kind]

            i = 0
            while i < len(opts):
                opt = opts[i]
                c = opt[0]   # '+' or '-'
                name = opt[1:]

                if name in _opts:
                    type_ = _opts[name][0]
                    if type_ == 'FLAG':
                        lst[:] = [x for x in lst if x != '-' + name]
                        if c == '-':
                            lst.append('-' + name)
                        i += 1
                    else:
                        # Remove existing value pair
                        j = 0
                        while j < len(lst):
                            if lst[j] == '-' + name:
                                del lst[j:j+2]
                                break
                            j += 1
                        if c == '-':
                            i += 1
                            lst.append('-' + name)
                            lst.append(opts[i])
                        i += 1
                else:
                    if c == '-':
                        i += 1
                        xml_hash[name] = opts[i]
                    else:
                        xml_hash.pop(name, None)
                    i += 1

    def parse(self, **kwargs):
        if 'string' in kwargs:
            return self.parse_string(kwargs.pop('string'), **kwargs)
        elif 'program' in kwargs:
            return self.parse_program(kwargs.pop('program'), **kwargs)
        elif 'location' in kwargs:
            return self.parse_location(kwargs.pop('location'), **kwargs)
        elif 'fragment' in kwargs:
            return self.parse_fragment(kwargs.pop('fragment'), **kwargs)
        elif 'statement' in kwargs:
            return self.parse_statement(kwargs.pop('statement'), **kwargs)
        elif 'expr' in kwargs:
            return self.parse_expression(kwargs.pop('expr'), **kwargs)
        raise ValueError("parse() requires one of: string, program, location, fragment, statement, expr")

    def parse_string(self, string, fopts=None, xopts=None):
        fopts = fopts if fopts is not None else list(self._options['String'])
        xml_opts = xopts if xopts is not None else self._xml_options['String']

        with tempfile.NamedTemporaryFile(suffix='.F90', mode='w', delete=False) as fh:
            fh.write(string)
            fname = fh.name

        try:
            ret = subprocess.call(['fxtran'] + fopts + [fname])
            if ret != 0:
                raise RuntimeError(string)
            xml_file = fname + '.xml'
            doc = _xml_parser.load_xml(location=xml_file)
            os.unlink(xml_file)
        finally:
            os.unlink(fname)

        return doc

    def parse_program(self, program, fopts=None, xopts=None):
        fopts = fopts if fopts is not None else list(self._options['Program'])
        xml_opts = xopts if xopts is not None else self._xml_options['Program']

        program = program.rstrip('\n') + '\n'
        xml = _fxtran.run(*fopts, program)
        doc = _xml_parser.load_xml(string=xml)
        doc = doc.lastChild.firstChild
        return list(doc.childNodes())

    def parse_fragment(self, fragment, fopts=None, xopts=None):
        fopts = fopts if fopts is not None else list(self._options['Fragment'])
        xml_opts = xopts if xopts is not None else self._xml_options['Fragment']

        fragment = fragment.strip('\n')
        program = fragment + '\nEND\n'
        xml = _fxtran.run(*fopts, program)
        doc = _xml_parser.load_xml(string=xml)
        program_unit = doc.documentElement.firstChild.firstChild  # object → file → program-unit
        for _ in range(2):
            program_unit.lastChild.unbindNode()
        return list(program_unit.childNodes())

    def parse_statement(self, statement, fopts=None, xopts=None):
        fopts = fopts if fopts is not None else list(self._options['Statement'])
        xml_opts = xopts if xopts is not None else self._xml_options['Statement']

        program = statement + '\nEND\n'
        xml = _fxtran.run(*fopts, program)
        doc = _xml_parser.load_xml(string=xml)
        return doc.documentElement.firstChild.firstChild

    def parse_expression(self, expression, fopts=None, xopts=None):
        fopts = fopts if fopts is not None else list(self._options['Expression'])
        xml_opts = xopts if xopts is not None else self._xml_options['Expression']

        program = 'X = ' + expression + '\nEND\n'
        xml = _fxtran.run(*fopts, program)
        doc = _xml_parser.load_xml(string=xml)
        return doc.documentElement.firstChild.firstChild.lastChild.firstChild

    def parse_location(self, location, fopts=None, xopts=None, dir=None):
        fopts = fopts if fopts is not None else list(self._options['Location'])
        xml_opts = xopts if xopts is not None else self._xml_options['Location']

        if not os.path.isfile(location):
            return None

        dirname = dir if dir is not None else os.path.dirname(location)
        basename = os.path.basename(location)
        xml_file = os.path.join(dirname, basename + '.xml')

        cmd = ['fxtran'] + fopts + ['-o', xml_file, location]
        ret = subprocess.call(cmd)
        if ret != 0:
            raise RuntimeError('`{}` failed'.format(' '.join(cmd)))

        doc = _xml_parser.load_xml(location=xml_file)
        return doc


PARSER = Parser()
