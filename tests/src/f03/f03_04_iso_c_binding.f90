! Test: interoperabilite avec C (ISO_C_BINDING)
! Statements couverts: USE ISO_C_BINDING, BIND(C), types C,
!                      C_PTR, C_NULL_PTR, C_ASSOCIATED, VALUE

MODULE CBINDMOD
  USE ISO_C_BINDING
  IMPLICIT NONE

  ! Types de base C
  INTEGER(C_INT)        :: CI
  INTEGER(C_LONG)       :: CL
  INTEGER(C_SHORT)      :: CS
  INTEGER(C_SIZE_T)     :: CST
  REAL(C_FLOAT)         :: CF
  REAL(C_DOUBLE)        :: CD
  REAL(C_LONG_DOUBLE)   :: CLD
  COMPLEX(C_FLOAT_COMPLEX)  :: CFC
  COMPLEX(C_DOUBLE_COMPLEX) :: CDC
  LOGICAL(C_BOOL)       :: CB
  CHARACTER(KIND=C_CHAR,LEN=1) :: CCH

  ! Pointeur C opaque
  TYPE(C_PTR) :: CPTR = C_NULL_PTR

  ! Interface vers une fonction C avec BIND(C)
  INTERFACE
    FUNCTION C_SQRT(X) BIND(C, NAME='sqrt') RESULT(Y)
      USE ISO_C_BINDING
      REAL(C_DOUBLE), VALUE, INTENT(IN) :: X
      REAL(C_DOUBLE) :: Y
    END FUNCTION C_SQRT

    SUBROUTINE C_MEMSET(PTR, VAL, N) BIND(C, NAME='memset')
      USE ISO_C_BINDING
      TYPE(C_PTR),    VALUE :: PTR
      INTEGER(C_INT), VALUE :: VAL
      INTEGER(C_SIZE_T), VALUE :: N
    END SUBROUTINE C_MEMSET
  END INTERFACE

  ! Structure interoperable avec C
  TYPE, BIND(C) :: C_POINT
    REAL(C_FLOAT) :: X
    REAL(C_FLOAT) :: Y
  END TYPE C_POINT

END MODULE CBINDMOD

! Subroutine exportable vers C (hors module)
SUBROUTINE FORTRAN_SUB(X, N) BIND(C, NAME='fortran_sub')
  USE ISO_C_BINDING
  REAL(C_DOUBLE), INTENT(INOUT) :: X
  INTEGER(C_INT), VALUE, INTENT(IN) :: N
  X = X * REAL(N, C_DOUBLE)
END SUBROUTINE FORTRAN_SUB


PROGRAM CBINDTEST
  USE ISO_C_BINDING
  USE CBINDMOD
  IMPLICIT NONE

  TYPE(C_POINT) :: PT
  TYPE(C_PTR)   :: P
  REAL(C_DOUBLE) :: D

  ! Verification de l'interoperabilite
  WRITE(*,*) C_INT, C_DOUBLE, C_FLOAT

  ! Utilisation de types C
  CI = 42_C_INT
  CD = 3.14_C_DOUBLE

  ! Pointeur C
  P = C_NULL_PTR
  WRITE(*,*) C_ASSOCIATED(P)

  ! Structure BIND(C)
  PT%X = 1.0_C_FLOAT
  PT%Y = 2.0_C_FLOAT
  WRITE(*,*) PT%X, PT%Y

  ! Constantes de caracteres C
  WRITE(*,*) C_NULL_CHAR, C_NEW_LINE

  ! Tableau de caracteres C (chaine C)
  BLOCK
    CHARACTER(KIND=C_CHAR, LEN=1) :: CSTR(6)
    CSTR = [CHARACTER(KIND=C_CHAR,LEN=1) :: 'H','E','L','L','O',C_NULL_CHAR]
  END BLOCK

END PROGRAM CBINDTEST
