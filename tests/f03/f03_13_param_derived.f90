! Test: types derives parametres (F2003)
! Statements couverts: TYPE avec parametres KIND et LEN,
!                      declarations avec parametres, assumed (*) et deferred (:)

MODULE PARAMTYPEMOD
  IMPLICIT NONE

  ! Type derive parametre par KIND (parametre de type)
  TYPE :: MYFLOAT(K)
    INTEGER, KIND :: K
    REAL(K) :: VALUE
  END TYPE MYFLOAT

  ! Type derive parametre par LEN (parametre de longueur)
  TYPE :: MYSTRING(MAXLEN)
    INTEGER, LEN :: MAXLEN
    CHARACTER(LEN=MAXLEN) :: DATA
    INTEGER :: USED = 0
  END TYPE MYSTRING

  ! Type avec les deux types de parametres
  TYPE :: MATRIX(K, M, N)
    INTEGER, KIND :: K
    INTEGER, LEN  :: M, N
    REAL(K) :: A(M, N)
  END TYPE MATRIX

CONTAINS

  SUBROUTINE PRINT_FLOAT(F)
    TYPE(MYFLOAT(*)), INTENT(IN) :: F
    WRITE(*,*) F%VALUE, KIND(F%VALUE)
  END SUBROUTINE PRINT_FLOAT

  SUBROUTINE APPEND(S, CH)
    TYPE(MYSTRING(*)), INTENT(INOUT) :: S
    CHARACTER(LEN=1),  INTENT(IN)    :: CH
    IF (S%USED < S%MAXLEN) THEN
      S%USED = S%USED + 1
      S%DATA(S%USED:S%USED) = CH
    END IF
  END SUBROUTINE APPEND

END MODULE PARAMTYPEMOD


PROGRAM PARAMTEST
  USE PARAMTYPEMOD
  IMPLICIT NONE

  ! Instanciation avec parametre KIND
  TYPE(MYFLOAT(KIND=4)) :: F32
  TYPE(MYFLOAT(KIND=8)) :: F64

  ! Instanciation avec parametre LEN
  TYPE(MYSTRING(MAXLEN=20)) :: STR1
  TYPE(MYSTRING(MAXLEN=80)) :: STR2

  ! Instanciation avec les deux types de parametres
  TYPE(MATRIX(KIND=4, M=3, N=3)) :: M33
  TYPE(MATRIX(KIND=8, M=2, N=4)) :: M24

  INTEGER :: I, J

  F32%VALUE = 3.14
  F64%VALUE = 3.14159265358979D0

  CALL PRINT_FLOAT(F32)
  CALL PRINT_FLOAT(F64)

  STR1%DATA = '                    '
  STR1%USED = 0
  CALL APPEND(STR1, 'H')
  CALL APPEND(STR1, 'I')
  WRITE(*,*) STR1%DATA(1:STR1%USED)

  FORALL (I=1:3, J=1:3) M33%A(I,J) = REAL(I*10 + J)
  WRITE(*,*) M33%A

  FORALL (I=1:2, J=1:4) M24%A(I,J) = REAL(8, KIND=8) * REAL(I+J, KIND=8)
  WRITE(*,*) M24%A

END PROGRAM PARAMTEST
