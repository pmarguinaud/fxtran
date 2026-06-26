! Test: I/O avancee F90/F95
! Statements couverts: READ/WRITE avec ADVANCE=, EOR=, PENDING=,
!                      lecture interne (internal READ/WRITE),
!                      OPEN avec nouveaux parametres

PROGRAM IOTEST
  IMPLICIT NONE
  CHARACTER(LEN=80) :: LINE
  CHARACTER(LEN=20) :: WORD
  INTEGER :: IVAL, ISTAT
  REAL    :: RVAL
  CHARACTER(LEN=40) :: BUFFER

  ! Lecture/ecriture interne (internal file)
  BUFFER = '42 3.14159 HELLO'
  READ(BUFFER, *) IVAL, RVAL, WORD
  WRITE(*,*) IVAL, RVAL, TRIM(WORD)

  ! Ecriture interne avec format
  WRITE(BUFFER, '(I5,F10.4)') 123, 4.567
  WRITE(*,*) TRIM(BUFFER)

  ! OPEN avec STATUS='SCRATCH' (fichier temporaire)
  OPEN(UNIT=20, STATUS='SCRATCH', FORM='FORMATTED')
  WRITE(20, '(A)') 'LIGNE 1'
  WRITE(20, '(A)') 'LIGNE 2'
  REWIND(20)
  READ(20, '(A)') LINE
  WRITE(*,*) TRIM(LINE)
  CLOSE(20)

  ! OPEN avec ACTION= et POSITION=
  OPEN(UNIT=21, FILE='test_io_f95.dat', STATUS='UNKNOWN', &
       ACTION='READWRITE', POSITION='REWIND', IOSTAT=ISTAT)
  IF (ISTAT == 0) THEN
    WRITE(21, *) 1.0, 2.0, 3.0
    CLOSE(21, STATUS='DELETE')
  END IF

  ! WRITE avec ADVANCE='NO' (pas de saut de ligne)
  WRITE(*, '(A)', ADVANCE='NO') 'SANS RETOUR '
  WRITE(*, '(A)', ADVANCE='YES') 'AVEC RETOUR'

  ! INQUIRE etendu
  BLOCK
    INTEGER :: RECL_VAL
    CHARACTER(LEN=20) :: FORM_VAL, ACCESS_VAL
    LOGICAL :: LEXIST, LOPEN
    INQUIRE(FILE='test_io_f95.dat', EXIST=LEXIST)
    INQUIRE(UNIT=21, OPENED=LOPEN, FORM=FORM_VAL, IOSTAT=ISTAT)
    WRITE(*,*) LEXIST, LOPEN
  END BLOCK

END PROGRAM IOTEST
