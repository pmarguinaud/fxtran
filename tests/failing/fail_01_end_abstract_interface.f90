! ECHEC ATTENDU: END ABSTRACT INTERFACE
! fxtran ne reconnait pas END ABSTRACT INTERFACE,
! il faut utiliser END INTERFACE a la place.
! Reference: corrections apportees dans f03_02 et f03_05.

MODULE M
  IMPLICIT NONE

  ABSTRACT INTERFACE
    REAL FUNCTION F(X)
      REAL, INTENT(IN) :: X
    END FUNCTION F
  END ABSTRACT INTERFACE   ! <- fxtran echoue ici

END MODULE M
