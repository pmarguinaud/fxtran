C     Test: I/O fichier
C     Statements couverts: OPEN, CLOSE, INQUIRE, BACKSPACE, ENDFILE, REWIND
      PROGRAM FILETEST
      INTEGER IUNIT, ISTAT
      REAL X
      LOGICAL LEXIST
      CHARACTER*30 FNAME

      IUNIT = 10
      FNAME = 'test_output.dat'

C     OPEN
      OPEN(UNIT=IUNIT, FILE=FNAME, STATUS='UNKNOWN',
     +     FORM='FORMATTED', ACCESS='SEQUENTIAL',
     +     IOSTAT=ISTAT)
      IF (ISTAT .NE. 0) GOTO 999

C     Ecriture de quelques valeurs
      DO 100 I = 1, 5
        X = REAL(I) * 1.5
        WRITE(IUNIT,*) I, X
  100 CONTINUE

C     ENDFILE
      ENDFILE IUNIT

C     REWIND
      REWIND IUNIT

C     Lecture en retour
      READ(IUNIT,*) I, X

C     BACKSPACE
      BACKSPACE IUNIT

C     Relecture apres backspace
      READ(IUNIT,*) I, X

C     CLOSE
      CLOSE(UNIT=IUNIT, STATUS='DELETE')

C     INQUIRE sur fichier
      INQUIRE(FILE=FNAME, EXIST=LEXIST)

C     INQUIRE sur unite
      OPEN(UNIT=11, FILE='tmp2.dat', STATUS='UNKNOWN')
      INQUIRE(UNIT=11, EXIST=LEXIST, IOSTAT=ISTAT)
      CLOSE(11)

  999 END
