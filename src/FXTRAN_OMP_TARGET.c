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

int FXTRAN_handle_omp_target (const char * text, FXTRAN_char_info * ci, int i, int OMP)
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
      if ((OMP_FXTRAN (text+i+2)) || (OMP && OMP_FXTRAN (text+i+2)))
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
      case FXTRAN_OMPTD_TARGET            :  return _T(_S(TARGET) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETENTERDATA   :  return _T(_S(TARGET) H _S(ENTER) H _S(DATA) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETEXITDATA    :  return _T(_S(TARGET) H _S(EXIT) H _S(DATA) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETPARALLEL    :  return _T(_S(TARGET) H _S(PARALLEL) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETPARALLELDO  :  return _T(_S(TARGET) H _S(PARALLEL) H _S(DO) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETUPDATE      :  return _T(_S(TARGET) H _S(UPDATE) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETTEAMS       :  return _T(_S(TARGET) H _S(TEAMS) H _S(OPENMP));
      case FXTRAN_OMPTD_TARGETDATA        :  return _T(_S(TARGET) H _S(DATA) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGETPARALLELDO :  return _T(_S(END) H _S(TARGET) H _S(PARALLEL) H _S(DO) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGETPARALLEL :  return _T(_S(END) H _S(TARGET) H _S(PARALLEL) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGETTEAMS    :  return _T(_S(END) H _S(TARGET) H _S(TEAMS) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGETDATA     :  return _T(_S(END) H _S(TARGET) H _S(DATA) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTARGET         :  return _T(_S(END) H _S(TARGET) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDDECLARETARGET  :  return _T(_S(END) H _S(DECLARE) H _S(TARGET) H _S(OPENMP));
      case FXTRAN_OMPTD_DECLARETARGET     :  return _T(_S(DECLARE) H _S(TARGET) H _S(OPENMP));
      case FXTRAN_OMPTD_DECLARE           :  return _T(_S(DECLARE) H _S(OPENMP));
      case FXTRAN_OMPTD_PARALLELMASTER    :  return _T(_S(PARALLEL) H _S(MASTER) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDPARALLELMASTER :  return _T(_S(END) H _S(PARALLEL) H _S(MASTER) H _S(OPENMP));
      case FXTRAN_OMPTD_PARALLELDOSIMD    :  return _T(_S(PARALLEL) H _S(DO) H _S(SIMD) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDPARALLELDOSIMD :  return _T(_S(END) H _S(PARALLEL) H _S(DO) H _S(SIMD) H _S(OPENMP));
      case FXTRAN_OMPTD_PARALLEL          :  return _T(_S(PARALLEL) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDPARALLEL       :  return _T(_S(END) H _S(PARALLEL) H _S(OPENMP));
      case FXTRAN_OMPTD_SIMD              :  return _T(_S(SIMD) H _S(OPENMP));
      case FXTRAN_OMPTD_DOSIMD            :  return _T(_S(SIMD) H _S(DO) H _S(OPENMP));
      case FXTRAN_OMPTD_SINGLE            :  return _T(_S(SINGLE) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDSINGLE         :  return _T(_S(END) H _S(SINGLE) H _S(OPENMP));
      case FXTRAN_OMPTD_TASKGROUP         :  return _T(_S(TASKGROUP) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTASKGROUP      :  return _T(_S(END) H _S(TASKGROUP) H _S(OPENMP));
      case FXTRAN_OMPTD_TASK              :  return _T(_S(TASK) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTASK           :  return _T(_S(END) H _S(TASK) H _S(OPENMP));
      case FXTRAN_OMPTD_MASKED            :  return _T(_S(MASKED) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDMASKED         :  return _T(_S(END) H _S(MASKED) H _S(OPENMP));
      case FXTRAN_OMPTD_TASKWAIT          :  return _T(_S(TASKWAIT) H _S(OPENMP));
      case FXTRAN_OMPTD_BARRIER           :  return _T(_S(BARRIER) H _S(OPENMP));
      case FXTRAN_OMPTD_SECTION           :  return _T(_S(SECTION) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDSECTION        :  return _T(_S(END) H _S(SECTION) H _S(OPENMP));
      case FXTRAN_OMPTD_SECTIONS          :  return _T(_S(SECTIONS) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDSECTIONS       :  return _T(_S(END) H _S(SECTIONS) H _S(OPENMP));
      case FXTRAN_OMPTD_ATOMIC            :  return _T(_S(ATOMIC) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDATOMIC         :  return _T(_S(END) H _S(ATOMIC) H _S(OPENMP));
      case FXTRAN_OMPTD_DO                :  return _T(_S(DO) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDDO             :  return _T(_S(END) H _S(DO) H _S(OPENMP));
      case FXTRAN_OMPTD_CRITICAL          :  return _T(_S(CRITICAL) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDCRITICAL       :  return _T(_S(END) H _S(CRITICAL) H _S(OPENMP));
      case FXTRAN_OMPTD_SCOPE             :  return _T(_S(SCOPE) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDSCOPE          :  return _T(_S(END) H _S(SCOPE) H _S(OPENMP));
      case FXTRAN_OMPTD_TEAMS             :  return _T(_S(TEAMS) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTEAMS          :  return _T(_S(END) H _S(TEAMS) H _S(OPENMP));
      case FXTRAN_OMPTD_DISTRIBUTE        :  return _T(_S(DISTRIBUTE) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDDISTRIBUTE     :  return _T(_S(END) H _S(DISTRIBUTE) H _S(OPENMP));
      case FXTRAN_OMPTD_REQUIRES          :  return _T(_S(REQUIRES) H _S(OPENMP));
      case FXTRAN_OMPTD_TILE              :  return _T(_S(TILE) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDTILE           :  return _T(_S(END) H _S(TILE) H _S(OPENMP));
      case FXTRAN_OMPTD_UNROLL            :  return _T(_S(UNROLL) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDUNROLL         :  return _T(_S(END) H _S(UNROLL) H _S(OPENMP));
      case FXTRAN_OMPTD_ALLOCATORS        :  return _T(_S(ALLOCATORS) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDALLOCATORS     :  return _T(_S(END) H _S(ALLOCATORS) H _S(OPENMP));
      case FXTRAN_OMPTD_FLUSH             :  return _T(_S(FLUSH) H _S(OPENMP));
      case FXTRAN_OMPTD_WORKSHARE         :  return _T(_S(WORK) H _S(SHARE) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDWORKSHARE      :  return _T(_S(END) H _S(WORK) H _S(SHARE) H _S(OPENMP));
      case FXTRAN_OMPTD_ORDERED           :  return _T(_S(ORDERED) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDORDERED        :  return _T(_S(END) H _S(ORDERED) H _S(OPENMP));
      case FXTRAN_OMPTD_LOOP              :  return _T(_S(LOOP) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDLOOP           :  return _T(_S(END) H _S(LOOP) H _S(OPENMP));
      case FXTRAN_OMPTD_THREADPRIVATE     :  return _T(_S(THREADPRIVATE) H _S(OPENMP));
      case FXTRAN_OMPTD_TASKYIELD         :  return _T(_S(TASKYIELD) H _S(OPENMP));
      case FXTRAN_OMPTD_SCAN              :  return _T(_S(SCAN) H _S(OPENMP));
      case FXTRAN_OMPTD_ASSUMES           :  return _T(_S(ASSUMES) H _S(OPENMP));
      case FXTRAN_OMPTD_ASSUME            :  return _T(_S(ASSUME) H _S(OPENMP));
      case FXTRAN_OMPTD_ENDASSUME         :  return _T(_S(END) H _S(ASSUME) H _S(OPENMP));
      case FXTRAN_OMPTD_ERROR             :  return _T(_S(ERROR) H _S(OPENMP));
      case FXTRAN_OMPTD_DEPOBJ            :  return _T(_S(DEPOBJ) H _S(OPENMP));
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

  if (kp == 0)
    FXTRAN_THROW ("Malformed OpenMP Target clause; expected terminal `)'");

  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  if (k == 0)
    FXTRAN_THROW ("Malformed OpenMP Target clause; expected `:'");

  kn = FXTRAN_eat_word (t);

  if (kn && (t[kn] == ','))
    {
      XNT (_T(_S(MODIFIER) H _S(NAME)), kn);
      XAD(kn);
      XAD(1);
    }

  kn = FXTRAN_eat_word (t);

  if (kn)
    {
      XNT (_T(_S(OPERATOR)), kn);
      XAD(kn);
    }
  else
    {
      k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);
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

static int FXTRAN_omptc_TASK_REDUCTION (const char * t, const FXTRAN_char_info * ci,
                                        FXTRAN_xmlctx * ctx)
{
  return FXTRAN_omptc_REDUCTION (t, ci, ctx);
}

static int omptc_map (const char * t, const FXTRAN_char_info * ci,
                      FXTRAN_xmlctx * ctx, const char * directive)
{
  const char * T = t;
  int kp, k0;

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed OpenMP Target %s clause; expected `('", directive);

  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k0 = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  if (k0 > 0)
    {
      while (t[0] != ':')
        {
          int k = FXTRAN_eat_word (t);
          XST (_T(_S(PREFIX)));
          XAD(k);
          XET ();
          if (t[0] == ',')
            XAD (1);
          else if (t[0] != ':')
            FXTRAN_THROW ("Malformed %s clause", directive);
        }
      XAD (1);
    }

  XST (_T(_S(EXPR) H _S(LIST)));
  while (t[0] != ')')
    {
      int kp = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);
      int kc = FXTRAN_str_at_level_ir (t, ci, ",", ci->parens, kp);

      if (! kc)
        kc = kp;

      FXTRAN_expr (t, ci, kc-1, ctx);
      XAD (kc-1);
      
      if (t[0] == ',')
        XAD(1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenMP Target %s clause", directive);
    }
  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP Target %s clause; expected `)'", directive);
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_MAP (const char * t, const FXTRAN_char_info * ci,
                             FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  k = omptc_map (t, ci, ctx, _S(MAP));
  
  XAD (k);

  return t - T;
}

static int FXTRAN_omptc_single_prefix (const char * t, const FXTRAN_char_info * ci,
                                       FXTRAN_xmlctx * ctx, const char * clause)
{
  const char * T = t;
  int kp, k;

  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed %s clause", clause);
  XAD (1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  if (k)
    {
      k = FXTRAN_eat_word (t);
      XST (_T(_S(PREFIX)));
      XAD(k);
      XET ();
      XAD (1);
    }

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  FXTRAN_expr (t, ci, kp-1, ctx);

  XAD (kp);

  XET ();

  return t - T;
}

static int FXTRAN_omptc_IF (const char * t, const FXTRAN_char_info * ci,
                            FXTRAN_xmlctx * ctx)
{
  return FXTRAN_omptc_single_prefix (t, ci, ctx, "IF");
}

static int FXTRAN_omptc_DEVICE (const char * t, const FXTRAN_char_info * ci,
                                 FXTRAN_xmlctx * ctx)
{
  return FXTRAN_omptc_single_prefix (t, ci, ctx, "DEVICE");
}

static int FXTRAN_omptc_LASTPRIVATE (const char * t, const FXTRAN_char_info * ci,
                                     FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int kp, k;

  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed LASTPRIVATE clause");
  XAD (1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  if (k)
    {
      while (t[0] != ':')
        {
          k = FXTRAN_eat_word (t);
          XST (_T(_S(PREFIX)));
          XAD(k);
          XET ();
          if (t[0] == ',')
            XAD (1);
          else if (t[0] != ':')
            FXTRAN_THROW ("Malformed LASTPRIVATE clause");
        }
      XAD (1);
    }


  while (t[0] != ')')
    {
      kp = FXTRAN_str_at_level (t, ci, ")", 0);
      k = FXTRAN_str_at_level_ir (t, ci, ",", 1, kp);
      if (k == 0)
        k = kp;
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD (k-1);
      if (t[0] == ',')
        XAD (1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed clause");
    }

  XAD (1);

  XET ();

  return t - T;
}

/* Generic clause parser for clauses with an optional type prefix before ':'
   followed by a comma-separated expression list.
   If modifier_tag is non-NULL, a modifier may precede the type (comma-separated).
   The type is emitted as <T>. */
static int FXTRAN_omptc_clause_with_type_and_exprs (const char * t, const FXTRAN_char_info * ci,
                                                     FXTRAN_xmlctx * ctx, const char * clause_name,
                                                     const char * modifier_tag)
{
  const char * T = t;
  int k, kp, km;

  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed OpenMP Target %s clause; expected `('", clause_name);
  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);

  /* type prefix before ':' (may include modifier) */
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);
  if (k > 0)
    {
      if (modifier_tag)
        {
          km = FXTRAN_str_at_level_ir (t, ci, ",", 1, k);
          if (km > 0)
            {
              /* modifier present */
              XST (modifier_tag);
              XAD (km - 1);
              XET ();
              XAD (1);
              XNT (_T(_S(TYPE)), k - km - 1);
              XAD (k - km);
            }
          else
            {
              XNT (_T(_S(TYPE)), k-1);
              XAD(k);
            }
        }
      else
        {
          XNT (_T(_S(TYPE)), k-1);
          XAD(k);
        }
    }

  /* expression list */
  XST (_T(_S(EXPR) H _S(LIST)));
  while (t[0] != ')')
    {
      int kexpr = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);
      int kc = FXTRAN_str_at_level_ir (t, ci, ",", ci->parens, kexpr);

      if (! kc)
        kc = kexpr;

      FXTRAN_expr (t, ci, kc - 1, ctx);
      XAD (kc - 1);

      if (t[0] == ',')
        XAD(1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenMP Target %s clause", clause_name);
    }
  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed OpenMP Target %s clause; expected `)'", clause_name);
  XAD(1);

  XET ();
  return t - T;
}

static int FXTRAN_omptc_DEPEND (const char * t, const FXTRAN_char_info * ci,
                                 FXTRAN_xmlctx * ctx)
{
  return FXTRAN_omptc_clause_with_type_and_exprs (t, ci, ctx, "DEPEND",
                                                   _T(_S(DEPEND) H _S(MODIFIER)));
}

static int FXTRAN_omptc_DOACROSS (const char * t, const FXTRAN_char_info * ci,
                                  FXTRAN_xmlctx * ctx)
{
  return FXTRAN_omptc_clause_with_type_and_exprs (t, ci, ctx, "DOACROSS", NULL);
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

  k = omptc_map (t, ci, ctx, _S(DEFAULTMAP));
  
  XAD (k);

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
  const char * T = t;
  int k, kp;

  k = FXTRAN_eat_word (t);
  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(k);
  XET ();

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed OpenMP Target LINEAR clause");
  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  XST (_S(VARIABLE) H _S(LIST));
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
          int kw;
          XAD(1);
          kw = FXTRAN_eat_word (t);
          if ((kw == 3 && strncmp (t, "REF", 3) == 0) ||
              (kw == 3 && strncmp (t, "VAL", 3) == 0) ||
              (kw == 4 && strncmp (t, "UVAL", 4) == 0) ||
              (kw == 4 && strncmp (t, "STEP", 4) == 0))
            {
              /* OpenMP 5.2 modifier list */
              XST (_T(_S(MODIFIER) H _S(LIST)));
              while (t[0] != ')')
                {
                  int kn = FXTRAN_eat_word (t);
                  if (kn == 0) break;
                  XST (_T(_S(MODIFIER)));
                  XST (_T(_S(NAME)));
                  XAD(kn);
                  XET ();
                  /* if modifier is step, parse (expr) */
                  if ((kn == 4) && (strncmp (t - 4, "STEP", 4) == 0))
                    {
                      if (t[0] == '(')
                        {
                          int ks = FXTRAN_str_at_level (t, ci, ")", ci->parens);
                          XAD(1);
                          FXTRAN_expr (t, ci, ks - 2, ctx);
                          XAD(ks - 1);
                        }
                    }
                  XET ();
                  if (t[0] == ',')
                    XAD(1);
                  else if (t[0] != ')')
                    FXTRAN_THROW ("Malformed OpenMP Target LINEAR clause");
                }
              XET ();
            }
          else
            {
              /* Traditional linear-step expression */
              kp = FXTRAN_str_at_level (t, ci, ")", 0);
              FXTRAN_expr (t, ci, kp - 1, ctx);
              XAD (kp - 1);
            }
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
    FXTRAN_THROW ("Malformed OpenMP Target LINEAR clause; expected `)'");
  XAD(1);

  XET ();
  return t - T;
}

static int omp_var_list (const char * t, const FXTRAN_char_info * ci,
                         FXTRAN_xmlctx * ctx, const char * tag, int optional)
{
  const char * T = t;
  int k;

  if ((t[0] != '(') && optional)
    return 0;

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed OpenMP Target clause");
  XAD(1);

  XST (tag);

  while (t[0] != ')')
    {
      if (t[0] == '/') 
        { 
          XST (_T(_S(COMMON) H _S(BLOCK)));
          XAD (1);
          k = FXTRAN_eat_word (t);
          XNT (_T(_S(COMMON) H _S(BLOCK) H _S(NAME)), k);
          XAD (k);
          if (t[0] != '/')
            FXTRAN_THROW ("Expected common block name");
          XAD (1);
          XET ();
        }
      else
        {
          k = FXTRAN_eat_word (t);
          XNT (_T(_S(VARIABLE) H _S(NAME)), k);
          XAD(k);
        }
      if (t[0] == ',')
        XAD(1);
      else if (t[0] != ')')
        FXTRAN_THROW ("Malformed OpenMP Target clause");
    }

  XET ();

  XAD(1);

  return t - T;
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

  k = omp_var_list (t, ci, ctx, _S(VARIABLE) H _S(LIST), 0);

  XAD (k);
    
  XET ();
  return t - T;
}

static int FXTRAN_omptc_expr (const char * t, const FXTRAN_char_info * ci,
                              FXTRAN_xmlctx * ctx, const char * clause)
{
  const char * T = t;
  int k;

  XST (_T(_S(CLAUSE)));
  XST (_T(_S(NAME)));
  XAD(strlen(clause));
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

static int FXTRAN_omptc_expr_list (const char * t, const FXTRAN_char_info * ci,
                                   FXTRAN_xmlctx * ctx, const char * clause)
{
  const char * T = t;
  int kp, kc;

  if (clause)
    {
      XST (_T(_S(CLAUSE)));
      XST (_T(_S(NAME)));
      XAD(strlen(clause));
      XET ();
    }

  if (t[0] == '(')
    {
      XAD (1);

      XST (_T(_S(EXPR) H _S(LIST)));

      while (t[0] != ')')
        {
          kp = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);
          kc = FXTRAN_str_at_level_ir (t, ci, ",", ci->parens, kp);

          if (! kc)
            kc = kp;

          FXTRAN_expr (t, ci, kc-1, ctx);
          XAD(kc-1);

          if (t[0] == ',')
            XAD (1);
          else if (t[0] != ')') 
            FXTRAN_THROW ("Expected `)'");
        }
      XAD (1);

      XET ();
    }

  if (clause)
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
                              FXTRAN_xmlctx * ctx)                        \
{                                                                         \
  return FXTRAN_omptc_simple (t, #T, ci, ctx);                            \
}

#define def_FXTRAN_omptc_expr(T) \
static int FXTRAN_omptc_##T (const char * t, const FXTRAN_char_info * ci, \
                             FXTRAN_xmlctx * ctx)                         \
{                                                                         \
  return FXTRAN_omptc_expr (t, ci, ctx, #T);                              \
}

#define def_FXTRAN_omptc_expr_list(T) \
static int FXTRAN_omptc_##T (const char * t, const FXTRAN_char_info * ci, \
                             FXTRAN_xmlctx * ctx)                         \
{                                                                         \
  return FXTRAN_omptc_expr_list (t, ci, ctx, #T);                         \
}

#define def_FXTRAN_omptc_ktype(T) \
static int FXTRAN_omptc_##T (const char * t, const FXTRAN_char_info * ci, \
                             FXTRAN_xmlctx * ctx)                         \
{                                                                         \
  return FXTRAN_omptc_ktype (t, ci, ctx);                                 \
}

#define def_FXTRAN_omptc_list(T) \
static int FXTRAN_omptc_##T (const char * t, const FXTRAN_char_info * ci, \
                             FXTRAN_xmlctx * ctx)                         \
{                                                                         \
  return omptc_var_list (t, ci, ctx);                                     \
}

def_FXTRAN_omptc_simple (NOWAIT)
def_FXTRAN_omptc_simple (DISTRIBUTE)
def_FXTRAN_omptc_simple (LOOP)
def_FXTRAN_omptc_simple (DO)
def_FXTRAN_omptc_simple (INBRANCH)
def_FXTRAN_omptc_simple (NOTINBRANCH)
def_FXTRAN_omptc_simple (MASKED)
def_FXTRAN_omptc_simple (SECTIONS)
def_FXTRAN_omptc_simple (CAPTURE)
def_FXTRAN_omptc_simple (UNTIED)
def_FXTRAN_omptc_simple (MERGEABLE)
def_FXTRAN_omptc_simple (NOGROUP)
def_FXTRAN_omptc_simple (TASKLOOP)
def_FXTRAN_omptc_simple (UPDATE)
def_FXTRAN_omptc_simple (WRITE)
def_FXTRAN_omptc_simple (READ)
def_FXTRAN_omptc_simple (ACQUIRE)
def_FXTRAN_omptc_simple (RELEASE)
def_FXTRAN_omptc_simple (ACQ_REL)
def_FXTRAN_omptc_simple (PARALLEL)
def_FXTRAN_omptc_simple (UNIFIED_ADDRESS)
def_FXTRAN_omptc_simple (UNIFIED_SHARED_MEMORY)
def_FXTRAN_omptc_simple (DYNAMIC_ALLOCATORS)
def_FXTRAN_omptc_simple (REVERSE_OFFLOAD)
def_FXTRAN_omptc_simple (FULL)
def_FXTRAN_omptc_simple (INDIRECT)
def_FXTRAN_omptc_simple (NO_PARALLELISM)

def_FXTRAN_omptc_ktype (DEFAULT)
def_FXTRAN_omptc_ktype (BIND)
def_FXTRAN_omptc_ktype (ATOMIC_DEFAULT_MEM_ORDER)
def_FXTRAN_omptc_ktype (DEVICE_TYPE)
def_FXTRAN_omptc_ktype (SEVERITY)
def_FXTRAN_omptc_ktype (AT)

def_FXTRAN_omptc_expr (PARTIAL)
def_FXTRAN_omptc_expr (SIMD)
def_FXTRAN_omptc_expr (NUM_TEAMS)
def_FXTRAN_omptc_expr (THREAD_LIMIT)
def_FXTRAN_omptc_expr (COLLAPSE)
def_FXTRAN_omptc_expr (SIMDLEN)
def_FXTRAN_omptc_expr (SAFELEN)
def_FXTRAN_omptc_expr (NUM_THREADS)
def_FXTRAN_omptc_expr (PROC_BIND)
def_FXTRAN_omptc_expr (AFFINITY)
def_FXTRAN_omptc_expr (FINAL)
def_FXTRAN_omptc_expr (GRAINSIZE)
def_FXTRAN_omptc_expr (PRIORITY)
def_FXTRAN_omptc_expr (DETACH)
def_FXTRAN_omptc_expr (ORDERED)
def_FXTRAN_omptc_expr (HOLDS)
def_FXTRAN_omptc_expr (HINT)
def_FXTRAN_omptc_expr (FILTER)
def_FXTRAN_omptc_expr (VARIANT)
def_FXTRAN_omptc_expr (MESSAGE)

def_FXTRAN_omptc_expr_list (TO)
def_FXTRAN_omptc_expr_list (FROM)
def_FXTRAN_omptc_expr_list (SIZES)

def_FXTRAN_omptc_list (HAS_DEVICE_ADDR)
def_FXTRAN_omptc_list (UNIFORM)
def_FXTRAN_omptc_list (PRIVATE)
def_FXTRAN_omptc_list (FIRSTPRIVATE)
def_FXTRAN_omptc_list (SHARED)
def_FXTRAN_omptc_list (IS_DEVICE_PTR)
def_FXTRAN_omptc_list (USES_ALLOCATORS)
def_FXTRAN_omptc_list (COPYPRIVATE)
def_FXTRAN_omptc_list (COPYIN)
def_FXTRAN_omptc_list (ENTER)
def_FXTRAN_omptc_list (EXCLUSIVE)
def_FXTRAN_omptc_list (INCLUSIVE)

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
          goto FOUND;                             \
        }
      FXTRAN_omptc_list(test_macro)
#undef test_macro

      FXTRAN_THROW ("Unknown OpenMP Target clause");

FOUND:

      if (t[0] == ',')
        XAD(1);
    }
}

#define def_omptd_extra_clause_list(T) \
static void omptd_##T##_extra (const char * t, const FXTRAN_char_info * ci,  \
                               FXTRAN_xmlctx * ctx)                          \
{                                                                            \
  int k = strlen (#T);                                                       \
  XAD(k);                                                                    \
  return omptd_clause_list (t, ci, ctx);                                     \
}

def_omptd_extra_clause_list (TARGETENTERDATA)
def_omptd_extra_clause_list (TARGETEXITDATA)
def_omptd_extra_clause_list (TARGETPARALLELDO)
def_omptd_extra_clause_list (TARGETPARALLEL)
def_omptd_extra_clause_list (TARGETUPDATE)
def_omptd_extra_clause_list (TARGETTEAMS)
def_omptd_extra_clause_list (TARGETDATA)
def_omptd_extra_clause_list (TARGET)
def_omptd_extra_clause_list (ENDTARGETPARALLELDO)
def_omptd_extra_clause_list (ENDTARGETPARALLEL)
def_omptd_extra_clause_list (ENDTARGETTEAMS)
def_omptd_extra_clause_list (ENDTARGETDATA)
def_omptd_extra_clause_list (ENDTARGET)
def_omptd_extra_clause_list (ENDDECLARETARGET)
def_omptd_extra_clause_list (DECLARE)
def_omptd_extra_clause_list (PARALLELDOSIMD)
def_omptd_extra_clause_list (ENDPARALLELDOSIMD)
def_omptd_extra_clause_list (TASKWAIT)
def_omptd_extra_clause_list (TASK)
def_omptd_extra_clause_list (ENDTASK)
def_omptd_extra_clause_list (PARALLELMASTER)
def_omptd_extra_clause_list (ENDPARALLELMASTER)
def_omptd_extra_clause_list (PARALLEL)
def_omptd_extra_clause_list (ENDPARALLEL)
def_omptd_extra_clause_list (SIMD)
def_omptd_extra_clause_list (DOSIMD)
def_omptd_extra_clause_list (SINGLE)
def_omptd_extra_clause_list (ENDSINGLE)
def_omptd_extra_clause_list (MASKED)
def_omptd_extra_clause_list (ENDMASKED)
def_omptd_extra_clause_list (BARRIER)
def_omptd_extra_clause_list (SECTION)
def_omptd_extra_clause_list (ENDSECTION)
def_omptd_extra_clause_list (SECTIONS)
def_omptd_extra_clause_list (ENDSECTIONS)
def_omptd_extra_clause_list (ATOMIC)
def_omptd_extra_clause_list (ENDATOMIC)
def_omptd_extra_clause_list (DO)
def_omptd_extra_clause_list (ENDDO)
def_omptd_extra_clause_list (SCOPE)
def_omptd_extra_clause_list (ENDSCOPE)
def_omptd_extra_clause_list (TEAMS)
def_omptd_extra_clause_list (ENDTEAMS)
def_omptd_extra_clause_list (DISTRIBUTE)
def_omptd_extra_clause_list (ENDDISTRIBUTE)
def_omptd_extra_clause_list (REQUIRES)
def_omptd_extra_clause_list (TILE)
def_omptd_extra_clause_list (ENDTILE)
def_omptd_extra_clause_list (UNROLL)
def_omptd_extra_clause_list (ENDUNROLL)
def_omptd_extra_clause_list (ALLOCATORS)
def_omptd_extra_clause_list (ENDALLOCATORS)
def_omptd_extra_clause_list (WORKSHARE)
def_omptd_extra_clause_list (ENDWORKSHARE)
def_omptd_extra_clause_list (ORDERED)
def_omptd_extra_clause_list (ENDORDERED)
def_omptd_extra_clause_list (LOOP)
def_omptd_extra_clause_list (ENDLOOP)
def_omptd_extra_clause_list (TASKGROUP)
def_omptd_extra_clause_list (ENDTASKGROUP)
def_omptd_extra_clause_list (TASKYIELD)
def_omptd_extra_clause_list (SCAN)
def_omptd_extra_clause_list (ASSUMES)
def_omptd_extra_clause_list (ASSUME)
def_omptd_extra_clause_list (ENDASSUME)
def_omptd_extra_clause_list (ERROR)

static void omptd_THREADPRIVATE_extra (const char * t, const FXTRAN_char_info * ci, 
		                       FXTRAN_xmlctx * ctx)                         
{                                                                          
  int k;
  XAD(13);                                                                  
  k = omp_var_list (t, ci, ctx, _T(_S(VARIABLE) H _S(LIST)), 0);
  XAD (k);
}

static void omptd_DECLARETARGET_extra (const char * t, const FXTRAN_char_info * ci, 
		                       FXTRAN_xmlctx * ctx)                         
{                                                                          
  int k;
  XAD(13);                                                                  
  k = omp_var_list (t, ci, ctx, _T(_S(VARIABLE) H _S(LIST)), 1);
  XAD (k);
}

static void omptd_DEPOBJ_extra (const char * t, const FXTRAN_char_info * ci, 
		                FXTRAN_xmlctx * ctx)                         
{                                                                          
  int k;
  XAD(6);                                                                  
  k = omp_var_list (t, ci, ctx, _T(_S(VARIABLE) H _S(LIST)), 0);
  XAD (k);
}

static void omptd_CRITICAL_extra (const char * t, const FXTRAN_char_info * ci, 
		                  FXTRAN_xmlctx * ctx)                         
{                                                                          
  int k = FXTRAN_eat_word (t);

  XAD(k);                                                                  

  if (t[0] == '(')
    {
      XAD (1);

      k = FXTRAN_eat_word (t);

      if (k == 0)
        FXTRAN_THROW ("Malformed CRITICAL label");

      XST (_T(_S(NAME)));
      XAD(k);
      XET ();
    
      if (t[0] != ')')
        FXTRAN_THROW ("Malformed CRITICAL label");

      XAD (1);
    }

}

static void omptd_ENDCRITICAL_extra (const char * t, const FXTRAN_char_info * ci, 
		                     FXTRAN_xmlctx * ctx)                         
{                                                                          
  omptd_CRITICAL_extra (t, ci, ctx);
}

static void omptd_FLUSH_extra (const char * t, const FXTRAN_char_info * ci, 
		               FXTRAN_xmlctx * ctx)                         
{                                                                          
  XAD (5);
  FXTRAN_omptc_expr_list (t, ci, ctx, NULL);
}

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
