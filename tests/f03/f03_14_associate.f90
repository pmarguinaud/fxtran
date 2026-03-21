! Test: construct ASSOCIATE (Fortran 2003)
! Statements couverts: ASSOCIATE/END ASSOCIATE, aliases de composantes,
!                      aliases de tableaux, ASSOCIATE imbriques

MODULE ASSOCMOD
  IMPLICIT NONE

  TYPE :: POINT3D
    REAL :: X, Y, Z
  END TYPE POINT3D

  TYPE :: SEGMENT
    TYPE(POINT3D) :: A, B
  END TYPE SEGMENT

CONTAINS

  SUBROUTINE PROCESS_SEGMENT(SEG)
    TYPE(SEGMENT), INTENT(INOUT) :: SEG

    ! ASSOCIATE permet de creer des alias pour des expressions complexes
    ASSOCIATE (PA => SEG%A, PB => SEG%B)
      PA%X = 1.0
      PA%Y = 2.0
      PA%Z = 3.0
      PB%X = 4.0
      PB%Y = 5.0
      PB%Z = 6.0
      WRITE(*,*) 'Longueur au carre:', &
        (PB%X - PA%X)**2 + (PB%Y - PA%Y)**2 + (PB%Z - PA%Z)**2
    END ASSOCIATE

    ! ASSOCIATE avec un alias sur une composante scalaire
    ASSOCIATE (DX => SEG%B%X - SEG%A%X, &
               DY => SEG%B%Y - SEG%A%Y, &
               DZ => SEG%B%Z - SEG%A%Z)
      WRITE(*,*) 'Delta:', DX, DY, DZ
    END ASSOCIATE

  END SUBROUTINE PROCESS_SEGMENT

END MODULE ASSOCMOD


PROGRAM ASSOCIATETEST
  USE ASSOCMOD
  IMPLICIT NONE

  TYPE(SEGMENT) :: S
  REAL :: MATRIX(3,3)
  INTEGER :: I, J

  ! Initialisation du tableau
  DO I = 1, 3
    DO J = 1, 3
      MATRIX(I,J) = REAL(I) * 10.0 + REAL(J)
    END DO
  END DO

  ! ASSOCIATE sur des elements de tableau et expressions
  ASSOCIATE (M11 => MATRIX(1,1), &
             M22 => MATRIX(2,2), &
             M33 => MATRIX(3,3), &
             TRACE => MATRIX(1,1) + MATRIX(2,2) + MATRIX(3,3))
    WRITE(*,*) 'Diagonale:', M11, M22, M33
    WRITE(*,*) 'Trace:', TRACE
  END ASSOCIATE

  ! ASSOCIATE imbriques
  ASSOCIATE (ROW1 => MATRIX(1,:))
    ASSOCIATE (ELEM => ROW1(2))
      WRITE(*,*) 'Element (1,2):', ELEM
    END ASSOCIATE
  END ASSOCIATE

  ! Appel de la subroutine
  CALL PROCESS_SEGMENT(S)

  ! ASSOCIATE avec un tableau entier (alias de section)
  ASSOCIATE (DIAG => [MATRIX(1,1), MATRIX(2,2), MATRIX(3,3)])
    WRITE(*,*) 'Diagonale via ASSOCIATE:', DIAG
  END ASSOCIATE

END PROGRAM ASSOCIATETEST
