C     Test: boucles DO
C     Statements couverts: DO (avec etiquette) / CONTINUE,
C                          DO (avec pas negatif), DO imbrique
      PROGRAM DOTEST
      INTEGER I, J, SUM

C     Boucle DO simple avec CONTINUE
      SUM = 0
      DO 100 I = 1, 10
        SUM = SUM + I
  100 CONTINUE

C     Boucle DO avec pas (increment)
      DO 200 I = 1, 20, 2
        WRITE(*,*) I
  200 CONTINUE

C     Boucle DO avec pas negatif
      DO 300 I = 10, 1, -1
        WRITE(*,*) I
  300 CONTINUE

C     Boucles DO imbriquees
      DO 500 I = 1, 3
        DO 400 J = 1, 3
          WRITE(*,*) I, J
  400   CONTINUE
  500 CONTINUE

      END
