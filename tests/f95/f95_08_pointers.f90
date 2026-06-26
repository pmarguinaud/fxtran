! Test: pointeurs et allocation dynamique
! Statements couverts: POINTER, TARGET, ALLOCATABLE,
!                      ALLOCATE, DEALLOCATE, NULLIFY,
!                      ASSOCIATED, ALLOCATED (fonctions intrinseques)

PROGRAM PTRTEST
  IMPLICIT NONE

  ! Pointeurs scalaires
  REAL, POINTER    :: P => NULL()
  REAL, TARGET     :: X, Y

  ! Pointeurs sur tableaux
  REAL, POINTER    :: VPTR(:) => NULL()
  REAL, TARGET     :: VTGT(5)

  ! Tableaux allocatables
  REAL, ALLOCATABLE :: AVEC(:)
  REAL, ALLOCATABLE :: MAT(:,:)

  INTEGER :: I, ISTAT

  ! Association de pointeur
  X = 3.14
  P => X
  WRITE(*,*) P, ASSOCIATED(P)

  ! Reassociation
  Y = 2.71
  P => Y
  WRITE(*,*) P

  ! NULLIFY
  NULLIFY(P)
  WRITE(*,*) ASSOCIATED(P)

  ! Pointeur sur tableau
  VTGT = [1.0, 2.0, 3.0, 4.0, 5.0]
  VPTR => VTGT
  WRITE(*,*) VPTR(3)

  ! Pointeur sur sous-tableau (section)
  VPTR => VTGT(2:4)
  WRITE(*,*) SIZE(VPTR)

  ! ALLOCATE scalaire via pointeur
  ALLOCATE(P)
  P = 42.0
  WRITE(*,*) P
  DEALLOCATE(P)

  ! ALLOCATE tableau via pointeur
  ALLOCATE(VPTR(10), STAT=ISTAT)
  IF (ISTAT == 0) THEN
    FORALL (I = 1:10) VPTR(I) = REAL(I)
    WRITE(*,*) VPTR
  END IF
  DEALLOCATE(VPTR)

  ! ALLOCATABLE
  WRITE(*,*) ALLOCATED(AVEC)
  ALLOCATE(AVEC(5))
  AVEC = [1.0, 2.0, 3.0, 4.0, 5.0]
  WRITE(*,*) ALLOCATED(AVEC), SIZE(AVEC)
  DEALLOCATE(AVEC)

  ! ALLOCATE tableau 2D
  ALLOCATE(MAT(3,4), STAT=ISTAT)
  MAT = 0.0
  MAT(2,3) = 99.0
  WRITE(*,*) MAT(2,3)
  DEALLOCATE(MAT)

END PROGRAM PTRTEST
