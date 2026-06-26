C     Test: SUBROUTINE / RETURN / END + ENTRY
C     Statements couverts: SUBROUTINE, RETURN, END, ENTRY, CALL (dans main)
      SUBROUTINE MYSUB(X, Y)
      REAL X, Y
      X = Y * 2.0
      RETURN
      ENTRY MYSUB2(X)
      X = 0.0
      RETURN
      END

      PROGRAM CALLSUB
      REAL A, B
      A = 1.0
      B = 2.0
      CALL MYSUB(A, B)
      CALL MYSUB2(A)
      END
