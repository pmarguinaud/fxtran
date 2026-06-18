! Test: arithmetique IEEE 754 (Fortran 2003)
! Statements couverts: USE IEEE_ARITHMETIC, USE IEEE_EXCEPTIONS,
!                      fonctions IEEE_, types IEEE_CLASS_TYPE, IEEE_FLAG_TYPE

MODULE IEEEMOD
  USE IEEE_ARITHMETIC
  USE IEEE_EXCEPTIONS
  IMPLICIT NONE

CONTAINS

  SUBROUTINE CHECK_IEEE()
    REAL :: X, Y, Z
    TYPE(IEEE_CLASS_TYPE) :: CLS
    TYPE(IEEE_FLAG_TYPE)  :: FLAG
    LOGICAL :: SUPPORT, HALTING, FLAGGED

    ! Verifier le support des fonctionnalites IEEE
    SUPPORT = IEEE_SUPPORT_DATATYPE(X)
    WRITE(*,*) 'IEEE DATATYPE supported:', SUPPORT

    SUPPORT = IEEE_SUPPORT_INF(X)
    WRITE(*,*) 'IEEE INF supported:', SUPPORT

    SUPPORT = IEEE_SUPPORT_NAN(X)
    WRITE(*,*) 'IEEE NAN supported:', SUPPORT

    SUPPORT = IEEE_SUPPORT_DENORMAL(X)
    WRITE(*,*) 'IEEE DENORMAL supported:', SUPPORT

    ! Valeurs speciales IEEE
    X = IEEE_VALUE(X, IEEE_POSITIVE_INF)
    WRITE(*,*) '+INF:', X

    X = IEEE_VALUE(X, IEEE_NEGATIVE_INF)
    WRITE(*,*) '-INF:', X

    X = IEEE_VALUE(X, IEEE_QUIET_NAN)
    WRITE(*,*) 'NaN:', X

    X = IEEE_VALUE(X, IEEE_POSITIVE_ZERO)
    Y = IEEE_VALUE(Y, IEEE_NEGATIVE_ZERO)

    ! Classification de valeurs
    X = 3.14
    CLS = IEEE_CLASS(X)
    IF (CLS == IEEE_POSITIVE_NORMAL) WRITE(*,*) 'X est normal positif'

    ! Tester si une valeur est NaN ou infinie
    X = IEEE_VALUE(X, IEEE_QUIET_NAN)
    WRITE(*,*) 'IS_NAN:', IEEE_IS_NAN(X)
    WRITE(*,*) 'IS_FINITE:', IEEE_IS_FINITE(X)
    WRITE(*,*) 'IS_NEGATIVE:', IEEE_IS_NEGATIVE(X)

    X = 1.0
    WRITE(*,*) 'IS_NORMAL:', IEEE_IS_NORMAL(X)

    ! Gestion des exceptions IEEE
    FLAG = IEEE_OVERFLOW
    CALL IEEE_GET_FLAG(FLAG, FLAGGED)
    WRITE(*,*) 'OVERFLOW flag:', FLAGGED

    CALL IEEE_SET_FLAG(IEEE_OVERFLOW, .FALSE.)  ! Effacer le flag

    CALL IEEE_GET_HALTING_MODE(IEEE_OVERFLOW, HALTING)
    WRITE(*,*) 'Halting mode OVERFLOW:', HALTING

    ! Provoquer un overflow et le capturer
    CALL IEEE_SET_HALTING_MODE(IEEE_OVERFLOW, .FALSE.)
    X = HUGE(X)
    Y = X * 2.0  ! Provoque un overflow
    CALL IEEE_GET_FLAG(IEEE_OVERFLOW, FLAGGED)
    WRITE(*,*) 'Overflow detecte:', FLAGGED
    CALL IEEE_SET_FLAG(IEEE_OVERFLOW, .FALSE.)

    ! SCALB et LOGB
    X = 3.14
    Z = IEEE_SCALB(X, 2)   ! X * 2^2
    WRITE(*,*) 'SCALB(3.14,2)=', Z

    Z = IEEE_LOGB(X)        ! Log2 de la magnitude
    WRITE(*,*) 'LOGB(3.14)=', Z

    ! IEEE_NEXT_AFTER
    X = 1.0
    Y = IEEE_NEXT_AFTER(X, 2.0)
    WRITE(*,*) 'NEXT_AFTER(1.0, 2.0)=', Y

    ! IEEE_REM
    X = 5.0
    Y = 3.0
    Z = IEEE_REM(X, Y)
    WRITE(*,*) 'REM(5.0, 3.0)=', Z

  END SUBROUTINE CHECK_IEEE

END MODULE IEEEMOD


PROGRAM IEEETEST
  USE IEEEMOD
  USE IEEE_ARITHMETIC
  USE IEEE_EXCEPTIONS
  IMPLICIT NONE

  REAL :: A, B
  TYPE(IEEE_ROUND_TYPE) :: RND_MODE

  ! Mode d'arrondi
  CALL IEEE_GET_ROUNDING_MODE(RND_MODE)
  WRITE(*,*) 'Mode arrondi initial'

  CALL IEEE_SET_ROUNDING_MODE(IEEE_NEAREST)
  A = 1.0 / 3.0
  WRITE(*,*) 'NEAREST:', A

  CALL IEEE_SET_ROUNDING_MODE(IEEE_UP)
  B = 1.0 / 3.0
  WRITE(*,*) 'UP:', B

  CALL IEEE_SET_ROUNDING_MODE(IEEE_DOWN)
  B = 1.0 / 3.0
  WRITE(*,*) 'DOWN:', B

  CALL IEEE_SET_ROUNDING_MODE(IEEE_TO_ZERO)
  B = 1.0 / 3.0
  WRITE(*,*) 'TO_ZERO:', B

  ! Restaurer le mode initial
  CALL IEEE_SET_ROUNDING_MODE(RND_MODE)

  CALL CHECK_IEEE()

END PROGRAM IEEETEST
