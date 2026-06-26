! Test: allocatables etendus (F2003)
! Statements couverts: ALLOCATE avec SOURCE=, ALLOCATE avec MOLD=,
!                      MOVE_ALLOC, composantes allocatables,
!                      arguments factices allocatables, resultats allocatables

MODULE ALLOCMOD
  IMPLICIT NONE

  ! Type avec composantes allocatables
  TYPE :: DYNTREE
    INTEGER :: VALUE
    TYPE(DYNTREE), ALLOCATABLE :: LEFT
    TYPE(DYNTREE), ALLOCATABLE :: RIGHT
    REAL,          ALLOCATABLE :: DATA(:)
  END TYPE DYNTREE

  ! Type avec pointeurs et allocatables
  TYPE :: MATRIX
    REAL, ALLOCATABLE :: A(:,:)
    INTEGER :: M = 0, N = 0
  CONTAINS
    PROCEDURE :: INIT => MAT_INIT
    PROCEDURE :: COPY => MAT_COPY
  END TYPE MATRIX

CONTAINS

  SUBROUTINE MAT_INIT(THIS, M, N, VAL)
    CLASS(MATRIX),  INTENT(INOUT) :: THIS
    INTEGER,        INTENT(IN)    :: M, N
    REAL, OPTIONAL, INTENT(IN)    :: VAL
    THIS%M = M; THIS%N = N
    ALLOCATE(THIS%A(M, N))
    IF (PRESENT(VAL)) THIS%A = VAL
  END SUBROUTINE MAT_INIT

  SUBROUTINE MAT_COPY(THIS, OTHER)
    CLASS(MATRIX), INTENT(INOUT) :: THIS
    TYPE(MATRIX),  INTENT(IN)    :: OTHER
    ! ALLOCATE avec SOURCE= : alloue et initialise en une etape
    ALLOCATE(THIS%A, SOURCE=OTHER%A)
    THIS%M = OTHER%M; THIS%N = OTHER%N
  END SUBROUTINE MAT_COPY

  ! Argument factice allocatable
  SUBROUTINE RESIZE(V, N)
    REAL, ALLOCATABLE, INTENT(INOUT) :: V(:)
    INTEGER,           INTENT(IN)    :: N
    REAL, ALLOCATABLE :: TMP(:)
    INTEGER :: OLDN
    IF (ALLOCATED(V)) THEN
      OLDN = MIN(SIZE(V), N)
      ALLOCATE(TMP(N))
      TMP(1:OLDN) = V(1:OLDN)
      CALL MOVE_ALLOC(FROM=TMP, TO=V)
    ELSE
      ALLOCATE(V(N))
      V = 0.0
    END IF
  END SUBROUTINE RESIZE

  ! Resultat de fonction allocatable
  FUNCTION LINSPACE(A, B, N) RESULT(V)
    REAL,    INTENT(IN) :: A, B
    INTEGER, INTENT(IN) :: N
    REAL, ALLOCATABLE :: V(:)
    INTEGER :: I
    ALLOCATE(V(N))
    DO I = 1, N
      V(I) = A + (B - A) * REAL(I-1) / REAL(N-1)
    END DO
  END FUNCTION LINSPACE

END MODULE ALLOCMOD


PROGRAM ALLOCTEST
  USE ALLOCMOD
  IMPLICIT NONE

  TYPE(MATRIX) :: M1, M2
  TYPE(DYNTREE) :: TREE
  REAL, ALLOCATABLE :: V(:), W(:)
  INTEGER :: I

  ! ALLOCATE avec SOURCE= (copie et allocation)
  CALL M1%INIT(3, 4, 1.0)
  ALLOCATE(M2%A, SOURCE=M1%A)
  M2%M = M1%M; M2%N = M1%N
  WRITE(*,*) M2%A(2,3)

  ! ALLOCATE avec MOLD= (meme forme, non initialise)
  ALLOCATE(W, MOLD=M1%A(1,:))
  WRITE(*,*) SIZE(W)

  ! MOVE_ALLOC
  ALLOCATE(V(5))
  V = [(REAL(I), I=1,5)]
  CALL RESIZE(V, 8)
  WRITE(*,*) SIZE(V), V(1:5)

  ! Composantes allocatables d'un type derive
  TREE%VALUE = 1
  ALLOCATE(TREE%LEFT)
  TREE%LEFT%VALUE = 2
  ALLOCATE(TREE%DATA(10))
  TREE%DATA = 0.0

  ! Resultat de fonction allocatable
  V = LINSPACE(0.0, 1.0, 6)
  WRITE(*,*) V

  DEALLOCATE(M1%A, M2%A, W, V)

END PROGRAM ALLOCTEST
