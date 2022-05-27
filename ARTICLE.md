# Parsing and refactoring FORTRAN code : when XML meets high performance computing

## Introduction

FORTRAN (FORmula TRANslation) is a compiled language widely used in scientific computing. It has beeen
designed in the fifties and underwent substancial evolutions over the last 50 years (1977, 1990, 2003, 2008).

The specification of FORTRAN is described in the ISO/IEC 1539 document using the Backus-Naur form (BNF) syntax. For
instance, a FORTRAN program is defined as :

    R201 program is program-unit
                       [ program-unit ] ...
    
    R202 program-unit is main-program
                      or external-subprogram
                      or module
                      or submodule
                      or block-data
    
    R1101 main-program is [ program-stmt ]
                             [ specification-part ]
                             [ execution-part ]
                             [ internal-subprogram-part ]
                             end-program-stmt

An expression is defined by :

    R714 and-operand is [ not-op ] level-4-expr

    R715 or-operand is [ or-operand and-op ] and-operand

    R716 equiv-operand is [ equiv-operand or-op ] or-operand

    R722 expr is [ expr defined-binary-op ] level-5-expr

    R718 not-op is.NOT.

    R719 and-op is.AND.

    R720 or-op is.OR.

    R721 equiv-op is .EQV.
            or .NEQV.

Et cetera.

Generating a parser from the BNF definition is however not straightforward, because :

1. There are no reserved keywords; it is legal, for instance to have a variable named IF or SUBROUTINE.
2. A lot of constraints apply. These are listed in the ISO/IEC 1539 document.
3. In fixed form, spaces are not significant. That is, a routine such as :


        SUBROUTINE MYSUB (X, Y)
        IMPLICIT NONE
        REAL X
        REAL Y
        END SUBROUTINE


could also be defined as :

        SUB ROUTINE MY SUB (X, Y)
        IMPLICITNONE
        REALX
        R E A L Y
        ENDSUBROUTIN E

4. Linebreaks and commends can be inserted almost anywhere :

        CHARACTER(LEN=16) :: STR
        REAL X, Y, ZZ
        STR = "EXAMPLE OF&  
        ! This is a comment
              &STRING"
        X = Y + Z& ! Another comment
           &Z
        END

Implementing a FORTRAN parser is therefore a non trivial task. It has to be emphasized that such a tool
has a very high value for people (like the author) who are involved in the maintenance and the evolution
of codebases consisting of several millions of lines of FORTRAN code.


## Parsing FORTRAN code using fxtran

Several tools are available for parsing FORTRAN: some compilers (OMNI or gfortran) can dump the syntax tree they 
create during syntax analysis. Some other tools, like fparser or OpenFortranParser provide the user with
a syntax tree and do not compile the code. All these tools cannot perform round tripping, that is, the exact
original FORTRAN source code cannot be recovered from the result of the parsing.

This is because features like whitespaces, line breaks, or even comments are ignored by the parser.

FORTRAN code is semi-structured data (a syntax tree can be derived from source code), but it is also data 
created by a human being, with some indentation, whitespaces, comments, etc. We know that XML shines when it
comes to representing such data. HTML is a typical example of documents that may be hand written but that have a
structure. 

fxtran (https://github.com/pmarguinaud/fxtran) is a FORTRAN parser written in C which relies on XML for its output. 
Its handles most of FORTRAN 2003/2008 features and is extremely fast, at least 10 times faster that fparser.

FORTRAN source code annotated with XML tags is the result of parsing by fxtran. Let us take a very simple example
of a FORTRAN program:

    PROGRAM MAIN
    REAL :: X, Y, Z
    X = Y + Z
    CALL SUB (X, Y, Z)
    END

The result of parsing this program with fxtran is :

    <?xml version="1.0"?><object xmlns="http://fxtran.net/#syntax" source-form="FREE" source-width="132" openmp="0" openacc="0"><file name="main.F90"><program-unit><program-stmt>PROGRAM <program-N><N><n>MAIN</n></N></program-N></program-stmt>
    <T-decl-stmt><_T-spec_><intrinsic-T-spec><T-N>REAL</T-N></intrinsic-T-spec></_T-spec_> :: <EN-decl-LT><EN-decl><EN-N><N><n>X</n></N></EN-N></EN-decl>, <EN-decl><EN-N><N><n>Y</n></N></EN-N></EN-decl>, <EN-decl><EN-N><N><n>Z</n></N></EN-N></EN-decl></EN-decl-LT></T-decl-stmt>
    <a-stmt><E-1><named-E><N><n>X</n></N></named-E></E-1> <a>=</a> <E-2><op-E><named-E><N><n>Y</n></N></named-E> <op><o>+</o></op> <named-E><N><n>Z</n></N></named-E></op-E></E-2></a-stmt>
    <call-stmt>CALL <procedure-designator><named-E><N><n>SUB</n></N></named-E></procedure-designator> (<arg-spec><arg><named-E><N><n>X</n></N></named-E></arg>, <arg><named-E><N><n>Y</n></N></named-E></arg>, <arg><named-E><N><n>Z</n></N></named-E></arg></arg-spec>)</call-stmt>
    <end-program-stmt>END</end-program-stmt></program-unit>


The careful reader has already noticed that **the original source code is embedded** in this XML document. This 
implies that recovering the original content is just a matter of removing the XML tags.

Let us have a closer look.

The following FORTRAN statement :

    CALL SUB (X, Y , Z)

is represented by the following XML fragment :

    <call-stmt>CALL <procedure-designator><named-E><N><n>SUB</n></N></named-E></procedure-designator> (<arg-spec><arg><named-E><N><n>X</n></N></named-E></arg>, <arg><named-E><N><n>Y</n></N></named-E></arg>, <arg><named-E><N><n>Z</n></N></named-E></arg></arg-spec>)</call-stmt>

We first observer that we have a `call-stmt` tag surrounding the whole statement. `call-stmt' is the denomination 
used in the ISO/IEC 1539; in fxtran output; note that I have tried to **use the FORTRAN BNF linguo eveywhere 
it is possible**.

Some other important elements are tagged with `named-E`; these are named expressions (`E` stands for expression,
and there are so many expressions in FORTRAN source code, that it was necessary to use a shorter word). There
are other kinds of expressions like literal expressions (`literal-E`), expressions involving operators (`op-E`), etc.

The reader should now be able to distinguish other tags, such as the `procedure-designator` (the name of 
the callee, which is also a named expression), the arguments of the callee, etc.

The following statement :

    REAL :: X, Y, Z

is a type declaration statement, whose parsed output is :

    <T-decl-stmt><_T-spec_><intrinsic-T-spec><T-N>REAL</T-N></intrinsic-T-spec></_T-spec_> :: <EN-decl-LT><EN-decl><EN-N><N><n>X</n></N></EN-N></EN-decl>, <EN-decl><EN-N><N><n>Y</n></N></EN-N></EN-decl>, <EN-decl><EN-N><N><n>Z</n></N></EN-N></EN-decl></EN-decl-LT></T-decl-stmt>

It is possible to distinguish the type specification (the `REAL` intrinsic type is used here), and entity 
declarations (`EN-decl`) tags, grouped in a list (`EN-decl-LT`, `LT` being the abbreviated form os list).

Eventually note that FORTRAN identifiers are tagged with `n`s nested in `N` tags. To understand why, look at the
following assignment statement :

    XX = Z&
      &ZZZ

whose XML representation is :

    <a-stmt><E-1><named-E><N><n>XX</n></N></named-E></E-1> <a>=</a> <E-2><named-E><N><n>Z</n><cnt>&amp;</cnt>
      <cnt>&amp;</cnt><n>ZZZ</n></N></named-E></E-2></a-stmt>

We see here that an identifier may be split accross multiple lines, using `&` lines continuators. To cope with
this possibility, it is necessary to introduce this extra `n` tag, which stands for a piece of identifier.

## FORTRAN code refactoring

Once the FORTRAN source has been parsed, it becomes possible to perform surgical modifications (eg adding an
extra argument to a particular subroutine). We will look here at a typical modification which is necessary
when porting the existing code (which works well on x86 platforms with micro-vectorization) to accelerators
like graphical processors.

Let us take as an example the following code snippet :

    PROGRAM LOOP
    REAL :: X (KLON, KLEV)
    REAL :: Y (KLON, KLEV)
    REAL :: Z

    DO JLEV = 2, KLEV
      DO JLON = 1, KLON
        Z = X (JLON, JLEV-1) + Y (JLON, JLEV)
        X (JLON, JLEV) = Z * Z
      ENDDO
    ENDDO
    END PROGRAM

On x86, the inner loop would vectorize, and the compiler would generate AVX instructions, but when using 
graphical accelerators (hereafter GPUs), the situtation is very different, because these devices are an
aggregate of thousands of very small cores which do not have any vectorization capability, but nevertheless
require coordinated access to memory. The reader should not pay too much attention to these details, but
needs to understand that our purpose is to tranform this loop (as well as all loops which are similar)
into :

    !$acc loop vector private (Z)
    DO JLON = 1, KLON
      DO JLEV = 2, KLEV
        Z = X (JLON, JLEV-1) + Y (JLON, JLEV)
        X (JLON, JLEV) = Z * Z
      ENDDO
    ENDDO

What we did in this transformation is that we exchanged the loops on `JLON` and `JLEV` and added an OpenACC
directive stating that the iterations of this loop should be distributed over the GPU cores, and that
`Z` is a private variable, which means that each GPU should have its private copy.

Our transformation involves the following steps :

* Parse the document
* Target the loops that should be transformed (`JLON` loops nested in a `JLEV` loop)
* Exchange `JLEV` and `JLON` loops
* Find private variables (scalar variables which are modified in the `JLON` loop)
* Create the OpenACC directive and insert it

Parsing the document is straightforward; we first invoke fxtran (the `-construct-tag` option adds tags for
structures like loops, if then else constructs, etc.):

    $ fxtran -construct-tag loop.F90
    $ ls -l loop.F90.xml 
    -rw-rw-r-- 1 phi001 phi001 2825 mai   27 09:29 loop.F90.xml

We then use an XML parser and load the XML document, after registering the fxtran namespace (here we
use Perl and the libxml2 bindings, but any other language with any XML library would actually do the job) :

    use XML::LibXML;
    use strict;
   
    my $xpc = 'XML::LibXML::XPathContext'->new ();
    $xpc->registerNs (f => 'http://fxtran.net/#syntax');
    my $doc = 'XML::LibXML'->load_xml (location => 'loop.F90.xml');

We can then search `JLEV` loop construct which contain `JLON` loops using XPath :

    my @do_jlev = $xpc->findnodes 
                  ('//f:do-construct[f:do-stmt[string(f:do-V)="JLEV"]]'
                .  '[f:do-construct[f:do-stmt[string(f:do-V)="JLON"]]]',
                   $doc);

The DO statements we need to exchange are easily retrieved :

    for my $do_jlev (@do_jlev)
      {
        my ($do_jlon) = $xpc->findnodes ('./f:do-construct[f:do-stmt[string(f:do-V)="JLON"]]', $do_jlev);
        my $do_jlev_stmt = $do_jlev->firstChild;
        my $do_jlon_stmt = $do_jlon->firstChild;
        ...

And it is also easy to exchange them using the XML DOM methods :

       my $do_jlev_stmt_1 = $do_jlev_stmt->cloneNode (1);
       my $do_jlon_stmt_1 = $do_jlon_stmt->cloneNode (1);
       $do_jlev_stmt->replaceNode ($do_jlon_stmt_1);
       $do_jlon_stmt->replaceNode ($do_jlev_stmt_1);
       ...
     
We then look for scalar (that is without a reference list) variables which are on the left hand side 
of assignment statements (that is contained in the `E-1` member of `a-stmt` elements):

       my @s = $xpc->findnodes ('.//f:a-stmt/f:E-1/f:named-E[not(f:R-LT)]/f:N/f:n/text()', $do_jlev);
       @s = map { $_->textContent } @s;




