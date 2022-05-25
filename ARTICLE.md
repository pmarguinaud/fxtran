# Parsing and refactoring FORTRAN code using XML

## Introduction

FORTRAN (FORmula TRANslation) is a compiled language widely used in scientific computing. It has beeen
designed in the fifties and underwent substancial evolutions over the last 50 years (1977, 1990, 2003, 2008).
The specification of FORTRAN is described in the ISO/IEC 1539 document using the Backus-Naur form syntax. For
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
