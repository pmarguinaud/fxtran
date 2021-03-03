MODULE m                          ! The ancestor module m
  INTEGER :: i

  INTERFACE
    MODULE SUBROUTINE sub1(arg1)  ! Module procedure interface body for sub1
      INTEGER :: arg1
    END SUBROUTINE
    
    MODULE SUBROUTINE sub2(arg2)  ! Module procedure interface body for sub2
      INTEGER :: arg2
    END SUBROUTINE
  END INTERFACE
END MODULE
