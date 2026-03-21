C     Test: EQUIVALENCE et SAVE
C     Statements couverts: EQUIVALENCE, SAVE (avec et sans liste)
      SUBROUTINE EQTEST(N)
      INTEGER N
      INTEGER IBUF(10)
      REAL RBUF(5)
      DOUBLE PRECISION DBUF(2)
      EQUIVALENCE (IBUF(1), RBUF(1))
      EQUIVALENCE (DBUF(1), IBUF(1))
      SAVE IBUF
      IBUF(1) = N
      RETURN
      END

      SUBROUTINE SAVEALL
C     SAVE sans liste (sauvegarde tout)
      SAVE
      INTEGER COUNT
      DATA COUNT /0/
      COUNT = COUNT + 1
      WRITE(*,*) 'APPEL', COUNT
      RETURN
      END

      PROGRAM EQMAIN
      CALL EQTEST(42)
      CALL SAVEALL
      CALL SAVEALL
      END
