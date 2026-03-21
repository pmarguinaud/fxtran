! Test: nouvelles fonctions intrinseques F90/F95
! Statements couverts: intrinseques tableaux, intrinseques numeriques,
!                      intrinseques caracteres, intrinseques bits, CPU_TIME (F95)

PROGRAM INTRTEST
  IMPLICIT NONE

  REAL    :: A(6) = [3.0, 1.0, 4.0, 1.0, 5.0, 9.0]
  REAL    :: B(6) = [2.0, 7.0, 1.0, 8.0, 2.0, 8.0]
  REAL    :: MAT(3,4)
  INTEGER :: IVEC(5) = [5, 3, 8, 1, 7]
  INTEGER :: I, J
  REAL    :: T1, T2

  FORALL (I=1:3, J=1:4) MAT(I,J) = REAL(I + J)

  ! --- Intrinseques de tableau ---

  ! Forme et taille
  WRITE(*,*) SIZE(A)                 ! 6
  WRITE(*,*) SIZE(MAT)               ! 12
  WRITE(*,*) SIZE(MAT, DIM=1)        ! 3
  WRITE(*,*) SIZE(MAT, DIM=2)        ! 4
  WRITE(*,*) SHAPE(MAT)              ! [3, 4]
  WRITE(*,*) LBOUND(MAT, 1), UBOUND(MAT, 1)  ! 1 3
  WRITE(*,*) LBOUND(A), UBOUND(A)            ! 1 6

  ! Reductions
  WRITE(*,*) SUM(A)                  ! somme
  WRITE(*,*) PRODUCT(A)              ! produit
  WRITE(*,*) MAXVAL(A)               ! maximum
  WRITE(*,*) MINVAL(A)               ! minimum
  WRITE(*,*) SUM(MAT, DIM=1)         ! somme par ligne
  WRITE(*,*) SUM(MAT, DIM=2)         ! somme par colonne
  WRITE(*,*) SUM(A, MASK=A>3.0)      ! somme avec masque

  ! Localisation (F95: MAXLOC/MINLOC avec DIM)
  WRITE(*,*) MAXLOC(A)               ! indice du max
  WRITE(*,*) MINLOC(A)               ! indice du min
  WRITE(*,*) MAXLOC(IVEC)
  WRITE(*,*) MINLOC(A, MASK=A<5.0)

  ! Logiques
  WRITE(*,*) ANY(A > 5.0)
  WRITE(*,*) ALL(A > 0.0)
  WRITE(*,*) COUNT(A > 3.0)

  ! Construction/transformation
  WRITE(*,*) RESHAPE(A, [2,3])
  WRITE(*,*) TRANSPOSE(MAT)
  WRITE(*,*) SPREAD(A(1), DIM=1, NCOPIES=3)
  WRITE(*,*) PACK(A, A > 3.0)
  WRITE(*,*) MERGE(A, B, A > B)

  ! Produit matriciel
  BLOCK
    REAL :: M1(2,3), M2(3,2), M3(2,2)
    M1 = RESHAPE([1.0,2.0,3.0,4.0,5.0,6.0], [2,3])
    M2 = RESHAPE([1.0,0.0,0.0,1.0,1.0,0.0], [3,2])
    M3 = MATMUL(M1, M2)
    WRITE(*,*) M3
    WRITE(*,*) DOT_PRODUCT(A(1:3), B(1:3))
  END BLOCK

  ! Decalages
  WRITE(*,*) CSHIFT(IVEC, 2)
  WRITE(*,*) EOSHIFT(IVEC, 2, 0)

  ! --- Intrinseques numeriques ---
  WRITE(*,*) CEILING(3.2)
  WRITE(*,*) FLOOR(3.7)
  WRITE(*,*) MODULO(7, 3)
  WRITE(*,*) MODULO(-7.0, 3.0)
  WRITE(*,*) NEAREST(1.0, 1.0)
  WRITE(*,*) EPSILON(1.0)
  WRITE(*,*) HUGE(1.0)
  WRITE(*,*) TINY(1.0)
  WRITE(*,*) DIGITS(1.0)
  WRITE(*,*) EXPONENT(A(1))
  WRITE(*,*) FRACTION(A(1))
  WRITE(*,*) RRSPACING(A(1))
  WRITE(*,*) SPACING(A(1))
  WRITE(*,*) SET_EXPONENT(A(1), 2)
  WRITE(*,*) SCALE(A(1), 2)
  WRITE(*,*) KIND(1.0)
  WRITE(*,*) KIND(1)
  WRITE(*,*) SELECTED_REAL_KIND(6)
  WRITE(*,*) SELECTED_INT_KIND(9)
  WRITE(*,*) RANGE(1.0)
  WRITE(*,*) PRECISION(1.0)
  WRITE(*,*) RADIX(1.0)

  ! --- Intrinseques caracteres ---
  WRITE(*,*) ADJUSTL('  HELLO  ')
  WRITE(*,*) ADJUSTR('  HELLO  ')
  WRITE(*,*) TRIM('HELLO   ')
  WRITE(*,*) LEN_TRIM('HELLO   ')
  WRITE(*,*) REPEAT('AB', 3)
  WRITE(*,*) SCAN('FORTRAN', 'AEIOU')
  WRITE(*,*) VERIFY('FORTRAN', 'AEIOU')

  ! --- Intrinseques de bits ---
  WRITE(*,*) IAND(12, 10)
  WRITE(*,*) IOR(12, 10)
  WRITE(*,*) IEOR(12, 10)
  WRITE(*,*) NOT(0)
  WRITE(*,*) IBSET(0, 3)
  WRITE(*,*) IBCLR(15, 2)
  WRITE(*,*) IBITS(15, 1, 3)
  WRITE(*,*) ISHFT(1, 3)
  WRITE(*,*) ISHFTC(1, 2, 8)
  WRITE(*,*) BIT_SIZE(1)

  ! --- CPU_TIME (F95) ---
  CALL CPU_TIME(T1)
  DO I = 1, 1000
    A(1) = A(1) + REAL(I) * 0.001
  END DO
  CALL CPU_TIME(T2)
  WRITE(*,*) 'CPU time:', T2 - T1

END PROGRAM INTRTEST
