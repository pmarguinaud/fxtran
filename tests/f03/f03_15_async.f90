! Test: E/S asynchrones (Fortran 2003)
! Statements couverts: ASYNCHRONOUS, WAIT, READ/WRITE ASYNCHRONOUS='YES',
!                      ID= specifier, PENDING=

PROGRAM ASYNCTEST
  IMPLICIT NONE

  ! Tableau avec attribut ASYNCHRONOUS
  REAL, ASYNCHRONOUS :: BUFFER(1000)
  REAL, ASYNCHRONOUS :: SENDBUF(100), RECVBUF(100)
  INTEGER :: ID1, ID2, ISTAT
  LOGICAL :: PENDING_FLAG
  INTEGER :: I, UNIT1

  ! Remplissage du buffer
  DO I = 1, 100
    SENDBUF(I) = REAL(I)
  END DO

  ! Ouverture d'un fichier pour test
  UNIT1 = 10
  OPEN(UNIT=UNIT1, FILE='async_test.tmp', STATUS='REPLACE', &
       ACCESS='SEQUENTIAL', ACTION='READWRITE')

  ! Ecriture synchrone pour initialisation
  WRITE(UNIT1, *) (SENDBUF(I), I=1,100)
  REWIND(UNIT1)

  ! Lecture asynchrone avec ID=
  READ(UNIT1, *, ASYNCHRONOUS='YES', ID=ID1) (BUFFER(I), I=1,100)

  ! ... calcul pendant le transfert ...
  DO I = 1, 1000
    BUFFER(I + 100) = 0.0
  END DO

  ! Attente de la completion avec WAIT
  WAIT(UNIT=UNIT1, ID=ID1)

  ! Verifier que le transfert est termine
  WRITE(*,*) 'Lecture asynchrone terminee'
  WRITE(*,*) 'Premier element:', BUFFER(1)

  ! Ecriture asynchrone
  REWIND(UNIT1)
  WRITE(UNIT1, *, ASYNCHRONOUS='YES', ID=ID2) (BUFFER(I), I=1,100)

  ! WAIT sans ID= attend tous les transferts en attente sur l'unite
  WAIT(UNIT=UNIT1)

  ! WAIT avec IOSTAT= et PENDING=
  REWIND(UNIT1)
  READ(UNIT1, *, ASYNCHRONOUS='YES', ID=ID1) (RECVBUF(I), I=1,100)
  WAIT(UNIT=UNIT1, ID=ID1, IOSTAT=ISTAT, PENDING=PENDING_FLAG)
  IF (.NOT. PENDING_FLAG) THEN
    WRITE(*,*) 'Transfert complete, IOSTAT=', ISTAT
  END IF

  CLOSE(UNIT1, STATUS='DELETE')

  ! Variable avec attribut ASYNCHRONOUS dans un sous-programme
  CALL ASYNC_SUB()

CONTAINS

  SUBROUTINE ASYNC_SUB()
    REAL, ASYNCHRONOUS :: LOCAL_BUF(50)
    INTEGER :: LID, LU

    LU = 20
    OPEN(UNIT=LU, FILE='async2.tmp', STATUS='REPLACE', ACTION='READWRITE')
    LOCAL_BUF = 1.0
    WRITE(LU, *, ASYNCHRONOUS='YES', ID=LID) LOCAL_BUF
    WAIT(UNIT=LU)
    CLOSE(LU, STATUS='DELETE')
    WRITE(*,*) 'ASYNC_SUB terminee'
  END SUBROUTINE ASYNC_SUB

END PROGRAM ASYNCTEST
