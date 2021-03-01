/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <string.h>

#include "FXTRAN_OMP.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_EXPR.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_ALPHA.h"

#define fc_isspace(c) (((c) == ' ') || ((c) == '\t'))

#define OMP_FXTRAN(t) \
  ((((t)[0] == 'O') || ((t)[0] == 'o')) && \
   (((t)[1] == 'M') || ((t)[1] == 'm')) && \
   (((t)[2] == 'P') || ((t)[2] == 'p')))

#define OMPS_FXTRAN(t) \
  (OMP_FXTRAN(t) && fc_isspace ((t)[3]))

#define CASE_FXTRAN_SPACE \
	case ' ': case '\t'

int FXTRAN_check_omp (const char * t, const FXTRAN_char_info * ci, int i1, int i2,
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
  
  if ((ci0mask == FXTRAN_OMD) || (ci0mask == FXTRAN_OMC))
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
              FXTRAN_THROW ("Malformed OpenMP statement or directive");
          } 
      return ci0mask == FXTRAN_OMC ? 1 : 2;
    }
  
 
  return 0;
}

int FXTRAN_handle_omp (const char * text, FXTRAN_char_info * ci, int i, int OMP)
{
  int omp = 0;

  if (text[i+1] == '$')
    {
      int j;
      omp = 1;
      for (j = i-1; j >= 0; j--)
        {
          switch (text[j])
            {
              case '\n':
                goto done;
              CASE_FXTRAN_SPACE:
              break;
              default:
                omp = 0;
		goto done;
            }
        }
    }
done:

  if (omp)
    {
      if ((OMPS_FXTRAN (text+i+2)) || (OMP && OMP_FXTRAN (text+i+2)))
        {
          ci[i+0].mask = FXTRAN_OMD;
          ci[i+1].mask = FXTRAN_OMD;
          ci[i+2].mask = FXTRAN_OMD;
          ci[i+3].mask = FXTRAN_OMD;
          ci[i+4].mask = FXTRAN_OMD;
          return 5;
	}
      else if ((text[i+2] == ' ') || OMP)
        {
          ci[i+0].mask = FXTRAN_OMC;
          ci[i+1].mask = FXTRAN_OMC;
          return 2;
	}
    }
  

  return 0;
}

static FXTRAN_ompd_type get_FXTRAN_omp_type (const char * t)
{
#define test_macro(T) \
  do {                                    \
    int len = strlen (#T);                \
    if (strncmp (#T, t, len)==0)          \
      return FXTRAN_OMPD_##T;             \
  } while (0);

FXTRAN_ompd_list(test_macro)
#undef test_macro

  return FXTRAN_OMPD_NONE;
}

static const char * ompd_as_str (FXTRAN_ompd_type type)
{
  switch (type) 
    {
      case FXTRAN_OMPD_PARALLELDO              :  return _T(_S(PARALLEL) H _S(DO) H _S(OPENMP))                            ;
      case FXTRAN_OMPD_ENDPARALLELDO           :  return _T(_S(END) H _S(PARALLEL) H _S(DO) H _S(OPENMP))                  ;
      case FXTRAN_OMPD_PARALLELSECTIONS        :  return _T(_S(PARALLEL) H _S(SECTIONS) H _S(OPENMP))                      ;
      case FXTRAN_OMPD_ENDPARALLELSECTIONS     :  return _T(_S(END) H _S(PARALLEL) H _S(SECTIONS) H _S(OPENMP))            ;
      case FXTRAN_OMPD_PARALLELWORKSHARE       :  return _T(_S(PARALLEL) H _S(WORK) H _S(SHARE) H _S(OPENMP))              ;
      case FXTRAN_OMPD_ENDPARALLELWORKSHARE    :  return _T(_S(END) H _S(PARALLEL) H _S(WORK) H _S(SHARE) H _S(OPENMP))    ;
      case FXTRAN_OMPD_DO                      :  return _T(_S(DO) H _S(OPENMP))                                           ;
      case FXTRAN_OMPD_ENDDO                   :  return _T(_S(END) H _S(DO) H _S(OPENMP))                                 ;
      case FXTRAN_OMPD_SINGLE                  :  return _T(_S(SINGLE) H _S(OPENMP))                                       ;
      case FXTRAN_OMPD_ENDSINGLE               :  return _T(_S(END) H _S(SINGLE) H _S(OPENMP))                             ;
      case FXTRAN_OMPD_WORKSHARE               :  return _T(_S(WORK) H _S(SHARE) H _S(OPENMP))                             ;
      case FXTRAN_OMPD_ENDWORKSHARE            :  return _T(_S(END) H _S(WORK) H _S(SHARE) H _S(OPENMP))                   ;
      case FXTRAN_OMPD_SECTIONS                :  return _T(_S(SECTIONS) H _S(OPENMP))                                     ;
      case FXTRAN_OMPD_ENDSECTIONS             :  return _T(_S(END) H _S(SECTIONS) H _S(OPENMP))                           ;
      case FXTRAN_OMPD_ATOMIC                  :  return _T(_S(ATOMIC) H _S(OPENMP))                                       ;
      case FXTRAN_OMPD_CRITICAL                :  return _T(_S(CRITICAL) H _S(OPENMP))                                     ;
      case FXTRAN_OMPD_ENDCRITICAL             :  return _T(_S(END) H _S(CRITICAL) H _S(OPENMP))                           ;
      case FXTRAN_OMPD_ORDERED                 :  return _T(_S(ORDERED) H _S(OPENMP))                                      ;
      case FXTRAN_OMPD_ENDORDERED              :  return _T(_S(END) H _S(ORDERED) H _S(OPENMP))                            ;
      case FXTRAN_OMPD_PARALLEL                :  return _T(_S(PARALLEL) H _S(OPENMP))                                     ;
      case FXTRAN_OMPD_ENDPARALLEL             :  return _T(_S(END) H _S(PARALLEL) H _S(OPENMP))                           ;
      case FXTRAN_OMPD_FLUSH                   :  return _T(_S(FLUSH) H _S(OPENMP))                                        ;
      case FXTRAN_OMPD_THREADPRIVATE           :  return _T(_S(THREAD) H _S(PRIVATE) H _S(OPENMP))                         ;
      case FXTRAN_OMPD_MASTER                  :  return _T(_S(MASTER) H _S(OPENMP))                                       ;
      case FXTRAN_OMPD_ENDMASTER               :  return _T(_S(END) H _S(MASTER) H _S(OPENMP))                             ;
      case FXTRAN_OMPD_NONE:
      case FXTRAN_OMPD_LAST:
      break;
   }
  return NULL;
}

static int FXTRAN_omc_REDUCTION (const char * t, const FXTRAN_char_info * ci, 
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
    FXTRAN_THROW ("Malformed OpenMP clause; expected `('");
  
  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  if (k == 0)
    FXTRAN_THROW ("Malformed OpenMP clause; expected `:'");

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
    FXTRAN_THROW ("Malformed OpenMP clause; expected `:'");
  XAD(1);

  XST (_S(VARIABLE) H _S(LIST));
  while (t[0] != ')')
    {
      kn = FXTRAN_eat_word (t);
      XNT (_T(_S(VARIABLE)), kn);
      XAD(kn);
      if (t[0] == ',')
        XAD(1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenMP clause");
    }
  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP clause; expected `)'");
  XAD(1);


  XET ();
  return t - T;
}

static int FXTRAN_omc_list (const char * t, const FXTRAN_char_info * ci, 
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
    FXTRAN_THROW ("Malformed OpenMP clause");
  
  XAD(1);

  XST (_S(VARIABLE) H _S(NAME));
  while (t[0] != ')')
    {
      k = FXTRAN_eat_word (t);
      XNT (_T(_S(NAME)), k);
      XAD(k);
      if (t[0] == ',')
        XAD(1);
    }
  XET ();

  XAD(1);

  XET ();

  return t - T;
}

static int FXTRAN_omc_expr (const char * t, const FXTRAN_char_info * ci, 
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
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      XAD(1);
      FXTRAN_expr (t, ci, k-2, ctx);
      XAD(k-1);
    }

  XET ();

  return t - T;
}

static int FXTRAN_omc_SCHEDULE (const char * t, const FXTRAN_char_info * ci, 
		                FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k, kp;
  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed OpenMP clause");
  XAD(1);

  k = FXTRAN_eat_word (t);

  if (k == 0)
    FXTRAN_THROW ("Malformed OpenMP clause");

  XST (_T(_S(TYPE)));
  XAD(k);
  XET ();

  if (t[0] == ',')
    {
      XAD(1);
      XST (_T(_S(CHUNK) H _S(SIZE)));
      kp = FXTRAN_str_at_level (t, ci, ")", 0);
      FXTRAN_expr (t, ci, kp-1, ctx);
      XAD(kp-1);
      XET ();
    }

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP clause");
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omc_ktype (const char * t, const FXTRAN_char_info * ci, 
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
    FXTRAN_THROW ("Malformed OpenMP clause");

  t++;

  k = FXTRAN_eat_word (t);

  if (k == 0)
    FXTRAN_THROW ("Malformed OpenMP clause");

  XST (_T(_S(TYPE)));
  XAD(k);
  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP clause");

  t++;

  XET ();
  return t - T;
}

static int FXTRAN_omc_simple (const char * t, const char * C, const FXTRAN_char_info * ci, 
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

#define def_FXTRAN_omc_simple(T) \
static int FXTRAN_omc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_omc_simple (t, #T, ci, ctx);                            \
}

#define def_FXTRAN_omc_ktype(T) \
static int FXTRAN_omc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_omc_ktype (t, ci, ctx);                                 \
}

#define def_FXTRAN_omc_expr(T) \
static int FXTRAN_omc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_omc_expr (t, ci, ctx);                                  \
}

#define def_FXTRAN_omc_list(T) \
static int FXTRAN_omc_##T (const char * t, const FXTRAN_char_info * ci, \
		           FXTRAN_xmlctx * ctx)                         \
{                                                                       \
  return FXTRAN_omc_list (t, ci, ctx);                                  \
}

def_FXTRAN_omc_simple (NOWAIT)
def_FXTRAN_omc_simple (ORDERED)

def_FXTRAN_omc_ktype (DEFAULT)

def_FXTRAN_omc_expr (IF)
def_FXTRAN_omc_expr (NUM_THREADS)

def_FXTRAN_omc_list (COPYIN)
def_FXTRAN_omc_list (FIRSTPRIVATE)
def_FXTRAN_omc_list (LASTPRIVATE)
def_FXTRAN_omc_list (PRIVATE)
def_FXTRAN_omc_list (COPYPRIVATE)
def_FXTRAN_omc_list (SHARED)

static void ompd_clause_list (const char * t, const FXTRAN_char_info * ci, 
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
        k = FXTRAN_omc_##T(t, ci, ctx); \
        XAD(k);                         \
      }
      FXTRAN_ompc_list(test_macro)
#undef test_macro

      if (k == 0)
        FXTRAN_THROW ("Unknown OpenMP clause");

      if (t[0] == ',')
        XAD(1);
    }
}


static void ompd_optional_name (const char * t, const FXTRAN_char_info * ci, 
		                FXTRAN_xmlctx * ctx)
{
  int k;
  if (t[0] == '(')
    {
      XAD(1);
      k = FXTRAN_eat_word (t);
      XNT (_T(_S(NAME)), k);
      XAD(k+1);
    }
  if (t[0])
    FXTRAN_THROW ("Malformed OpenMP directive");
}


#define def_ompd_extra_clause_list(T) \
static void ompd_##T##_extra (const char * t, const FXTRAN_char_info * ci,  \
		              FXTRAN_xmlctx * ctx)                          \
{                                                                           \
  int k = strlen (#T);                                                      \
  XAD(k);                                                                   \
  return ompd_clause_list (t, ci, ctx);                                     \
}

#define def_ompd_extra_optional_name(T) \
static void ompd_##T##_extra (const char * t, const FXTRAN_char_info * ci,  \
		              FXTRAN_xmlctx * ctx)                          \
{                                                                           \
  int k = strlen (#T);                                                      \
  XAD(k);                                                                   \
  return ompd_optional_name (t, ci, ctx);                                   \
}

static void ompd_FLUSH_extra (const char * t, const FXTRAN_char_info * ci, 
		              FXTRAN_xmlctx * ctx)                         
{                                                                          
  int k;
  XAD(5);                                                                  
  if (t[0] == '(')
    {
      XAD(1);
      XST ("list");
      while (t[0] != ')')
        {
          k = FXTRAN_eat_word (t);
          XNT (_T(_S(VARIABLE)), k);
          XAD(k);
          if (t[0] == ',')
            XAD(1);
          else if (t[0] != ')')
            FXTRAN_THROW ("Malformed OpenMP clause");
        }
      XET ();
    }
}

static void ompd_THREADPRIVATE_extra (const char * t, const FXTRAN_char_info * ci, 
		                      FXTRAN_xmlctx * ctx)                         
{                                                                          
  int k;
  XAD(13);                                                                  
  if (t[0] != '(')
    FXTRAN_THROW ("Malformed OpenMP directive");
  XAD(1);
  XST (_T(_S(LIST)));
  while (t[0] != ')')
    {
      k = FXTRAN_eat_word (t);
      XNT (_T(_S(VARIABLE)), k);
      XAD(k);
      if (t[0] == ',')
        XAD(1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenMP clause");
    }
  XET ();
}

def_ompd_extra_clause_list (PARALLELDO)
def_ompd_extra_clause_list (ENDPARALLELDO)
def_ompd_extra_clause_list (PARALLELSECTIONS)
def_ompd_extra_clause_list (ENDPARALLELSECTIONS)
def_ompd_extra_clause_list (PARALLELWORKSHARE)
def_ompd_extra_clause_list (ENDPARALLELWORKSHARE)
def_ompd_extra_clause_list (DO)
def_ompd_extra_clause_list (ENDDO)   
def_ompd_extra_clause_list (SINGLE)
def_ompd_extra_clause_list (ENDSINGLE)   
def_ompd_extra_clause_list (WORKSHARE)   
def_ompd_extra_clause_list (ENDWORKSHARE)
def_ompd_extra_clause_list (SECTIONS)
def_ompd_extra_clause_list (ENDSECTIONS)   
def_ompd_extra_clause_list (ATOMIC)
def_ompd_extra_clause_list (ORDERED)
def_ompd_extra_clause_list (ENDORDERED)
def_ompd_extra_clause_list (PARALLEL)
def_ompd_extra_clause_list (ENDPARALLEL)
def_ompd_extra_clause_list (MASTER)
def_ompd_extra_clause_list (ENDMASTER) 

def_ompd_extra_optional_name (CRITICAL)
def_ompd_extra_optional_name (ENDCRITICAL)



void FXTRAN_dump_ompd (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int k = strlen (t);
  FXTRAN_ompd_type type = get_FXTRAN_omp_type (t);
  const char * str = type == FXTRAN_OMPD_NONE ? _T(_S(BROKEN) H _S(OPENMP)) : ompd_as_str (type);

  XST (str);


#define case_macro(T) \
  case FXTRAN_OMPD_##T: ompd_##T##_extra (t, ci, ctx); break;

  switch (type)
    {
      FXTRAN_ompd_list(case_macro)
      default:
      break;
    }
#undef case_macro

  if (type == FXTRAN_OMPD_NONE)
    XAD(k);
  else
    XAD(strlen (t));

  XET ();

}


