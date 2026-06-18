! Test: WHERE / ELSEWHERE / END WHERE
! Statements couverts: WHERE (enonce), WHERE (construct), ELSEWHERE,
!                      ELSEWHERE avec masque, WHERE imbrique

PROGRAM WHERETEST
  IMPLICIT NONE
  REAL    :: A(5), B(5), C(5)
  LOGICAL :: MASK(5)
  INTEGER :: I

  A = [1.0, -2.0, 3.0, -4.0, 5.0]
  B = [10.0, 20.0, 30.0, 40.0, 50.0]

  ! WHERE enonce (forme courte)
  WHERE (A > 0.0) C = A

  ! WHERE construct simple
  WHERE (A > 0.0)
    C = SQRT(A)
  END WHERE

  ! WHERE / ELSEWHERE / END WHERE
  WHERE (A >= 0.0)
    C = SQRT(A)
  ELSEWHERE
    C = 0.0
  END WHERE

  ! WHERE / ELSEWHERE avec masque / ELSEWHERE / END WHERE
  WHERE (A > 2.0)
    C = A * 2.0
  ELSEWHERE (A >= 0.0)
    C = A
  ELSEWHERE
    C = -A
  END WHERE

  WRITE(*,*) C

  ! WHERE imbrique
  WHERE (B > 0.0)
    WHERE (A > 0.0)
      C = A / B
    ELSEWHERE
      C = 0.0
    END WHERE
  END WHERE

  WRITE(*,*) C

END PROGRAM WHERETEST
