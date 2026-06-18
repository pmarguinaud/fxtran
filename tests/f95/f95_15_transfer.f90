! Test: fonctions intrinseques supplementaires F90/F95
! Statements couverts: TRANSFER, RESHAPE, PACK, UNPACK, SPREAD,
!                      BIT_SIZE, BTEST, IBCLR, IBSET, IAND, IOR, IEOR, ISHFT

PROGRAM TRANSFERTEST
  IMPLICIT NONE

  INTEGER  :: I, J
  REAL     :: R
  REAL     :: A(3,3), B(9), C(3,3), V(3)
  LOGICAL  :: MASK(3,3), LMASK(3)
  INTEGER  :: IBITS

  ! TRANSFER: reinterpretation binaire
  I = 42
  R = TRANSFER(I, 1.0)

  R = 3.14
  I = TRANSFER(R, 1)

  ! RESHAPE: changement de forme
  B = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
  A = RESHAPE(B, [3, 3])
  WRITE(*,*) A

  ! RESHAPE avec ORDER
  C = RESHAPE(B, [3, 3], ORDER=[2,1])
  WRITE(*,*) C

  ! PACK: extraction des elements satisfaisant un masque
  MASK = .FALSE.
  MASK(1,1) = .TRUE.
  MASK(2,2) = .TRUE.
  MASK(3,3) = .TRUE.
  V = PACK(A, MASK)
  WRITE(*,*) V

  ! UNPACK: dispersion d'un vecteur selon un masque
  LMASK = [.TRUE., .FALSE., .TRUE.]
  V = [10.0, 20.0, 30.0]
  B(1:3) = UNPACK(PACK(V, LMASK), LMASK, 0.0)

  ! SPREAD: extension d'un tableau par replication
  V = [1.0, 2.0, 3.0]
  A = SPREAD(V, DIM=2, NCOPIES=3)
  WRITE(*,*) A

  ! Operations sur les bits
  IBITS = BIT_SIZE(I)
  WRITE(*,*) 'BIT_SIZE=', IBITS

  I = 5  ! 0101 en binaire
  J = 3  ! 0011 en binaire

  WRITE(*,*) IAND(I, J)   ! ET bit-a-bit
  WRITE(*,*) IOR(I, J)    ! OU bit-a-bit
  WRITE(*,*) IEOR(I, J)   ! OU EXCLUSIF
  WRITE(*,*) NOT(I)        ! NOT bit-a-bit

  WRITE(*,*) IBCLR(I, 2)  ! Effacer bit 2
  WRITE(*,*) IBSET(I, 3)  ! Mettre a 1 bit 3
  WRITE(*,*) BTEST(I, 0)  ! Tester bit 0
  WRITE(*,*) ISHFT(I, 1)  ! Decalage gauche de 1
  WRITE(*,*) ISHFT(I, -1) ! Decalage droite de 1
  WRITE(*,*) ISHFTC(I, 2, 8) ! Rotation circulaire

  ! IBITS: extraction de bits
  WRITE(*,*) IBITS(I, 1, 2)  ! Extraire 2 bits a partir de la position 1

END PROGRAM TRANSFERTEST
