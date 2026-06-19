! Test: CONTAINS dans les unites de programme (procedures internes)
! Statements couverts: CONTAINS dans PROGRAM, SUBROUTINE, FUNCTION,
!                      procedures internes avec acces aux variables hotes (host association)

PROGRAM CONTAINSTEST
  IMPLICIT NONE
  REAL    :: X, Y, RESULT
  INTEGER :: N

  X = 3.0
  Y = 4.0
  N = 5

  RESULT = HYPOTENUSE(X, Y)
  WRITE(*,*) RESULT

  CALL REPORT(N)

CONTAINS

  ! Procedure interne: acces a X, Y, N par host association
  REAL FUNCTION HYPOTENUSE(A, B)
    REAL, INTENT(IN) :: A, B
    HYPOTENUSE = SQRT(A*A + B*B)
  END FUNCTION HYPOTENUSE

  SUBROUTINE REPORT(K)
    INTEGER, INTENT(IN) :: K
    INTEGER :: I
    ! Acces a X par host association
    DO I = 1, K
      WRITE(*,*) I, X * REAL(I)
    END DO
    ! Procedure interne dans une procedure interne n'est pas permis en F95
    ! (les procedures internes ne peuvent pas contenir CONTAINS)
  END SUBROUTINE REPORT

END PROGRAM CONTAINSTEST


! Subroutine avec ses propres procedures internes
SUBROUTINE OUTERSUB(A, N)
  REAL,    INTENT(INOUT) :: A(:)
  INTEGER, INTENT(IN)    :: N
  INTEGER :: I

  DO I = 1, N
    CALL NORMALIZE(A(I))
  END DO
  WRITE(*,*) SUM(A)

CONTAINS

  SUBROUTINE NORMALIZE(V)
    REAL, INTENT(INOUT) :: V
    IF (V /= 0.0) V = V / ABS(V)
  END SUBROUTINE NORMALIZE

END SUBROUTINE OUTERSUB
