/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <string.h>
#include <ctype.h>

#include "FXTRAN_ACC.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_EXPR.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_ALPHA.h"

#define fc_isspace(c) (((c) == ' ') || ((c) == '\t'))

#define ACC_FXTRAN(t) \
  ((((t)[0] == 'A') || ((t)[0] == 'a')) && \
   (((t)[1] == 'C') || ((t)[1] == 'c')) && \
   (((t)[2] == 'C') || ((t)[2] == 'c')))

#define ACCS_FXTRAN(t) \
  (ACC_FXTRAN(t) && fc_isspace ((t)[3]))

#define CASE_FXTRAN_SPACE \
	case ' ': case '\t'

int FXTRAN_check_acc (const char * t, const FXTRAN_char_info * ci, int i1, int i2,
	              FXTRAN_xmlctx * ctx)
{
  int i;
  int ci0mask;

/* Find beginning of line */
  for (i = i1; i; i--)
    if (t[i-1] == '\n')
      break;

/* Goto first non white-space char */
  for (; fc_isspace (t[i]); i++);

  ci0mask = ci[i].mask;
  
  if (ci0mask == FXTRAN_ACC)
    {
      for (; i < i2+1; i++)
        if (ci[i].column == 0)
          {
            int ci1mask;
            int seencode = 0;

            /* Goto first non white-space char */
            for (; fc_isspace (t[i]); i++);

            ci1mask = ci[i].mask;

            for (; i < i2+1; i++)
              if (t[i] == '\n')
                break;
              else if ((ci[i].mask == FXTRAN_COD) || (ci[i].mask == FXTRAN_STR))
                seencode = 1;
            if (seencode && (ci1mask != ci0mask))
              FXTRAN_THROW ("Malformed OpenACC directive");
          } 
      return 2;
    }
  
 
  return 0;
}

int FXTRAN_handle_acc (const char * text, FXTRAN_char_info * ci, int i, int ACC)
{
  int acc = 0;

  if (text[i+1] == '$')
    {
      int j;
      acc = 1;
      for (j = i-1; j >= 0; j--)
        {
          switch (text[j])
            {
              case '\n':
                goto done;
              CASE_FXTRAN_SPACE:
              break;
              default:
                acc = 0;
		goto done;
            }
        }
    }
done:

  if (acc)
    {
      if ((ACCS_FXTRAN (text+i+2)) || (ACC && ACC_FXTRAN (text+i+2)))
        {
          ci[i+0].mask = FXTRAN_ACC;
          ci[i+1].mask = FXTRAN_ACC;
          ci[i+2].mask = FXTRAN_ACC;
          ci[i+3].mask = FXTRAN_ACC;
          ci[i+4].mask = FXTRAN_ACC;
          return 5;
	}
    }
  

  return 0;
}

static FXTRAN_accd_type get_FXTRAN_acc_type (const char * t)
{
#define test_macro(T) \
  do {                                    \
    int len = strlen (#T);                \
    if (strncmp (#T, t, len)==0)          \
      return FXTRAN_ACCD_##T;             \
  } while (0);

FXTRAN_accd_list(test_macro)
#undef test_macro

  return FXTRAN_ACCD_NONE;
}

static const char * accd_as_str (FXTRAN_accd_type type)
{
  switch (type) 
    {
      case FXTRAN_ACCD_ATOMIC                  :  return _T(_S(ATOMIC) H _S(OPENACC))                                       ;
      case FXTRAN_ACCD_CACHE                   :  return _T(_S(CACHE) H _S(OPENACC))                                        ;
      case FXTRAN_ACCD_DATA                    :  return _T(_S(DATA) H _S(OPENACC))                                         ;
      case FXTRAN_ACCD_DECLARE                 :  return _T(_S(DECLARE) H _S(OPENACC))                                      ;
      case FXTRAN_ACCD_ENDATOMIC               :  return _T(_S(END) H _S(ATOMIC) H _S(OPENACC))                             ;
      case FXTRAN_ACCD_ENDDATA                 :  return _T(_S(END) H _S(DATA) H _S(OPENACC))                               ;
      case FXTRAN_ACCD_ENDHOST_DATA            :  return _T(_S(END) H _S(HOST) H _S(DATA) H _S(OPENACC))                    ;
      case FXTRAN_ACCD_ENDKERNELSLOOP          :  return _T(_S(END) H _S(KERNELS) H _S(LOOP) H _S(OPENACC))                 ;
      case FXTRAN_ACCD_ENDKERNELS              :  return _T(_S(END) H _S(KERNELS) H _S(OPENACC))                            ;
      case FXTRAN_ACCD_ENDPARALLELLOOP         :  return _T(_S(END) H _S(PARALLEL) H _S(LOOP) H _S(OPENACC))                ;
      case FXTRAN_ACCD_ENDPARALLEL             :  return _T(_S(END) H _S(PARALLEL) H _S(OPENACC))                           ;
      case FXTRAN_ACCD_ENDSERIALLOOP           :  return _T(_S(END) H _S(SERIAL) H _S(LOOP) H _S(OPENACC))                  ;
      case FXTRAN_ACCD_ENDSERIAL               :  return _T(_S(END) H _S(SERIAL) H _S(OPENACC))                             ;
      case FXTRAN_ACCD_ENTERDATA               :  return _T(_S (ENTER) H _S(DATA) H _S(OPENACC))                            ;
      case FXTRAN_ACCD_EXITDATA                :  return _T(_S (EXIT) H _S(DATA) H _S(OPENACC))                             ;
      case FXTRAN_ACCD_HOST_DATA               :  return _T(_S(HOST) H _S(DATA) H _S(OPENACC))                              ;
      case FXTRAN_ACCD_INIT                    :  return _T(_S(INIT) H _S(OPENACC))                                         ;
      case FXTRAN_ACCD_KERNELSLOOP             :  return _T(_S(KERNELS) H _S(LOOP) H _S(OPENACC))                           ;
      case FXTRAN_ACCD_KERNELS                 :  return _T(_S(KERNELS) H _S(OPENACC))                                      ;
      case FXTRAN_ACCD_LOOP                    :  return _T(_S(LOOP) H _S(OPENACC))                                         ;
      case FXTRAN_ACCD_PARALLELLOOP            :  return _T(_S(PARALLEL) H _S(LOOP) H _S(OPENACC))                          ;
      case FXTRAN_ACCD_PARALLEL                :  return _T(_S(PARALLEL) H _S(OPENACC))                                     ;
      case FXTRAN_ACCD_ROUTINE                 :  return _T(_S(ROUTINE) H _S(OPENACC))                                      ;
      case FXTRAN_ACCD_SERIALLOOP              :  return _T(_S(SERIAL) H _S(LOOP) H _S(OPENACC))                            ;
      case FXTRAN_ACCD_SERIAL                  :  return _T(_S(SERIAL) H _S(OPENACC))                                       ;
      case FXTRAN_ACCD_SET                     :  return _T(_S(SET) H _S(OPENACC))                                          ;
      case FXTRAN_ACCD_SHUTDOWN                :  return _T(_S(SHUTDOWN) H _S(OPENACC))                                     ;
      case FXTRAN_ACCD_UPDATE                  :  return _T(_S(UPDATE) H _S(OPENACC))                                       ;
      case FXTRAN_ACCD_WAIT                    :  return _T(_S(WAIT) H _S(OPENACC))                                         ;
      case FXTRAN_ACCD_NONE:
      case FXTRAN_ACCD_LAST:
      default:
      break;
   }
  return NULL;
}

static int FXTRAN_acc_expr (const char * t, const FXTRAN_char_info * ci, 
		            FXTRAN_xmlctx * ctx, int optional, int list,
                            int prefix, int star, int seenpar, 
                            const char * list_tag)
{
  const char * T = t;
  int k, l;

  if ((t[0] == '(') || seenpar)
    {
      if (! seenpar)
        XAD(1);
      if (prefix == 1)
        {
          k = FXTRAN_eat_word (t);
          if (t[k] == ':')
            XAD (k+1);
        }

      if (list)
        {
          XST (list_tag ? list_tag : _T(_S(EXPR) H _S(LIST)));
          while (1)
            {
              if (prefix == 2)
                {
                  k = FXTRAN_eat_word (t);
                  if (t[k] == ':')
                    XAD (k+1);
                }
              k = FXTRAN_str_at_level (t, ci, ")", 0);
              l = FXTRAN_str_at_level_ir (t, ci, ",", 1, k);
              if (l == 0)
                break;
              if (star && (t[0] == '*'))
                {
                  XST (_S (SIZE));
                  XAD (1);
                  XET ();
                }
              else
                {
                  FXTRAN_expr (t, ci, l-1, ctx);
                  XAD(l);
                }
            }
          if (star && (t[0] == '*'))
            {
              XST (_S (SIZE));
              XAD (1);
              XET ();
            }
          else
            {
              FXTRAN_expr (t, ci, k-1, ctx);
              XAD(k-1);
            }
          XET();
          if (t[0] != ')')
            FXTRAN_THROW ("Malformed OpenACC clause");
          XAD(1);
        }
      else
        {
          if (prefix == 2)
            {
              k = FXTRAN_eat_word (t);
              if (t[k] == ':')
                XAD (k+1);
            }
          k = FXTRAN_str_at_level (t, ci, ")", 0);
          if (star && (t[0] == '*'))
            {
              XST (_S (SIZE));
              XAD (1);
              XET ();
            }
          else
            {
              FXTRAN_expr (t, ci, k-1, ctx);
              XAD(k-1);
            }
          if (t[0] != ')')
            FXTRAN_THROW ("Malformed OpenACC clause");
          XAD(1);
        }

    }
  else if (! optional)
    {
      FXTRAN_THROW ("Malformed OpenACC clause");
    }

  return t - T;
}

static int FXTRAN_acc_DEVICE_TYPE (const char * t, const FXTRAN_char_info * ci, 
		                   FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] == '(')
    {
      XAD (1);
      if (t[0] == '*')
        {
          XAD (1);
          if (t[0] != ')')
            FXTRAN_THROW ("Malformed OpenACC clause");
          XAD (1);
        }
      else
        {
          XST (_T(_S(DEVICE) H _S(LIST)));
          while (1)
            {
              k = FXTRAN_eat_word (t);
              if (k == 0)
                break;
              XST (_S(DEVICE) H _S(NAME));
              XAD (k);
              XET ();
              if (t[0] == ',')
                XAD (1);
            }
          XET();
          if (t[0] != ')')
            FXTRAN_THROW ("Malformed OpenACC clause");
          XAD(1);
        }
    }

  XET ();

  return t - T;
}

static int FXTRAN_acc_DTYPE (const char * t, const FXTRAN_char_info * ci, 
		             FXTRAN_xmlctx * ctx)
{
  return FXTRAN_acc_DEVICE_TYPE (t, ci, ctx);
}

static int FXTRAN_acc_REDUCTION (const char * t, const FXTRAN_char_info * ci, 
		                 FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k, kp, kn;
  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed OpenACC clause; expected `('");
  
  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  if (k == 0)
    FXTRAN_THROW ("Malformed OpenACC clause; expected `:'");

  if ((kn = FXTRAN_eat_word (t)))
    {
      XNT (_T(_S(PROCEDURE) H _S(NAME)), kn);
      XAD(kn);
    }
  else
    {
      XNO (_T(_S(OPERATOR)), k-1);
      XAD(k-1);
    }

  if (t[0] != ':')
    FXTRAN_THROW ("Malformed OpenACC clause; expected `:'");
  XAD(1);

  k = FXTRAN_acc_expr (t, ci, ctx, 0, 1, 0, 0, 1, NULL);
  XAD (k);

  XET ();
  return t - T;
}

static int FXTRAN_acc_expr_clause (const char * t, const char * name, const FXTRAN_char_info * ci, 
		                   FXTRAN_xmlctx * ctx, int optional, int list,
                                   int prefix, int star, const char * list_tag)
{
  const char * T = t;
  int k;
  k = strlen (name);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  k = FXTRAN_acc_expr (t, ci, ctx, optional, list, prefix, star, 0, list_tag);

  XAD(k);

  XET ();

  return t - T;
}

static int FXTRAN_acc_DEFAULT (const char * t, const FXTRAN_char_info * ci, 
		               FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] == '(')
    {
      XAD(1);
      k = FXTRAN_eat_word (t);
      XAD (k);
      XAD (1);
    }

  XET ();

  return t - T;
}

static int FXTRAN_acc_WAIT_arg (const char * t, const FXTRAN_char_info * ci,  
		                FXTRAN_xmlctx * ctx)                          
{                                                                           
  const char * T = t;
  int i, n, k;

  if (t[0] == '(')
    {
    
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      
      for (i = 0, n = 0; i < k; i++)
        if (t[i] == ':')
          n++;
  
      XAD(1);

      if (n <= 3)
        {
          if (n >= 1)
            {
              k = FXTRAN_eat_word (t);
              XAD(k);
              if (t[0] != ':')
                FXTRAN_THROW ("Malformed OpenACC directive");
              XAD(1);
            }
          if (n >= 2)
            {
              k = FXTRAN_str_at_level (t, ci, ":", 1);
              FXTRAN_expr (t, ci, k-1, ctx);
              XAD(k);
            }
          if (n >= 3)
            {
              k = FXTRAN_eat_word (t);
              XAD(k);
              if (t[0] != ':')
                FXTRAN_THROW ("Malformed OpenACC directive");
              XAD(1);
            }
          k = FXTRAN_acc_expr (t, ci, ctx, 0, 1, 0, 0, 1, NULL);
          XAD(k);
        }
      else
        {
          FXTRAN_THROW ("Malformed OpenACC directive");
        }
    }

  return t - T;
}

static int FXTRAN_acc_WAIT (const char * t, const FXTRAN_char_info * ci, 
		            FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  k = FXTRAN_acc_WAIT_arg (t, ci, ctx);
  XAD (k);
  XET ();

  return t - T;
}

static int FXTRAN_acc_BIND (const char * t, const FXTRAN_char_info * ci, 
		            FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed OpenACC clause");

  XAD (1);

  if (isalpha (t[0]))
    {
      k = FXTRAN_eat_word (t);
      XNT (_T(_S(NAME)), k);
      XAD (k);
    }
  else
    {
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD (k-1);
    }
  
  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenACC clause");

  XAD (1);

  XET ();

  return t - T;
}

static int FXTRAN_acc_simple (const char * t, const char * C, const FXTRAN_char_info * ci, 
		              FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = strlen (C);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();
  XET ();
  return t - T;
}

static int FXTRAN_acc_TILE (const char * t, const FXTRAN_char_info * ci, 
		            FXTRAN_xmlctx * ctx)                         
{                                                                       
  return FXTRAN_acc_expr_clause (t, "TILE", ci, ctx, 0, 1, 0, 1, 
                                 _T (_S(SIZE) H _S(EXPR) H _S(LIST)));                     
}

#define def_FXTRAN_acc_simple(T) \
static int FXTRAN_acc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_acc_simple (t, #T, ci, ctx);                            \
}

#define def_FXTRAN_acc_expr(T) \
static int FXTRAN_acc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_acc_expr_clause (t, #T, ci, ctx, 0, 0, 0, 0, NULL);     \
}

#define def_FXTRAN_acc_optional_expr(T) \
static int FXTRAN_acc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_acc_expr_clause (t, #T, ci, ctx, 1, 0, 0, 0, NULL);     \
}

#define def_FXTRAN_acc_prefix_expr_list(T,N) \
static int FXTRAN_acc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_acc_expr_clause (t, #T, ci, ctx, 0, 1, 1, 0, N);        \
}

#define def_FXTRAN_acc_expr_list(T,N) \
static int FXTRAN_acc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_acc_expr_clause (t, #T, ci, ctx, 0, 1, 0, 0, N);        \
}

#define def_FXTRAN_acc_optional_expr_list(T) \
static int FXTRAN_acc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_acc_expr_clause (t, #T, ci, ctx, 1, 1, 0, 0, NULL);     \
}

#define def_FXTRAN_acc_optional_prefix_expr(T) \
static int FXTRAN_acc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_acc_expr_clause (t, #T, ci, ctx, 1, 0, 2, 0, NULL);     \
}

def_FXTRAN_acc_expr (DEFAULT_ASYNC)
def_FXTRAN_acc_expr_list (LINK, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_expr_list (DEVICE_RESIDENT, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_expr (DEVICE_NUM)
def_FXTRAN_acc_optional_expr (ASYNC)
def_FXTRAN_acc_expr (NUM_GANGS)
def_FXTRAN_acc_expr (NUM_WORKERS)
def_FXTRAN_acc_expr (VECTOR_LENGTH)
def_FXTRAN_acc_expr (IF)
def_FXTRAN_acc_expr (COLLAPSE)
def_FXTRAN_acc_optional_expr (SELF)
def_FXTRAN_acc_expr_list (COPY, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_expr_list (DEVICE, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_expr_list (HOST, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (COPYIN, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (COPYOUT, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (CREATE, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (NO_CREATE, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (PRESENT, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (DEVICEPTR, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (ATTACH, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (PRIVATE, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (FIRSTPRIVATE, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (DETACH, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (DELETE, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_prefix_expr_list (USE_DEVICE, _T (_S(VARIABLE) H _S(LIST)))
def_FXTRAN_acc_simple (FINALIZE)
def_FXTRAN_acc_simple (NOHOST)
def_FXTRAN_acc_simple (SEQ)
def_FXTRAN_acc_simple (INDEPENDENT)
def_FXTRAN_acc_simple (AUTO)
def_FXTRAN_acc_simple (IF_PRESENT)
def_FXTRAN_acc_optional_prefix_expr (WORKER)
def_FXTRAN_acc_optional_prefix_expr (VECTOR)
def_FXTRAN_acc_optional_prefix_expr (GANG)

static void accd_clause_list (const char * t, const FXTRAN_char_info * ci, 
		              FXTRAN_xmlctx * ctx)
{
  int len;
  int k;

  while (t[0])
    {
      k = 0;
#define test_macro(T) \
    len = strlen (#T);      \
    if (strncmp (#T, t, len) == 0)      \
      {                                 \
        k = FXTRAN_acc_##T(t, ci, ctx); \
        XAD(k);                         \
      }
      FXTRAN_accc_list(test_macro)
#undef test_macro

      if (k == 0)
        FXTRAN_THROW ("Unknown OpenACC clause");

    }
}

static void accd_ROUTINE_extra (const char * t, const FXTRAN_char_info * ci,  
		              FXTRAN_xmlctx * ctx)                          
{                                                                           
  int k;
  XAD(7);                                                                   
  if (t[0] == '(')
    {
      XAD(1);
      k = FXTRAN_eat_word (t);
      XNT (_T(_S(NAME)), k);
      XAD (k);
      if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenACC directive");
      XAD(1);
    }
  return accd_clause_list (t, ci, ctx);                                     
}

static void accd_CACHE_extra (const char * t, const FXTRAN_char_info * ci,  
		              FXTRAN_xmlctx * ctx)                          
{                                                                           
  XAD(5);                                                                   
  FXTRAN_acc_expr (t, ci, ctx, 1, 1, 1, 0, 0, NULL);
}

static void accd_ATOMIC_extra (const char * t, const FXTRAN_char_info * ci,  
		               FXTRAN_xmlctx * ctx)                          
{                                                                           
  int k;
  XAD(5);                                                                   

  if (t[0])
    {
      k = FXTRAN_eat_word (t);
      XAD (k);
    }
}

static void accd_WAIT_extra (const char * t, const FXTRAN_char_info * ci,  
		             FXTRAN_xmlctx * ctx)                          
{                                                                           
  int k;
  XAD(4);                                                                   

  k = FXTRAN_acc_WAIT_arg (t, ci, ctx);
  XAD(k);

  return accd_clause_list (t, ci, ctx);                                     
}


#define def_accd_extra_clause_list(T) \
static void accd_##T##_extra (const char * t, const FXTRAN_char_info * ci,  \
		              FXTRAN_xmlctx * ctx)                          \
{                                                                           \
  int k = strlen (#T);                                                      \
  XAD(k);                                                                   \
  return accd_clause_list (t, ci, ctx);                                     \
}

def_accd_extra_clause_list (DATA)
def_accd_extra_clause_list (DECLARE)
def_accd_extra_clause_list (ENDATOMIC)
def_accd_extra_clause_list (ENDDATA)
def_accd_extra_clause_list (ENDHOST_DATA)
def_accd_extra_clause_list (ENDKERNELS)
def_accd_extra_clause_list (ENDKERNELSLOOP)
def_accd_extra_clause_list (ENDPARALLEL)
def_accd_extra_clause_list (ENDPARALLELLOOP)
def_accd_extra_clause_list (ENDSERIAL)
def_accd_extra_clause_list (ENDSERIALLOOP)
def_accd_extra_clause_list (ENTERDATA)
def_accd_extra_clause_list (EXITDATA)
def_accd_extra_clause_list (HOST_DATA)
def_accd_extra_clause_list (INIT)
def_accd_extra_clause_list (KERNELS)
def_accd_extra_clause_list (KERNELSLOOP)
def_accd_extra_clause_list (LOOP)
def_accd_extra_clause_list (PARALLEL)
def_accd_extra_clause_list (PARALLELLOOP)
def_accd_extra_clause_list (SERIAL)
def_accd_extra_clause_list (SERIALLOOP)
def_accd_extra_clause_list (SET)
def_accd_extra_clause_list (SHUTDOWN)
def_accd_extra_clause_list (UPDATE)

void FXTRAN_dump_accd (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int k = strlen (t);
  FXTRAN_accd_type type = get_FXTRAN_acc_type (t);
  const char * str = type == FXTRAN_ACCD_NONE ? _T(_S(BROKEN) H _S(OPENACC)) : accd_as_str (type);

  XST (str);

#define case_macro(T) \
  case FXTRAN_ACCD_##T: accd_##T##_extra (t, ci, ctx); break;

  switch (type)
    {
      FXTRAN_accd_list(case_macro)
      default:
      break;
    }
#undef case_macro

  if (type == FXTRAN_ACCD_NONE)
    XAD(k);
  else
    XAD(strlen (t));

  XET ();

}


