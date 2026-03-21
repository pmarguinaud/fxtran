! Test: FORALL - specifique Fortran 95
! Statements couverts: FORALL (enonce), FORALL (construct) / END FORALL,
!                      FORALL avec masque, FORALL imbrique, FORALL nomme

PROGRAM FORALLTEST
  IMPLICIT NONE
  INTEGER :: I, J, N
  REAL    :: A(5), B(5), MAT(4,4), IMAT(4,4)

  N = 5
  A = 0.0
  MAT  = 0.0
  IMAT = 0.0

  ! FORALL enonce (forme courte) - remplissage de tableau
  FORALL (I = 1:N) A(I) = REAL(I)

  ! FORALL enonce avec masque
  FORALL (I = 1:N, A(I) > 2.0) B(I) = A(I) * 2.0

  ! FORALL construct
  FORALL (I = 1:4, J = 1:4)
    MAT(I,J) = REAL(I + J - 1)
  END FORALL

  ! FORALL construct avec masque
  FORALL (I = 1:4, J = 1:4, I == J)
    IMAT(I,J) = 1.0
  END FORALL

  WRITE(*,*) A
  WRITE(*,*) IMAT(1,1), IMAT(2,2), IMAT(1,2)

  ! FORALL imbrique
  FORALL (I = 1:4)
    FORALL (J = 1:4, J /= I)
      MAT(I,J) = 0.0
    END FORALL
  END FORALL

  ! FORALL nomme
  MYFORALL: FORALL (I = 1:N)
    A(I) = REAL(N + 1 - I)
  END FORALL MYFORALL

  WRITE(*,*) A

END PROGRAM FORALLTEST
