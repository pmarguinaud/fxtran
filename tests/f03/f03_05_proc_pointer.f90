! Test: pointeurs de procedures
! Statements couverts: PROCEDURE (declaration), PROCEDURE POINTER,
!                      association de pointeur de procedure, appel via pointeur

MODULE PROCPTRMOD
  IMPLICIT NONE

  ! Interface pour les pointeurs de procedures
  ABSTRACT INTERFACE
    REAL FUNCTION REAL_FUNC(X)
      REAL, INTENT(IN) :: X
    END FUNCTION REAL_FUNC

    SUBROUTINE REAL_SUB(X, Y)
      REAL, INTENT(IN)  :: X
      REAL, INTENT(OUT) :: Y
    END SUBROUTINE REAL_SUB
  END INTERFACE

  ! Pointeur de procedure au niveau module
  PROCEDURE(REAL_FUNC), POINTER :: FUNCPTR => NULL()

CONTAINS

  REAL FUNCTION MY_SIN(X)
    REAL, INTENT(IN) :: X
    MY_SIN = SIN(X)
  END FUNCTION MY_SIN

  REAL FUNCTION MY_COS(X)
    REAL, INTENT(IN) :: X
    MY_COS = COS(X)
  END FUNCTION MY_COS

  REAL FUNCTION MY_EXP(X)
    REAL, INTENT(IN) :: X
    MY_EXP = EXP(X)
  END FUNCTION MY_EXP

  ! Procedure prenant un pointeur de procedure en argument
  SUBROUTINE APPLY(F, X, Y)
    PROCEDURE(REAL_FUNC) :: F
    REAL, INTENT(IN)  :: X
    REAL, INTENT(OUT) :: Y
    Y = F(X)
  END SUBROUTINE APPLY

  ! Procedure retournant un pointeur de procedure
  FUNCTION GET_FUNC(NAME) RESULT(PTR)
    CHARACTER(LEN=*), INTENT(IN) :: NAME
    PROCEDURE(REAL_FUNC), POINTER :: PTR
    SELECT CASE (TRIM(NAME))
      CASE ('SIN')
        PTR => MY_SIN
      CASE ('COS')
        PTR => MY_COS
      CASE DEFAULT
        PTR => MY_EXP
    END SELECT
  END FUNCTION GET_FUNC

END MODULE PROCPTRMOD


PROGRAM PROCPTRTEST
  USE PROCPTRMOD
  IMPLICIT NONE

  PROCEDURE(REAL_FUNC), POINTER :: F => NULL()
  REAL :: X, Y
  INTEGER :: I

  X = 1.5708  ! pi/2

  ! Association de pointeur de procedure
  F => MY_SIN
  WRITE(*,*) F(X)

  ! Reassociation
  F => MY_COS
  WRITE(*,*) F(X)

  ! Pointeur vers intrinsique
  F => SIN
  WRITE(*,*) F(X)

  ! Passage en argument
  CALL APPLY(MY_SIN, X, Y)
  WRITE(*,*) Y

  ! Tableau de pointeurs de procedures (via tableau de TYPE encapsulant)
  BLOCK
    TYPE :: FWRAP
      PROCEDURE(REAL_FUNC), POINTER, NOPASS :: PTR => NULL()
    END TYPE FWRAP
    TYPE(FWRAP) :: FUNCS(3)
    FUNCS(1)%PTR => MY_SIN
    FUNCS(2)%PTR => MY_COS
    FUNCS(3)%PTR => MY_EXP
    DO I = 1, 3
      WRITE(*,*) FUNCS(I)%PTR(X)
    END DO
  END BLOCK

  ! Via GET_FUNC
  F => GET_FUNC('SIN')
  WRITE(*,*) F(X)

  ! NULLIFY
  NULLIFY(F)
  WRITE(*,*) ASSOCIATED(F)

END PROGRAM PROCPTRTEST
