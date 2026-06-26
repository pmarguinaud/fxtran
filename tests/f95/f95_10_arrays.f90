! Test: operations tableaux F90/F95
! Statements couverts: constructeurs de tableaux (/ /), sections de tableaux,
!                      operations whole-array, tableaux assumes-shape (assumed-shape),
!                      tableaux automatiques

PROGRAM ARRAYTEST
  IMPLICIT NONE

  ! Constructeurs de tableaux
  INTEGER :: IVEC(5) = (/ 1, 2, 3, 4, 5 /)
  REAL    :: RVEC(4) = (/ 1.0, 2.0, 3.0, 4.0 /)
  REAL    :: MAT(3,3)
  INTEGER :: I, J

  ! Constructeur avec implied-DO
  IVEC = (/ (I*2, I = 1, 5) /)
  WRITE(*,*) IVEC

  ! Operations whole-array
  RVEC = RVEC * 2.0
  RVEC = RVEC + 1.0
  WRITE(*,*) RVEC

  ! Sections de tableaux
  WRITE(*,*) IVEC(2:4)          ! section contigue
  WRITE(*,*) IVEC(1:5:2)        ! section avec pas
  WRITE(*,*) IVEC([1,3,5])      ! section avec vecteur d'indices

  ! Tableaux 2D
  FORALL (I=1:3, J=1:3) MAT(I,J) = REAL(I)*10.0 + REAL(J)
  WRITE(*,*) MAT(:,2)            ! colonne 2
  WRITE(*,*) MAT(2,:)            ! ligne 2
  WRITE(*,*) MAT(1:2, 1:2)      ! sous-matrice

  ! Affectation de section
  MAT(1,:) = 0.0
  MAT(:,3) = 99.0

  BLOCK
    ! Tableau automatique (taille determinee au runtime)
    INTEGER :: N
    REAL    :: AUTARR(N)

    N = 7
    BLOCK
      REAL :: DYNARR(N)
      DYNARR = (/ (REAL(I), I=1,N) /)
      WRITE(*,*) DYNARR
    END BLOCK
  END BLOCK

END PROGRAM ARRAYTEST
