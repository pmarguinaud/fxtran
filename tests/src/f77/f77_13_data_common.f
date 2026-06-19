C     Test: DATA et COMMON approfondis
C     Statements couverts: DATA (formes multiples), COMMON (nomme et vide)
      PROGRAM DATATEST
      INTEGER I, J, K
      REAL A(5), B(3,3)
      LOGICAL FLAGS(4)
      CHARACTER*5 WORDS(3)
      COMMON X, Y
      COMMON /BLK1/ I, J
      COMMON /BLK2/ A
      REAL X, Y

C     DATA avec scalaires
      DATA I /0/, J /1/, K /2/

C     DATA avec tableau - repetition
      DATA A /5*0.0/

C     DATA avec tableau 2D
      DATA B /9*1.0/

C     DATA avec logiques
      DATA FLAGS /.TRUE., .FALSE., .TRUE., .FALSE./

C     DATA avec caracteres
      DATA WORDS /'HELLO', 'WORLD', 'FORTR'/

C     DATA avec multiple listes
      DATA I, J / 10, 20 /

      X = 1.0
      Y = 2.0
      END
