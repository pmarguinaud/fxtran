! Test: attributs VOLATILE et PROTECTED
! Statements couverts: VOLATILE, PROTECTED (dans module)

MODULE PROTECTEDMOD
  IMPLICIT NONE

  ! PROTECTED: variable lisible de l'exterieur mais non modifiable
  INTEGER, PROTECTED :: COUNTER = 0
  REAL,    PROTECTED :: PI_VAL  = 3.14159265358979

  ! VOLATILE: pas d'optimisation du compilateur sur cette variable
  ! (utile pour I/O memoire mappee, variables modifiees par signal, etc.)
  INTEGER, VOLATILE :: HW_REGISTER

CONTAINS

  SUBROUTINE INCREMENT()
    COUNTER = COUNTER + 1
  END SUBROUTINE INCREMENT

  SUBROUTINE RESET()
    COUNTER = 0
  END SUBROUTINE RESET

END MODULE PROTECTEDMOD


PROGRAM VOLPROTTEST
  USE PROTECTEDMOD
  IMPLICIT NONE

  ! Variables VOLATILE locales
  INTEGER, VOLATILE :: FLAG
  REAL,    VOLATILE :: SENSOR_VALUE
  INTEGER, VOLATILE :: LOCK_VAR

  FLAG         = 0
  SENSOR_VALUE = 0.0
  LOCK_VAR     = 0

  ! Utilisation normale de variables VOLATILE
  FLAG = 1
  SENSOR_VALUE = 3.14
  WRITE(*,*) FLAG, SENSOR_VALUE

  ! PROTECTED: lecture OK
  WRITE(*,*) COUNTER
  WRITE(*,*) PI_VAL

  ! Modification via les procedures du module
  CALL INCREMENT()
  CALL INCREMENT()
  WRITE(*,*) COUNTER   ! = 2

  CALL RESET()
  WRITE(*,*) COUNTER   ! = 0

  ! Boucle avec variable VOLATILE (pas d'optimisation de la boucle)
  BLOCK
    INTEGER, VOLATILE :: I
    DO I = 1, 5
      LOCK_VAR = LOCK_VAR + I
    END DO
    WRITE(*,*) LOCK_VAR
  END BLOCK

END PROGRAM VOLPROTTEST
