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

#include "FXTRAN_FREE.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_STMT.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_OMP.h"
#include "FXTRAN_ACC.h"
#include "FXTRAN_DDD.h"


static int fixup_fc_label (const char * text, FXTRAN_char_info * ci, int i1, int i2)
{
  int i;
  int label = 0;
  for (i = i1; i <= i2; i++)
    if (isdigit (text[i]))
      {
        ci[i].mask = FXTRAN_LAB;
	label = 10 * label + (text[i] - '0');
      }
    else
      break;
  return label;
}

#define fc_isspace(c) (((c) == ' ') || ((c) == '\t'))

#define FXTRAN_NEXT_CHAR \
  do {                                   \
    ci[i].column = c;                    \
    ci[i].line = l;                      \
    if (text[i] == '\n')                 \
      {                                  \
        l++; c = 0;                      \
      }                                  \
    else                                 \
      {                                  \
        c++;                             \
      }                                  \
   if (c == 0)                           \
     {                                   \
       omp = 0;                          \
       acc = 0;                          \
       ddd = 0;                          \
       S = 1;                            \
     }                                   \
   else                                  \
     {                                   \
       S = S && (fc_isspace (text[i]));  \
     }                                   \
   if ((!omp) && (!acc) && (!ddd) && c   \
    && (ci[i].mask != FXTRAN_SPC)        \
    && (ci[i].mask != FXTRAN_COM)        \
    && (ci[i].mask != FXTRAN_OMD)        \
    && (ci[i].mask != FXTRAN_ACC)        \
    && (ci[i].mask != FXTRAN_OMC))       \
     {                                   \
       OMP = 0;                          \
       ACC = 0;                          \
       DDD = 0;                          \
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
       int komp = ctx->opts.openmp &&              \
     ((strncmp (&text[i+1], "$ ", 2) == 0)         \
   || (strncmp (&text[i+1], "$&", 2) == 0)         \
   || (strncasecmp (&text[i+1], "$omp ", 5) == 0)  \
   || (strncasecmp (&text[i+1], "$omp&", 5) == 0)) \
	 ? FXTRAN_handle_omp (text, ci, i, OMP)    \
	          : 0;                             \
       int kacc =  ctx->opts.openacc &&            \
     ((strncasecmp (&text[i+1], "$acc ", 5) == 0)  \
   || (strncasecmp (&text[i+1], "$acc&", 5) == 0)) \
	 ? FXTRAN_handle_acc (text, ci, i, ACC)    \
	          : 0;                             \
       int kddd =  ctx->opts.directive &&          \
     ((strncasecmp (&text[i+1], ctx->opts.directive_st, ctx->opts.directive_ln) == 0)  \
   || (strncasecmp (&text[i+1], ctx->opts.directive_ct, ctx->opts.directive_ln) == 0)) \
	 ? FXTRAN_handle_ddd (text, ci, i, DDD, &ctx->opts)                            \
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
           ACC = 1;                                \
           acc = 1;                                \
         }                                         \
       else if (kddd != 0)                         \
         {                                         \
           kddd--;                                 \
           for (; kddd; kddd--)                    \
             FXTRAN_NEXT_CHAR;                     \
           DDD = 1;                                \
           ddd = 1;                                \
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

#define CASE_FXTRAN_DIGIT \
   case '0': case '1': case '2': \
   case '3': case '4': case '5': \
   case '6': case '7': case '8': \
   case '9'

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
  do {                                 \
    free (ctx->text);                  \
    FXTRAN_char_info_free (&ctx->ci);  \
    ctx->text = NULL;                  \
    ctx->ci = NULL;                    \
  } while (0)

void FXTRAN_FREE_decode (FXTRAN_xmlctx * ctx)
{
  char * text = ctx->text;
  FXTRAN_char_info * ci;

  int len, i;

  /* string flags are handled directly in the code */
  char Q   = 0; /* quote when in continuated string */
  char q   = 0; /* quote when in string, 0 otherwise */

  /* C is handled by CASE_FXTRAN_HANDLE_NEW_LINE and CASE_FXTRAN_HANDLE_NEW_BANG */
  char C   = 0; /* true in comment */

  /* the following flags are handled by FXTRAN_NEXT_CHAR */
  char S   = 1; /* true if only space was seen since beginning of line */
  char OMP = 0; /* true if inside OMP directive or statement */
  char omp = 0; /* true if current line starts with OMP sentinel */
  char ACC = 0; /* true if inside ACC directive */
  char acc = 0; /* true if current line starts with ACC sentinel */
  char DDD = 0;
  char ddd = 0;

  int c    = 0;  /* column number */
  int l    = 0;  /* line number */


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
      else if (q)  /* string */
	{
          switch (text[i])
            {
	      case '\n':
		FXTRAN_THROW ("Unterminated character constant at (%d,%d)\n", l+1, c+1);
              break;
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
	      case '&':
                {
	          /* lookahead (other characters?) */

                  int j, e;
		  e = 1;
		  for (j = i+1; (j < len) && (text[j] != '\n'); j++)
                    {
                      e = e && (fc_isspace (text[j]));
		      if (!e)
                        break;
                    }

		  if (e) /* empty line after & */
                    {
		      ci[i].mask = FXTRAN_CO1;
                      Q = q;
		      q = 0;
                    }
		  else
                    {
                      ci[i].mask = FXTRAN_STR;
		    }

                }
              break;
              default:
                ci[i].mask = FXTRAN_STR;
              break;
            }
        }
      else if (Q) /* continuated string */
        {
          switch (text[i])
            {
              CASE_FXTRAN_HANDLE_NEW_CPPD;
	      CASE_FXTRAN_HANDLE_NEW_LINE;
	      CASE_FXTRAN_HANDLE_NEW_BANG;
              CASE_FXTRAN_QUOTE:
	        if (Q == text[i])
                  {
                    ci[i].mask = FXTRAN_STR;
		    Q = 0;
		  }
		else
                  {
                    q = Q;
		    Q = 0;
                    ci[i].mask = FXTRAN_STR;
		  }
              break;
              CASE_FXTRAN_SPACE:
                ci[i].mask = FXTRAN_SPC;
	      break;
	      case '&':
		ci[i].mask = FXTRAN_CO2;
                q = Q;
                Q = 0;
              break;
              default:
	        ci[i].mask = FXTRAN_STR;
		q = Q;
		Q = 0;
              break;
            }
        }
      else  /* code */
        {
          switch (text[i])
            {
              CASE_FXTRAN_HANDLE_NEW_CPPD;
	      CASE_FXTRAN_HANDLE_NEW_LINE;
	      CASE_FXTRAN_HANDLE_NEW_BANG;
	      CASE_FXTRAN_HANDLE_NEW_OPTD;
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
	      case '&':
	        if (S)
                  {
		    ci[i].mask = FXTRAN_CO2;
                  }
		else
                  {
		    ci[i].mask = FXTRAN_CO1;
		  }
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
  do {                                                                \
      if (i1 >= 0)                                                    \
        {                                                             \
          int label = fixup_fc_label (text, ci, i1, i2);              \
          FXTRAN_dump_fc_stmt (text, ci, i1, i2, ctx, &stack, label); \
        }                                                             \
      i1 = INT_MIN; sc = 0;                                                \
  } while (0)
#define GOTO_FXTRAN_COD \
    do { while ((ci[i+1].mask != FXTRAN_COD) && (ci[i+1].mask != FXTRAN_STR)) { i++; if (i > len) FXTRAN_ABORT ("End of file"); } } while (0)

    int sc = 0;
    int i1 = INT_MIN, i2 = INT_MIN;

    FXTRAN_stmt_stack_init (&stack); 

    for (i = 0; i < len; i++)
      {
        switch (ci[i].mask)
          {
            case FXTRAN_LAB:
            case FXTRAN_OMD:
            case FXTRAN_ACC:
            case FXTRAN_DDD:
            case FXTRAN_OPT:
            case FXTRAN_CPP:
            case FXTRAN_COM:
            case FXTRAN_MAR:
            case FXTRAN_OMC:
            case FXTRAN_SPC:
	    case FXTRAN_CO2:
            break;
            case FXTRAN_CO1:
	      GOTO_FXTRAN_COD;
            break;
    	    case FXTRAN_STR:
            case FXTRAN_COD:
	      if (i1 < 0)
                i1 = i;
	      i2 = i;
	      sc++;
            break;
            case FXTRAN_SMC:
	      DUMP_FXTRAN_STMT;
            break;
            case '\n':
	      if (sc)
                DUMP_FXTRAN_STMT;
            break;
            default:
              CLEANUP ();
              FXTRAN_ABORT ("Unexpected mask value `%c'\n", ci[i].mask);
          }
      }
   
    FXTRAN_final_check_stack_empty (ctx, &stack);

  }


}
