! Test: nouvelles formes de DO (F90/F95)
! Statements couverts: DO sans etiquette, DO WHILE, DO sans borne (boucle infinie),
!                      EXIT, CYCLE, DO nomme, EXIT/CYCLE avec nom

PROGRAM DOTEST
  IMPLICIT NONE
  INTEGER :: I, J, N

  ! DO sans etiquette (F90+)
  DO I = 1, 5
    WRITE(*,*) I
  END DO

  ! DO WHILE
  N = 1
  DO WHILE (N <= 10)
    N = N * 2
  END DO
  WRITE(*,*) N

  ! DO infini avec EXIT
  I = 0
  DO
    I = I + 1
    IF (I >= 5) EXIT
  END DO

  ! CYCLE dans une boucle
  DO I = 1, 10
    IF (MOD(I, 2) == 0) CYCLE
    WRITE(*,*) I  ! imprime seulement les impairs
  END DO

  ! DO nomme avec EXIT/CYCLE sur nom
  OUTER: DO I = 1, 5
    INNER: DO J = 1, 5
      IF (J == 3) CYCLE INNER
      IF (I == 4) EXIT OUTER
      WRITE(*,*) I, J
    END DO INNER
  END DO OUTER

  ! DO WHILE nomme
  N = 0
  MYLOOP: DO WHILE (N < 3)
    N = N + 1
  END DO MYLOOP

END PROGRAM DOTEST
