C     Test: entrees/sorties - WRITE, PRINT, FORMAT
C     Statements couverts: WRITE, PRINT, FORMAT
      PROGRAM WRITETEST
      INTEGER I
      REAL X
      CHARACTER*20 MSG
      I = 42
      X = 3.14159
      MSG = 'BONJOUR'

C     WRITE avec numero de format
      WRITE(6, 100) I, X
  100 FORMAT(I5, F10.4)

C     WRITE vers stdout avec liste libre
      WRITE(*,*) I, X, MSG

C     WRITE avec format inline
      WRITE(6, '(A, I5)') 'VALEUR = ', I

C     PRINT avec numero de format
      PRINT 200, I
  200 FORMAT('ENTIER =', I6)

C     PRINT avec liste libre
      PRINT *, X, MSG

C     FORMAT avec differents descripteurs
      WRITE(6, 300) I, X, MSG
  300 FORMAT(1X, I10, E15.6, A20)

      WRITE(6, 400) I, X
  400 FORMAT(T10, 'I=', I5, /, T10, 'X=', F8.3)

      END
