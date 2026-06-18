/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <string.h>
#include <ctype.h>

#include "FXTRAN_OMP_TARGET.h"
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

#define CASE_FXTRAN_SPACE \
	case ' ': case '\t'

/* Returns 1 if the text at position k starts a TARGET-family directive */
static int is_omp_target_directive (const char * text, int k)
{
  /* !$OMP TARGET ... */
  if (strncasecmp (text + k, "TARGET", 6) == 0)
    return 1;

  /* !$OMP DECLARE TARGET ... */
  if (strncasecmp (text + k, "DECLARE", 7) == 0)
    {
      int m = k + 7;
      while (fc_isspace (text[m])) m++;
      if (strncasecmp (text + m, "TARGET", 6) == 0)
        return 1;
    }

  /* !$OMP END TARGET ..., !$OMP END DECLARE TARGET */
  if (strncasecmp (text + k, "END", 3) == 0)
    {
      int m = k + 3;
      while (fc_isspace (text[m])) m++;
      if (strncasecmp (text + m, "TARGET", 6) == 0)
        return 1;
      if (strncasecmp (text + m, "DECLARE", 7) == 0)
        {
          int n = m + 7;
          while (fc_isspace (text[n])) n++;
          if (strncasecmp (text + n, "TARGET", 6) == 0)
            return 1;
        }
    }

  return 0;
}

int FXTRAN_check_omp_target (const char * t, const FXTRAN_char_info * ci, int i1, int i2,
                              FXTRAN_xmlctx * ctx)
{
  int i;
  int ci0mask;

  if (i1 < 0)
    return 0;

/* Find beginning of line */
  for (i = i1; i; i--)
    if (t[i-1] == '\n')
      break;

/* Goto first non white-space char */
  for (; fc_isspace (t[i]); i++);

  ci0mask = ci[i].mask;

  if (ci0mask == FXTRAN_OTD)
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
              FXTRAN_THROW ("Malformed OpenMP Target directive");
          }
      return 2;
    }

  return 0;
}

int FXTRAN_handle_omp_target (const char * text, FXTRAN_char_info * ci, int i, int OTD)
{
  int omp = 0;
  int k;

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
      /* Must be !$OMP */
      if (!OMP_FXTRAN (text+i+2))
        return 0;
      /* Must have space after !$OMP */
      if (!fc_isspace (text[i+5]))
        return 0;

      /* Skip spaces and check for TARGET-family directive */
      k = i + 5;
      while (fc_isspace (text[k])) k++;

      if (is_omp_target_directive (text, k) || (OTD && (text[k] == '&')))
        {
          ci[i+0].mask = FXTRAN_OTD;
          ci[i+1].mask = FXTRAN_OTD;
          ci[i+2].mask = FXTRAN_OTD;
          ci[i+3].mask = FXTRAN_OTD;
          ci[i+4].mask = FXTRAN_OTD;
          return 5;
        }
    }

  return 0;
}

static FXTRAN_omptd_type get_FXTRAN_ompt_type (const char * t)
{
#define test_macro(T) \
  do {                                    \
    int len = strlen (#T);                \
    if (strncmp (#T, t, len)==0)          \
      return FXTRAN_OMPTD_##T;            \
  } while (0);

FXTRAN_omptd_list(test_macro)
#undef test_macro

  return FXTRAN_OMPTD_NONE;
}

static const char * omptd_as_str (FXTRAN_omptd_type type)
{
  switch (type)
    {
      case FXTRAN_OMPTD_TARGETENTERDATA  :
        return _T(_S(TARGET) H _S(ENTER) H _S(DATA) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETEXITDATA   :
        return _T(_S(TARGET) H _S(EXIT) H _S(DATA) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETPARALLEL   :
        return _T(_S(TARGET) H _S(PARALLEL) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETUPDATE     :
        return _T(_S(TARGET) H _S(UPDATE) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETTEAMS      :
        return _T(_S(TARGET) H _S(TEAMS) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETDATA       :
        return _T(_S(TARGET) H _S(DATA) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGET           :
        return _T(_S(TARGET) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGETPARALLEL:
        return _T(_S(END) H _S(TARGET) H _S(PARALLEL) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGETTEAMS   :
        return _T(_S(END) H _S(TARGET) H _S(TEAMS) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGETDATA    :
        return _T(_S(END) H _S(TARGET) H _S(DATA) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGET        :
        return _T(_S(END) H _S(TARGET) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDDECLARETARGET :
        return _T(_S(END) H _S(DECLARE) H _S(TARGET) H _S(OPENMP));
      case FXTRAN_OMPTD_DECLARETARGET    :
        return _T(_S(DECLARE) H _S(TARGET) H _S(OPENMP));
      case FXTRAN_OMPTD_NONE:
      case FXTRAN_OMPTD_LAST:
      default:
      break;
    }
  return NULL;
}

/* ========== Clause parsers ========== */

static int FXTRAN_omptc_REDUCTION (const char * t, const FXTRAN_char_info * ci,
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
    FXTRAN_THROW ("Malformed OpenMP Target clause; expected `('");

  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  if (k == 0)
    FXTRAN_THROW ("Malformed OpenMP Target clause; expected `:'");

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
    FXTRAN_THROW ("Malformed OpenMP Target clause; expected `:'");
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
        FXTRAN_THROW ("Malformed OpenMP Target clause");
    }
  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP Target clause; expected `)'");
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_IN_REDUCTION (const char * t, const FXTRAN_char_info * ci,
                                       FXTRAN_xmlctx * ctx)
{
  return FXTRAN_omptc_REDUCTION (t, ci, ctx);
}

static int FXTRAN_omptc_MAP (const char * t, const FXTRAN_char_info * ci,
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
    FXTRAN_THROW ("Malformed OpenMP Target MAP clause; expected `('");

  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);

  /* Look for map-type or map-type-modifier: prefix */
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);
  if (k > 0)
    {
      XNW (_T(_S(MAP) H _S(TYPE)), k-1);
      XAD(k);
    }

  XST (_T(_S(VARIABLE) H _S(LIST)));
  while (t[0] != ')')
    {
      k = FXTRAN_eat_word (t);
      if (k == 0)
        break;
      XNT (_T(_S(VARIABLE)), k);
      XAD(k);
      if (t[0] == ',')
        XAD(1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenMP Target MAP clause");
    }
  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP Target MAP clause; expected `)'");
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_DEPEND (const char * t, const FXTRAN_char_info * ci,
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
    FXTRAN_THROW ("Malformed OpenMP Target DEPEND clause; expected `('");

  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);

  /* depend-type: variable-list */
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);
  if (k > 0)
    {
      XNW (_T(_S(DEPEND) H _S(TYPE)), k-1);
      XAD(k);
    }

  XST (_T(_S(VARIABLE) H _S(LIST)));
  while (t[0] != ')')
    {
      k = FXTRAN_eat_word (t);
      if (k == 0)
        break;
      XNT (_T(_S(VARIABLE)), k);
      XAD(k);
      if (t[0] == ',')
        XAD(1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenMP Target DEPEND clause");
    }
  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP Target DEPEND clause; expected `)'");
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_DEFAULTMAP (const char * t, const FXTRAN_char_info * ci,
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
    FXTRAN_THROW ("Malformed OpenMP Target DEFAULTMAP clause; expected `('");

  XAD(1);

  /* implicit-behavior */
  k = FXTRAN_eat_word (t);
  if (k == 0)
    FXTRAN_THROW ("Malformed OpenMP Target DEFAULTMAP clause");

  XNW (_T(_S(DEFAULTMAP) H _S(TYPE)), k);
  XAD(k);

  /* optional :variable-category */
  if (t[0] == ':')
    {
      XAD(1);
      k = FXTRAN_eat_word (t);
      if (k > 0)
        {
          XNW (_T(_S(VARIABLE) H _S(TYPE)), k);
          XAD(k);
        }
    }

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP Target DEFAULTMAP clause; expected `)'");
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_SCHEDULE (const char * t, const FXTRAN_char_info * ci,
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
    FXTRAN_THROW ("Malformed OpenMP Target clause");
  XAD(1);

  k = FXTRAN_eat_word (t);
  if (k == 0)
    FXTRAN_THROW ("Malformed OpenMP Target clause");

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
    FXTRAN_THROW ("Malformed OpenMP Target clause");
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_DIST_SCHEDULE (const char * t, const FXTRAN_char_info * ci,
                                        FXTRAN_xmlctx * ctx)
{
  return FXTRAN_omptc_SCHEDULE (t, ci, ctx);
}

static int FXTRAN_omptc_ALIGNED (const char * t, const FXTRAN_char_info * ci,
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
    FXTRAN_THROW ("Malformed OpenMP Target ALIGNED clause");
  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  XST (_T(_S(VARIABLE) H _S(LIST)));
  if (k > 0)
    {
      /* variables before : */
      while (t[0] != ':' && t[0] != ')')
        {
          int kn = FXTRAN_eat_word (t);
          if (kn == 0) break;
          XNT (_T(_S(VARIABLE)), kn);
          XAD(kn);
          if (t[0] == ',') XAD(1);
        }
      XET ();
      if (t[0] == ':')
        {
          XAD(1);
          kp = FXTRAN_str_at_level (t, ci, ")", 0);
          FXTRAN_expr (t, ci, kp-1, ctx);
          XAD(kp-1);
        }
    }
  else
    {
      while (t[0] != ')')
        {
          int kn = FXTRAN_eat_word (t);
          if (kn == 0) break;
          XNT (_T(_S(VARIABLE)), kn);
          XAD(kn);
          if (t[0] == ',') XAD(1);
        }
      XET ();
    }

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP Target ALIGNED clause");
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_LINEAR (const char * t, const FXTRAN_char_info * ci,
                                 FXTRAN_xmlctx * ctx)
{
  return FXTRAN_omptc_ALIGNED (t, ci, ctx);
}

static int omptc_var_list (const char * t, const FXTRAN_char_info * ci,
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
    FXTRAN_THROW ("Malformed OpenMP Target clause");
  XAD(1);

  XST (_S(VARIABLE) H _S(LIST));
  while (t[0] != ')')
    {
      k = FXTRAN_eat_word (t);
      XNT (_T(_S(VARIABLE)), k);
      XAD(k);
      if (t[0] == ',')
        XAD(1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenMP Target clause");
    }
  XET ();

  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_expr (const char * t, const FXTRAN_char_info * ci,
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

static int FXTRAN_omptc_ktype (const char * t, const FXTRAN_char_info * ci,
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
    FXTRAN_THROW ("Malformed OpenMP Target clause");

  XAD(1);

  k = FXTRAN_eat_word (t);
  if (k == 0)
    FXTRAN_THROW ("Malformed OpenMP Target clause");

  XST (_T(_S(TYPE)));
  XAD(k);
  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP Target clause");

  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_simple (const char * t, const char * C,
                                 const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
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

#define def_FXTRAN_omptc_simple(T) \
static int FXTRAN_omptc_##T (const char * t, const FXTRAN_char_info * ci, \
                              FXTRAN_xmlctx * ctx)                         \
{                                                                          \
  return FXTRAN_omptc_simple (t, #T, ci, ctx);                            \
}

#define def_FXTRAN_omptc_expr(T) \
static int FXTRAN_omptc_##T (const char * t, const FXTRAN_char_info * ci, \
                              FXTRAN_xmlctx * ctx)                         \
{                                                                          \
  return FXTRAN_omptc_expr (t, ci, ctx);                                  \
}

#define def_FXTRAN_omptc_ktype(T) \
static int FXTRAN_omptc_##T (const char * t, const FXTRAN_char_info * ci, \
                              FXTRAN_xmlctx * ctx)                         \
{                                                                          \
  return FXTRAN_omptc_ktype (t, ci, ctx);                                 \
}

#define def_FXTRAN_omptc_list(T) \
static int FXTRAN_omptc_##T (const char * t, const FXTRAN_char_info * ci, \
                              FXTRAN_xmlctx * ctx)                         \
{                                                                          \
  return omptc_var_list (t, ci, ctx);                                      \
}

def_FXTRAN_omptc_simple (NOWAIT)
def_FXTRAN_omptc_simple (ORDERED)
def_FXTRAN_omptc_simple (PARALLELDOSIMD)
def_FXTRAN_omptc_simple (PARALLELDO)
def_FXTRAN_omptc_simple (DISTRIBUTE)
def_FXTRAN_omptc_simple (SIMD)
def_FXTRAN_omptc_simple (LOOP)
def_FXTRAN_omptc_simple (DO)

def_FXTRAN_omptc_ktype (DEFAULT)

def_FXTRAN_omptc_expr (IF)
def_FXTRAN_omptc_expr (DEVICE)
def_FXTRAN_omptc_expr (NUM_TEAMS)
def_FXTRAN_omptc_expr (THREAD_LIMIT)
def_FXTRAN_omptc_expr (COLLAPSE)
def_FXTRAN_omptc_expr (SIMDLEN)
def_FXTRAN_omptc_expr (SAFELEN)

def_FXTRAN_omptc_list (PRIVATE)
def_FXTRAN_omptc_list (FIRSTPRIVATE)
def_FXTRAN_omptc_list (SHARED)
def_FXTRAN_omptc_list (LASTPRIVATE)
def_FXTRAN_omptc_list (IS_DEVICE_PTR)
def_FXTRAN_omptc_list (USES_ALLOCATORS)
def_FXTRAN_omptc_list (TO)
def_FXTRAN_omptc_list (FROM)

static void omptd_clause_list (const char * t, const FXTRAN_char_info * ci,
                                FXTRAN_xmlctx * ctx)
{
  int len;
  int k;

  while (t[0])
    {
      k = 0;
#define test_macro(T) \
      len = strlen (#T);                          \
      if (strncmp (#T, t, len) == 0)              \
        {                                         \
          k = FXTRAN_omptc_##T (t, ci, ctx);      \
          XAD(k);                                 \
        }
      FXTRAN_omptc_list(test_macro)
#undef test_macro

      if (k == 0)
        FXTRAN_THROW ("Unknown OpenMP Target clause");

      if (t[0] == ',')
        XAD(1);
    }
}

#define def_omptd_extra_clause_list(T) \
static void omptd_##T##_extra (const char * t, const FXTRAN_char_info * ci,  \
                               FXTRAN_xmlctx * ctx)                           \
{                                                                              \
  int k = strlen (#T);                                                         \
  XAD(k);                                                                      \
  return omptd_clause_list (t, ci, ctx);                                       \
}

def_omptd_extra_clause_list (TARGETENTERDATA)
def_omptd_extra_clause_list (TARGETEXITDATA)
def_omptd_extra_clause_list (TARGETPARALLEL)
def_omptd_extra_clause_list (TARGETUPDATE)
def_omptd_extra_clause_list (TARGETTEAMS)
def_omptd_extra_clause_list (TARGETDATA)
def_omptd_extra_clause_list (TARGET)
def_omptd_extra_clause_list (ENDTARGETPARALLEL)
def_omptd_extra_clause_list (ENDTARGETTEAMS)
def_omptd_extra_clause_list (ENDTARGETDATA)
def_omptd_extra_clause_list (ENDTARGET)
def_omptd_extra_clause_list (ENDDECLARETARGET)
def_omptd_extra_clause_list (DECLARETARGET)

void FXTRAN_dump_omptd (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int k = strlen (t);
  FXTRAN_omptd_type type = get_FXTRAN_ompt_type (t);
  const char * str = type == FXTRAN_OMPTD_NONE ? _T(_S(BROKEN) H _S(OPENMP)) : omptd_as_str (type);

  XST (str);

  if (ctx->in_stmt)
    FXTRAN_ABORT ("Expected ctx->in_stmt == 0");

  ctx->in_stmt = 1;

#define case_macro(T) \
  case FXTRAN_OMPTD_##T: omptd_##T##_extra (t, ci, ctx); break;

  switch (type)
    {
      FXTRAN_omptd_list(case_macro)
      default:
      break;
    }
#undef case_macro

  if (type == FXTRAN_OMPTD_NONE)
    XAD(k);
  else
    XAD(strlen (t));

  XET ();

  ctx->in_stmt = 0;

}
