C     Test: enonces de specification
C     Statements couverts: IMPLICIT, PARAMETER, DIMENSION, COMMON,
C                          EQUIVALENCE, EXTERNAL, INTRINSIC, SAVE
      PROGRAM SPECTEST
      IMPLICIT REAL (A-H, O-Z)
      IMPLICIT INTEGER (I-N)
      PARAMETER (MAXN=100, PI=3.14159265)
      DIMENSION ARR(MAXN), MAT(10,10)
      REAL ARR, MAT
      COMMON /SHARED/ ARR, NSIZE
      INTEGER NSIZE
      REAL A, B
      EQUIVALENCE (A, MAT(1,1))
      EXTERNAL MYSUB
      INTRINSIC SIN, COS, ABS, SQRT
      SAVE ARR, NSIZE
      A = SIN(PI)
      B = COS(PI)
      NSIZE = MAXN
      END

      SUBROUTINE MYSUB(X)
      REAL X
      X = ABS(X)
      RETURN
      END
