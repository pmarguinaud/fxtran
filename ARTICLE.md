# Parsing and refactoring FORTRAN code using XML

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


    <?xml version="1.0"?><object xmlns="http://fxtran.net/#syntax" source-form="FREE" source-width="132" openmp="0" openacc="0"><file name="main.F90"><program-unit><program-stmt>PROGRAM <program-N><N><n>MAIN</n></N></program-N></program-stmt>
    <T-decl-stmt><_T-spec_><intrinsic-T-spec><T-N>REAL</T-N></intrinsic-T-spec></_T-spec_> :: <EN-decl-LT><EN-decl><EN-N><N><n>X</n></N></EN-N></EN-decl>, <EN-decl><EN-N><N><n>Y</n></N></EN-N></EN-decl>, <EN-decl><EN-N><N><n>Z</n></N></EN-N></EN-decl></EN-decl-LT></T-decl-stmt>
    <a-stmt><E-1><named-E><N><n>X</n></N></named-E></E-1> <a>=</a> <E-2><op-E><named-E><N><n>Y</n></N></named-E> <op><o>+</o></op> <named-E><N><n>Z</n></N></named-E></op-E></E-2></a-stmt>
    <call-stmt>CALL <procedure-designator><named-E><N><n>SUB</n></N></named-E></procedure-designator> (<arg-spec><arg><named-E><N><n>X</n></N></named-E></arg>, <arg><named-E><N><n>Y</n></N></named-E></arg>, <arg><named-E><N><n>Z</n></N></named-E></arg></arg-spec>)</call-stmt>
    <end-program-stmt>END</end-program-stmt></program-unit>








