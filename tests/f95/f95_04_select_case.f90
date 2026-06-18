! Test: SELECT CASE / CASE / CASE DEFAULT / END SELECT
! Statements couverts: SELECT CASE, CASE, CASE DEFAULT, END SELECT,
!                      CASE avec plages, CASE avec listes, constructs nommes

PROGRAM SELECTTEST
  IMPLICIT NONE
  INTEGER :: I
  CHARACTER :: CH
  REAL    :: X

  ! SELECT CASE sur entier
  I = 3
  SELECT CASE (I)
    CASE (1)
      WRITE(*,*) 'UN'
    CASE (2, 3)
      WRITE(*,*) 'DEUX OU TROIS'
    CASE (4:9)
      WRITE(*,*) 'ENTRE 4 ET 9'
    CASE (10:)
      WRITE(*,*) '10 OU PLUS'
    CASE DEFAULT
      WRITE(*,*) 'AUTRE'
  END SELECT

  ! SELECT CASE sur caractere
  CH = 'B'
  SELECT CASE (CH)
    CASE ('A')
      WRITE(*,*) 'A'
    CASE ('B':'Z')
      WRITE(*,*) 'B A Z'
    CASE DEFAULT
      WRITE(*,*) 'AUTRE CARACTERE'
  END SELECT

  ! SELECT CASE sur logique
  BLOCK
    LOGICAL :: FLAG
    FLAG = .TRUE.
    SELECT CASE (FLAG)
      CASE (.TRUE.)
        WRITE(*,*) 'VRAI'
      CASE (.FALSE.)
        WRITE(*,*) 'FAUX'
    END SELECT
  END BLOCK

  ! SELECT CASE nomme
  OUTER: SELECT CASE (I)
    CASE (1:5) OUTER
      WRITE(*,*) 'PETIT'
    CASE DEFAULT OUTER
      WRITE(*,*) 'GRAND'
  END SELECT OUTER

END PROGRAM SELECTTEST
