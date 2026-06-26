C     Test: fonctions intrinseques et EXTERNAL
C     Statements couverts: INTRINSIC, EXTERNAL, appels de fonctions
      PROGRAM INTRTEST
      REAL X, Y, Z
      DOUBLE PRECISION D
      INTEGER I, J
      COMPLEX C
      INTRINSIC SIN, COS, TAN, ASIN, ACOS, ATAN, ATAN2
      INTRINSIC EXP, LOG, LOG10, SQRT
      INTRINSIC ABS, IABS, SIGN, ISIGN, DIM, IDIM
      INTRINSIC INT, REAL, FLOAT, IFIX, AINT, ANINT, NINT
      INTRINSIC MOD, AMOD
      INTRINSIC MAX, MIN, AMAX1, AMIN1, AMAX0, AMIN0
      INTRINSIC MAX0, MIN0
      INTRINSIC LEN, INDEX
      INTRINSIC DBLE, SNGL, CMPLX, CONJG
      INTRINSIC ICHAR, CHAR

      X = 1.5
      Y = SIN(X)
      Y = COS(X)
      Y = TAN(X)
      Y = ASIN(0.5)
      Y = ACOS(0.5)
      Y = ATAN(1.0)
      Y = ATAN2(1.0, 1.0)
      Y = EXP(X)
      Y = LOG(X)
      Y = LOG10(X)
      Y = SQRT(X)
      Y = ABS(-X)
      I = IABS(-5)
      Y = SIGN(X, -1.0)
      I = ISIGN(3, -1)
      Y = MOD(X, 1.0)
      I = MOD(7, 3)
      I = MAX(3, 5, 2)
      I = MIN(3, 5, 2)
      Y = AMAX1(1.5, 2.5)
      Y = AMIN1(1.5, 2.5)
      I = INT(3.7)
      Y = REAL(I)
      Y = AINT(3.7)
      Y = ANINT(3.5)
      I = NINT(3.5)
      D = DBLE(X)
      Y = SNGL(D)
      C = CMPLX(1.0, 2.0)
      C = CONJG(C)
      I = ICHAR('A')
      END
