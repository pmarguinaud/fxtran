C     Test: declarations de type Fortran 77
C     Statements couverts: INTEGER, REAL, DOUBLE PRECISION, COMPLEX,
C                          LOGICAL, CHARACTER, PARAMETER, DIMENSION, DATA
      PROGRAM TYPETEST
      INTEGER I, J, IARR(5)
      REAL X, Y, RARR(3)
      DOUBLE PRECISION D1, D2
      COMPLEX C1, C2
      LOGICAL L1, L2
      CHARACTER*8 STR1
      CHARACTER CH
      CHARACTER*(*) PARAM
      PARAMETER (PARAM='FORTRAN77')
      DIMENSION ZARR(4)
      REAL ZARR
      DATA IARR /1, 2, 3, 4, 5/
      DATA RARR /1.0, 2.0, 3.0/
      I = 10
      J = -5
      X = 1.5
      Y = -2.7
      D1 = 3.14159265358979D0
      D2 = 2.71828182845905D0
      C1 = (1.0, 0.0)
      C2 = (0.0, 1.0)
      L1 = .TRUE.
      L2 = .FALSE.
      STR1 = 'HELLO   '
      CH = 'A'
      END
