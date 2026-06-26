! Test: attributs de procedures et d'arguments
! Statements couverts: INTENT(IN/OUT/INOUT), OPTIONAL,
!                      RECURSIVE, PURE (F95), ELEMENTAL (F95),
!                      VALUE, arguments par mot-cle

MODULE ATTRMOD
  IMPLICIT NONE

CONTAINS

  ! RECURSIVE: procedure qui s'appelle elle-meme
  RECURSIVE INTEGER FUNCTION FACTORIAL(N) RESULT(RES)
    INTEGER, INTENT(IN) :: N
    IF (N <= 1) THEN
      RES = 1
    ELSE
      RES = N * FACTORIAL(N - 1)
    END IF
  END FUNCTION FACTORIAL

  ! PURE: procedure sans effets de bord (F95)
  PURE REAL FUNCTION PURE_ADD(A, B)
    REAL, INTENT(IN) :: A, B
    PURE_ADD = A + B
  END FUNCTION PURE_ADD

  ! ELEMENTAL: s'applique element par element (F95)
  ELEMENTAL REAL FUNCTION CLAMP(X, LO, HI)
    REAL, INTENT(IN) :: X, LO, HI
    CLAMP = MIN(MAX(X, LO), HI)
  END FUNCTION CLAMP

  ! OPTIONAL: arguments optionnels
  SUBROUTINE GREET(NAME, TITLE, LOUD)
    CHARACTER(LEN=*), INTENT(IN)           :: NAME
    CHARACTER(LEN=*), INTENT(IN), OPTIONAL :: TITLE
    LOGICAL,          INTENT(IN), OPTIONAL :: LOUD
    CHARACTER(LEN=60) :: MSG
    IF (PRESENT(TITLE)) THEN
      MSG = TRIM(TITLE) // ' ' // TRIM(NAME)
    ELSE
      MSG = TRIM(NAME)
    END IF
    IF (PRESENT(LOUD)) THEN
      IF (LOUD) MSG = TRIM(MSG) // '!'
    END IF
    WRITE(*,*) TRIM(MSG)
  END SUBROUTINE GREET

  ! INTENT(OUT) et INTENT(INOUT)
  SUBROUTINE SWAP(A, B)
    REAL, INTENT(INOUT) :: A, B
    REAL :: TMP
    TMP = A; A = B; B = TMP
  END SUBROUTINE SWAP

  SUBROUTINE INIT(ARR, VAL)
    REAL, INTENT(OUT)  :: ARR(:)
    REAL, INTENT(IN)   :: VAL
    ARR = VAL
  END SUBROUTINE INIT

  ! PURE SUBROUTINE (F95)
  PURE SUBROUTINE PURE_COPY(DST, SRC)
    REAL, INTENT(OUT) :: DST(:)
    REAL, INTENT(IN)  :: SRC(:)
    DST = SRC
  END SUBROUTINE PURE_COPY

END MODULE ATTRMOD


PROGRAM ATTRTEST
  USE ATTRMOD
  IMPLICIT NONE
  REAL    :: A(5), B(5), X, Y
  INTEGER :: N

  N = 5
  WRITE(*,*) FACTORIAL(N)

  X = PURE_ADD(1.0, 2.0)
  WRITE(*,*) X

  ! ELEMENTAL applique a un scalaire et a un tableau
  WRITE(*,*) CLAMP(5.0, 0.0, 3.0)
  A = [-1.0, 0.5, 1.5, 2.5, 4.0]
  WRITE(*,*) CLAMP(A, 0.0, 2.0)

  ! Arguments par mot-cle (keyword arguments)
  CALL GREET(NAME='ALICE')
  CALL GREET(NAME='BOB', TITLE='DR.')
  CALL GREET(LOUD=.TRUE., NAME='CHARLIE', TITLE='PROF.')

  X = 1.0; Y = 2.0
  CALL SWAP(X, Y)
  WRITE(*,*) X, Y

  CALL INIT(B, 0.0)
  WRITE(*,*) B

END PROGRAM ATTRTEST
