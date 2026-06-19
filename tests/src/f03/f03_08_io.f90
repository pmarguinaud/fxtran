! Test: nouvelles fonctionnalites I/O F2003
! Statements couverts: FLUSH, NEWUNIT=, IOMSG=, ACCESS='STREAM',
!                      ENCODING=, lecture/ecriture en mode stream

PROGRAM IOF03TEST
  IMPLICIT NONE

  INTEGER :: IUNIT, ISTAT
  CHARACTER(LEN=200) :: ERRMSG
  REAL :: X
  INTEGER :: I

  ! OPEN avec NEWUNIT= (F2003: numero d'unite automatique)
  OPEN(NEWUNIT=IUNIT, FILE='test_f03_stream.dat', &
       STATUS='REPLACE', FORM='UNFORMATTED', &
       ACCESS='STREAM', IOSTAT=ISTAT, IOMSG=ERRMSG)
  IF (ISTAT /= 0) THEN
    WRITE(*,*) 'ERREUR OPEN: ', TRIM(ERRMSG)
    STOP
  END IF

  ! Ecriture en mode stream (acces direct par octet)
  DO I = 1, 5
    X = REAL(I) * 1.1
    WRITE(IUNIT) X
  END DO

  ! FLUSH: vide le tampon d'ecriture
  FLUSH(IUNIT)
  FLUSH(UNIT=IUNIT)

  REWIND(IUNIT)

  ! Lecture en mode stream
  DO I = 1, 5
    READ(IUNIT, IOSTAT=ISTAT, IOMSG=ERRMSG) X
    IF (ISTAT /= 0) EXIT
    WRITE(*,*) X
  END DO

  CLOSE(IUNIT, STATUS='DELETE')

  ! OPEN fichier formate avec NEWUNIT=
  OPEN(NEWUNIT=IUNIT, FILE='test_f03_fmt.txt', &
       STATUS='REPLACE', FORM='FORMATTED', &
       IOSTAT=ISTAT, IOMSG=ERRMSG)
  IF (ISTAT == 0) THEN
    WRITE(IUNIT, '(A)', IOSTAT=ISTAT, IOMSG=ERRMSG) 'LIGNE TEST'
    FLUSH(IUNIT)
    CLOSE(IUNIT, STATUS='DELETE')
  END IF

  ! IOMSG= sur READ avec erreur
  OPEN(NEWUNIT=IUNIT, STATUS='SCRATCH')
  WRITE(IUNIT, *) 'PAS UN ENTIER'
  REWIND(IUNIT)
  READ(IUNIT, *, IOSTAT=ISTAT, IOMSG=ERRMSG) I
  IF (ISTAT /= 0) WRITE(*,*) 'ERREUR: ', TRIM(ERRMSG)
  CLOSE(IUNIT)

END PROGRAM IOF03TEST
