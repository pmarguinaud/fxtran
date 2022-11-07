/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <limits.h>

#include "FXTRAN_MISC.h"
#include "FXTRAN_FIXED.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_STMT.h"
#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_OMP.h"
#include "FXTRAN_ACC.h"


#define fc_isspace(c) (((c) == ' ') || ((c) == '\t'))

#define FXTRAN_NEXT_CHAR                  \
  do {                                    \
    ci[i].column = c;                     \
    ci[i].line = l;                       \
    if (text[i] == '\n')                  \
      { l++; c = 0; }                     \
    else                                  \
      { c++; }                            \
    if ((!omp) && (!acc) & c       &&     \
        (ci[i].mask != FXTRAN_SPC) &&     \
        (ci[i].mask != FXTRAN_COM) &&     \
        (ci[i].mask != FXTRAN_OMD) &&     \
        (ci[i].mask != FXTRAN_ACC) &&     \
        (ci[i].mask != FXTRAN_MAL) &&     \
        (ci[i].mask != FXTRAN_OMC))       \
      {                                   \
        OMP = 0;                          \
        ACC = 0;                          \
      }                                   \
    i++;                                  \
  } while (0)



#define CASE_FXTRAN_HANDLE_NEW_LINE \
   case '\n':              \
     ci[i].mask = '\n';    \
     C = 0;                \
   break;


#define CASE_FXTRAN_SPACE \
	case ' ': case '\t'

#define CASE_FXTRAN_HANDLE_NEW_BANG \
   case '!':                                       \
     {                                             \
       int komp =                                  \
          ((strncmp (&text[i+1], "$ ", 2) == 0) || \
       (strncasecmp (&text[i+1], "$omp", 4) == 0)) \
	       &&  ctx->opts.openmp  ?             \
	   FXTRAN_handle_omp (text, ci, i, OMP)    \
	          : 0;                             \
       int kacc =                                  \
        (strncasecmp (&text[i+1], "$acc", 4) == 0) \
	       &&  ctx->opts.openacc  ?            \
	   FXTRAN_handle_acc (text, ci, i, ACC)    \
	          : 0;                             \
       if (komp != 0)                              \
         {                                         \
           komp--;                                 \
           for (; komp; komp--)                    \
             FXTRAN_NEXT_CHAR;                     \
           omp = 1;                                \
           OMP = 1;                                \
         }                                         \
       else if (kacc != 0)                         \
         {                                         \
           kacc--;                                 \
           for (; kacc; kacc--)                    \
             FXTRAN_NEXT_CHAR;                     \
           acc = 1;                                \
           ACC = 1;                                \
         }                                         \
       else                                        \
         {                                         \
           ci[i].mask = FXTRAN_COM;                \
           C = 1;                                  \
         }                                         \
     }                                             \
   break;


#define CASE_FXTRAN_QUOTE \
   case '"': case '\''

#define CASE_FXTRAN_F77CO \
	case '*': case 'C': case 'c' 

#define CASE_FXTRAN_DIGIT \
   case '0': case '1': case '2': \
   case '3': case '4': case '5': \
   case '6': case '7': case '8': \
   case '9'

#define CASE_FXTRAN_HANDLE_NEW_LABL \
   CASE_FXTRAN_DIGIT:               \
     {                                    \
       int i1 = i, i2, i3, j;             \
       /* lookahead; labels may contain spaces */  \
       for (i2 = i; i2 < len; i2++)       \
         {                                \
           if ((!isdigit (text[i2])) &&   \
               (text[i2] != ' '))         \
             break;                       \
           if (c + (i2 - i) > 5)          \
             break;                       \
         }                                \
       for (i3 = i2-1; i3 >= i1; i3--)    \
         {                                \
           if (text[i3-1] != ' ')         \
             break;                       \
         }                                \
       for (j = i1; j < i3-1; j++)        \
	 {                                \
           ci[i].mask = FXTRAN_LAB;       \
           FXTRAN_NEXT_CHAR;              \
         }                                \
        ci[i].mask = FXTRAN_LAB;          \
     }                                    \
   break;

#define CASE_FXTRAN_HANDLE_NEW_CPPD \
   case '#':               \
     {                                    \
       while (text[i+1] != '\n')          \
         {                                \
           ci[i].mask = FXTRAN_CPP;       \
           FXTRAN_NEXT_CHAR;              \
         }                                \
        ci[i].mask = FXTRAN_CPP;          \
     }                                    \
   break;

#define CASE_FXTRAN_HANDLE_NEW_OPTD \
   case '@':               \
     {                                    \
       while (text[i+1] != '\n')          \
         {                                \
           ci[i].mask = FXTRAN_OPT;       \
           FXTRAN_NEXT_CHAR;              \
         }                                \
        ci[i].mask = FXTRAN_OPT;          \
     }                                    \
   break;


#define DUMP_FXTRAN_MASK \
  do {                                              \
    int i, j;                                       \
    for (i = 0, j = 0; i < len; i++)                \
      {                                             \
        fprintf (stderr, "%c", text[i]);            \
        if (text[i] == '\n')                        \
          for (; j <= i; j++)                       \
            fprintf (stderr, "%c", ci[j].mask);     \
      }                                             \
  } while (0)                             

#define CLEANUP() \
  do {                                \
    free (ctx->text);                 \
    FXTRAN_char_info_free (&ctx->ci); \
    ctx->text = NULL;                 \
    ctx->ci = NULL;                   \
  } while (0)


void FXTRAN_FIXED_decode (FXTRAN_xmlctx * ctx)
{
  char * text = ctx->text;
  FXTRAN_char_info * ci;

  int len, i;

  char q = 0; /* quote when in string, 0 otherwise */
  char C = 0; /* true in comment */

  int c = 0;  /* column number */
  int l = 0;  /* line number */
  int OMP = 0;  /* true if we are in an OpenMP directive or statement */
  int omp = 0;  /* true if current line starts with an OpenMP sentinel */
  int ACC = 0;  /* true if we are in an OpenACC directive */
  int acc = 0;  /* true if current line starts with an OpenACC sentinel */


  len = strlen (text);

  FXTRAN_char_info_alloc (&ci, len);
  ctx->ci = ci;

  for (i = 0; i < len;)
    {

      if (C) /* comment */
        {
          switch (text[i])
            {
              CASE_FXTRAN_HANDLE_NEW_LINE;
              default:
	        ci[i].mask = FXTRAN_COM;
	      break;
            }
        }
      else if ((c >= ctx->opts.line_length) && 
	       ctx->opts.line_length && (text[i] != '\n'))
        {
          ci[i].mask = FXTRAN_MAR;
        }
      else if (c == 0) /* first char of margin */
        {
          switch (text[i])
            {
              CASE_FXTRAN_HANDLE_NEW_OPTD;
              CASE_FXTRAN_HANDLE_NEW_CPPD;
              CASE_FXTRAN_HANDLE_NEW_LINE;
              CASE_FXTRAN_F77CO:
	      CASE_FXTRAN_HANDLE_NEW_BANG;
              CASE_FXTRAN_HANDLE_NEW_LABL;
	      default:
                ci[i].mask = FXTRAN_MAL;
	      break;
            }
        }
      else if (c < 5) /* margin */
	{
          switch (text[i])
            {
              CASE_FXTRAN_HANDLE_NEW_LINE;
	      CASE_FXTRAN_HANDLE_NEW_BANG;
              CASE_FXTRAN_HANDLE_NEW_LABL;
              CASE_FXTRAN_SPACE:
                ci[i].mask = FXTRAN_MAL;
	      break;
	      default:
	      break;
            }
        }
      else if (c < 6) /* 6th column */
	{
          switch (text[i])
            {
              CASE_FXTRAN_HANDLE_NEW_LINE;
	      CASE_FXTRAN_HANDLE_NEW_BANG;
	      case '0':
	        ci[i].mask = FXTRAN_ZER;
	      break;
              CASE_FXTRAN_SPACE:
                if (q)
                  FXTRAN_ABORT ("Unterminated string");
                else
                  ci[i].mask = FXTRAN_MAL;
	      break;
	      default:
                ci[i].mask = FXTRAN_CO2;
	      break;
            }
        }
      else if (q)  /* string */
	{
          switch (text[i])
            {
	      CASE_FXTRAN_HANDLE_NEW_LINE;
              CASE_FXTRAN_QUOTE:
                if (q == text[i])
                  {
                    ci[i].mask = FXTRAN_STR;
                    q = 0;
                  }
                else 
                  {
                    ci[i].mask = FXTRAN_STR;
                  }
              break;
              default:
                ci[i].mask = FXTRAN_STR;
              break;
            }
        }
      else  /* code */
        {
          switch (text[i])
            {
	      CASE_FXTRAN_HANDLE_NEW_LINE;
	      CASE_FXTRAN_HANDLE_NEW_BANG;
              CASE_FXTRAN_QUOTE:
                 q = text[i];
                 ci[i].mask = FXTRAN_STR;
              break;
              CASE_FXTRAN_SPACE:
                ci[i].mask = FXTRAN_SPC;
	      break;
	      case ';':
	        ci[i].mask = FXTRAN_SMC;
              break;
              default:
	        ci[i].mask = FXTRAN_COD;
              break;
            }
	}

      FXTRAN_NEXT_CHAR;
    }
  

  FXTRAN_set_char_info_off (text, ci);

  if (ctx->opts.dump_mask)
    {
      DUMP_FXTRAN_MASK; 
      exit (0);
    }
  
  {
    FXTRAN_stmt_stack stack;

#define DUMP_FXTRAN_STMT \
    do {                                                           \
      FXTRAN_dump_fc_stmt (text, ci, i1, i2, ctx, &stack, label);  \
      label = 0;                                                   \
    } while (0)
#define DUMP_FXTRAN_STMT_CR \
    do {                              \
        if (cr)                       \
          {                           \
            if (i1 >= 0)              \
              {                       \
                DUMP_FXTRAN_STMT;     \
                i1 = INT_MIN;         \
              }                       \
            cr = 0;                   \
  	}                             \
    } while (0)
    

    int i1 = INT_MIN, i2 = INT_MIN;
    int cr = 0;
    int label = 0;

    FXTRAN_stmt_stack_init (&stack);

    for (i = 0; i < len; i++)
      {
        switch (ci[i].mask)
          {
            case FXTRAN_LAB:
              DUMP_FXTRAN_STMT_CR;
              c = text[i] == ' ' ? '0' : text[i];
              label = 10 * label + (c - '0');
            break;
            case FXTRAN_OMD:
            case FXTRAN_ACC:
            case FXTRAN_OMC:
            case FXTRAN_OPT:
            case FXTRAN_COM:
            case FXTRAN_MAR:
            case FXTRAN_ZER:
            case FXTRAN_MAL:
            case FXTRAN_CPP:
            case FXTRAN_SPC:
            break;
            case FXTRAN_CO2:
	      cr = 0;
            break;
    	    case FXTRAN_STR:
            case FXTRAN_COD:
              DUMP_FXTRAN_STMT_CR;
	      if (i1 < 0)
                i1 = i;
	      i2 = i;
            break;
            case FXTRAN_SMC:
	      if (i1 >= 0)
	        DUMP_FXTRAN_STMT;
	      i1 = INT_MIN;
            break;
            case '\n':
	      cr++;
            break;
            default:
              CLEANUP ();
	      FXTRAN_ABORT ("Unexpected mask value `%c'\n", ci[i].mask);
          }
      }
    if (i1 >= 0)
      DUMP_FXTRAN_STMT;
  }


  return;
}
