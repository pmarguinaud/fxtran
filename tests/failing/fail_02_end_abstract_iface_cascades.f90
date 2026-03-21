! ECHEC ATTENDU: END ABSTRACT INTERFACE provoque une cascade d'erreurs
! Quand END ABSTRACT INTERFACE est utilise, fxtran perd le contexte du module
! et toutes les procedures qui suivent dans le CONTAINS echouent egalement.
! La correction est de toujours ecrire END INTERFACE (sans ABSTRACT).

MODULE M
  IMPLICIT NONE

  TYPE, ABSTRACT :: ANIMAL
    CHARACTER(LEN=30) :: NAME
  CONTAINS
    PROCEDURE(SPEAK_IFACE), DEFERRED :: SPEAK
  END TYPE ANIMAL

  ABSTRACT INTERFACE
    SUBROUTINE SPEAK_IFACE(THIS)
      IMPORT :: ANIMAL
      CLASS(ANIMAL), INTENT(IN) :: THIS
    END SUBROUTINE SPEAK_IFACE
  END ABSTRACT INTERFACE     ! <- fxtran echoue ici, cascade sur la suite

CONTAINS

  SUBROUTINE PRINT_ANIMAL(X)
    CLASS(ANIMAL), INTENT(IN) :: X
    WRITE(*,*) TRIM(X%NAME)
  END SUBROUTINE PRINT_ANIMAL

END MODULE M
