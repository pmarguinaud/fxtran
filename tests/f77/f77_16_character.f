C     Test: operations sur les chaines de caracteres
C     Statements couverts: concatenation //, sous-chaines, comparaison,
C                          affectation de chaine, fonctions intrinsiques sur chaines

      PROGRAM CHARTEST
      IMPLICIT NONE

      CHARACTER*20 STR1, STR2, STR3
      CHARACTER*5  SUB1
      CHARACTER*1  CH
      INTEGER      ILEN, I

C     Affectation de chaines
      STR1 = 'HELLO'
      STR2 = ' WORLD'

C     Concatenation //
      STR3 = STR1 // STR2

C     Sous-chaine (substring) : extraction par indices
      SUB1 = STR3(1:5)

C     Sous-chaine : affectation dans une sous-chaine
      STR3(7:11) = 'WORLD'

C     Caractere unique
      CH = STR1(1:1)

C     Comparaison de chaines (opérateurs relationnels)
      IF (STR1 .EQ. 'HELLO') WRITE(*,*) 'EGAL'
      IF (STR1 .NE. STR2)    WRITE(*,*) 'DIFFERENT'
      IF (STR1 .LT. STR2)    WRITE(*,*) 'INFERIEUR'
      IF (STR2 .GT. STR1)    WRITE(*,*) 'SUPERIEUR'

C     Fonction LEN : longueur declaree
      ILEN = LEN(STR1)
      WRITE(*,*) 'LEN=', ILEN

C     Fonction INDEX : position d'une sous-chaine
      I = INDEX(STR3, 'WOR')
      WRITE(*,*) 'INDEX=', I

C     Boucle sur les caracteres
      DO 10 I = 1, 5
        WRITE(*,*) STR1(I:I)
   10 CONTINUE

C     Concatenation dans une expression complexe
      STR3 = 'A' // 'B' // 'C'

C     Chaine dans DATA
      DATA STR1 / 'FORTRAN' /

      STOP
      END
