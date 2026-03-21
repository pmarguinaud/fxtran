! Test: TYPE / END TYPE, constructeur de structure, acces aux composantes
! Statements couverts: TYPE, END TYPE, type-declaration avec type derive,
!                      constructeur de structure (T(...)), operateur %

MODULE TYPEMOD
  IMPLICIT NONE

  TYPE :: POINT
    REAL :: X
    REAL :: Y
  END TYPE POINT

  TYPE :: SEGMENT
    TYPE(POINT) :: A
    TYPE(POINT) :: B
  END TYPE SEGMENT

  TYPE :: PERSON
    CHARACTER(LEN=30) :: NAME
    INTEGER           :: AGE
    LOGICAL           :: ACTIVE
  END TYPE PERSON

CONTAINS

  REAL FUNCTION DISTANCE(P1, P2)
    TYPE(POINT), INTENT(IN) :: P1, P2
    DISTANCE = SQRT((P2%X - P1%X)**2 + (P2%Y - P1%Y)**2)
  END FUNCTION DISTANCE

  SUBROUTINE PRINT_PERSON(P)
    TYPE(PERSON), INTENT(IN) :: P
    WRITE(*,*) TRIM(P%NAME), P%AGE, P%ACTIVE
  END SUBROUTINE PRINT_PERSON

END MODULE TYPEMOD


PROGRAM TYPETEST
  USE TYPEMOD
  IMPLICIT NONE

  TYPE(POINT)   :: P1, P2
  TYPE(SEGMENT) :: SEG
  TYPE(PERSON)  :: ALICE
  REAL          :: D

  ! Constructeur de structure
  P1 = POINT(0.0, 0.0)
  P2 = POINT(3.0, 4.0)

  ! Acces aux composantes via %
  P1%X = 1.0
  P1%Y = 1.0

  ! Type imbrique
  SEG = SEGMENT(P1, P2)
  WRITE(*,*) SEG%A%X, SEG%B%Y

  ! Appel de fonction
  D = DISTANCE(P1, P2)

  ! Type avec champs mixtes
  ALICE = PERSON('ALICE', 30, .TRUE.)
  CALL PRINT_PERSON(ALICE)

  ! Tableau de types derives
  BLOCK
    TYPE(POINT) :: PTS(3)
    INTEGER :: I
    DO I = 1, 3
      PTS(I) = POINT(REAL(I), REAL(I)**2)
    END DO
    WRITE(*,*) PTS(2)%X, PTS(2)%Y
  END BLOCK

END PROGRAM TYPETEST
