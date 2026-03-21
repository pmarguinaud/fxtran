C     Test: entrees - READ
C     Statements couverts: READ (differentes formes)
      PROGRAM READTEST
      INTEGER I, J
      REAL X
      CHARACTER*10 STR

C     READ depuis stdin liste libre
      READ(*,*) I

C     READ avec format
      READ(5, 100) I, X
  100 FORMAT(I5, F10.4)

C     READ avec format en ligne
      READ(5, '(I5)') J

C     READ avec END= et ERR=
      READ(5, *, END=200, ERR=300) X
      GOTO 400
  200 WRITE(*,*) 'FIN DE FICHIER'
      GOTO 400
  300 WRITE(*,*) 'ERREUR LECTURE'
  400 CONTINUE

C     READ avec IOSTAT=
      INTEGER ISTAT
      READ(5, *, IOSTAT=ISTAT) STR

      END
