C     Test: enonces de controle - IF
C     Statements couverts: IF arithmetique, IF logique, IF/THEN/END IF,
C                          IF/THEN/ELSE/END IF, IF/THEN/ELSE IF/ELSE/END IF
      PROGRAM IFTEST
      INTEGER I, J
      REAL X
      I = 5
      J = 0
      X = -3.7

C     IF arithmetique (3 branches: neg, zero, pos)
      IF (I-5) 10, 20, 30
   10 WRITE(*,*) 'NEGATIF'
      GOTO 40
   20 WRITE(*,*) 'ZERO'
      GOTO 40
   30 WRITE(*,*) 'POSITIF'
   40 CONTINUE

C     IF logique (une seule instruction)
      IF (X .LT. 0.0) X = -X

C     IF / THEN / END IF
      IF (I .GT. 0) THEN
        J = I * 2
      END IF

C     IF / THEN / ELSE / END IF
      IF (I .EQ. 5) THEN
        WRITE(*,*) 'CINQ'
      ELSE
        WRITE(*,*) 'PAS CINQ'
      END IF

C     IF / THEN / ELSE IF / ELSE / END IF
      IF (I .LT. 0) THEN
        WRITE(*,*) 'NEGATIF'
      ELSE IF (I .EQ. 0) THEN
        WRITE(*,*) 'NUL'
      ELSE IF (I .LT. 10) THEN
        WRITE(*,*) 'PETIT POSITIF'
      ELSE
        WRITE(*,*) 'GRAND POSITIF'
      END IF

      END
