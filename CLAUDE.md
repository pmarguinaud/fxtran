# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**fxtran** is a Fortran source code parser written in C that converts Fortran source to XML-decorated output, enabling XPath queries and DOM manipulation. It supports round-tripping: recover original or modified source by stripping XML tags.

## Build Commands

```bash
# Build everything (C library + Perl + Python3 bindings + man pages)
make all

# Clean all build artifacts
make clean

# Build only the C library/binary
cd src && make

# Debug build (disables optimization, keeps debug symbols)
make DEBUG=1
```

### Perl bindings
```bash
cd perl5
perl Makefile.PL
make
make test        # Run Perl tests (tests in perl5/t/)
make install
```

### Python3 bindings
```bash
cd python3
python3 setup.py install
```

## Architecture

### C Core (`src/`)
The main executable (`bin/fxtran`) and shared library (`lib/libfxtran.so.0`) are built from ~100 source files. Key modules:

- **FXTRAN_FREE / FXTRAN_FIXED** — Free-form (F2003+) and fixed-form (F77) Fortran parsers
- **FXTRAN_STMT** — Statement recognition and dispatching (40+ statement types)
- **FXTRAN_EXPR** — Expression parsing
- **FXTRAN_XML** — XML output generation (tag stack, context management, buffer handling)
- **FXTRAN_OMP / FXTRAN_ACC** — OpenMP and OpenACC directive parsing
- **FXTRAN_OPTS** — Command-line option parsing
- **FXTRAN_LOAD / FXTRAN_FBUFFER** — Source file loading and buffering
- **src/cpp/** — Embedded GCC C preprocessor (macro expansion, includes, directives)
- **src/obstack/** — Stack-based memory allocator

Public headers are in `include/FXTRAN/`.

### Language Bindings
- **perl5/** — XS extension wrapping the C library; depends on `XML::LibXML` and `XML::XPath::Parser`
- **python3/** — C extension module (`fxtran.c`) wrapping the C library

### Build System Notes
- `makefile.inc` contains shared compiler flags (O2 by default, O0 with `DEBUG=1`; `-Wall -g -fPIC -DNO_OBSTACK=1`)
- Debian packaging: `debian/control` defines 6 packages (fxtran, libfxtran0, libfxtran-dev, libfxtran-perl, python3-fxtran, fxtran-doc)
- Cross-compilation supported via `DEB_BUILD_ARCH`, `DEB_CFLAGS`, `DEB_LDFLAGS` environment variables

### Man Page Generation
```bash
LD_LIBRARY_PATH=lib ./bin/fxtran -help-pod | pod2man -n fxtran -r "" -c "" | gzip -c > share/man/man1/fxtran.1.gz
```
