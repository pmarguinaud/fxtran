C     Test: enonces GOTO et ASSIGN
C     Statements couverts: GOTO (inconditionnel), GOTO calcule,
C                          ASSIGN, GOTO assigne, PAUSE, CONTINUE
      PROGRAM GOTOTEST
      INTEGER I, ILAB

C     GOTO inconditionnel
      GOTO 100
      WRITE(*,*) 'JAMAIS EXECUTE'
  100 CONTINUE

C     GOTO calcule
      I = 2
      GOTO (10, 20, 30), I
   10 WRITE(*,*) 'CAS 1'
      GOTO 40
   20 WRITE(*,*) 'CAS 2'
      GOTO 40
   30 WRITE(*,*) 'CAS 3'
   40 CONTINUE

C     ASSIGN et GOTO assigne
      ASSIGN 200 TO ILAB
      GOTO ILAB, (200, 300)
  200 WRITE(*,*) 'ETIQUETTE 200'
      GOTO 400
  300 WRITE(*,*) 'ETIQUETTE 300'
  400 CONTINUE

C     PAUSE
      PAUSE 'APPUYEZ ENTREE'

      END
