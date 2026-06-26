! Test: INTERFACE / END INTERFACE, surcharge d'operateur, OPERATOR
! Statements couverts: INTERFACE, END INTERFACE, INTERFACE OPERATOR,
!                      INTERFACE ASSIGNMENT, MODULE PROCEDURE

MODULE VECMOD
  IMPLICIT NONE

  TYPE :: VEC3
    REAL :: X, Y, Z
  END TYPE VEC3

  ! Interface pour surcharge de +
  INTERFACE OPERATOR(+)
    MODULE PROCEDURE VEC_ADD
  END INTERFACE

  ! Interface pour surcharge de *
  INTERFACE OPERATOR(*)
    MODULE PROCEDURE VEC_SCALE
  END INTERFACE

  ! Interface pour surcharge de l'affectation
  INTERFACE ASSIGNMENT(=)
    MODULE PROCEDURE REAL_TO_VEC
  END INTERFACE

  ! Interface generique nommee
  INTERFACE NORM
    MODULE PROCEDURE NORM_VEC3
  END INTERFACE

CONTAINS

  FUNCTION VEC_ADD(A, B) RESULT(C)
    TYPE(VEC3), INTENT(IN) :: A, B
    TYPE(VEC3) :: C
    C%X = A%X + B%X
    C%Y = A%Y + B%Y
    C%Z = A%Z + B%Z
  END FUNCTION VEC_ADD

  FUNCTION VEC_SCALE(S, V) RESULT(W)
    REAL,       INTENT(IN) :: S
    TYPE(VEC3), INTENT(IN) :: V
    TYPE(VEC3) :: W
    W%X = S * V%X
    W%Y = S * V%Y
    W%Z = S * V%Z
  END FUNCTION VEC_SCALE

  SUBROUTINE REAL_TO_VEC(V, S)
    TYPE(VEC3), INTENT(OUT) :: V
    REAL,       INTENT(IN)  :: S
    V%X = S; V%Y = S; V%Z = S
  END SUBROUTINE REAL_TO_VEC

  REAL FUNCTION NORM_VEC3(V)
    TYPE(VEC3), INTENT(IN) :: V
    NORM_VEC3 = SQRT(V%X**2 + V%Y**2 + V%Z**2)
  END FUNCTION NORM_VEC3

END MODULE VECMOD


PROGRAM IFACETEST
  USE VECMOD
  IMPLICIT NONE

  TYPE(VEC3) :: U, V, W
  REAL :: S, N

  U = VEC3(1.0, 0.0, 0.0)
  V = VEC3(0.0, 1.0, 0.0)

  W = U + V          ! surcharge +
  W = 2.0 * U        ! surcharge *
  S = 1.0
  U = S              ! surcharge =
  N = NORM(W)        ! interface generique

  WRITE(*,*) W%X, W%Y, W%Z, N

  ! Bloc d'interface explicite pour procedure externe
  BLOCK
    INTERFACE
      REAL FUNCTION EXTERNAL_FUNC(X, Y)
        REAL, INTENT(IN) :: X, Y
      END FUNCTION EXTERNAL_FUNC
    END INTERFACE
    WRITE(*,*) 'Interface explicite declaree'
  END BLOCK

END PROGRAM IFACETEST
