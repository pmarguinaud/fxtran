# fxtran — Technical Architecture

## Table of Contents

1. [Overview](#overview)
2. [Repository Layout](#repository-layout)
3. [Build System](#build-system)
4. [Processing Pipeline](#processing-pipeline)
5. [Source Loading and Preprocessing](#source-loading-and-preprocessing)
6. [Character Classification](#character-classification)
7. [Free-form and Fixed-form Parsers](#free-form-and-fixed-form-parsers)
8. [Directive Handling](#directive-handling)
9. [Statement Parsing](#statement-parsing)
10. [Expression Parsing](#expression-parsing)
11. [XML Output System](#xml-output-system)
12. [Key Data Structures](#key-data-structures)
13. [Error Handling](#error-handling)
14. [Language Bindings](#language-bindings)
15. [Command-line Interface](#command-line-interface)

---

## Overview

**fxtran** is a Fortran source code parser written in C. It converts Fortran source files
(both free-form and fixed-form) into an XML-decorated representation, enabling the use of
standard XML tools — XPath queries, XSLT transforms, and DOM manipulation — on Fortran
code. The transformation is fully reversible: stripping all XML tags from the output
recovers the original source exactly, unchanged character by character (round-tripping).

The tool supports:

- Fortran 77 through Fortran 2018
- Free-form (F90+) and fixed-form (F77) source
- OpenMP, OpenACC, and OpenMP Target offloading directives
- C preprocessor directives (`#include`, `#define`, conditional compilation)
- User-defined sentinel directives
- A C library (`libfxtran`) with Perl XS and Python 3 extension bindings

---

## Repository Layout

```
fxtran/
├── src/                        C core: parser, XML generator, directives
│   ├── cpp/                    Embedded GCC cpplib (C preprocessor)
│   ├── obstack/                Stack-based memory allocator
│   ├── fxtran.c                main() entry point (14 lines)
│   ├── FXTRAN_RUN.c            Top-level pipeline orchestration
│   ├── FXTRAN_FREE.c           Free-form tokenizer
│   ├── FXTRAN_FIXED.c          Fixed-form tokenizer
│   ├── FXTRAN_STMT.c           Statement recognition and parsing (~5000 lines)
│   ├── FXTRAN_EXPR.c           Expression parser (~1200 lines)
│   ├── FXTRAN_XML.c            XML output engine
│   ├── FXTRAN_OMP.c            OpenMP directive parser
│   ├── FXTRAN_OMP_TARGET.c     OpenMP Target directive parser
│   ├── FXTRAN_ACC.c            OpenACC directive parser
│   ├── FXTRAN_DDD.c            Custom directive parser
│   ├── FXTRAN_OPTS.c           Command-line option parsing
│   ├── FXTRAN_LOAD.c           File loading and CPP dispatch
│   ├── FXTRAN_NAMELIST.c       Fortran NAMELIST parser
│   ├── FXTRAN_MISC.c           Utilities (eat_word, str_at_level, …)
│   ├── FXTRAN_FILE.c           Source file tracking for #include
│   ├── FXTRAN_CPP_INTF.c       Interface to the embedded preprocessor
│   ├── FXTRAN_ALPHA.h          XML tag name string table (macro-generated)
│   ├── FXTRAN_CHARINFO.h       FXTRAN_char_info struct definition
│   ├── FXTRAN_MASK.h           Character mask constants
│   ├── FXTRAN_INTRINSIC.h      Fortran intrinsic function table
│   └── FXTRAN_XML.h            XML macro API (XST, XET, XAD, …)
├── include/FXTRAN/
│   └── RUN.h                   Public C API (FXTRAN_RUN)
├── perl5/
│   ├── fxtran.xs               Perl XS wrapper
│   ├── t/                      Perl test suite (Test::More)
│   └── …
├── python3/
│   ├── fxtran.c                Python 3 C extension
│   └── …
├── bin/fxtran                  Built executable
├── lib/libfxtran.so.0          Built shared library
├── makefile                    Top-level build
├── makefile.inc                Shared compiler flags
└── share/man/man1/fxtran.1.gz  Man page
```

---

## Build System

### Compiler Flags (`makefile.inc`)

```make
CFLAGS = -Wall -g -fPIC -O2   # -O0 with DEBUG=1
CPPFLAGS += -DNO_OBSTACK=1    # Use system malloc instead of obstack
```

The `NO_OBSTACK=1` flag disables the custom obstack allocator in favour of the
standard allocator. The flag is set by default for simplicity and portability.

### Targets

| Target | Output |
|--------|--------|
| `make` or `make all` | C core + Perl bindings + Python 3 bindings + man page |
| `cd src && make` | `bin/fxtran` and `lib/libfxtran.so.0` only |
| `make DEBUG=1` | Same, compiled without optimisation |
| `cd perl5 && make test` | Run the Perl test suite |

### Object Files (C Core)

The core library is built from roughly 20 C translation units. Aside from the two
sub-directories (`cpp/` and `obstack/`), which are compiled independently and then
linked in, the main objects are:

```
FXTRAN_RUN.o   FXTRAN_FREE.o    FXTRAN_FIXED.o
FXTRAN_STMT.o  FXTRAN_EXPR.o    FXTRAN_XML.o
FXTRAN_OMP.o   FXTRAN_OMP_TARGET.o  FXTRAN_ACC.o  FXTRAN_DDD.o
FXTRAN_OPTS.o  FXTRAN_LOAD.o    FXTRAN_CPP_INTF.o
FXTRAN_MISC.o  FXTRAN_FILE.o    FXTRAN_FILE_FUNC.o
FXTRAN_FBUFFER.o  FXTRAN_NAMELIST.o  FXTRAN_XCP.o
FXTRAN_BBT.o   FXTRAN_CHARINFO.o  FXTRAN_ERROR.o
```

---

## Processing Pipeline

```
 ┌───────────┐     ┌──────────────────────────────┐     ┌──────────────┐
 │  fxtran   │────▶│         FXTRAN_RUN()         │────▶│ XML string   │
 │  (main)   │     │         FXTRAN_RUN.c         │     │  output      │
 └───────────┘     └──────────────────────────────┘     └──────────────┘
                                  │
                   ┌──────────────┼──────────────────────────┐
                   ▼              ▼                          ▼
            Parse options    Load source                Emit XML header
            FXTRAN_OPTS.c   FXTRAN_LOAD.c               <object …>
                   │              │
                   │    ┌─────────┴──────────┐
                   │    ▼                    ▼
                   │  With CPP          Without CPP
                   │  FXTRAN_load_cpp()  FXTRAN_load_nocpp()
                   │    │                    │
                   │    └─────────┬──────────┘
                   │              ▼
                   │    text[] + FXTRAN_char_info ci[]
                   │              │
                   │    ┌─────────┴──────────┐
                   │    ▼                    ▼
                   │  FREE form          FIXED form
                   │  FXTRAN_FREE_decode  FXTRAN_FIXED_decode
                   │    │                    │
                   │    └─────────┬──────────┘
                   │              ▼
                   │    Statement loop → FXTRAN_stmt()
                   │              │
                   │    ┌─────────┴──────────┐
                   │    ▼                    ▼
                   │  Directive?         Regular stmt?
                   │  FXTRAN_dump_omp/   FXTRAN_stmt()
                   │  FXTRAN_dump_acc/   FXTRAN_STMT.c
                   │  FXTRAN_dump_omptd
                   │              │
                   └──────────────▼
                              </object>
```

`FXTRAN_RUN()` is the single public entry point for both the standalone binary and
the language bindings:

```c
/* include/FXTRAN/RUN.h */
int FXTRAN_RUN(int    argc,   /* number of arguments          */
               char * argv[], /* arguments (options + source) */
               char * Text,   /* in-memory source, or NULL    */
               char ** Xml,   /* output XML (caller-allocated) */
               char ** Err);  /* error message, or NULL       */
```

---

## Source Loading and Preprocessing

### Without the C Preprocessor (`FXTRAN_load_nocpp`)

The source file is read into a dynamically growing `FXTRAN_FBUFFER`, with two
optional transformations applied in-place:

- **Fixed-form only** — tab expansion: tabs are replaced with spaces according
  to the fixed-form column rules (continuation in column 6, code from column 7).
- **Free-form only** — carriage-return stripping (`\r` removed).

### With the Embedded GCC Preprocessor (`FXTRAN_load_cpp`)

fxtran bundles a copy of GCC's `cpplib` (under `src/cpp/`). The interface layer
`FXTRAN_CPP_INTF.c` drives it via a callback:

```c
int FXTRAN_cpp_intf(
    const char * filename,
    FXTRAN_file ** root,          /* file-inclusion tree (out) */
    FXTRAN_cpp2loc ** c2l,        /* CPP output → source map   */
    FXTRAN_opts * opts,
    void * obj,
    void (*append)(void*, char*, int)  /* callback: consume output */
);
```

The `append` callback accumulates the preprocessed text in the same
`FXTRAN_FBUFFER`. A `FXTRAN_cpp2loc` array records the mapping from each byte
of preprocessed output back to its original file and line, enabling
source-accurate error messages and `<file>` element boundaries in the XML even
after macro expansion.

---

## Character Classification

### The `FXTRAN_char_info` Array

After loading, fxtran allocates an array of `FXTRAN_char_info` structures with
one entry per character in the source text:

```c
/* src/FXTRAN_CHARINFO.h */
typedef struct FXTRAN_char_info {
    int  parens;   /* parenthesis nesting depth                    */
    int  dots;     /* number of dots seen (for decimal-point logic) */
    char mask;     /* character classification (see below)         */
    int  column;   /* column position in line                      */
    int  line;     /* line number                                  */
    int  rank;     /* context rank (expression hierarchy)         */
    int  offset;   /* byte offset in output buffer                */
} FXTRAN_char_info;
```

This parallel array is threaded through every parsing function alongside the raw
`text` pointer. It decouples semantic context (what a character *is*) from its
byte value (what a character *says*), which is central to how fxtran handles
directives, strings, and comments without ambiguity.

### Mask Values (`src/FXTRAN_MASK.h`)

| Constant | Value | Meaning |
|----------|-------|---------|
| `FXTRAN_NON` | `'\0'` | Unclassified |
| `FXTRAN_COD` | `'x'` | Regular Fortran code |
| `FXTRAN_STR` | `'"'` | Inside a character string |
| `FXTRAN_COM` | `'!'` | Comment text |
| `FXTRAN_CPP` | `'#'` | C preprocessor directive |
| `FXTRAN_LAB` | `'L'` | Statement label |
| `FXTRAN_SMC` | `';'` | Semicolon separator |
| `FXTRAN_SPC` | `' '` | Insignificant whitespace |
| `FXTRAN_OMD` | `'$'` | OpenMP directive sentinel (`!$OMP`) |
| `FXTRAN_OMC` | `'~'` | OpenMP code (continuation line) |
| `FXTRAN_ACC` | `'A'` | OpenACC directive sentinel (`!$ACC`) |
| `FXTRAN_OTD` | `'O'` | OpenMP Target directive sentinel |
| `FXTRAN_DDD` | `'D'` | Custom directive sentinel |
| `FXTRAN_CO1` | `'&'` | Free-form continuation (end of line) |
| `FXTRAN_CO2` | `'>'` | Free-form continuation (beginning of line) |
| `FXTRAN_MAL` | `'M'` | Fixed-form left margin (cols 1–6) |
| `FXTRAN_MAR` | `'R'` | Fixed-form right margin (col 73+) |
| `FXTRAN_ZER` | `'0'` | Fixed-form label-zero column |
| `FXTRAN_NAM` | `'n'` | Identifier name |
| `FXTRAN_OPR` | `'+'` | Operator |
| `FXTRAN_LIT` | `'8'` | Numeric literal |
| `FXTRAN_BOZ` | `'Z'` | Binary / octal / hex literal |
| `FXTRAN_KWD` | `'_'` | Keyword |
| `FXTRAN_CPT` | `'%'` | Derived-type component selector |
| `FXTRAN_OPT` | `'@'` | Optional directive |

---

## Free-form and Fixed-form Parsers

### Free-form (`FXTRAN_FREE.c`)

`FXTRAN_FREE_decode()` performs a single left-to-right scan over the source
text, maintaining a small set of boolean state flags:

| Flag | Meaning |
|------|---------|
| `q` | Inside a string literal (set to `'` or `"`) |
| `Q` | Continuing a string across a continuation line |
| `C` | Inside a comment (reset at `\n`) |
| `S` | Only whitespace seen since start of line (used to detect directive sentinels) |
| `OMP` | Current line is an OpenMP directive |
| `ACC` | Current line is an OpenACC directive |
| `OTD` | Current line is an OpenMP Target directive |
| `DDD` | Current line is a custom directive |

At each `!` character that appears at the start of a line (after whitespace), the
scanner looks ahead for `$OMP`, `$ACC`, or a user-defined sentinel and delegates
to the corresponding `FXTRAN_handle_*` function to classify the entire directive
(see [Directive Handling](#directive-handling)).

After the scan the `ci[]` array is fully populated. `FXTRAN_FREE_decode()` then
calls `FXTRAN_str_decode()` to iterate over statements and generate XML.

### Fixed-form (`FXTRAN_FIXED.c`)

`FXTRAN_FIXED_decode()` follows the same pattern but applies the fixed-form
column rules:

- Columns 1–5: statement label (`FXTRAN_LAB` / `FXTRAN_MAL`)
- Column 6: continuation marker (`FXTRAN_CO1`)
- Columns 7–72: code (`FXTRAN_COD`)
- Columns 73+: right-margin noise (`FXTRAN_MAR`)

Tabs are expanded before the scan (column 6 = one tab stop from column 1).

---

## Directive Handling

All three directive systems share the same two-step design:

1. **Detection** — during the tokenization scan, a `FXTRAN_handle_*` function
   is called when a sentinel is found. It sets the `mask` bytes of the sentinel
   characters to the appropriate `FXTRAN_OMD` / `FXTRAN_ACC` / `FXTRAN_OTD`
   value and returns the length consumed.

2. **Parsing** — later, during the statement loop, a `FXTRAN_dump_*` function
   reads the directive text, identifies the directive type and its clauses, and
   emits the corresponding XML elements.

### OpenMP (`FXTRAN_OMP.c`)

Directives are identified by a macro-generated list:

```c
#define FXTRAN_ompd_list(macro) \
  macro (PARALLELDO)      macro (ENDPARALLELDO) \
  macro (PARALLELSECTIONS) …                    \
  macro (DO)              macro (ENDDO)         \
  macro (PARALLEL)        macro (ENDPARALLEL)   \
  macro (FLUSH)           macro (THREADPRIVATE) \
  …
```

Recognised clauses include: `COPYIN`, `COPYPRIVATE`, `DEFAULT`, `FIRSTPRIVATE`,
`IF`, `LASTPRIVATE`, `NOWAIT`, `NUM_THREADS`, `ORDERED`, `PRIVATE`, `REDUCTION`,
`SCHEDULE`, `SHARED`.

### OpenACC (`FXTRAN_ACC.c`)

29 directives are supported, including compound forms such as `PARALLEL LOOP`,
`KERNELS LOOP`, `SERIAL LOOP`, `ENTER DATA`, `EXIT DATA`, and `HOST_DATA`.
Clause parsers cover all OpenACC 2.x standard clauses (`GANG`, `WORKER`,
`VECTOR`, `REDUCTION`, `COLLAPSE`, `TILE`, data-mapping clauses, etc.).

### OpenMP Target (`FXTRAN_OMP_TARGET.c`)

13 directives are supported:

```
TARGET              END TARGET
TARGET DATA         END TARGET DATA
TARGET ENTER DATA   TARGET EXIT DATA
TARGET UPDATE
TARGET PARALLEL     END TARGET PARALLEL
TARGET TEAMS        END TARGET TEAMS
DECLARE TARGET      END DECLARE TARGET
```

Clause parsers are organised by argument shape:

| Shape | Clauses |
|-------|---------|
| No argument | `NOWAIT`, `ORDERED`, `DO`, `SIMD`, `LOOP`, `DISTRIBUTE`, `PARALLELDO`, `PARALLELDOSIMD` |
| Expression `(expr)` | `IF`, `DEVICE`, `NUM_TEAMS`, `THREAD_LIMIT`, `COLLAPSE`, `SAFELEN`, `SIMDLEN` |
| Keyword type `(word)` | `DEFAULT` — parsed by `FXTRAN_omptc_ktype` |
| Variable list `(v,…)` | `PRIVATE`, `FIRSTPRIVATE`, `SHARED`, `LASTPRIVATE`, `IS_DEVICE_PTR`, `USES_ALLOCATORS`, `TO`, `FROM` |
| Typed variable list `(type:v,…)` | `MAP`, `DEPEND` |
| Typed map `(behavior:category)` | `DEFAULTMAP` |
| Operator + variable list `(op:v,…)` | `REDUCTION`, `IN_REDUCTION` |
| Variable list + optional step | `ALIGNED`, `LINEAR` |
| Type + optional chunk `(type[,n])` | `SCHEDULE`, `DIST_SCHEDULE` |

The directive type is determined by a compact macro-generated string matcher:

```c
#define test_macro(T) \
  do { if (strncmp (#T, t, strlen (#T)) == 0) return FXTRAN_OMPTD_##T; } while (0);
FXTRAN_omptd_list(test_macro)
```

The XML tag name for each directive is also macro-generated:

```c
case FXTRAN_OMPTD_TARGET:
    return _T(_S(TARGET) H _S(OPENMP));   /* → "target-openmp" */
case FXTRAN_OMPTD_TARGETENTERDATA:
    return _T(_S(TARGET) H _S(ENTER) H _S(DATA) H _S(OPENMP));
…
```

where `H` expands to `"-"` and `_S(X)` expands to the string defined in
`FXTRAN_ALPHA.h` for concept `X`.

### Custom Directives (`FXTRAN_DDD.c`)

The `-directive STR` command-line option registers a user-defined sentinel.
`FXTRAN_DDD.c` follows the same detection/parsing pattern as the built-in
directive handlers but with a configurable pattern string.

---

## Statement Parsing

### Statement Type Table

`FXTRAN_STMT.c` defines more than 150 Fortran statement types through a single
`FXTRAN_statement_list` macro:

```c
#define FXTRAN_statement_list(macro) \
  macro (ASSIGNMENT,        1, 77,  0) \
  macro (IF,                1, 77,  0) \
  macro (DO,                1, 77,  0) \
  macro (PROGRAM,           0, 77,  0) \
  macro (SUBROUTINE,        0, 77,  0) \
  macro (FUNCTION,          0, 77,  0) \
  macro (TYPE,              0, 90,  0) \
  macro (ALLOCATE,          1, 90,  0) \
  macro (SELECT_CASE,       1, 90,  0) \
  …
```

The four arguments per statement are: name, whether it is executable (1) or
declarative (0), the Fortran standard that introduced it, and whether it is
an attribute statement.

The macro is instantiated several times to build parallel tables:

| Table | Type | Purpose |
|-------|------|---------|
| `FXTRAN_stmt_exec[]` | `char` | 1 = executable, 0 = declarative |
| `FXTRAN_stmt_attr[]` | `char` | non-zero = attribute statement |
| `FXTRAN_stmt_std[]`  | `int`  | Year of standard (1977, 1990, 2003 …) |
| `FXTRAN_stmt_name[]` | `const char *` | Statement name string |

The XML tag name for each statement type is produced by `stmt_as_str()`, which
maps each `FXTRAN_stmt_type` enum value to a hyphenated string built from the
`FXTRAN_ALPHA.h` macros, e.g. `FXTRAN_POINTERASSIGNMENT` →
`"pointer-assignment-stmt"`.

### Statement Identification (`get_FXTRAN_stmt_type`)

`get_FXTRAN_stmt_type()` identifies the statement type from the normalised text
(whitespace removed, case-folded). It proceeds in three tiers:

**Tier 1 — fast structural checks (at parenthesis level 0).**
Before looking at keywords, the function searches for `=`, `=>`, or `:` at
nesting level 0:

- `=>` at level 0 → `POINTER_ASSIGNMENT` (unless after `IF(…)`, `WHERE(…)`,
  `FORALL(…)`)
- `=` at level 0 → `ASSIGNMENT` (same caveat)
- `word:` at level 0 → named construct label; recurse on the suffix

**Tier 2 — program-unit and interface context.**
When a program unit is expected (after `CONTAINS`, or at the top level), the
function calls `grok_fs()` to recognise `FUNCTION` / `SUBROUTINE` headers
(including prefix keywords like `PURE`, `ELEMENTAL`, `RECURSIVE`). Inside an
`INTERFACE` block, `MODULE PROCEDURE` is handled separately.

**Tier 3 — keyword switch.**
All remaining statements are matched by a switch on the first character of the
normalised text, with `strncmp` for disambiguation:

```c
switch (t[0]) {
  case 'A':
    if (ystrcmp("ABSTRACTINTERFACE", t)) ret(FXTRAN_INTERFACE);
    tt(ALLOCATABLE); tt(ALLOCATE); tt(ASSIGN); tt(ASSOCIATE);
    tt(ASYNCHRONOUS);
    break;
  case 'D':
    if (zstrcmp("DO", t)) {
      if (isdigit(t[2])) ret(FXTRAN_DOLABEL);
      else               ret(FXTRAN_DO);
    }
    …
```

`ystrcmp` is an exact match; `zstrcmp` is a prefix match. The switch reduces
the number of comparisons from O(150) to O(10) in the common case.

When no type is identified, the statement is tagged `<broken-stmt>` and parsing
continues (best-effort mode).

### Construct Stack

Nested constructs (`DO`, `IF`, `SELECT CASE`, etc.) are tracked by
`FXTRAN_stmt_stack`:

```c
typedef struct FXTRAN_stmt_stack {
    int  lev;                           /* current nesting level   */
    int  broken;                        /* error flag              */
    FXTRAN_stmt_stack_state state[1024];
} FXTRAN_stmt_stack;

typedef struct FXTRAN_stmt_stack_state {
    FXTRAN_stmt_type type;              /* construct type          */
    int  seen_contains;                 /* CONTAINS encountered    */
    int  do_label;                      /* label for labelled DO   */
    int  nstmt;                         /* statements in construct */
} FXTRAN_stmt_stack_state;
```

`stmt_block_handle()` is called for every statement and manages the stack:

- Opening statements (`DO`, `IF … THEN`, `SELECT CASE`, `TYPE`, `MODULE`, …)
  push a new entry with `FXTRAN_stmt_stack_incr()`.
- `CONTAINS` sets the `seen_contains` flag on the current entry; this switches
  the context from specification to internal subprogram mode.
- Closing statements (`END DO`, `END IF`, …) pop the stack with
  `FXTRAN_stmt_stack_decr()` after validating that the type matches.
- A mismatch sets the `broken` flag and throws via `FXTRAN_stmt_stack_break()`,
  which unwinds to the `setjmp` recovery point.

When `-construct-tag` is active, `stmt_block_handle` additionally emits
`<do-construct>`, `<if-construct>`, `<select-case-construct>` wrapper elements
around the statements they enclose, by inserting open/close tags via the
`xml_tu` structure (a pair of pending tag arrays that are flushed before and
after the statement tag).

### Statement Dispatcher and Emitters

`FXTRAN_stmt()` is the central dispatch function. For each statement it:

1. Checks for OMP / ACC / OpenMP-Target / custom directive flags set by the
   tokenizer; if present, delegates to `FXTRAN_dump_ompd()`,
   `FXTRAN_dump_accd()`, etc.
2. Otherwise calls `get_FXTRAN_stmt_type()` to identify the type.
3. Calls `stmt_block_handle()` to update the construct stack and emit any
   wrapping construct tags.
4. Opens the statement XML element: `FXTRAN_xml_start_tag(stmt_as_str(type), …)`.
5. Dispatches to the type-specific emitter via a macro-generated switch:
   ```c
   switch (type) {
   #define macro_cextra(t,x,nn,isatt) \
     case FXTRAN_##t: stmt_##t##_extra(text1, ci1, stack, ctx); break;
     FXTRAN_statement_list(macro_cextra)
   }
   ```
   Each `stmt_XXX_extra()` function reads the statement-specific syntax,
   calling `FXTRAN_expr()` for sub-expressions and the XML macros to emit tags.
6. Closes the statement element.

The two-function split (`get_FXTRAN_stmt_type` + `stmt_XXX_extra`) keeps
identification logic separate from XML-generation logic.

### Type Declarations and Attribute Statements

Type declaration statements (`INTEGER`, `REAL`, `CHARACTER`, `TYPE(…)`,
`CLASS(…)`, …) are all mapped to the single `FXTRAN_TYPEDECL` type. The
`stmt_TYPEDECL_extra()` emitter handles the full attribute list (`::`
separator, `INTENT`, `DIMENSION`, `POINTER`, `ALLOCATABLE`, `SAVE`, …) and the
entity list, including initialisation expressions.

Attribute-only statements (`ALLOCATABLE`, `POINTER`, `TARGET`, `VOLATILE`, …)
are identified by the `isatt` column in `FXTRAN_statement_list` and share a
common emitter pattern.

### I/O Statements

`READ`, `WRITE`, `PRINT`, `OPEN`, `CLOSE`, `INQUIRE`, `FLUSH`, `WAIT`,
`BACKSPACE`, `ENDFILE`, `REWIND` all use a common helper,
`stmt_actual_args()`, parameterised by a `stmt_actual_args_parms` struct that
specifies the list element tag name, whether type specifiers are allowed, and
whether `*` is a valid argument. This allows I/O control specifiers
(`UNIT=`, `FMT=`, `IOSTAT=`, `IOMSG=`, `ADVANCE=`, …) to be emitted with
their correct XML element names without duplicating the list-walking code.

---

## Expression Parsing

### Overview

`FXTRAN_expr()` in `FXTRAN_EXPR.c` is the single public entry point for
expression parsing. Rather than a classic recursive-descent parser with
one function per precedence level, it works in two phases:

1. **Operator scan** — a flat left-to-right scan over the expression text at
   the current parenthesis nesting level, collecting alternating
   operand/operator segments into parallel arrays `K1[]`, `K2[]`, `OP[]`.
2. **Tree construction** — `FXTRAN_expr0` / `FXTRAN_expr1` build the operator
   tree bottom-up by finding the lowest-precedence operator and recursing.

### Operator Precedence (`op_chrs`)

`op_chrs()` maps each operator token to a floating-point *rank* (lower = binds
more loosely) and an associativity *order* (+1 = left-to-right, −1 = right-to-left):

| Rank | Operators | Associativity |
|------|-----------|---------------|
| 13 | user-defined unary (`.OP.`) | — |
| 12 | `**` | right-to-left |
| 11 / 11.5 | `*` / `/` | left-to-right |
| 10 | unary `+` `-` | — |
| 9 / 9.5 | binary `+` / `-` | left-to-right |
| 8 | `//` | left-to-right |
| 7 | `.EQ.` `.NE.` `.LT.` `.LE.` `.GT.` `.GE.` `==` `/=` `<` `<=` `>` `>=` | non-associative |
| 6 | `.NOT.` | — |
| 5 | `.AND.` | left-to-right |
| 4 | `.OR.` | left-to-right |
| 3 | `.EQV.` | left-to-right |
| 2 | `.NEQV.` | left-to-right |
| 1 | user-defined binary (`.OP.`) | left-to-right |

The half-integer ranks for `/` (11.5) and binary `-` (9.5) force correct
left-associativity when these appear alongside `*` or `+` at the same nominal
level: `FXTRAN_expr1` selects the operator with the *lowest* rank; when two
operators share a rank it picks the leftmost (for left-associative) or
rightmost (for right-associative) one according to the `order` field.

User-defined operators (`.MYOP.`) are detected by scanning for a leading `.`,
reading the word between the dots, and verifying the closing `.`. They receive
rank 13 (unary) or rank 1 (binary) depending on position.

### Tree Construction (`FXTRAN_expr0` / `FXTRAN_expr1`)

```
FXTRAN_expr(t, ci, kmax, ctx)
  │
  ├─ scan left-to-right at level ci->parens
  │   collect K1[], K2[], OP[] arrays
  │
  ├─ if no operators found → FXTRAN_expr_primary()
  │
  └─ FXTRAN_expr0()      assign rank + order to each operator slot
       └─ FXTRAN_expr1() find minimum-rank operator i0
            ├─ emit <operator-E>
            ├─ recurse on left sub-array  [0 .. i0-1]
            ├─ emit <operator> token
            └─ recurse on right sub-array [i0+1 .. kop-1]
```

`FXTRAN_expr1` is called recursively on the left and right sub-arrays, until
each sub-array contains a single non-operator slot, at which point
`FXTRAN_expr_primary` is called.

### Primary Expressions (`FXTRAN_expr_primary`)

`FXTRAN_expr_primary` classifies the current token and dispatches to the
appropriate sub-parser:

| Token pattern | Sub-parser | XML element |
|---------------|-----------|-------------|
| `(/` or `[` | `FXTRAN_expr_array_constructor` | `<array-constructor-E>` |
| `B"`, `O"`, `Z"`, `X"` | `FXTRAN_expr_boz_litteral_constant` | `<literal-E>` |
| `%name(` | `FXTRAN_expr_percent` | `<function>` |
| identifier | `FXTRAN_expr_named` | `<named-E>` |
| `id_"` (named kind string) | `FXTRAN_expr_string_with_named_kind` | `<string-E>` |
| `n_"` (integer kind string) | `FXTRAN_expr_string_with_int_kind` | `<string-E>` |
| `"` | `FXTRAN_expr_string` | `<string-E>` |
| `(` | `FXTRAN_expr_parens` | `<parens-E>` |
| digit or `.` (non-dot context) | `FXTRAN_expr_numeric_litteral_constant` | `<literal-E>` |
| `.TRUE.` / `.FALSE.` | `FXTRAN_expr_logical_litteral_constant` | `<literal-E>` |

String literals support substring notation via a trailing ref list
(`"hello"(2:4)`), which is handled by `FXTRAN_ref_list` after the closing
quote.

### Named References and Subscript Disambiguation

After parsing an identifier, `FXTRAN_ref_list` consumes any trailing
subscript/component chain:

- `(…)` — parenthesised reference, disambiguated by `FXTRAN_grok_parens`:
  - `RANGE` — contains `:` at the current level → array section, parsed by
    `array_ref` into `<array-R>` / `<section-subscript-LT>` / `<lower-bound>` /
    `<upper-bound>` / `<stride>` elements.
  - `ARGKW` — contains `name=` at the current level → actual argument list,
    parsed by `FXTRAN_actual_args` into `<arg>` / `<arg-name>` elements.
  - `ITRTR` — iterator form (for `FORALL`/`DO CONCURRENT`), parsed by
    `iterator`.
  - `UNKNW` — cannot determine statically; emitted as `<parens-R>` /
    `<element-LT>`.
- `[…]` — coarray reference, parsed by `coarray_ref` into
  `<coarray-R>` / `<cosection-subscript-LT>`.
- `%name` — structure component access, parsed by `FXTRAN_ref_component` into
  `<component-R>`.

Multiple suffixes chain inside a single `<R-LT>` list:
```xml
<named-E>
  <N><n>A</n></N>
  <R-LT>
    <array-R>(<section-subscript-LT>…</section-subscript-LT>)</array-R>
    <component-R>%<N><n>X</n></N></component-R>
  </R-LT>
</named-E>
```

Array constructors with a type specifier (`[INTEGER(8) :: …]`) parse the type
prefix before the value list; the type name is emitted as `<type-name>` if it
is a derived type, or as a full `FXTRAN_typespec` if it is intrinsic.

### Flat-Expression Modes

Two options suppress the nested XML structure:

| Option | Effect |
|--------|--------|
| `-flat-expr` | All `XST`/`XET` calls inside the expression parser are no-ops; the expression appears as a flat character sequence. |
| `-flat-op-expr` | Only operator expressions are flattened; primaries (named refs, literals, parens) still produce their own elements. |

These modes are useful when tools only need to query statement-level structure
and do not need to navigate into expressions.

---

## XML Output System

### The Context Object

All XML generation is mediated through `FXTRAN_xmlctx` (defined in
`FXTRAN_XML.h`). It holds:

- `FXTRAN_FBUFFER fb` — the output buffer
- `text` and `ci` — pointers into the source and its mask array, advanced as
  characters are consumed
- A tag stack (`stack[]` + `lev`) for open-but-not-yet-closed elements
- `FXTRAN_opts opts` — the parsed command-line options
- `jmp_buf env_buf` — the error recovery point (see
  [Error Handling](#error-handling))

### The Macro API

The XML macros are defined in `FXTRAN_XML.h` and operate on the `ctx` implicit
variable that is in scope in every parsing function:

| Macro | Effect |
|-------|--------|
| `XST(tag)` | Emit `<tag>`, push onto tag stack |
| `XET()` | Emit `</tag>` for innermost open tag, pop stack |
| `XNT(tag, len)` | Emit `<tag>text[0..len]</tag>` (name token) |
| `XNO(tag, len)` | Emit `<tag>text[0..len]</tag>` (operator token) |
| `XNW(tag, len)` | Emit `<tag>text[0..len]</tag>` (keyword token) |
| `XAD(n)` | Advance both `t` and `ci` by `n` characters |
| `XSA(attr)` | Emit `<_attr_>` (attribute wrapper) |
| `XEA()` | Emit `</_attr_>` |
| `XSD(x)` | Set/unset the dump flag |
| `XSP()` | Emit a space (honouring `-strip-spaces`) |

`XAD(n)` is critical: it must be called instead of plain `t++` or `t += n`
whenever text is consumed inside an open XML element, because it advances the
`ci` pointer in lockstep. Failing to do so causes the XML element boundaries to
be misaligned with the source characters — which was the root cause of the
`DEFAULT` clause bug fixed in this branch.

### Tag Name String Table (`FXTRAN_ALPHA.h`)

All XML tag names are defined as `FXTRAN_STRING_<CONCEPT>` macros, for example:

```c
#define FXTRAN_STRING_CLAUSE    "clause"
#define FXTRAN_STRING_NAME      "N"
#define FXTRAN_STRING_TYPE      "T"
#define FXTRAN_STRING_VARIABLE  "V"
#define FXTRAN_STRING_LIST      "LT"
#define FXTRAN_STRING_MAP       "map"
#define FXTRAN_STRING_DEPEND    "depend"
#define FXTRAN_STRING_OPENMP    "openmp"
#define FXTRAN_STRING_TARGET    "target"
…
```

The macros `_S(X)` and `H` allow composing multi-word tag names at compile time:

```c
_T(_S(TARGET) H _S(OPENMP))   /* expands to "target-openmp" */
```

### Output Buffer (`FXTRAN_FBUFFER`)

`FXTRAN_FBUFFER` is a dynamically grown heap buffer:

```c
typedef struct FXTRAN_FBUFFER {
    char * str;   /* base pointer         */
    char * cur;   /* write cursor         */
    int    len;   /* total capacity       */
    int    len0;  /* initial capacity     */
} FXTRAN_FBUFFER;
```

Key operations: `FXTRAN_FBUFFER_putc`, `FXTRAN_FBUFFER_printf`,
`FXTRAN_FBUFFER_ncat` (append n bytes), `FXTRAN_FBUFFER_extend` (grow if
needed). When writing to the output, characters are XML-escaped on the fly by
`FXTRAN_FBUFFER_append_escaped_str()`, which also handles case conversion
(`-uppercase`), space stripping (`-strip-spaces`), and linefeed stripping
(`-strip-linefeed`).

### Round-tripping

Because every character of the source text is passed through `XAD` (which
copies from `text` into the output buffer, XML-escaping as needed), and because
every XML tag is inserted *around* source characters rather than *replacing*
them, stripping all XML tags from the output yields exactly the original source.
This property is maintained even across preprocessed files: CPP-expanded text
appears inside `<file name="…">` elements that record the original filename, so
the transformation remains auditable.

---

## Key Data Structures

### `FXTRAN_char_info`

Per-character metadata array allocated parallel to the source text. See
[Character Classification](#character-classification).

### `FXTRAN_xmlctx`

Global state threaded through all parsing and XML-generation functions.
Holds the output buffer, source pointers, tag stack, options, and error context.

### `FXTRAN_stmt_stack`

Construct-nesting tracker used in `FXTRAN_stmt()` to match opening and closing
constructs. Maximum nesting depth is 1024.

### `FXTRAN_opts`

Flat structure populated by `FXTRAN_OPTS.c` from `argv[]`. All options are
stored here and consulted throughout parsing and XML generation.

### `FXTRAN_FBUFFER`

Growable output buffer shared between the XML engine and the CPP interface.

### `FXTRAN_file` / `FXTRAN_cpp2loc`

`FXTRAN_file` is a tree of source files (the root file plus any files pulled in
via `#include`). `FXTRAN_cpp2loc` maps byte offsets in the preprocessed text
back to `(file, line)` pairs in the original sources.

---

## Error Handling

fxtran uses `setjmp`/`longjmp` for error propagation:

1. `FXTRAN_xmlctx_eval(ctx)` calls `setjmp` and returns 0 on the first
   invocation.
2. Any parsing function can call `FXTRAN_THROW("message …")`, which writes the
   error into `ctx->err[]` and calls `longjmp` to unwind directly back to
   `FXTRAN_xmlctx_eval`.
3. The caller checks `ctx->err[0] != '\0'` to detect failure.

This mechanism avoids the need to propagate error return codes through every
call site. `FXTRAN_WARNING` logs a message but does not jump. `FXTRAN_ABORT`
calls `abort()` directly for internal invariant violations.

Error messages include a source extract with a caret pointing to the offending
position, formatted in `FXTRAN_ERROR.c`.

---

## Language Bindings

### Perl XS (`perl5/fxtran.xs`)

The Perl module exposes a single function `fxtran::run(...)`. Its calling
convention mirrors the C API: all arguments but the last are command-line
options; the last argument is the Fortran source text. The XS glue:

1. Converts the Perl argument list into a `char *argv[]`
2. Calls `FXTRAN_RUN(argc, argv, source, &xml, &err)`
3. Returns the XML string on success, or `croak`s on error

```perl
use fxtran;
my $xml = fxtran::run('-openmp-target', '-construct-tag', '-no-include', $src);
```

The module also provides `fxtran::xpath` which wraps `XML::LibXML` and
`XML::XPath::Parser` for convenient XPath evaluation on the returned XML.

### Python 3 (`python3/fxtran.c`)

The Python extension exposes `fxtran.run(...)` with identical semantics. It uses
the standard CPython extension API (`PyArg_ParseTuple`, `Py_BuildValue`). On
error it raises `fxtran.error`.

```python
import fxtran
xml = fxtran.run('-openmp-target', '-construct-tag', '-no-include', src)
```

---

## Command-line Interface

### Source Form

| Option | Meaning |
|--------|---------|
| `-form FREE` | Force free-form parsing |
| `-form FIXED` | Force fixed-form parsing |
| (default) | Auto-detect from file extension |

### Directives

| Option | Meaning |
|--------|---------|
| `-openmp` | Enable OpenMP directive parsing |
| `-openacc` | Enable OpenACC directive parsing |
| `-openmp-target` | Enable OpenMP Target directive parsing |
| `-directive STR` | Enable custom directive with sentinel `STR` |

### Preprocessing

| Option | Meaning |
|--------|---------|
| `-cpp` | Run the embedded GCC preprocessor |
| `-nocpp` | Skip preprocessing (default for `.F90`) |
| `-no-include` | Ignore `INCLUDE` statements |
| `-D NAME[=VAL]` | Preprocessor `#define` |
| `-I PATH` | Preprocessor include path |

### Output Control

| Option | Meaning |
|--------|---------|
| `-construct-tag` | Emit construct wrapper tags (e.g. `<do-construct>`) |
| `-code-tag` | Emit `<code>` tags around executable statements |
| `-name-attr` | Emit `name=` attributes on program-unit elements |
| `-flat-expr` | Flatten all expressions to plain text |
| `-flat-op-expr` | Flatten only operator expressions |
| `-strip` | Remove comments, linefeeds, and insignificant spaces |
| `-strip-comments` | Remove comments only |
| `-strip-spaces` | Normalise whitespace |
| `-uppercase` | Convert identifiers to upper case |
| `-xml-stylesheet FILE` | Prepend `<?xml-stylesheet?>` PI |

### Debugging

| Option | Meaning |
|--------|---------|
| `-dump-mask` | Print character mask array to stderr |
| `-dump-stmt-list` | Print all recognised statement types and exit |
| `-help` | Print usage to stdout |
| `-help-pod` | Print POD documentation (used to generate man page) |
