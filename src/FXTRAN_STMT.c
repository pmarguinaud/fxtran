/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "FXTRAN_MASK.h"
#include "FXTRAN_STMT.h"
#include "FXTRAN_MISC.h"

#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_EXPR.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_OMP.h"
#include "FXTRAN_ACC.h"
#include "FXTRAN_DDD.h"
#include "FXTRAN_ALPHA.h"

const char * FXTRAN_ops[] = { "+",  "-", "**", "*", "//", "/=", "/",
                              "==", ">=", ">", "<=", "<",  NULL };

const char * FXTRAN_types[] = { "LOGICAL", "REAL", "COMPLEX", "INTEGER", "CHARACTER",
                                "DOUBLEPRECISION", "DOUBLECOMPLEX", "TYPE", "CLASS",
                                "PROCEDURE", NULL };
const int FXTRAN_types_with_kind[] = { 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 };
const int FXTRAN_types_with_leng[] = { 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 };
const int FXTRAN_types_with_name[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0 };
const int FXTRAN_types_with_parm[] = { 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0 };
const int FXTRAN_types_intrinsic[] = { 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0 };


#define macro_name(x,n) \
  #x,
const char * FXTRAN_attr_name[] = {
  FXTRAN_attr_list(macro_name)
  NULL
};
#undef macro_name


#define macro_exec(t,x,nn,isatt) \
  x,
const char FXTRAN_stmt_exec[] = {
  0,
  FXTRAN_statement_list(macro_exec)
  0
};
#undef macro_exec



#define macro_std(t,x,nn,isatt) \
  (nn < 50 ? 2000+nn : 1900+nn),
const int FXTRAN_stmt_std[] = {
  0,
  FXTRAN_statement_list(macro_std)
  0
};
#undef macro_std



#define macro_attr(t,x,nn,isatt) \
 isatt,
const char FXTRAN_stmt_attr[] = {
  0,
  FXTRAN_statement_list(macro_attr)
  -1
};
#undef macro_attr



#define macro_name(t,x,nn,isatt) \
  #t,
const char * FXTRAN_stmt_name[] = {
  NULL,
  FXTRAN_statement_list(macro_name)
  NULL
};
#undef macro_name

#define ystrcmp(x,y) \
  (!strcmp (x,y))

#define zstrcmp(x,y) \
  (!strncmp (x,y,strlen(x)))

#define minnn(x,x1,x2) \
  do {                                            \
    x = 0;                                        \
    if (x1 > 0)                                   \
      x = x1;                                     \
    if ((x2 > 0) && ((x2 < x1) || (x1 == 0)))     \
      x = x2;                                     \
  } while (0)



#define def_extra_proto(T) \
static void stmt_##T##_extra (const char * t, const FXTRAN_char_info * ci, \
		              FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)

#define def_extra_proto_etc(T, ...) \
static void stmt_##T##_extra (const char * t, const FXTRAN_char_info * ci, \
		              FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx, __VA_ARGS__)

typedef struct xml_tu 
{
  int xml_ctu1;
  const char * xml_otu1[20];
  int xml_ctu2;
  const char * xml_otu2[20];
} xml_tu;

static const char * stmt_as_str (FXTRAN_stmt_type type)
{

  switch (type) 
    {
      case FXTRAN_ARITHMETICIF                      :  return _T(_S(ARITHMETIC) H _S(IF)              H _S(STMT));
      case FXTRAN_ASSIGNEDGOTO                      :  return _T(_S(ASSIGNED) H _S(GOTO)              H _S(STMT));
      case FXTRAN_COMPONENTDECL                     :  return _T(_S(COMPONENT) H _S(DECL)             H _S(STMT));
      case FXTRAN_POINTERASSIGNMENT                 :  return _T(_S(POINTER) H _S(ASSIGNMENT)         H _S(STMT));
      case FXTRAN_ASSIGNMENT                        :  return _T(_S(ASSIGNMENT)                       H _S(STMT));
      case FXTRAN_ASSOCIATE                         :  return _T(_S(ASSOCIATE)                        H _S(STMT));
      case FXTRAN_ASYNCHRONOUS                      :  return _T(_S(ASYNCHRONOUS)                     H _S(STMT));
      case FXTRAN_IF                                :  return _T(_S(IF)                               H _S(STMT));
      case FXTRAN_FORALL                            :  return _T(_S(FORALL)                           H _S(STMT));
      case FXTRAN_ALLOCATABLE                       :  return _T(_S(ALLOCATABLE)                      H _S(STMT));
      case FXTRAN_ALLOCATE                          :  return _T(_S(ALLOCATE)                         H _S(STMT));
      case FXTRAN_ASSIGN                            :  return _T(_S(ASSIGN)                           H _S(STMT));
      case FXTRAN_BACKSPACE                         :  return _T(_S(BACKSPACE)                        H _S(STMT));
      case FXTRAN_BIND                              :  return _T(_S(BIND)                             H _S(STMT));
      case FXTRAN_BLOCK                             :  return _T(_S(BLOCK)                            H _S(STMT));
      case FXTRAN_BLOCKDATA                         :  return _T(_S(BLOCK) H _S(DATA)                 H _S(STMT));
      case FXTRAN_CALL                              :  return _T(_S(CALL)                             H _S(STMT));
      case FXTRAN_CASE                              :  return _T(_S(CASE)                             H _S(STMT));
      case FXTRAN_CHANGETEAM                        :  return _T(_S(CHANGE) H _S(TEAM)                H _S(STMT));
      case FXTRAN_SELECTRANKCASE                    :  return _T(_S(SELECT) H _S(RANK) H _S(CASE)     H _S(STMT));
      case FXTRAN_CLASS                             :  return _T(_S(CLASS)                            H _S(STMT));
      case FXTRAN_CLASSIS                           :  return _T(_S(CLASS) H _S(IS)                   H _S(STMT));
      case FXTRAN_CLOSE                             :  return _T(_S(CLOSE)                            H _S(STMT));
      case FXTRAN_CODIMENSION                       :  return _T(_S(CODIMENSION)                      H _S(STMT));
      case FXTRAN_COMMON                            :  return _T(_S(COMMON)                           H _S(STMT));
      case FXTRAN_COMPUTEDGOTO                      :  return _T(_S(COMPUTED) H _S(GOTO)              H _S(STMT));
      case FXTRAN_CONTAINS                          :  return _T(_S(CONTAINS)                         H _S(STMT));
      case FXTRAN_CONTIGUOUS                        :  return _T(_S(CONTIGUOUS)                       H _S(STMT));
      case FXTRAN_CONTINUE                          :  return _T(_S(CONTINUE)                         H _S(STMT));
      case FXTRAN_CRAYPOINTER                       :  return _T(_S(CRAY) H _S(POINTER)               H _S(STMT));
      case FXTRAN_CRITICAL                          :  return _T(_S(CRITICAL)                         H _S(STMT));
      case FXTRAN_CYCLE                             :  return _T(_S(CYCLE)                            H _S(STMT));
      case FXTRAN_TYPEDECL                          :  return _T(_S(TYPE) H _S(DECL)                  H _S(STMT));
      case FXTRAN_DATA                              :  return _T(_S(DATA)                             H _S(STMT));
      case FXTRAN_DEALLOCATE                        :  return _T(_S(DEALLOCATE)                       H _S(STMT));
      case FXTRAN_DIMENSION                         :  return _T(_S(DIMENSION)                        H _S(STMT));
      case FXTRAN_DO                                :  return _T(_S(DO)                               H _S(STMT));
      case FXTRAN_DOLABEL                           :  return _T(_S(DO) H _S(LABEL)                   H _S(STMT));
      case FXTRAN_ENDASSOCIATE                      :  return _T(_S(END) H _S(ASSOCIATE)              H _S(STMT));
      case FXTRAN_ENDBLOCK                          :  return _T(_S(END) H _S(BLOCK)                  H _S(STMT));
      case FXTRAN_ENDBLOCKDATA                      :  return _T(_S(END) H _S(BLOCK) H _S(DATA)       H _S(STMT));
      case FXTRAN_ENDCHANGETEAM                     :  return _T(_S(END) H _S(CHANGE) H _S(TEAM)      H _S(STMT));
      case FXTRAN_ENDCLASS                          :  return _T(_S(END) H _S(CLASS)                  H _S(STMT));
      case FXTRAN_ENDCRITICAL                       :  return _T(_S(END) H _S(CRITICAL)               H _S(STMT));
      case FXTRAN_ENDDO                             :  return _T(_S(END) H _S(DO)                     H _S(STMT));
      case FXTRAN_ENDFORALL                         :  return _T(_S(END) H _S(FORALL)                 H _S(STMT));
      case FXTRAN_ENDFUNCTION                       :  return _T(_S(END) H _S(FUNCTION)               H _S(STMT));
      case FXTRAN_ENDINTERFACE                      :  return _T(_S(END) H _S(INTERFACE)              H _S(STMT));
      case FXTRAN_ENDMODULE                         :  return _T(_S(END) H _S(MODULE)                 H _S(STMT));
      case FXTRAN_ENDPROCEDURE                      :  return _T(_S(END) H _S(PROCEDURE)              H _S(STMT));
      case FXTRAN_ENDPROGRAM                        :  return _T(_S(END) H _S(PROGRAM)                H _S(STMT));
      case FXTRAN_ENDSELECTCASE                     :  return _T(_S(END) H _S(SELECT) H _S(CASE)      H _S(STMT));
      case FXTRAN_ENDSELECTRANK                     :  return _T(_S(END) H _S(SELECT) H _S(RANK)      H _S(STMT));
      case FXTRAN_ENDSELECTTYPE                     :  return _T(_S(END) H _S(SELECT) H _S(TYPE)      H _S(STMT));
      case FXTRAN_ENDSUBMODULE                      :  return _T(_S(END) H _S(SUBMODULE)              H _S(STMT));
      case FXTRAN_ENDSUBROUTINE                     :  return _T(_S(END) H _S(SUBROUTINE)             H _S(STMT));
      case FXTRAN_ENDTYPE                           :  return _T(_S(END) H _S(TYPE)                   H _S(STMT));
      case FXTRAN_ENDWHERE                          :  return _T(_S(END) H _S(WHERE)                  H _S(STMT));
      case FXTRAN_ENDFILE                           :  return _T(_S(END) H _S(FILE)                   H _S(STMT));
      case FXTRAN_ELSEIF                            :  return _T(_S(ELSE) H _S(IF)                    H _S(STMT));
      case FXTRAN_ELSE                              :  return _T(_S(ELSE)                             H _S(STMT));
      case FXTRAN_ELSEWHERE                         :  return _T(_S(ELSE) H _S(WHERE)                 H _S(STMT));
      case FXTRAN_ENDIF                             :  return _T(_S(END) H _S(IF)                     H _S(STMT));
      case FXTRAN_ENTRY                             :  return _T(_S(ENTRY)                            H _S(STMT));
      case FXTRAN_ENDENUM                           :  return _T(_S(END) H _S(ENUM)                   H _S(STMT));
      case FXTRAN_ENUM                              :  return _T(_S(ENUM)                             H _S(STMT));
      case FXTRAN_ENUMERATOR                        :  return _T(_S(ENUMERATOR)                       H _S(STMT));
      case FXTRAN_EQUIVALENCE                       :  return _T(_S(EQUIVALENCE)                      H _S(STMT));
      case FXTRAN_EXIT                              :  return _T(_S(EXIT)                             H _S(STMT));
      case FXTRAN_EXTERNAL                          :  return _T(_S(EXTERNAL)                         H _S(STMT));
      case FXTRAN_EVENTPOST                         :  return _T(_S(EVENT) H _S(POST)                 H _S(STMT));
      case FXTRAN_EVENTWAIT                         :  return _T(_S(EVENT) H _S(WAIT)                 H _S(STMT));
      case FXTRAN_FINAL                             :  return _T(_S(FINAL)                            H _S(STMT));
      case FXTRAN_FLUSH                             :  return _T(_S(FLUSH)                            H _S(STMT));
      case FXTRAN_FORALLCONSTRUCT                   :  return _T(_S(FORALL) H _S(CONSTRUCT)           H _S(STMT));
      case FXTRAN_FORMTEAM                          :  return _T(_S(FORM) H _S(TEAM)                  H _S(STMT));
      case FXTRAN_FORMAT                            :  return _T(_S(FORMAT)                           H _S(STMT));
      case FXTRAN_FUNCTION                          :  return _T(_S(FUNCTION)                         H _S(STMT));
      case FXTRAN_GENERIC                           :  return _T(_S(GENERIC)                          H _S(STMT));
      case FXTRAN_GOTO                              :  return _T(_S(GOTO)                             H _S(STMT));
      case FXTRAN_IFTHEN                            :  return _T(_S(IF) H _S(THEN)                    H _S(STMT));
      case FXTRAN_IMPLICITNONE                      :  return _T(_S(IMPLICIT) H _S(NONE)              H _S(STMT));
      case FXTRAN_IMPLICIT                          :  return _T(_S(IMPLICIT)                         H _S(STMT));
      case FXTRAN_IMPORT                            :  return _T(_S(IMPORT)                           H _S(STMT));
      case FXTRAN_INCLUDE                           :  return _T(_S(INCLUDE)                          H _S(STMT));
      case FXTRAN_INQUIRE                           :  return _T(_S(INQUIRE)                          H _S(STMT));
      case FXTRAN_INTENT                            :  return _T(_S(INTENT)                           H _S(STMT));
      case FXTRAN_INTERFACE                         :  return _T(_S(INTERFACE)                        H _S(STMT));
      case FXTRAN_INTRINSIC                         :  return _T(_S(INTRINSIC)                        H _S(STMT));
      case FXTRAN_LOCK                              :  return _T(_S(LOCK)                             H _S(STMT));
      case FXTRAN_PROCEDURE                         :  return _T(_S(PROCEDURE)                        H _S(STMT));
      case FXTRAN_MODULE                            :  return _T(_S(MODULE)                           H _S(STMT));
      case FXTRAN_NAMELIST                          :  return _T(_S(NAMELIST)                         H _S(STMT));
      case FXTRAN_NULLIFY                           :  return _T(_S(NULLIFY)                          H _S(STMT));
      case FXTRAN_OPEN                              :  return _T(_S(OPEN)                             H _S(STMT));
      case FXTRAN_OPTIONAL                          :  return _T(_S(OPTIONAL)                         H _S(STMT));
      case FXTRAN_PAUSE                             :  return _T(_S(PAUSE)                            H _S(STMT));
      case FXTRAN_PARAMETER                         :  return _T(_S(PARAMETER)                        H _S(STMT));
      case FXTRAN_POINTER                           :  return _T(_S(POINTER)                          H _S(STMT));
      case FXTRAN_PROGRAM                           :  return _T(_S(PROGRAM)                          H _S(STMT));
      case FXTRAN_PRINT                             :  return _T(_S(PRINT)                            H _S(STMT));
      case FXTRAN_PRIVATE                           :  return _T(_S(PRIVATE)                          H _S(STMT));
      case FXTRAN_PROTECTED                         :  return _T(_S(PROTECTED)                        H _S(STMT));
      case FXTRAN_PUBLIC                            :  return _T(_S(PUBLIC)                           H _S(STMT));
      case FXTRAN_READ                              :  return _T(_S(READ)                             H _S(STMT));
      case FXTRAN_RETURN                            :  return _T(_S(RETURN)                           H _S(STMT));
      case FXTRAN_REWIND                            :  return _T(_S(REWIND)                           H _S(STMT));
      case FXTRAN_SAVE                              :  return _T(_S(SAVE)                             H _S(STMT));
      case FXTRAN_SELECTCASE                        :  return _T(_S(SELECT) H _S(CASE)                H _S(STMT));
      case FXTRAN_SELECTRANK                        :  return _T(_S(SELECT) H _S(RANK)                H _S(STMT));
      case FXTRAN_SELECTTYPE                        :  return _T(_S(SELECT) H _S(TYPE)                H _S(STMT));
      case FXTRAN_SEQUENCE                          :  return _T(_S(SEQUENCE)                         H _S(STMT));
      case FXTRAN_STOP                              :  return _T(_S(STOP)                             H _S(STMT));
      case FXTRAN_ERRORSTOP                         :  return _T(_S(ERROR) H _S(STOP)                 H _S(STMT));
      case FXTRAN_SUBMODULE                         :  return _T(_S(SUBMODULE)                        H _S(STMT));
      case FXTRAN_SUBROUTINE                        :  return _T(_S(SUBROUTINE)                       H _S(STMT));
      case FXTRAN_SYNCALL                           :  return _T(_S(SYNC) H _S(ALL)                   H _S(STMT));
      case FXTRAN_SYNCIMAGES                        :  return _T(_S(SYNC) H _S(IMAGES)                H _S(STMT));
      case FXTRAN_SYNCMEMORY                        :  return _T(_S(SYNC) H _S(MEMORY)                H _S(STMT));
      case FXTRAN_SYNCTEAM                          :  return _T(_S(SYNC) H _S(TEAM)                  H _S(STMT));
      case FXTRAN_TARGET                            :  return _T(_S(TARGET)                           H _S(STMT));
      case FXTRAN_TYPE                              :  return _T(_S(TYPE)                             H _S(STMT));
      case FXTRAN_TYPEIS                            :  return _T(_S(TYPE) H _S(IS)                    H _S(STMT));
      case FXTRAN_UNLOCK                            :  return _T(_S(UNLOCK)                           H _S(STMT));
      case FXTRAN_USE                               :  return _T(_S(USE)                              H _S(STMT));
      case FXTRAN_VALUE                             :  return _T(_S(VALUE)                            H _S(STMT));
      case FXTRAN_VOLATILE                          :  return _T(_S(VOLATILE)                         H _S(STMT));
      case FXTRAN_WAIT                              :  return _T(_S(WAIT)                             H _S(STMT));
      case FXTRAN_WHERE                             :  return _T(_S(WHERE)                            H _S(STMT));
      case FXTRAN_WHERECONSTRUCT                    :  return _T(_S(WHERE) H _S(CONSTRUCT)            H _S(STMT));
      case FXTRAN_WRITE                             :  return _T(_S(WRITE)                            H _S(STMT));
      case FXTRAN_NONE:
      case FXTRAN_LAST:
      break;
   }
  return NULL;
}


#define skip_dc() \
do {                                       \
  if (t[0] == ':')                         \
    {                                      \
      if (t[1] == ':')                     \
        {                                  \
          XAD(2);                          \
        }                                  \
      else                                 \
        {                                  \
          FXTRAN_THROW ("Expected `::'");  \
          return;                          \
        }                                  \
    }                                      \
} while (0)


static int stmt_unit_name (const char * t, const FXTRAN_char_info * ci, 
		           const char * T, const char * N, FXTRAN_xmlctx * ctx)
{
  int k1 = strlen (T);
  int k2;
 
  if (k1 > strlen (t))
    return 0;

  k2 = FXTRAN_eat_word (&t[k1]);

  XAD (k1);
  XST (N);
  XNT (_T(_S(NAME)), k2);
  XAD (k2);
  XET ();

  return k1+k2;
}

/* TODO : add a tag for named labels; eg : _T(_S(NAMED) H _S(LABEL)) */

static int stmt_eos_named_label (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int k = FXTRAN_eat_word (t);

  if (k == 0)
    return 0;

  XSP();

  XNT (_T(_S(NAME)), k);

  return k+1;
}

static int stmt_bos_named_label (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int k = FXTRAN_eat_word (t);

  if (k == 0)
    return 0;

  if (t[k] == ':')
    {
      XNT (_T(_S(NAME)), k);
      return k+1;
    }

  return 0;
}

static int stmt_endunit_name (const char * t, const FXTRAN_char_info * ci, 
                              const char * s, const char * N, FXTRAN_xmlctx * ctx)
{
  int k;
  const char * T = t;

  if (zstrcmp (s, t))
    {
      int len = strlen (s);
      XAD(len);
    }
  else
    {
      return 0;
    }

  k = strlen (t);
  if (k == 0)
    return 0;

  XST (N);
  XNT (_T(_S(NAME)), k);
  XAD (k);
  XET ();

  return t - T;
}


static int stmt_unit_dummy_args (const char * t, const FXTRAN_char_info * ci, 
		                 FXTRAN_xmlctx * ctx, FXTRAN_stmt_stack * stack)
{
  int 
    k1 = FXTRAN_str_at_level (t, ci, "(", 0),
    k2 = FXTRAN_str_at_level (t, ci, ")", 0);


  if (k2-k1-1 > 0)
    {
      XAD(k1);
      XST (_T(_S(DUMMY) H _S(ARG) H _S(LIST)));

      while (t[0])
        {
          int k;
	 
          if (t[0] == '*')
            {
              FXTRAN_xml_word_tag (_T(_S(ALT) H _S(RETURN) H _S(SPEC)), ci->offset, ci->offset+1, ctx);
	      XAD(1);
            }
	  else
            {
	      k = FXTRAN_eat_word (t);
	      XST (_T(_S(ARG) H _S(NAME)));
	      XNT (_T(_S(NAME)), k);
	      XAD(k);
	      XET ();
	    }

	  if (t[0] != ',')
            break;

          XAD(1);

        }

      XET ();
    }
  else if (k1 > 0)
    {
      XAD(k1);
      XST (_T(_S(DUMMY) H _S(ARG) H _S(LIST)));
      XET ();
    }

  return k2;
}


typedef struct stmt_actual_args_parms
{
  const char * argl;
  const char * argn;
  int allow_column;
  int typespec;
  int list;
  int allow_asterix;
} 
stmt_actual_args_parms;

#define def_actual_args(n,x,c,t,l,a) \
static stmt_actual_args_parms saap_##n = \
  { _T(x H _S(SPEC)), _T(x), c, t, l, a }

#define def_actual_argsl(n,x,l,c,t,a) \
static stmt_actual_args_parms saap_##n = \
  { _T(l), _T(x), c, t, 1, a }

def_actual_args (  actual,                             _S(ARG), 0, 0, 1, 0);
def_actual_args (allocate,                             _S(ARG), 0, 1, 1, 0);
def_actual_args (    sync,                             _S(ARG), 0, 1, 1, 1);
def_actual_args ( filepos,                  _S(POS) H _S(SPEC), 0, 0, 1, 0);
def_actual_args (   close,                _S(CLOSE) H _S(SPEC), 0, 0, 1, 0);
def_actual_args (    open,              _S(CONNECT) H _S(SPEC), 0, 0, 1, 0);
def_actual_args (   flush,                _S(FLUSH) H _S(SPEC), 0, 0, 1, 0);
def_actual_args ( inquiry,              _S(INQUIRY) H _S(SPEC), 0, 0, 1, 0);
def_actual_args (      io,                _S(IO) H _S(CONTROL), 0, 0, 1, 1);
def_actual_args (    wait,                 _S(WAIT) H _S(SPEC), 0, 0, 1, 0);
def_actual_args ( kindsel,                 _S(KIND) H _S(SPEC), 0, 0, 0, 0);
def_actual_args ( charsel,                 _S(CHAR) H _S(SPEC), 1, 0, 0, 1);

def_actual_argsl (typeparmspec, _S(TYPE) H _S(PARAMETER) H _S(SPEC), 
                  _S(TYPE) H _S(PARAMETER) H _S(SPEC) H _S(LIST), 1, 0, 1);
def_actual_argsl (typeparmname, _S(TYPE) H _S(PARAMETER) H _S(NAME), 
                  _S(TYPE) H _S(PARAMETER) H _S(NAME) H _S(LIST), 0, 0, 0);


#undef def_actual_args


static int stmt_actual_args (const char *, const FXTRAN_char_info *, 
		             FXTRAN_xmlctx *, const stmt_actual_args_parms *);

static int ts_with_args (const char * t, const FXTRAN_char_info * ci,
                         FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int intrinsic = 0, i;
  int kdn  = FXTRAN_eat_word (t);
  char w[kdn+1];
  strncpy (&w[0], t, kdn); w[kdn] = '\0';

  for (i = 0; FXTRAN_types[i]; i++)
    if ((FXTRAN_types_intrinsic[i]) && (0 == strcmp (FXTRAN_types[i], w)))
      {
        intrinsic = 1;
        break;
      }

  if (intrinsic)
    {
      int k = FXTRAN_typespec (t, ci, ctx);
      XAD (k);
    }
  else
    {
      int k = FXTRAN_eat_word (t);
      XST (_T(_S(DERIVED) H _S(TYPE) H _S(SPEC)));
      XST (_T(_S(TYPE) H _S(NAME)));
      XNT (_T(_S(NAME)), k);
      XAD(k);
      if (t[0] == '(')
        {
          k = stmt_actual_args (t, ci, ctx, &saap_typeparmspec);
          XAD (k);
        }
      XET ();
      XET ();
    }
  return t - T;
}

static int stmt_actual_args (const char * t, const FXTRAN_char_info * ci, 
		             FXTRAN_xmlctx * ctx, const stmt_actual_args_parms * saap)
{
  const char * T = t;

  if (t[0] != '(')
    return 0;

  XAD(1);

  if (t[0] == ')')
    {
      XST (saap->argl);
      XET ();
      return 2;
    }

  if (saap->typespec)
    {
      int kdc = FXTRAN_str_at_level (t, ci, "::", ci->parens);
      if (kdc)
        {
          int k = ts_with_args (t, ci, ctx);
	  XAD (k);
          if ((t[0] != ':') && (t[1] != ':'))
            FXTRAN_ABORT ("Expected ::");
          XAD(2);
        }
    }

  if (saap->list)
    XST (saap->argl);

  while (t[0])
    {
      if ((t[0] == '*') && ((t[1] == ',') || (t[1] == ')')) && saap->allow_asterix)
        {
          XST (saap->argn);
          XAD (1);
          XET ();
        }
      else if (t[0] == '*') /* Alternate return */
        {
         int k;

          XST (saap->argn);
          XAD (1);

          XST (_T(_S(LABEL)));

          for (k = 0; isdigit (t[k]); k++);

          if (k == 0)
            FXTRAN_ABORT ("Expected label", ctx);

          XAD(k);
          XET ();
          
          XET ();

          if ((t[0] != ')') && (t[0] != ','))
            FXTRAN_ABORT ("Expected `,' or `)'", ctx);

        }
      else
        {
          int kn = FXTRAN_eat_word (t);
          int kc;
          int kp = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);

          kc = FXTRAN_str_at_level_ir (t, ci, ",", ci->parens, kp);

          if (!kc)
            kc = kp;

          XST (saap->argn);

          if (kn && (t[kn] == '=') && (t[kn+1] != '='))
            {
              XNW (_T(_S(ARG) H _S(NAME)), kn);
              XAD(kn+1); 
              kc = kc - (kn+1);
            }

          if ((! saap->allow_column) || (t[0] != ':'))
            {
              FXTRAN_expr (t, ci, kc-1, ctx);
            }

          XAD(kc-1);

          XET ();
        }

      if (t[0] == ')')
        break;

      XAD(1);
      
    }

  if (saap->list)
    XET ();

  return t - T + 1;
}

int FXTRAN_actual_args (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return stmt_actual_args (t, ci, ctx, &saap_actual);
}

int FXTRAN_process_list (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, const char * sep, 
		         const char * lstn, int kmax, 
		         int (*process_list_elt)(const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *, int, void *),
			 void * data)
{
  int lev = ci->parens;
  const char * T = t;
  int i;
  int k;

  XST (lstn);

  while (t[0] && (t - T < kmax))
    {
      k = FXTRAN_str_at_level (t, ci, sep, lev);
      if (k == 0)
        k = strlen (t);
      else
	k = k - 1;
      for (i = 0; i < k; i++)
        if ((ci[i].parens < lev) || (&t[i] - T >= kmax))
          {
            k = i;
	    break;
	  }
      if (k == 0)
        goto done;
      if (process_list_elt (t, ci, ctx, k, data) < 0)
        {
          if ((t - T > 0) && (t[-1] == ','))
            XAD(-1);
	  goto done;
        }
      XAD(k);
      if (t[0] == ',')
        XAD(1);
    }
done:

  XET ();

  return t - T;
}

def_process_list_elt_proto (shape_spec)
{
  const char * T = t;
  int k;

  XST (_T(_S(SHAPE) H _S(SPEC)));

  if ((kmax == 2) && (t[0] == '.') && (t[1] == '.'))
    {
      XAD (2);
    }
  else
    {
      k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax);
      if (k)
        {
          if (k > 1)
            {
              XST (_T(_S(LOWER) H _S(BOUND)));
              FXTRAN_expr (t, ci, k-1, ctx);
              XAD(k-1);
              XET ();
            }
          XAD(1);
     
          kmax = kmax - (t - T);
        }
     
      if (kmax)
        {
          XST (_T(_S(UPPER) H _S(BOUND)));
          FXTRAN_expr (t, ci, kmax, ctx);
          XAD(kmax);
          XET ();
        }
    }

  XET ();
  return 1;
}

def_process_list_elt_proto (coshape_spec)
{
  const char * T = t;
  int k;

  XST (_T(_S(SHAPE) H _S(SPEC)));

  k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax);

  if (k)
    {
      if (k > 1)
        {
          XST (_T(_S(LOWER) H _S(COBOUND)));
          FXTRAN_expr (t, ci, k-1, ctx);
          XAD(k-1);
          XET ();
        }
      XAD(1);

      kmax = kmax - (t - T);
    }

  if (kmax)
    {
      XST (_T(_S(UPPER) H _S(COBOUND)));
      FXTRAN_expr (t, ci, kmax, ctx);
      XAD(kmax);
      XET ();
    }

  XET ();
  return 1;
}


static int coarray_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx *ctx)
{
  const char * T = t;
  int lev = ci[0].parens;
  int k;

  if (t[0] == '[')
    {
      XST (_T(_S(COARRAY) H _S(SPEC)));
      XAD(1);
      if ((k = FXTRAN_str_at_level (t, ci, "]", lev)))
        {

          FXTRAN_process_list (t, ci, ctx, ",", _T(_S(COSHAPE) H _S(SPEC) H _S(LIST)), k,
			       coshape_spec, NULL);
	  XAD(k-1);
          XAD(1);
          XET ();
        }
       
    }

  return t - T;
}

static int array_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx *ctx)
{
  const char * T = t;
  int lev = ci[0].parens;
  int k;

  if (t[0] == '(')
    {
      XST (_T(_S(ARRAY) H _S(SPEC)));
      XAD(1);
      if ((k = FXTRAN_str_at_level (t, ci, ")", lev)))
        {

          FXTRAN_process_list (t, ci, ctx, ",", _T(_S(SHAPE) H _S(SPEC) H _S(LIST)), k,
			       shape_spec, NULL);
	  XAD(k-1);
          XAD(1);
          XET ();
        }
       
    }

  return t - T;
}

static int stmt_old_cl (const char * t , const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  if (t[0] == '*')
    {
      XST (_T(_S(CHAR) H _S(SELECTOR)));
      XAD(1);
      if (t[0] == '(')
        {
          int k = FXTRAN_str_at_level (t, ci, ")", ci->parens);
          XAD(1);
          if ((t[0] == ':') && (t[1] == ')')) /* Parse *(:) */
            {
              XAD (2);
            }
          else
            {
	      k = k - 1;
	      FXTRAN_expr (t, ci, k-1, ctx);
	      XAD(k);
            }
	}
      else if (isdigit (t[0]))
        {
          int k;
	  XST (_T(_S(LITERAL) H _S(EXPR)));

          for (k = 0; isdigit (t[k]); k++);

          xml_mark_lit (ci->offset, ci[k-1].offset+1, ctx);
          XAD(k);

          XET ();
        }

      XET ();
    }
  else
    {
      return 0;
    }
  return t - T;
}

static int FXTRAN_stmt_init_expr (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int lev = ci[0].parens;
  int k;

  if ((t[0] == '=') && (t[1] == '>'))
    XAD(2);
  else if (t[0] == '=')
    XAD(1);
  else
    return 0;

  if ((k = FXTRAN_str_at_level (t, ci, ",", lev)) == 0)
    k = lev == 0 ? strlen (t) : FXTRAN_str_at_level (t, ci, ")", lev-1)-1;
  else
    k = k - 1;

  XST (_T(_S(INIT) H _S(EXPR)));

  FXTRAN_expr (t, ci, k, ctx);

  XAD(k);

  XET ();

  return t - T;
}

typedef struct stmt_entity_decl_parms
{
  const char * lst;
  const char * lste;
  const char * lsten;
} 
stmt_entity_decl_parms;


static stmt_entity_decl_parms seda_entity = 
{
  _T(_S(ENTITY) H _S(DECL) H _S(LIST)),
  _T(_S(ENTITY) H _S(DECL)),
  _T(_S(ENTITY) H _S(NAME))
};

static stmt_entity_decl_parms seda_common = 
{
  _T(_S(COMMON) H _S(BLOCK) H _S(OBJECT) H _S(LIST)),
  _T(_S(COMMON) H _S(BLOCK) H _S(OBJECT)),
  _T(_S(COMMON) H _S(BLOCK) H _S(OBJECT) H _S(NAME))
};

static stmt_entity_decl_parms seda_namelist = 
{
  _T(_S(NAMELIST) H _S(GROUP) H _S(OBJECT) H _S(LIST)),
  _T(_S(NAMELIST) H _S(GROUP) H _S(OBJECT)),
  _T(_S(NAMELIST) H _S(GROUP) H _S(OBJECT) H _S(NAME))
};

static stmt_entity_decl_parms seda_enumerator = 
{
  _T(_S(ENUMERATOR) H _S(LIST)),
  _T(_S(ENUMERATOR)),
  _T(_S(NAMED) H _S(CONSTANT))
};

def_process_list_elt_proto (data_stmt_value);

static int stmt_entity (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int no_allow_data_init,
		        int allow_common, const stmt_entity_decl_parms * seda, FXTRAN_stmt_stack * stack)
{
  int k;
  const char * T;
  int common = 0;

  T = t;

  if (t[0] == 0)
    return 0;

  common = allow_common && (t[0] == '/');

  if (common)
    {
      XAD (1);
      XST (_T(_S(COMMON) H _S(BLOCK) H _S(NAME)));
      k = FXTRAN_eat_word (t);
      XNT (_T(_S(NAME)), k);
      XAD(k);
      XET ();
      if (t[0] != '/')
        FXTRAN_ABORT ("Expected '/'");
      XAD(1);
    }
  else
    {
      XST (seda->lste);

      k = FXTRAN_eat_word (t);

      XST (seda->lsten);
     
      XNT (_T(_S(NAME)), k);
      XAD(k);
      XET ();

      if (t[0] == '\0')
        {
          XET ();
          return t - T;
        }

      k = array_spec (t, ci, ctx);
      XAD(k);
     
      k = coarray_spec (t, ci, ctx);
      XAD(k);
     
      k = stmt_old_cl (t, ci, ctx);
      XAD(k);
     
      if ((k = FXTRAN_stmt_init_expr (t, ci, ctx)))
        {
          XAD(k);
        }
      else if ((t[0] == '/') && (! no_allow_data_init))
        {
          /* This is not legal, but all compilers accept it : real  sin36(2) /2*0.587785252292473/ */
          int k;
          XAD (1);
          k = FXTRAN_str_at_level (t, ci, "/", 0);
          if (k == 0)
            FXTRAN_THROW ("Expected `/'");
          FXTRAN_process_list (t, ci, ctx, ",", 
            	           _T(_S(DATA) H _S(STMT) H _S(VALUE) H _S(LIST)), 
            		   k-1, data_stmt_value, NULL);
      
          XAD(k);
        }
     
      XET ();
    }

  return t - T;
}

static void stmt_entity_list (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int no_allow_data_init,
			      int allow_common, const stmt_entity_decl_parms * seda, FXTRAN_stmt_stack * stack)
{
  int k;

  if (t[0] == 0)
    return;

  XST (seda->lst);
  while (t[0] && (k = stmt_entity (t, ci, ctx, no_allow_data_init, allow_common, seda, stack)))
    {
      XAD(k);
      if (t[0] == ',')
        XAD(1);
      else
        break;
    }

  XET ();

  return;
}


static int FXTRAN_generic_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  if (zstrcmp ("OPERATOR(", t))
    {
      XAD(9);
      k = FXTRAN_str_at_level (t, ci, ")", 0);

      XNO (_T(_S(OPERATOR)), k-1);
      XAD(k);
    }
  else if (zstrcmp ("READ(", t) || zstrcmp ("WRITE(", t))
    {
      k = FXTRAN_eat_word (t);
      XST (_T(_S(DTIO) H _S(SPEC) H _S(NAME)));
      XAD(k);
      XET ();
      XAD(1);
      k = FXTRAN_str_at_level (t, ci, ")", 0);


      XST (_T(_S(DTIO) H _S(SPEC) H _S(FORMAT)));
      XAD(k-1);
      XET ();
      XAD(1);
    }
  else if (zstrcmp ("ASSIGNMENT(=)", t))
    {
      XAD(11);
      XST (_T(_S(ASSIGNMENT)));
      XAD(1);
      XET ();
      XAD(1);
    }
  else if ((k = FXTRAN_eat_word (t)))
    {
      XNT (_T(_S(NAME)), k);
      XAD(k);
    }

  return t - T;
}

static int clkd_of_type (const char * t, const FXTRAN_char_info * ci, 
                         FXTRAN_xmlctx * ctx, const char * spn,
                         stmt_actual_args_parms * saap)
{
  const char * T = t;
  int i;
  int k = 0;

  if ((t[0] == '*') && (isdigit (t[1])))
    {
      for (i = 1; t[i]; i++)
        if (!isdigit (t[i]))
          {
	    XST (spn);
	    XAD(1);
            k = i-1;

            xml_mark_lit (ci->offset, ci[k-1].offset+1, ctx);
	    XST (_T(_S(LITERAL) H _S(EXPR)));
            XAD(k);
	    XET ();

            XET ();
            goto end;
          }
    }

  if ((t[0] == '(') || zstrcmp ("*(", t))
    {
      int k;

      XST (spn);
      if (t[0] == '*')
        XAD(1);

      k = stmt_actual_args (t, ci, ctx, saap);
      XAD(k);
      XET ();
      goto end;
    }

end:
  return t - T;
}

static int leng_of_type (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return clkd_of_type (t, ci, ctx, _T(_S(CHAR) H _S(SELECTOR)), &saap_charsel); /* TODO : be more restrictive */
}

static int kind_of_type (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return clkd_of_type (t, ci, ctx, _T(_S(KIND) H _S(SELECTOR)), &saap_kindsel); /* TODO : be more restrictive */
}

static int parm_of_type (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int ktype)
{
  const char * T = t;
  int k;

  if (t[0] != '(')
    return 0;

  XAD(1);
  if ((t[0] == '*') && (t[1] == ')'))
    {
      k = 1;
      XST (_T(_S(TYPE) H _S(NAME)));
      XAD(k);
      XET ();
    }
  else
    {
      if ((FXTRAN_types_with_name[ktype] != 2) || (t[0] != ')'))
        {
          k = FXTRAN_eat_word (t);
          XST (_T(_S(TYPE) H _S(NAME)));
          XNT (_T(_S(NAME)), k);
          XAD(k);
          XET ();
        }
    }

  if (t[0] == '(')
    {
      k = stmt_actual_args (t, ci, ctx, &saap_typeparmspec);
      XAD(k);
    }

  if (t[0] != ')')
    FXTRAN_THROW ("Expected closing `)'"); 

  XAD(1);

  return t - T;
}

static int name_of_type (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int ktype)
{
  return parm_of_type (t, ci, ctx, ktype); /* TODO : be more restrictive */
}

static int typespec_ext (const char * t, const FXTRAN_char_info * ci, 
                         FXTRAN_xmlctx * ctx, const int ktype)
{
  if (FXTRAN_types_with_kind[ktype])
    return kind_of_type (t, ci, ctx);
  else if (FXTRAN_types_with_leng[ktype])
    return leng_of_type (t, ci, ctx);
  else if (FXTRAN_types_with_name[ktype])
    return name_of_type (t, ci, ctx, ktype);
  else if (FXTRAN_types_with_parm[ktype])
    return parm_of_type (t, ci, ctx, ktype);
  return 0;
}

static int FXTRAN_procedure_typespec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int i;
  int k;
  XST (_T(_S(PROCEDURE) H _S(TYPE) H _S(SPEC)));
  XAD (9);
  if (t[0] == '(')
    {
      XAD (1);
      if (t[0] != ')')
        {
          k = FXTRAN_eat_word (t);
          if (t[k] == ')')
            {
              char w[k+1];
              strncpy (&w[0], &t[0], k); w[k] = '\0';
              for (i = 0; FXTRAN_types[i]; i++)
                if ((strcmp (FXTRAN_types[i], w) == 0) && FXTRAN_types_intrinsic[i])
	          {
                    
                    k = FXTRAN_typespec (t, ci, ctx);
                    XAD (k);
                    goto end_parens;
	          }
              XST (_T(_S(PROCEDURE) H _S(NAME)));
              XNT (_T(_S(NAME)), k);
              XAD (k);
              XET ();
            }
          else
            {
              k = FXTRAN_typespec (t, ci, ctx);
              XAD (k);
            }
end_parens:
          if (t[0] != ')')
            FXTRAN_ABORT ("Expected ')'");
        }
      XAD (1);
    }
  XET ();
  return t - T;
}

int FXTRAN_typespec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int i;
  int k;

  for (i = 0; FXTRAN_types[i]; i++)
    {
      int intrinsic_typ = 0; /* Handle the TYPE(INTEGER|REAL|...) case */
      int len = strlen (FXTRAN_types[i]);
      if (strncmp (FXTRAN_types[i], t, len) == 0)
        {
          if (FXTRAN_types_intrinsic[i])
            {
              XST (_T(_S(INTRINSIC) H _S(TYPE) H _S(SPEC)));
              XST (_T(_S(TYPE) H _S(NAME)));
	      XAD(len);
	      XET ();
	    }
          else if (zstrcmp ("PROCEDURE", FXTRAN_types[i]))
            {
              k = FXTRAN_procedure_typespec (t, ci, ctx);
	      XAD (k);
              goto end;
            }
	  else
            {
              int intrinsic_len = 0;
              
              /* Starts with TYPE(, but maybe this is a TYPE(INTEGER) */
              if (zstrcmp ("TYPE(", t))
                {
                  int j, k;
                  for (j = 0; FXTRAN_types[j]; j++)
                    {
                      intrinsic_len = strlen (FXTRAN_types[j]);
                      if (FXTRAN_types_intrinsic[j])
                        {
                          if (strncmp (FXTRAN_types[j], t + 5, intrinsic_len) == 0)
                            {
                              k = FXTRAN_eat_word (t + 5);
                              if (k == intrinsic_len) 
                                {
                                  intrinsic_typ = 1;
                                  goto stop;
                                }
                            }
                        }
                     }
stop:
                   {}
                }

              if (intrinsic_typ)
                {
                  XST (_T(_S(INTRINSIC) H _S(TYPE) H _S(SPEC)));
                  XAD (5);
                  XST (_T(_S(TYPE) H _S(NAME)));
	          XAD(intrinsic_len);
	          XET ();
                }
              else
                {
                  XST (_T(_S(DERIVED) H _S(TYPE) H _S(SPEC)));
	          XAD(len);
                }
	    }

          int itype = intrinsic_typ ? intrinsic_typ : i;

          k = typespec_ext (t, ci, ctx, itype);

	  XAD(k);

          if (intrinsic_typ)
            {
              if (t[0] != ')')
                FXTRAN_THROW ("Malformed type spec");
              XAD (1);
            }

	  XET ();
	  break;
        }
    }

end:
  return t - T;
}

static int bind_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  if (zstrcmp ("C)", t))
    {
      XAD(2);
    }
  else if (zstrcmp ("C,NAME=", t))
    {
      int k;
      XAD(7);
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      XST (_T(_S(NAME)));
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD(k);
      XET ();
    }
  else if (zstrcmp ("C,", t))
    {
      int k;
      XAD(2);
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      XST (_T(_S(NAME)));
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD(k);
      XET ();
    }
  return t - T;
}

static int FXTRAN_attr0 (const char * t, const FXTRAN_char_info * ci, 
                          FXTRAN_xmlctx * ctx, const char * attr)
{
  const char * T = t;
  int k;
  int an = attr == NULL;

  if (an)
    {
      int i;
      k = -1;

      if (!isalpha (t[0]))
        return 0;


      for (i = 0; FXTRAN_stmt_attr[i] >= 0; i++)
        if (FXTRAN_stmt_attr[i])
          if (zstrcmp (FXTRAN_stmt_name[i], t))
            k = strlen (FXTRAN_stmt_name[i]);

      if (k < 0)
        for (i = 0; FXTRAN_attr_name[i]; i++)
          if (zstrcmp (FXTRAN_attr_name[i], t))
            k = strlen (FXTRAN_attr_name[i]);

      if (k < 0)
        return 0;
    }
  else
    {
      k = strlen (attr);
    }

  if (an)
    XST (_T(_S(ATTRIBUTE)));


  if (t[k] == '[')
    {
      if (zstrcmp ("CODIMENSION", T))
        {
          if (an) XST (_T(_S(ATTRIBUTE) H _S(NAME)));
          XAD(11);
          if (an) XET ();
          k = coarray_spec (t, ci, ctx);
          XAD(k);
        }
    }
  else if (t[k] != '(')
    {
      if (an) XST (_T(_S(ATTRIBUTE) H _S(NAME)));
      XAD(k);
      if (an) XET ();
    }
  else if ((k = FXTRAN_str_at_level (t, ci, ")", 0)))
    {
      if (zstrcmp ("DIMENSION", T))
        {
          if (an) XST (_T(_S(ATTRIBUTE) H _S(NAME)));
          XAD(9);
          if (an) XET ();
          k = array_spec (t, ci, ctx);
          XAD(k);
        }
      else if (zstrcmp ("BIND", T))
        {
          if (an) XST (_T(_S(ATTRIBUTE) H _S(NAME)));
          XAD(4);
          if (an) XET ();
          XAD(1);
          k = bind_spec (t, ci, ctx);
          XAD(k);
        }
      else if (zstrcmp ("EXTENDS", T))
        {
          if (an) XST (_T(_S(ATTRIBUTE) H _S(NAME)));
          XAD(7);
          if (an) XET ();
          XAD(1);
          XNT (_T(_S(NAME)), k-9);
          XAD(k-8);
        }
      else if (zstrcmp ("PASS", T))
        {
          if (an) XST (_T(_S(ATTRIBUTE) H _S(NAME)));
          XAD(4);
          if (an) XET ();
          XAD(1);
          XNT (_T(_S(NAME)), k-6);
          XAD(k-5);
        }
      else if (zstrcmp ("INTENT", T))
        {
          if (an) XST (_T(_S(ATTRIBUTE) H _S(NAME)));
          XAD(6);
          if (an) XET ();
          XAD(1);
          k = FXTRAN_eat_word (t);
          XST (_T(_S(INTENT) H _S(SPEC)));
          XAD(k);
          XET ();
          XAD(1);
        }
    }
    

  if (attr == NULL)
    XET ();
      
  return t - T;
}

static int FXTRAN_attr (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return FXTRAN_attr0 (t, ci, ctx, NULL);
}

static void FXTRAN_stmt_attr_extra (const char * t, const FXTRAN_char_info * ci, 
		                    FXTRAN_xmlctx * ctx, const char * attr, FXTRAN_stmt_stack * stack)
{
  int k = FXTRAN_attr0 (t, ci, ctx, attr);
  XAD(k);

  skip_dc ();
    
  stmt_entity_list (t, ci, ctx, 1, 0, &seda_entity, stack);
}

#define def_attr_extra_func(T) \
def_extra_proto(T)                                          \
{                                                           \
  return FXTRAN_stmt_attr_extra (t, ci, ctx, #T, stack);    \
}

def_attr_extra_func(ASYNCHRONOUS);
def_attr_extra_func(ALLOCATABLE);
def_attr_extra_func(FINAL);
def_attr_extra_func(TARGET);
def_attr_extra_func(POINTER);
def_attr_extra_func(EXTERNAL);
def_attr_extra_func(CONTIGUOUS);
def_attr_extra_func(INTRINSIC);
def_attr_extra_func(OPTIONAL);
def_attr_extra_func(PROTECTED);

def_attr_extra_func(VOLATILE);
def_attr_extra_func(VALUE);

#undef def_attr_extra_func

def_extra_proto (BLOCK)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);

  XAD(5);
}

def_extra_proto (CHANGETEAM)
{
  int kp;
  int k;
  int seen_assoc;
  int seen_sync;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);
  XAD(6);
  XSP();
  XAD(4);
  if (t[0] != '(')
    FXTRAN_ABORT ("Expected '('");
  XAD (1);
  
  k = FXTRAN_str_at_level (t, ci, ",", ci->parens);
  if (k == 0)
    k = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);

  XST (_T(_S(TEAM) H _S(VALUE)));
  FXTRAN_expr (t, ci, k-1, ctx);
  XAD (k-1);
  XET ();


  seen_assoc = 0;
  seen_sync = 0;
  while (t[0] && (t[0] != ')'))
    {
      if (t[0] != ',')
        FXTRAN_ABORT ("Expected ','");

      /* The following will be valid AFTER XAD(1) */
      k = FXTRAN_str_at_level (t+1, ci+1, ",", ci->parens);
      if (k == 0)
        k = FXTRAN_str_at_level (t+1, ci+1, ")", ci->parens-1);
      kp = FXTRAN_str_at_level (t+1, ci+1, "=>", ci->parens);

      if (kp > 0)
        {
          if (seen_sync > 0)
            FXTRAN_ABORT ("Malformed statement");

          XAD (1); /* Skip ',' */

          if (! seen_assoc)
            XST (_T (_S(COARRAY) H _S(ASSOCIATION) H _S(LIST)));
          seen_assoc = 1;

          XST (_T(_S(COARRAY) H _S(ASSOCIATION)));

          XST (_T(_S(CODIMENSION) H _S(DECL)));
          FXTRAN_expr (t, ci, kp-1, ctx);
          XAD (kp-1);
          XET ();
  
          XAD (2);
  
          XST (_T(_S(SELECTOR)));
          FXTRAN_expr (t, ci, k-kp-2, ctx);
          XAD (k-kp-2);
          XET ();
  
          XET ();
        }
      else
        {
          if (seen_assoc && (! seen_sync))
            XET ();

          XAD (1); /* Skip ',' */

          if (! seen_sync)
            XST (_T(_S(SYNC) H _S(STAT) H _S(LIST)));
          seen_sync = 1;

          XST (_T(_S(ARG)));

          kp = FXTRAN_str_at_level (t, ci, "=", ci->parens);

          if ((kp > 0) && (kp < k))
            {
              int kw = FXTRAN_eat_word (t);
              XNW (_T(_S(ARG) H _S(NAME)), kw); 
              XAD(kw);
              if (t[0] != '=')
                FXTRAN_ABORT ("Expected '='");
              XAD (1);
              FXTRAN_expr (t, ci, k-kp-1, ctx);
              XAD (k-kp-1);
            }
          else
            {
              FXTRAN_expr (t, ci, k-1, ctx);
              XAD (k-1);
            }

          XET ();
        }
    }

  if (seen_sync || seen_assoc)
    XET ();

  if (t[0] != ')')
    FXTRAN_ABORT ("Expected ')'");
}

def_extra_proto (ENDCHANGETEAM)
{
  int k;
  XAD(7);
  if (t[0] == '(')
    {
      k = stmt_actual_args (t, ci, ctx, &saap_sync);
      XAD (k);
    }
  if (t[0])                              
    stmt_eos_named_label (t, ci, ctx);  
}

def_extra_proto (CRITICAL)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);
  XAD(8);
  if (t[0] == '(')
    stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (CRAYPOINTER)
{

  XAD(7);

  XST (_T(_S(CRAY) H _S(POINTER) H _S(ASSOCIATION)  H _S(LIST)));

  while (1)
    {
      int k, kp;

      XST (_T(_S(CRAY) H _S(POINTER) H _S(ASSOCIATION)));
      if (t[0] != '(')
        FXTRAN_THROW ("Expected `('");
     
      XAD(1);
      k = FXTRAN_eat_word (t);
      XST (_T(_S(CRAY) H _S(POINTER)));
      XNT (_T(_S(NAME)), k); 
      XAD(k);
      XET ();

      if (t[0] != ',')
        FXTRAN_THROW ("Expected `,'");
      XAD(1);
      
      XST (_T(_S(CRAY) H _S(POINTEE)));
      kp = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);

      FXTRAN_expr (t, ci, kp-1, ctx);
      XAD(kp-1);
      XET ();

      if (t[0] != ')')
        FXTRAN_THROW ("Expected `)'");
      XAD(1);
      
      XET ();

      switch (t[0])
        {
          case ',':
            XAD (1);
            break;
          case '\0':
            goto end;
          default:
            break;
        }
    }
end:

  XET ();

}

def_process_list_elt_proto (pupr_entity)
{
  int k;
  XST (_T(_S(ENTITY)));
  k = FXTRAN_generic_spec (t, ci, ctx);
  if (k != kmax)
    FXTRAN_THROW ("Malformed generic spec");
  XAD(k);
  XET ();
  return 1;
}

static void stmt_pupr_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  if (t[0] == '\0') 
    return;

  skip_dc ();
    
  FXTRAN_process_list (t, ci, ctx, ",", _T(_S(ENTITY) H _S(LIST)), strlen (t),
		        pupr_entity, NULL);
  
}

def_extra_proto (PUBLIC)
{
  XAD(6);
  return stmt_pupr_extra (t, ci, ctx);
}

def_extra_proto (PRIVATE)
{
  XAD(7);
  return stmt_pupr_extra (t, ci, ctx);
}


def_process_list_elt_proto(saved_entity) 
{
  int seen_slash = 0;
  int k;
  XST (_T(_S(SAVED) H _S(ENTITY)));
  if (t[0] == '/')
    {
      seen_slash = 1;
      XAD(1);
    }
  k = FXTRAN_eat_word (t);

  XST (_T(_S(ENTITY) H _S(NAME)));
  XNT (_T(_S(NAME)), k);
  XAD(k);
  XET ();

  if (seen_slash)
    {
      if (t[0] == '/')
        XAD(1);
      else
        FXTRAN_THROW ("Expected closing '/'"); 
    }
  
  XET ();

  return 1;
}


def_extra_proto (SAVE)
{
  XAD(4);

  if (t[0] == '\0') 
    return;

  skip_dc ();
    
  FXTRAN_process_list (t, ci, ctx, ",", _T(_S(SAVED) H _S(ENTITY) H _S(LIST)), strlen (t),
		        saved_entity, NULL);
}

def_extra_proto (CODIMENSION)
{
  int k = FXTRAN_attr0 (t, ci, ctx, "CODIMENSION");

  XAD(k);

  skip_dc ();

  stmt_entity_list (t, ci, ctx, 1, 0, &seda_entity, stack);
}

def_extra_proto (DIMENSION)
{
  int k = FXTRAN_attr0 (t, ci, ctx, "DIMENSION");

  XAD(k);

  skip_dc ();

  stmt_entity_list (t, ci, ctx, 1, 0, &seda_entity, stack);
}

def_extra_proto (INTENT)
{
  int k = FXTRAN_attr0 (t, ci, ctx, "INTENT");

  XAD(k);

  k = FXTRAN_str_at_level (t, ci, ")", 0);

  if (k)
    XAD(k);

  skip_dc ();

  stmt_entity_list (t, ci, ctx, 1, 0, &seda_entity, stack);
}

def_extra_proto (BIND)
{
  /* entities, identifiers */
  int k = FXTRAN_attr0 (t, ci, ctx, "BIND");

  XAD(k);

  skip_dc ();

  stmt_entity_list (t, ci, ctx, 1, 1, &seda_entity, stack);
}

def_extra_proto (INTERFACE)
{
  int k;
  if (zstrcmp ("ABSTRACT", t))
    {
      XST (_T(_S(ATTRIBUTE)));
      XST (_T(_S(ATTRIBUTE) H _S(NAME)));
      XAD(8);
      XET ();
      XET ();
      XSP ();
    }

  XAD(9);

  if (t[0])
    {
      XST (_T(_S(GENERIC)) H _T(_S(SPEC)));
      k = FXTRAN_generic_spec (t, ci, ctx);
      XAD(k);
      XET ();
    }
}

def_extra_proto (ENDINTERFACE)
{
  int k;

  XAD(12);

  if (t[0])
    {
      XST (_T(_S(NAME)));
      k = FXTRAN_generic_spec (t, ci, ctx);
      XAD(k);
      XET ();
    }
}

static void stmt_clty_extra (const char * t, const FXTRAN_char_info * ci, 
                             FXTRAN_xmlctx * ctx, const char * T, const char * N)
{
  XAD(strlen (T));

  while (t[0] == ',')
    {
      int k;
      XAD(1);
      k = FXTRAN_attr (t, ci, ctx);
      if (k == 0)
        FXTRAN_THROW ("Cannot parse type attribute");
      XAD(k);
    }

  skip_dc ();

  XAD (stmt_unit_name (t, ci, "", N, ctx));

  if (t[0] == '(')
    {
      int k;
      k = stmt_actual_args (t, ci, ctx, &saap_typeparmname);
      XAD (k);
    }
}

def_extra_proto (TYPE)
{
  return stmt_clty_extra (t, ci, ctx, "TYPE", _T(_S(TYPE) H _S(NAME)));
}

def_extra_proto (CLASS)
{
  return stmt_clty_extra (t, ci, ctx, "CLASS", _T(_S(CLASS) H _S(NAME)));
}

def_extra_proto (ENDTYPE)
{
  XAD(7);
  if (t[0])
    stmt_unit_name (t, ci, "", _T(_S(TYPE) H _S(NAME)), ctx);
}

def_extra_proto (ENDCLASS)
{
  XAD(8);
  if (t[0])
    stmt_unit_name (t, ci, "", _T(_S(CLASS) H _S(NAME)), ctx);
}

def_extra_proto (DEALLOCATE)
{
  XAD(10);
  stmt_actual_args (t, ci, ctx, &saap_actual);
}

def_extra_proto (ALLOCATE)
{
  XAD(8);
  stmt_actual_args (t, ci, ctx, &saap_allocate);
}

def_extra_proto (NULLIFY)
{
  XAD(7);
  stmt_actual_args (t, ci, ctx, &saap_actual);
}

def_extra_proto (CALL)
{
  int k;
  int kargs = -1;

  XAD(4);
  k = strlen (t);
  if (t[k-1] == ')')
    {
      for (kargs = k-1; kargs >= 0; kargs--)
        if ((t[kargs] == '(') && (ci[kargs].parens == 0))
          break;
    }

  if (kargs >= 0)
    k = kargs;
    
  XST (_T(_S(PROCEDURE) H _S(DESIGNATOR)));
  FXTRAN_expr (t, ci, k, ctx);
  XAD(k);
  XET ();

  if (kargs >= 0)
    stmt_actual_args (t, ci, ctx, &saap_actual);
}


static void suffix (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, 
		    int func, FXTRAN_stmt_stack * stack)
{

  while (t[0])
    {
      if (zstrcmp ("BIND(C)", t))
        {
          FXTRAN_xml_word_tag (_T(_S(BIND) H _S(SPEC)), ci->offset, ci->offset+7, ctx);
          XAD(7);
        }
      else if (zstrcmp ("BIND(C,NAME=", t))
        {
          int k;
          XST (_T(_S(BIND) H _S(SPEC)));
	  XAD(12);
          k = FXTRAN_str_at_level (t, ci, ")", 0);
          FXTRAN_expr (t, ci, k-1, ctx);
          XAD(k);
          XET ();
        }
     else if (func && zstrcmp ("RESULT(", t))
       {
          int k;
          XST (_T(_S(RESULT) H _S(SPEC)));
	  XAD(7);
          if ((k = FXTRAN_str_at_level (t, ci, ")", 0)))
            {
	      XNT (_T(_S(NAME)), k-1);
	      XAD(k);
	    }
	  else
            {
              FXTRAN_THROW ("Missing closing `)'");
            }
          XET ();
       }
     else
       {
         FXTRAN_THROW ("Unexpected suffix : `%s'\n", t);
       }
    }
}

def_extra_proto (FUNCTION)
{
  int k2;
  int k3;
  const char * prefix[] = { "MODULE", "RECURSIVE", "NON_RECURSIVE", "IMPURE", "PURE", "ELEMENTAL", NULL };
  int seen_ts = 0;
  int seen_prefix = 0;
  int seen_attr = 0;

 
#define skip_comma \
  do {               \
    if (t[0] == ',') \
      {              \
        XAD(1);       \
      }              \
  } while (0)

  while (1)
    {
      int k;
      int i;
      int ad = 0;
      for (i = 0; prefix[i]; i++)
        if (zstrcmp (prefix[i], t))
          {
            int len = strlen (prefix[i]);
	    FXTRAN_xml_word_tag (_T(_S(PREFIX)), ci->offset, ci[len-1].offset+1, ctx);
	    XAD(len);
	    ad++;
	    prefix[i] = "!";
            seen_prefix++;
          }
      if (!seen_ts && (k = FXTRAN_typespec (t, ci, ctx)))
        {
          seen_ts = 1;
	  XAD(k);
	  ad++;
	  skip_comma;
        }

      if (zstrcmp ("FUNCTION", t))
        break;

      if (ad == 0)
        {
          if ((k = FXTRAN_attr0 (t, ci, ctx, NULL)))
            {
              XAD(k);
	      skip_comma;
              seen_attr++;
            }
	  else
            break;
	}
    }
#undef skip_comma

  if (seen_prefix || seen_ts || seen_attr)
    XSP ();

  k2 = stmt_unit_name (t, ci, "FUNCTION", _T(_S(FUNCTION) H _S(NAME)), ctx);
  XAD(k2);
  k3 = stmt_unit_dummy_args (t, ci, ctx, stack);
  XAD(k3);

  suffix (t, ci, ctx, 1, stack);
}


def_extra_proto (TYPEDECL)
{
  int k;
  int nattr = 0;
  int isoldchar = zstrcmp ("CHARACTER*", t);
  int seen_dc = 0;


  XSA (_T(_S(TYPE) H _S(SPEC)));
  k = FXTRAN_typespec (t, ci, ctx);
  XAD(k);
  XEA ();

  if (t[0] == 0)
    return;

  while (t[0] == ',')
    {
      XAD(1);
      k = FXTRAN_attr (t, ci, ctx);
      if ((nattr == 0) && (k == 0) && isoldchar)  /* May be a CHARACTER*8, C */
        break;
      XAD(k);
      nattr++;
    }

  seen_dc = t[0] == ':';

  skip_dc ();

  stmt_entity_list (t, ci, ctx, seen_dc, 0, &seda_entity, stack);

}

/* TODO : parse binding name expr */
def_process_list_elt_proto(binding_name) 
{
  XST (_T(_S(BINDING) H _S(NAME)));
  XNT (_T(_S(NAME)), kmax);
  XAD (kmax);
  XET ();
  return 1;
}


def_extra_proto (GENERIC)
{
  int k;
  XAD(7);

  while (t[0] == ',')
    {
      XAD(1);
      k = FXTRAN_attr (t, ci, ctx);
      XAD(k);
    }

  skip_dc ();

  XST (_T(_S(GENERIC) H _S(SPEC)));
  k = FXTRAN_generic_spec (t, ci, ctx);
  XAD(k);
  XET ();
  
  if ((t[0] == '=') && (t[1] == '>'))
    {
      XAD(2);
    }
  else
    FXTRAN_THROW ("Expected `=>'"); 
  
  FXTRAN_process_list (t, ci, ctx, ",", _T(_S(BINDING) H _S(NAME) H _S(LIST)), strlen (t),
	        	binding_name, NULL);
  

  return;
}

def_extra_proto (COMPONENTDECL)
{
  return stmt_TYPEDECL_extra (t, ci, stack, ctx);
}

def_extra_proto (BLOCKDATA)
{
  if (t[9])
    stmt_unit_name (t, ci, "BLOCKDATA", _T(_S(BLOCK) H _S(DATA) H _S(NAME)), ctx);
}

def_extra_proto (SUBMODULE)
{
  int k;

  XAD (9);

  if (t[0] != '(')
    FXTRAN_THROW ("Malformed SUBMODULE statement");

  XAD (1);

  k = FXTRAN_eat_word (t);
  XST (_T(_S(PARENT) H _S(IDENTIFIER)));
  XNT (_T(_S(ANCESTOR) H _S(MODULE) H _S(NAME)), k);
  XAD (k); 

  if (t[0] == ':')
    {
      XAD (1);
      k = FXTRAN_eat_word (t);
      XNT (_T(_S(PARENT) H _S(MODULE) H _S(NAME)), k);
      XAD (k); 
    }

  XET ();

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed SUBMODULE statement");
  XAD (1);

  k = FXTRAN_eat_word (t);

  XNT (_T(_S(SUBMODULE) H _S(MODULE) H _S(NAME)), k);
}

#define def_simple_unit(T) \
def_extra_proto (T)                                        \
{                                                          \
  stmt_unit_name (t, ci, #T, _T(_S(T) H _S(NAME)), ctx);   \
}

def_simple_unit(MODULE);
def_simple_unit(PROGRAM);

#undef def_simple_unit

#define def_simple_endunit(T) \
def_extra_proto (END##T)                                         \
{                                                                \
  stmt_endunit_name (t, ci, "END"#T, _T(_S(T) H _S(NAME)), ctx); \
}

def_simple_endunit(PROGRAM);
def_simple_endunit(SUBMODULE);
def_simple_endunit(MODULE);
def_simple_endunit(FUNCTION);
def_simple_endunit(SUBROUTINE);
def_simple_endunit(PROCEDURE);

def_extra_proto (ENDBLOCKDATA)
{
  stmt_endunit_name (t, ci, "ENDBLOCKDATA", _T(_S(BLOCK) H _S(DATA) H _S(NAME)), ctx); 
}

#undef def_simple_endunit


def_extra_proto (PARAMETER)
{

  XAD(10);
  
  stmt_entity_list (t, ci, ctx, 0, 0, &seda_entity, stack);
}

def_extra_proto (USE)
{
  int k;

  XAD(3);

  if (t[0] == ',')
    {
      XAD(1);
      k = FXTRAN_eat_word (t);
      XST (_T(_S(MODULE) H _S(NATURE)));
      XAD(k);
      XET ();
    }

  skip_dc ();

  k = FXTRAN_eat_word (t);

  XST (_T(_S(MODULE) H _S(NAME)));
  XNT (_T(_S(NAME)), k);
  XAD(k);
  XET ();

   
  if (t[0] == 0)
    return;

  if (t[0] == ',')
    XAD(1);


  if (zstrcmp ("ONLY:", t))
    XAD(5);

  XST (_T(_S(RENAME) H _S(LIST)));

  while (t[0])
    {
      int first = 1;
      XST (_T(_S(RENAME)));
      XST (_T(_S(USE) H _S(NAME)));
again:

      k = FXTRAN_generic_spec (t, ci, ctx);
      XAD(k);

      XET ();

      if (zstrcmp ("=>", t) && first)
        {
          first = 0;
	  XAD(2);
          XST (_T(_S(NAME)));
          goto again;
	}

      XET ();
      if (t[0] == ',')
        XAD(1);
      else
        break;
    }

  XET ();
}

def_extra_proto (ENUM)
{
  XAD(4);
  if (zstrcmp (",BIND(C)", t))
    {
      XAD(1);
      XST(_T(_S(BIND) H _S(SPEC)));
      XAD(7);
      XET ();
    }
}

def_extra_proto (ENUMERATOR)
{
  XAD(10);
  skip_dc ();

  stmt_entity_list (t, ci, ctx, 0, 0, &seda_enumerator, stack);
}

def_extra_proto (SELECTTYPE)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);

  XAD(11);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  if (k == 0)
    return;

  k = FXTRAN_str_at_level (t, ci, "=>", ci[0].parens);

  if (k)
    {
      XNT (_T(_S(ASSOCIATE) H _S(NAME)), k-1);
      XAD(k-1);
      XAD(2);
    }

  k = FXTRAN_str_at_level (t, ci, ")", 0);

  XST (_T(_S(SELECTOR)));

  FXTRAN_expr (t, ci, k-1, ctx);

  XAD(k-1);

  XET ();
  
}

def_extra_proto (SELECTRANK)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);

  XAD(11);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  if (k == 0)
    return;

  k = FXTRAN_str_at_level (t, ci, "=>", ci[0].parens);

  if (k)
    {
      XNT (_T(_S(ASSOCIATE) H _S(NAME)), k-1);
      XAD(k-1);
      XAD(2);
    }

  k = FXTRAN_str_at_level (t, ci, ")", 0);

  XST (_T(_S(SELECTOR)));

  FXTRAN_expr (t, ci, k-1, ctx);

  XAD(k-1);

  XET ();
  
}

def_extra_proto (SELECTCASE)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);

  XAD(11);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  if (k == 0)
    return;
  XST (_T(_S(CASE) H _S(EXPR)));

  FXTRAN_expr (t, ci, k-1, ctx);

  XAD(k-1);

  XET ();
}

def_process_list_elt_proto (association)
{
  const char * T = t;
  int k = FXTRAN_eat_word (t);

  XST (_T(_S(ASSOCIATE)));

  XNT (_T(_S(ASSOCIATE) H _S(NAME)), k);
  XAD(k);
  if (!zstrcmp ("=>", t))
    FXTRAN_THROW ("Expected `=>'"); 
  XAD(2);

  XST (_T(_S(SELECTOR)));

  k = kmax - (t - T);

  FXTRAN_expr (t, ci, k, ctx);

  XAD(k);

  XET ();
  XET ();

  return 1;
}

def_extra_proto (ASSOCIATE)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);

  XAD(10);
  k = strlen (t);

  FXTRAN_process_list (t, ci, ctx, ",",
	                _T(_S(ASSOCIATE) H _S(LIST)), k,
		        association, NULL);


}

def_process_list_elt_proto (equivalence_object)
{
  XST (_T(_S(EQUIVALENCE) H _S(OBJECT)));
  FXTRAN_expr (t, ci, kmax, ctx);
  XAD(kmax);
  XET ();
  return 1;
}

def_process_list_elt_proto (equivalence_set)
{
  int k;
  XST (_T(_S(EQUIVALENCE) H _S(SET)));
  XAD(1);
  k = FXTRAN_str_at_level (t, ci, ")", 0);
  FXTRAN_process_list (t, ci, ctx, ",",
	               _T(_S(EQUIVALENCE) H _S(OBJECT) H _S(LIST)), k,
		       equivalence_object, NULL);
  XAD(k);
  XET ();
  return 1;
}

def_extra_proto (EQUIVALENCE)
{
  XAD(11);
  FXTRAN_process_list (t, ci, ctx, ",",
	               _T(_S(EQUIVALENCE) H _S(SET) H _S(LIST)), strlen (t),
		       equivalence_set, NULL);
}

def_process_list_elt_proto (data_stmt_object)
{
  XST (_T(_S(DATA) H _S(STMT) H _S(OBJECT)));
  FXTRAN_expr (t, ci, kmax, ctx);
  XAD(kmax);
  XET ();
  return 1;
}

def_process_list_elt_proto (data_stmt_value)
{
  int i;
  XST (_T(_S(DATA) H _S(STMT) H _S(VALUE)));

  for (i = 0; t[i] && (i < kmax); i++)
    if (!isalnum (t[i]) && (t[i] != '_'))
      break;
  if (t[i] == '*')
    {
      XST (_T(_S(DATA) H _S(STMT) H _S(REPEAT)));
      FXTRAN_expr (t, ci, i, ctx);
      XAD(i);
      XET ();
      XAD(1);
      kmax = kmax - i - 1;
    }

  XST (_T(_S(DATA) H _S(STMT) H _S(CONSTANT)));

  FXTRAN_expr (t, ci, kmax, ctx);

  XAD(kmax);
  XET ();
  XET ();

  return 1;
}

def_extra_proto (DATA)
{
  int k;
  XAD(4);

  while (t[0])
    {
      k = FXTRAN_str_at_level (t, ci, "/", 0);

      if (k == 0)
        FXTRAN_THROW ("Expected `/'");

      XST (_T(_S(DATA) H _S(STMT) H _S(SET)));
      FXTRAN_process_list (t, ci, ctx, ",", _T(_S(DATA) H _S(STMT) H _S(OBJECT) H _S(LIST)), 
		           k-1, data_stmt_object, NULL);

      XAD(k);

      k = FXTRAN_str_at_level (t, ci, "/", 0);

      if (k == 0)
        FXTRAN_THROW ("Expected `/'");

      FXTRAN_process_list (t, ci, ctx, ",", 
		           _T(_S(DATA) H _S(STMT) H _S(VALUE) H _S(LIST)), 
			   k-1, data_stmt_value, NULL);

      XAD(k);

      XET ();

      if (t[0] == ',') /* optional comma */
        XAD(1);
    }
  
}

def_process_list_elt_proto (forall_triplet_spec)
{
  int k;
  const char * T = t;
  const char * tag;
  k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax);

  if (k == 0)
    return -1;

  XST (_T(_S(FORALL) H _S(TRIPLET) H _S(SPEC)));

  k = FXTRAN_eat_word (t);

  XST (_T(_S(VARIABLE)));
  FXTRAN_expr (t, ci, k, ctx);
  XAD(k);
  XET ();

  XAD(1);
  k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax-(t-T));

  if (k == 0)
    FXTRAN_THROW ("Expected `:'");

  XST (_T(_S(LOWER) H _S(BOUND)));
  FXTRAN_expr (t, ci, k-1, ctx);
  XAD(k-1);
  XET ();
  XAD(1);

  k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax-(t-T));

  if (k)
    {
      XST (_T(_S(UPPER) H _S(BOUND)));
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD(k-1);
      XET ();
      XAD(1);
      tag = _T(_S(STEP));
    }
  else
    {
      tag = _T(_S(UPPER) H _S(BOUND));
    }

  XST (tag);
  FXTRAN_expr (t, ci, kmax-(t-T), ctx);

  XAD(kmax-(t-T));
  XET ();

  XET ();

  return 1;
}

static int forall_header (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, 
		          FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  if (t[0] != '(')
    FXTRAN_THROW ("Expected FORALL header");

  XAD(1);

  k = FXTRAN_str_at_level (t, ci, "::", 1);

  if (k > 0)
    {
      k = FXTRAN_typespec (t, ci, ctx);
      XAD (k);
      if (! zstrcmp ("::", t))
        FXTRAN_THROW ("Malformed FORALL header");
      XAD (2);
    }

  k = FXTRAN_str_at_level (t, ci, ")", 0);

  k = FXTRAN_process_list (t, ci, ctx, ",", 
	          	   _T(_S(FORALL) H _S(TRIPLET) H _S(SPEC) H _S(LIST)), 
			   k-1, forall_triplet_spec, NULL);

  XAD(k);

  if (t[0] == ',')
    {
      XAD(1);
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      XST (_T(_S(MASK) H _S(EXPR)));
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD(k-1);
      XET ();
    }

  if (t[0] != ')')
    FXTRAN_THROW ("Malformed FORALL header");

  XAD(1);

  return t - T;
}
   
def_extra_proto (DO)
{
  int k;
  k = stmt_bos_named_label (t, ci, ctx);

  XAD(k);
  XAD(2);

  if (isdigit (t[0]))
    {
      XST (_T(_S(LABEL)));
      for (k = 0; isdigit (t[k]); k++);
      XAD(k);
      XET ();
    }
  
  if (t[0] == '\0')
    return;

  if (t[0] == ',')
    XAD(1);

  if (zstrcmp ("WHILE(", t))
    {
      int k;
      XSP ();
      XAD(6);
      XST (_T(_S(TEST) H _S(EXPR)));
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD(k-1);
      XET ();
    }
  else
    {
      int k = FXTRAN_str_at_level (t, ci, "=", 0);
      if (k)
        {
          k = FXTRAN_eat_word (t);
          XST (_T(_S(DO) H _S(VARIABLE)));
          FXTRAN_expr (t, ci, k, ctx);
          XAD(k);
          XET ();
          if (t[0] != '=')
            FXTRAN_THROW ("Expected `='"); 
          XAD(1);

          k = FXTRAN_str_at_level (t, ci, ",", 0);
          if (k == 0)
            FXTRAN_THROW ("Expected `,'"); 

          XST (_T(_S(LOWER) H _S(BOUND)));
          FXTRAN_expr (t, ci, k-1, ctx);
          XAD(k-1);
          XET ();
          XAD(1);

          k = FXTRAN_str_at_level (t, ci, ",", 0);
          if (k == 0)
            k = strlen (t);
          else
            k = k - 1;

          XST (_T(_S(UPPER) H _S(BOUND)));
          FXTRAN_expr (t, ci, k, ctx);
          XAD(k);
          XET ();

          if (t[0] == '\0')
            return;

          XAD(1);
            
          k = strlen (t);

          XST (_T(_S(STEP)));
          FXTRAN_expr (t, ci, k, ctx);
          XAD(k);
          XET ();
        }
      else if (zstrcmp ("CONCURRENT", t))
        {
          XAD(10);
          if (t[0] == '(')
            {
              int k = forall_header (t, ci, stack, ctx);
              XAD(k);
            }
        }
    }
}

def_extra_proto (DOLABEL)
{
  stmt_DO_extra (t, ci, stack, ctx);
}

def_process_list_elt_proto (case_value_range)
{
  int k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax);

  XST (_T(_S(CASE) H _S(VALUE) H _S(RANGE)));

  if ((k != 0) && (k <= kmax))
    {
      XST (_T(_S(CASE) H _S(VALUE)));
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD(k-1);
      XET ();
      XAD(1);
      kmax = kmax - k;
    }

  XST (_T(_S(CASE) H _S(VALUE)));
  FXTRAN_expr (t, ci, kmax, ctx);
  XAD(kmax);
  XET ();

  XET ();

  return 1;
}


static void stmt_cltpis_extra (const char * t, const FXTRAN_char_info * ci, 
		               FXTRAN_xmlctx * ctx, const char * N)
{
  int k;

  XST (_T(_S(TYPE) H _S (SELECTOR)));

  switch (t[0])
    {
      case '(':
        XAD(1);
        k = ts_with_args (t, ci, ctx);
	XAD (k);
	XAD (1);
      break;
      case 'D':
        if (zstrcmp ("DEFAULT", t))
          XAD(7);
	else
          FXTRAN_THROW ("Expected `DEFAULT'"); 
      break;
      default:
        FXTRAN_THROW ("Malformed case"); 
        return;
      break;
    }

  XET ();

  if (t[0])
    stmt_unit_name (t, ci, "", N, ctx);
}

def_extra_proto (CLASSIS)
{
  if (zstrcmp ("CLASSDEFAULT",t))
    {
      XAD(5);
    }
  else
    {
      XAD(7);
    }
  return stmt_cltpis_extra (t, ci, ctx, _T(_S(NAMED) H _S(LABEL)));
}

def_extra_proto (TYPEIS)
{
  if (zstrcmp ("TYPEDEFAULT",t))
    {
      XAD(4);
    }
  else
    {
      XAD(6);
    }
  return stmt_cltpis_extra (t, ci, ctx, _T(_S(NAMED) H _S(LABEL)));
}

def_extra_proto (CASE)
{
  int k;
  XAD(4);
  XST (_T(_S(CASE) H _S(SELECTOR)));

  switch (t[0])
    {
      case '(':
        XAD(1);
        k = FXTRAN_str_at_level (t, ci, ")", 0);
        FXTRAN_process_list (t, ci, ctx, ",", 
	        	     _T(_S(CASE) H _S(VALUE) H _S(RANGE) H _S(LIST)), 
			     k-1, case_value_range, NULL);
        XAD(k);
      break;
      case 'D':
        if (zstrcmp ("DEFAULT", t))
          XAD(7);
	else
          FXTRAN_THROW ("Expected `DEFAULT'"); 
      break;
      default:
        FXTRAN_THROW ("Malformed case"); 
      break;
    }


  XET ();

  if (t[0])
    stmt_unit_name (t, ci, "", _T(_S(NAMED) H _S(LABEL)), ctx);
}

def_extra_proto (SELECTRANKCASE)
{
  int k;
  XAD(4);
  XST (_T(_S(RANK) H _S(SELECTOR)));

  switch (t[0])
    {
      case '(':
        XAD(1);
        k = FXTRAN_str_at_level (t, ci, ")", 0);
        FXTRAN_process_list (t, ci, ctx, ",", 
	        	     _T(_S(RANK) H _S(VALUE) H _S(RANGE) H _S(LIST)), 
			     k-1, case_value_range, NULL);
        XAD(k);
      break;
      case 'D':
        if (zstrcmp ("DEFAULT", t))
          XAD(7);
	else
          FXTRAN_THROW ("Expected `DEFAULT'"); 
      break;
      default:
        FXTRAN_THROW ("Malformed case"); 
      break;
    }


  XET ();

  if (t[0])
    stmt_unit_name (t, ci, "", _T(_S(NAMED) H _S(LABEL)), ctx);
}

#define def_endblock_extra_func(T) \
def_extra_proto (T)                      \
{                                        \
  int k;                                 \
  k = strlen (#T);                       \
  XAD(k);                                \
  if (t[0])                              \
    stmt_eos_named_label (t, ci, ctx);   \
}

def_endblock_extra_func (ELSE)
def_endblock_extra_func (ENDBLOCK)
def_endblock_extra_func (ENDCRITICAL)
def_endblock_extra_func (ENDIF)
def_endblock_extra_func (ENDWHERE)
def_endblock_extra_func (ENDASSOCIATE)
def_endblock_extra_func (ENDDO)
def_endblock_extra_func (ENDFORALL)
def_endblock_extra_func (EXIT)
def_endblock_extra_func (CYCLE)

#undef def_endblock_extra_func

def_extra_proto (ENDSELECTTYPE)
{
  XAD(9);                               
  if (t[0])                             
    stmt_eos_named_label (t, ci, ctx);  
}

def_extra_proto (ENDSELECTCASE)
{
  XAD(9);                               
  if (t[0])                             
    stmt_eos_named_label (t, ci, ctx);  
}

def_extra_proto (ENDSELECTRANK)
{
  XAD(9);                               
  if (t[0])                             
    stmt_eos_named_label (t, ci, ctx);  
}

def_extra_proto (ELSEIF)
{
  int k;
  XAD(7);

  XST (_T(_S(CONDITION) H _S(EXPR)));
  k = FXTRAN_str_at_level (t, ci, ")", 0);
  FXTRAN_expr (t, ci, k-1, ctx);
  XAD(k-1);
  XET ();

  XAD(5);

  if (t[0])
    stmt_eos_named_label (t, ci, ctx);
}

def_extra_proto (ELSEWHERE)
{
  int k;
  XAD(9);

  if (t[0] == '(')
    {
      XAD(1);
      XST (_T(_S(MASK) H _S(EXPR)));
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      FXTRAN_expr (t, ci, k-1, ctx);
      XAD(k-1);
      XET ();
      XAD(1);
    }

  if (t[0])
    stmt_eos_named_label (t, ci, ctx);
}

def_extra_proto (CLOSE)
{
  XAD(5);
  stmt_actual_args (t, ci, ctx, &saap_close);
}

def_extra_proto (OPEN)
{
  XAD(4);
  stmt_actual_args (t, ci, ctx, &saap_open);
}

def_extra_proto (FLUSH)
{
  XAD(5);
  if (t[0] == '(')
    {
      stmt_actual_args (t, ci, ctx, &saap_flush);
    }
  else
    {
      int k;
      XST (_T(_S(EXTERNAL) H _S(FILE) H _S(UNIT)));
      k = strlen (t);
      FXTRAN_expr (t, ci, k, ctx);
      XAD(k);
      XET ();
    }

}

static void stmt_filepos_extra (const char * t, const FXTRAN_char_info * ci, 
		                FXTRAN_xmlctx * ctx, const char * T)
{
  int k = strlen (T);
  XAD(k);
  if (t[0] == '(')
    {
      stmt_actual_args (t, ci, ctx, &saap_filepos);
    }
  else
    {
      int k;
      XST (_T(_S(EXTERNAL) H _S(FILE) H _S(UNIT)));
      k = strlen (t);
      FXTRAN_expr (t, ci, k, ctx);
      XAD(k);
      XET ();
    }

}

#define def_filepos_func_extra(T) \
def_extra_proto (T)                            \
{                                              \
  return stmt_filepos_extra (t, ci, ctx, #T);  \
}

def_filepos_func_extra (BACKSPACE)
def_filepos_func_extra (ENDFILE)
def_filepos_func_extra (REWIND)

#undef def_filepos_func_extra

static void stmt_comnml_extra (const char * t, const FXTRAN_char_info * ci, 
		               FXTRAN_xmlctx * ctx, stmt_entity_decl_parms * seda, 
			       const char * name, FXTRAN_stmt_stack * stack)
{
  int k;

again:

  if (t[0] == '/')
    {
      XAD(1);
      if (t[0] == '/') /* Blank common */
        {
          XAD(1);
        }
      else
        {
          k = FXTRAN_eat_word (t);
          XNT (name, k);
          XAD(k);
          if (t[0] != '/')
            FXTRAN_THROW ("Expected `/'");
          XAD(1);
        }
    }

  k = FXTRAN_str_at_level (t, ci, "/", 0);
  if (k == 0)
    k = strlen (t);
  else
    {
      k = k - 1;
      if (t[k-1] == ',')
        k--;
    }

  {
    char t1[k];
    FXTRAN_char_info ci1[k];
    FXTRAN_restrict_tci (t1, ci1, t, ci, k);
    stmt_entity_list (t1, ci1, ctx, 1, 0, seda, stack);
    XAD(k);
  }

  if (t[0] == ',')
    XAD(1);

  if (t[0] == '/')
    goto again;
}

def_extra_proto (COMMON)
{
  XAD(6);
  stmt_comnml_extra (t, ci, ctx, &seda_common, _T(_S(COMMON) H _S(BLOCK) H _S(NAME)), stack);
}

def_extra_proto (NAMELIST)
{
  XAD(8);
  stmt_comnml_extra (t, ci, ctx, &seda_namelist, _T(_S(NAMELIST) H _S(GROUP) H _S(NAME)), stack);
}


def_extra_proto (ENTRY)
{
  int k = stmt_unit_name (t, ci, "ENTRY", _T(_S(ENTRY) H _S(NAME)), ctx);
  XAD(k);

  k = stmt_unit_dummy_args (t, ci, ctx, stack);
  XAD(k);
    
  suffix (t, ci, ctx, 1, stack);
}

def_extra_proto (SUBROUTINE)
{
  int seen_prefix = 0;
  int k2;
  int k3;
  const char * prefix[] = { "MODULE", "RECURSIVE", "NON_RECURSIVE", "IMPURE", "PURE", "ELEMENTAL", NULL };

  while (1)
    {
      int i;
      int ad = 0;

      for (i = 0; prefix[i]; i++)
        if (zstrcmp (prefix[i], t))
          {
            int len = strlen (prefix[i]);
            FXTRAN_xml_word_tag (_T(_S(PREFIX)), ci[0].offset, ci[len-1].offset+1, ctx);
	    XAD(len);
	    ad++;
	    prefix[i] = "!";
            seen_prefix++;
          }

      if (zstrcmp ("SUBROUTINE", t))
        break;

      if (ad == 0)
        break;

    }

  if (seen_prefix)
    XSP ();

  k2 = stmt_unit_name (t, ci, "SUBROUTINE", _T(_S(SUBROUTINE) H _S(NAME)), ctx);
  XAD(k2);
  k3 = stmt_unit_dummy_args (t, ci, ctx, stack);
  XAD(k3);

  suffix (t, ci, ctx, 0, stack);
}

static void stmt_assignment_extra (const char * t, const FXTRAN_char_info * ci, 
		                   FXTRAN_xmlctx * ctx, const char * op)
{
  int k = FXTRAN_str_at_level (t, ci, op, 0);

  if (k == 0)
    FXTRAN_THROW ("Expected `%s'", op);

  XST (_T(_S(EXPR) H "1"));
  FXTRAN_expr (t, ci, k-1, ctx);

  XAD(k-1);
  XET ();

  k = strlen (op);
  FXTRAN_xml_word_tag (_T(_S(ASSIGNMENT)), ci->offset, ci[k-1].offset+1, ctx);

  XAD(k);

  k = strlen (t);

  XST (_T(_S(EXPR) H "2"));
  FXTRAN_expr (t, ci, k, ctx);
  XAD(k);
  XET ();
}

def_extra_proto (POINTERASSIGNMENT)
{
  return stmt_assignment_extra (t, ci, ctx, "=>");
}

def_extra_proto (ASSIGNMENT)
{
  return stmt_assignment_extra (t, ci, ctx, "=");
}

static void def_construct_end_ (FXTRAN_stmt_type TFO, FXTRAN_stmt_type TF, int blk, 
		                FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, xml_tu * tu) 
{
  FXTRAN_stmt_stack_state * sts = FXTRAN_stmt_stack_curr (stack); 
  if (sts == NULL)
    FXTRAN_ABORT ("Unexpected %s statement", stmt_as_str (TF));               
  if (sts->type != TFO)                                  
    FXTRAN_ABORT ("Unexpected %s statement", stmt_as_str (TF));               
  if (ctx->opts.construct_tag)                                    
    tu->xml_ctu2 = blk ? 2 : 1;                                  
  FXTRAN_stmt_stack_decr (stack);                                 
}

static void def_construct_alt_ (FXTRAN_stmt_type TFO, FXTRAN_stmt_type TF, const char * ss,
		                FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, xml_tu * tu) 
{
  FXTRAN_stmt_stack_state * sts = FXTRAN_stmt_stack_curr (stack); 
  if (sts->type != TFO)                                  
    FXTRAN_ABORT ("Unexpected %s statement", stmt_as_str (TF));               
  if (ctx->opts.construct_tag)                                    
    {                                                             
      tu->xml_ctu1 = 1;                                          
      tu->xml_otu1[0] = ss;                                      
      tu->xml_otu1[1] = NULL;                                    
    }                                                             
}

static void def_construct_opn_ (FXTRAN_stmt_type TF, int blk, const char * ss1, const char * ss2,
		                FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, xml_tu * tu) 
{
  if (ctx->opts.construct_tag)                                      
    {                                                               
      tu->xml_otu1[0] = NULL;                                      
      tu->xml_otu1[1] = NULL;                                      
      tu->xml_otu1[2] = NULL;                                      
      tu->xml_otu1[0] = ss1;                                       
      if (blk)                                                      
        tu->xml_otu1[1] = ss2;                                     
    }                                                               
  FXTRAN_stmt_stack_incr (stack, TF);                      
}

static int stmt_prog_unit_expected (FXTRAN_stmt_stack * stack)
{
  FXTRAN_stmt_stack_state * st = FXTRAN_stmt_stack_curr(stack);
  if (st == NULL)
    return 1;
  if ((st->seen_contains) && (st->type != FXTRAN_TYPE) && (st->type != FXTRAN_CLASS))
    return 1;
  return 0;
}

static int seen_contains (FXTRAN_stmt_stack * stack)
{
  FXTRAN_stmt_stack_state * st = FXTRAN_stmt_stack_curr(stack);
  if (st == NULL)
    return 0;
  return st->seen_contains;
}

static FXTRAN_stmt_type grok_fs (const char * t, const FXTRAN_char_info * ci)
{
/* we need to distinguish between SUBROUTINE and FUNCTION */
  int k = 0;
  int i;
  const char * prefix[] = { "MODULE", "NON_RECURSIVE", "RECURSIVE", "ELEMENTAL", "IMPURE", "PURE", NULL };

  if (zstrcmp ("MODULEPROCEDURE", t))
    return FXTRAN_PROCEDURE;
  while (1)
    {
      int k1 = k;
      for (i = 0; prefix[i]; i++)
        if (zstrcmp(prefix[i], &t[k]))
          {
  	    k += strlen (prefix[i]);
            prefix[i] = "!";
          }
      if (k1 == k)
        break;
    }
  if (zstrcmp ("SUBROUTINE", &t[k]))
    return FXTRAN_SUBROUTINE;
/* At this point, we know it MUST be a function; perform a basic check */
  if ((k = FXTRAN_str_at_level (t, ci, "FUNCTION", 0))) 
    {
      int j;
     
      if ((j = FXTRAN_eat_word (&t[k])) == 0)
        return FXTRAN_NONE;

      k += j;

      if ((t[k] == '(') && ((t[k+1] == ')') || isalpha(t[k+1])))
        return FXTRAN_FUNCTION;
      
      return FXTRAN_NONE;
    }
  return FXTRAN_NONE;
}

static int get_do_label (const char * t)
{
  int i;
  int do_label = 0;
  int k = FXTRAN_eat_word (t);
  if (t[k] == ':')
    t = &t[k+1];
  for (i = 2; isdigit (t[i]); i++)
    do_label = do_label * 10 + (t[i] - '0');
  return do_label;
}


#define ret(x) \
  do { Type = x;                                   \
       if ((Type == FXTRAN_TYPEDECL) &&            \
           (FXTRAN_stmt_in(stack,FXTRAN_TYPE) ||   \
            FXTRAN_stmt_in(stack,FXTRAN_CLASS)))   \
	  Type = FXTRAN_COMPONENTDECL;             \
       goto done; } while (0)

#define tt(x) \
  do { if (zstrcmp(#x,t)) ret(FXTRAN_##x); } while (0)

#define tt0(x) \
  do { if (ystrcmp(#x,t)) ret(FXTRAN_##x); } while (0)

#define tt2(x) \
  do { tt(END##x); } while (0)

static FXTRAN_stmt_type get_FXTRAN_stmt_type (const char * t, const FXTRAN_char_info * ci, 
		                              FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, 
					      int * pexpect_pu, xml_tu * tu)
{
  int len;
  FXTRAN_stmt_type Type = FXTRAN_NONE;

  *pexpect_pu = 0;
  len = strlen (t);

  if ((!stmt_prog_unit_expected (stack)) || (!stack->seen_stmt))
  if (!FXTRAN_str_at_level (t, ci, "::", 0)) 
    {
      int k;
      if (!FXTRAN_str_at_level (t, ci, ",", 0))
        {
          FXTRAN_stmt_type tt = FXTRAN_NONE;
          if (FXTRAN_str_at_level (t, ci, "=>", 0))
            tt = FXTRAN_POINTERASSIGNMENT;
          else if (FXTRAN_str_at_level (t, ci, "=", 0))
            tt = FXTRAN_ASSIGNMENT;

	  if (tt)
            {
#define tother(T) \
  do {                                              \
  if (zstrcmp(#T"(",t))                             \
    {                                               \
      if ((k = FXTRAN_str_at_level (t, ci, ")", 0)))\
        if (isalpha (t[k]))                         \
          goto other;                               \
    }                                               \
  } while (0)

              tother(IF);
              tother(WHERE);
              tother(FORALL);
#undef tother
              ret(tt);
	    }
        }
      if ((k = FXTRAN_str_at_level (t, ci, ":", 0))) /* we may have a named label here */
        {
	  if (FXTRAN_eat_word (t) != k-1)
            goto other;
          return get_FXTRAN_stmt_type (&t[k], &ci[k], stack, ctx, pexpect_pu, tu);
	}
    }

  if (stmt_prog_unit_expected (stack))
    {
      FXTRAN_stmt_type type;

      if (! seen_contains (stack))
        {
          tt(MODULE);
          tt(SUBMODULE);
          tt(BLOCKDATA);
          tt(PROGRAM);        
        }
      
      type = grok_fs (t, ci);

      if (type == FXTRAN_NONE)
        {
          if (!stack->seen_stmt)
            {
              /* At this point, nothing was found, hence we 
	       * must have entered a nameless program unit */
              FXTRAN_stmt_stack_incr (stack, FXTRAN_PROGRAM);
              if (ctx->opts.construct_tag)
                {
	          tu->xml_otu1[0] = _T(_S(PROGRAM) H _S(UNIT));
	          tu->xml_otu1[1] = NULL;
                }
            }
	  else
            {
              *pexpect_pu = 1;
            }
	}
      else
        {
          if (seen_contains (stack))
            *pexpect_pu = 1;
          ret(type);
	}
    }
  else if (FXTRAN_stmt_in(stack,FXTRAN_INTERFACE))
    {
      FXTRAN_stmt_type type;

      if (zstrcmp ("MODULEPROCEDURE", t))
        ret(FXTRAN_PROCEDURE);
      else if (zstrcmp ("PROCEDURE", t))
        ret(FXTRAN_PROCEDURE);

      type = grok_fs (t, ci);

      if (type == FXTRAN_NONE)
        goto other;       /* Skip assignment & typedecl checks */
      else
        ret(type);
    }
  else if ((FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))
       && (FXTRAN_stmt_stack_curr(stack)->seen_contains))
    {
      if (zstrcmp ("PROCEDURE(", t) || zstrcmp("PROCEDURE,", t))
        goto other;
      if (zstrcmp ("PROCEDURE", t))
        ret(FXTRAN_PROCEDURE);
      else
        goto other;       /* Skip assignment & typedecl checks */
    }

 
other:
  /* Speed up search; look at first letter to reduce the number of strcmp */
  switch (t[0])
    {
	case 'A':
       
        if (ystrcmp("ABSTRACTINTERFACE", t))
          ret(FXTRAN_INTERFACE);
        tt(ALLOCATABLE);    tt(ALLOCATE);       tt(ASSIGN);         tt(ASSOCIATE);
	tt(ASYNCHRONOUS);

	break;
       
	case 'B':
       
        tt(BACKSPACE);      
        tt0(BLOCK);
        tt(BIND);      

	break;
       
        case 'C':
       
        if (zstrcmp ("CLASSIS(",t))
          ret(FXTRAN_CLASSIS);
       
        if (zstrcmp ("CLASSDEFAULT",t))
          ret(FXTRAN_CLASSIS);
       
        if (zstrcmp ("CLASS(",t))
          ret(FXTRAN_TYPEDECL);
       
        if (zstrcmp ("CHARACTER",t))
          ret(FXTRAN_TYPEDECL);

        if (zstrcmp ("COMPLEX",t))
          ret(FXTRAN_TYPEDECL);

        tt(CALL);           tt(CASE);           tt(CHANGETEAM);     tt(CLOSE);          
        tt(COMMON);         tt0(CONTAINS);      tt(CONTIGUOUS);     tt(CONTINUE);       
        tt(CYCLE);          tt(CODIMENSION);    tt(CRITICAL);

	break;
       
	case 'D':
       
        if (zstrcmp ("DOUBLEPRECISION",t))
          ret(FXTRAN_TYPEDECL);
        if (zstrcmp ("DOUBLECOMPLEX",t))
          ret(FXTRAN_TYPEDECL);
        tt(DATA);           tt(DEALLOCATE);     tt(DIMENSION);      
	
	if (zstrcmp ("DO", t))
          {
            if (isdigit (t[2]))
              ret(FXTRAN_DOLABEL);
            else
	      ret(FXTRAN_DO);
	  }

	break;
       
	case 'E':

        tt(ENUMERATOR);
        tt(ENUM);
       
	if ((t[1] == 'N') && (t[2] == 'D'))
          {
            tt2(ASSOCIATE);     tt2(BLOCKDATA);     tt2(BLOCK);         
            tt2(CLASS);         tt2(DO);            tt2(FORALL);        tt2(FUNCTION);      
            tt2(IF);            tt2(INTERFACE);     tt2(MODULE);        tt2(PROGRAM);       
            tt2(SUBROUTINE);    tt2(TYPE);          tt2(WHERE);         tt(ENDFILE);        
            tt2(ENUM);          tt2(SUBMODULE);     tt2(PROCEDURE);     tt2(CRITICAL);

            if (zstrcmp("ENDTEAM",t)) 
              ret(FXTRAN_ENDCHANGETEAM); 

            if (FXTRAN_stmt_stack_ok (stack)) /* here we need context data */
              {
#define csss(T) case FXTRAN_##T: ret(FXTRAN_END##T)
                FXTRAN_stmt_stack_state * st = FXTRAN_stmt_stack_curr(stack);
                if (t[3] == '\0')
                  {
	            if (st)
                      switch (FXTRAN_stmt_stack_curr(stack)->type)
                        {
                          csss(MODULE);
                          csss(SUBMODULE);
                          csss(PROGRAM);
                          csss(FUNCTION);
                          csss(SUBROUTINE);
                          csss(BLOCKDATA);
	                  default:
                            FXTRAN_stmt_stack_break (stack, ctx);
                        }
	            else
                      ret(FXTRAN_ENDPROGRAM);
                  }
                else if (zstrcmp ("ENDSELECT", t) && st)
                  {
                    int labok = 1;
                    const char * s = t + 9;
                    for (; *s; s++) 
                      labok = labok && (isalnum (*s) || *s == '_');
                    if (labok)
                      {
                        switch (FXTRAN_stmt_stack_curr(stack)->type)
                          {
                            csss(SELECTCASE);
                            csss(SELECTRANK);
                            csss(SELECTTYPE);
                            default:
                              break;
                          }
                      }
                  }
              }
#undef csss
	  }

	if (zstrcmp ("ELSEIF(", t))
          ret(FXTRAN_ELSEIF);

	if (FXTRAN_stmt_in (stack, FXTRAN_WHERECONSTRUCT))
	  if (zstrcmp ("ELSEWHERE", t))
            return FXTRAN_ELSEWHERE;

        tt(ELSE);           tt(ENDIF);          tt(ENTRY);          tt(EQUIVALENCE);    
	tt(ERRORSTOP);      tt(EXIT);           tt(EXTERNAL);

	break;
       
	case 'F':
       
        tt(FINAL);          tt(FLUSH);          tt(FORMTEAM);

	if (zstrcmp("FORALL",t))
          {
	    int k = FXTRAN_str_at_level (t, ci, ")", 0);
	    int len = strlen (t);
	    if (k != len)
              ret(FXTRAN_FORALL);
	    else
	      ret(FXTRAN_FORALLCONSTRUCT);
          }

        tt(FORMAT);         

	break;

	case 'G':

        tt(GENERIC);        
	
	if (zstrcmp ("GOTO(", t))
          ret(FXTRAN_COMPUTEDGOTO);

	if (zstrcmp ("GOTO", t))
          {
            if (FXTRAN_str_at_level (t, ci, "(", 0))
              ret(FXTRAN_ASSIGNEDGOTO);
	    ret(FXTRAN_GOTO);
          }

	break;
       
	case 'I':
       
        if (zstrcmp ("INTEGER",t))
          ret(FXTRAN_TYPEDECL);
        if (zstrcmp("IF(",t))
          {
            int k;
            if (zstrcmp(")THEN",&t[len-5]))
              ret(FXTRAN_IFTHEN);
            k = FXTRAN_str_at_level (t, ci, ")", ci[0].parens);
	    if (k == 0)
              ret(FXTRAN_NONE);
	    if (isdigit (t[k]))
              ret(FXTRAN_ARITHMETICIF);
	    ret(FXTRAN_IF);
	  }


	tt(IMPLICITNONE);   tt(IMPLICIT);       tt(IMPORT);         tt(INCLUDE);        
	tt(INQUIRE);        tt(INTENT);         tt(INTERFACE);      tt(INTRINSIC);

	break;

	case 'L':

        if (zstrcmp ("LOGICAL",t))
          ret(FXTRAN_TYPEDECL);
        
        tt(LOCK);

	break;
       
	case 'N':
       
        tt(NAMELIST);       tt(NULLIFY);

	break;
       
	case 'O':
       
        tt(OPEN);           tt(OPTIONAL);

	break;
       
	case 'P':
       
        if (zstrcmp ("PROCEDURE(",t))
          ret(FXTRAN_TYPEDECL);

        if (zstrcmp ("PROCEDURE,",t))
          ret(FXTRAN_TYPEDECL);

        if (ctx->opts.cray_pointer)                                    
          if (zstrcmp ("POINTER(",t))
            ret(FXTRAN_CRAYPOINTER);

        tt(PAUSE);          tt(PARAMETER);      tt(POINTER);        tt(PRINT);          
	tt(PRIVATE);        tt(PROTECTED);      tt(PUBLIC);

	break;
       
	case 'R':

        if (zstrcmp ("RANK",t))
          ret(FXTRAN_SELECTRANKCASE);           
	tt(READ);

        if (zstrcmp ("REAL",t))
          ret(FXTRAN_TYPEDECL);

	tt(RETURN);         tt(REWIND);

        break;

	case 'S':
       
        tt(SAVE);           tt(SELECTTYPE);     tt(SELECTRANK);     tt(SELECTCASE);     
        tt(SEQUENCE);       tt(STOP);           tt(SYNCALL);        tt(SYNCIMAGES);     
	tt(SYNCMEMORY); tt(SYNCTEAM);
       
        break;

	case 'T':
       
        tt(TARGET);
       
        if (zstrcmp ("TYPE(",t))
          ret(FXTRAN_TYPEDECL);

	/* TODO : remove possible confusion with TYPE IS(KIND,LEN) */
	if (zstrcmp ("TYPEIS(",t))
          ret(FXTRAN_TYPEIS);
       
        tt(TYPE);

	break;
       
	case 'U':
       
        tt(UNLOCK);         tt(USE);

	break;

	case 'V':

	tt(VOLATILE);       tt(VALUE);

	break;
       
	case 'W':
       
	tt(WAIT);           tt(WRITE);

	if (zstrcmp("WHERE",t))
          {
	    int k = FXTRAN_str_at_level (t, ci, ")", 0);
	    int len = strlen (t);
	    if (k != len)
              ret(FXTRAN_WHERE);
	    else
	      ret(FXTRAN_WHERECONSTRUCT);
          }


	break;

    }



done:

  stack->seen_stmt = 1;

  return Type;

#undef ystrcmp
#undef tt
#undef tt0
#undef tt2
#undef ret

}

static void stmt_block_handle (const char * t, FXTRAN_stmt_type Type, int expect_pu, int label,
		               FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, xml_tu * tu)
{

#define def_construct_end__(TFO,TF,blk) \
      case FXTRAN_##TF:                                                      \
        def_construct_end_ (FXTRAN_##TFO,FXTRAN_##TF,blk,stack,ctx,tu);      \
      break;

#define def_construct_alt__(TFO,TF,ss) \
      case FXTRAN_##TF:                                                      \
        def_construct_alt_ (FXTRAN_##TFO,FXTRAN_##TF,ss,stack,ctx,tu);       \
      break;

#define def_construct_opn__(TF,blk,ss1,ss2) \
      case FXTRAN_##TF:                                                      \
        def_construct_opn_ (FXTRAN_##TF,blk,ss1,ss2,stack,ctx,tu);           \
      break;

#define def_compound_block_construct_opn(TF,TS) \
  def_construct_opn__(TF,1,_T(_S(TS) H _S(CONSTRUCT)),_T(_S(TS) H _S(BLOCK)))
#define def_compound_block_construct_alt(TFO,TS,TF) \
  def_construct_alt__(TFO,TF,_T(_S(TS) H _S(BLOCK)))
#define def_compound_block_construct_end(TFO,TS,TF) \
  def_construct_end__(TFO,TF,1)

#define def_simple_block_construct_opn(TF,TS) \
  def_construct_opn__(TF,0,_T(_S(TS) H _S(CONSTRUCT)),NULL)
#define def_simple_block_construct_end(TFO,TS,TF) \
  def_construct_end__(TFO,TF,0)

#define def_program_construct_opn(TF) \
  def_construct_opn__(TF,0,_T(_S(PROGRAM) H _S(UNIT)),NULL)
#define def_program_construct_end(TFO,TF) \
  def_construct_end__(TFO,TF,0) 


  /* Particular case of a program made of a single END statement after another program unit */
  if ((!FXTRAN_stmt_stack_curr(stack)) && (Type == FXTRAN_ENDPROGRAM))
    def_construct_opn_ (FXTRAN_PROGRAM, 0, _T(_S(PROGRAM) H _S(UNIT)), NULL, stack, ctx, tu);

  /* program unit */
  switch (Type)
    {

def_program_construct_opn (BLOCKDATA)
def_program_construct_end (BLOCKDATA, ENDBLOCKDATA)

def_program_construct_opn (PROGRAM)
def_program_construct_end (PROGRAM, ENDPROGRAM)

def_program_construct_opn (SUBROUTINE)
def_program_construct_end (SUBROUTINE, ENDSUBROUTINE)

def_program_construct_opn (FUNCTION)
def_program_construct_end (FUNCTION, ENDFUNCTION)

def_program_construct_opn (MODULE)
def_program_construct_end (MODULE, ENDMODULE)

def_program_construct_opn (SUBMODULE)
def_program_construct_end (SUBMODULE, ENDSUBMODULE)

def_program_construct_end (PROCEDURE, ENDPROCEDURE)

      case FXTRAN_CONTAINS:
        if (! FXTRAN_stmt_stack_curr(stack))
          FXTRAN_ABORT ("Unexpected CONTAINS statement");
        FXTRAN_stmt_stack_curr(stack)->seen_contains = 1;
      break;
      default:
        if ((!FXTRAN_stmt_stack_curr(stack)) && (FXTRAN_stmt_stack_ok(stack)))
          {
	    expect_pu = 0;
            def_construct_opn_ (FXTRAN_PROGRAM, 0, _T(_S(PROGRAM) H _S(UNIT)), NULL, stack, ctx, tu);
	  }
	if (expect_pu)
          switch (Type)
            {
def_program_construct_opn (PROCEDURE)
	      case FXTRAN_INCLUDE:
	      break;
              default:
              FXTRAN_ABORT ("Expected program unit statement", ctx);
            }
          
      break;
    }

  /* The weird case of the end of do label statements */
  {
    int k = 0;
    while (1)
      {
        FXTRAN_stmt_stack_state * sts = FXTRAN_stmt_stack_curr (stack); 
        if (sts == NULL)
          break;
        if ((sts->type == FXTRAN_DOLABEL) && (sts->do_label == label))
          {
            if (ctx->opts.construct_tag)                                    
              tu->xml_ctu2++;
            FXTRAN_stmt_stack_decr (stack);                                 
	    k++;
          }
        else
          {
            break;
          }
      }
    if (k > 0)
      goto end;
  }

  /* Other block statements */
  switch (Type)
    {

def_compound_block_construct_opn (IFTHEN, IF)
def_compound_block_construct_alt (IFTHEN, IF, ELSEIF)
def_compound_block_construct_alt (IFTHEN, IF, ELSE)
def_compound_block_construct_end (IFTHEN, IF, ENDIF)

def_compound_block_construct_opn (WHERECONSTRUCT, WHERE)
def_compound_block_construct_alt (WHERECONSTRUCT, WHERE, ELSEWHERE)
def_compound_block_construct_end (WHERECONSTRUCT, WHERE, ENDWHERE)

def_compound_block_construct_opn (SELECTCASE, SELECTCASE)
def_compound_block_construct_alt (SELECTCASE, SELECTCASE, CASE)
def_compound_block_construct_end (SELECTCASE, SELECTCASE, ENDSELECTCASE)

def_compound_block_construct_opn (SELECTRANK, SELECTRANK)
def_compound_block_construct_alt (SELECTRANK, SELECTRANK, SELECTRANKCASE)
def_compound_block_construct_end (SELECTRANK, SELECTRANK, ENDSELECTRANK)

def_compound_block_construct_opn (SELECTTYPE, SELECTTYPE)
def_compound_block_construct_alt (SELECTTYPE, SELECTTYPE, TYPEIS)
def_compound_block_construct_end (SELECTTYPE, SELECTTYPE, ENDSELECTTYPE)

def_simple_block_construct_opn (BLOCK, BLOCK)
def_simple_block_construct_end (BLOCK, BLOCK, ENDBLOCK)

def_simple_block_construct_opn (CRITICAL, CRITICAL)
def_simple_block_construct_end (CRITICAL, CRITICAL, ENDCRITICAL)

def_construct_opn__(CHANGETEAM,0,_T(_S(CHANGE) H _S(TEAM) H _S(CONSTRUCT)),NULL)
def_construct_end__(CHANGETEAM,ENDCHANGETEAM,0)

def_simple_block_construct_opn (CLASS, CLASS)
def_simple_block_construct_end (CLASS, CLASS, ENDCLASS)

def_simple_block_construct_opn (ENUM, ENUM)
def_simple_block_construct_end (ENUM, ENUM, ENDENUM)

def_simple_block_construct_opn (TYPE, TYPE)
def_simple_block_construct_end (TYPE, TYPE, ENDTYPE)

def_simple_block_construct_opn (FORALLCONSTRUCT, FORALL)
def_simple_block_construct_end (FORALLCONSTRUCT, FORALL, ENDFORALL)

def_simple_block_construct_opn (INTERFACE, INTERFACE)
def_simple_block_construct_end (INTERFACE, INTERFACE, ENDINTERFACE)

def_simple_block_construct_opn (ASSOCIATE, ASSOCIATE)
def_simple_block_construct_end (ASSOCIATE, ASSOCIATE, ENDASSOCIATE)

def_construct_opn__ (DOLABEL, 0, _T(_S(DO) H _S(LABEL) H _S(CONSTRUCT)), NULL)

def_simple_block_construct_opn (DO, DO)
def_simple_block_construct_end (DO, DO, ENDDO)

      default:
      break;

    }

  /* Record the do label of do label statements */
  if (Type == FXTRAN_DOLABEL)
    FXTRAN_stmt_stack_curr(stack)->do_label = get_do_label (t);

end:
  return;

#undef def_construct_end__
#undef def_construct_alt__
#undef def_construct_opn__
#undef def_compound_block_construct_opn
#undef def_compound_block_construct_alt
#undef def_compound_block_construct_end
#undef def_simple_block_construct_opn
#undef def_simple_block_construct_end
#undef def_program_construct_opn
#undef def_program_construct_end

}


static void stmt_simple_extra (const char * t, const FXTRAN_char_info * ci, 
		               FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx,
			       const char * expr_name)
{
  int k = FXTRAN_str_at_level (t, ci, "(", 0);

  XAD(k);

  k = FXTRAN_str_at_level (t, ci, ")", 0);

  XST (expr_name);
  FXTRAN_expr (t, ci, k-1, ctx);

  XAD(k-1);

  XET ();

  XAD(1);

  XST (_T(_S(ACTION) H _S(STMT)));
  k = strlen (t);

  FXTRAN_stmt (t, ci, stack, ctx, 0, 0, 0, 0);

  XAD(k);
  XET ();
}

#define def_stmt_simple_extra(T, exn) \
static void stmt_##T##_extra (const char * t, const FXTRAN_char_info * ci,        \
		              FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx)     \
{                                                                                 \
  return stmt_simple_extra (t, ci, stack, ctx, exn);                              \
}

def_stmt_simple_extra(IF, _T(_S(CONDITION) H _S(EXPR)))
def_stmt_simple_extra(WHERE, _T(_S(MASK) H _S(EXPR)))

#undef def_stmt_simple_extra


#define def_stmt_empty(T) \
def_extra_proto (T) { }

def_stmt_empty (CONTINUE)
def_stmt_empty (CONTAINS)
def_stmt_empty (SEQUENCE)
def_stmt_empty (ENDENUM)

#undef def_stmt_empty

def_process_list_elt_proto (arithmetic_if_label)
{
  XST (_T(_S(LABEL)));
  XAD(kmax);
  XET ();
  return 1;
}

def_extra_proto (ARITHMETICIF)
{
  int k;
  XAD(3);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  XST (_T(_S(NUMERIC) H _S(EXPR)));
  FXTRAN_expr (t, ci, k-1, ctx);
  XAD(k-1);

  XET ();

  XAD(1);

  k = strlen (t);
  FXTRAN_process_list (t, ci, ctx, ",",
	               _T(_S(LABEL) H _S(LIST)), 
		       k, arithmetic_if_label, NULL);
  
}

def_extra_proto (ASSIGN)
{
  int k;
  XAD(6);
  k = FXTRAN_str_at_level (t, ci, "TO", 0);

  if (k == 0)
    FXTRAN_THROW ("Expected `TO'");

  XST (_T(_S(LABEL)));

  XAD(k-1);
  XET ();

  XAD(2);

  k = strlen (t);

  XNT (_T(_S(NAME)), k);

  XST (_T(_S(VARIABLE)));
  XAD(k);
  XET ();

}

def_process_list_elt_proto (letter_spec)
{

  FXTRAN_xml_word_tag (_T(_S(LETTER) H _S(SPEC)), ci->offset, ci[kmax-1].offset+1, ctx);

  return 1;
}

def_process_list_elt_proto (implicit_spec)
{
  int i;
  int k;
  const char * T = t;


  for (i = 0; FXTRAN_types[i]; i++)
    if (zstrcmp (FXTRAN_types[i], t))
      break;

  if (FXTRAN_types[i] == NULL)
    FXTRAN_THROW ("Unknown type"); 

  XST (_T(_S(IMPLICIT) H _S(SPEC)));
  XST (_T(_S(TYPE) H _S(SPEC)));
  k = strlen (FXTRAN_types[i]);
  XAD(k);

  if (t[0] == '(')
    {
      k = FXTRAN_str_at_level (t, ci, ")", ci[0].parens);
      if (&t[k] - T >= kmax)
        goto letter_spec;
    }

  k = typespec_ext (t, ci, ctx, i);

  XAD(k);


letter_spec:
  XET ();

  if (t[0] != '(')
    FXTRAN_THROW ("Expected `('"); 

  XAD(1);

  k = FXTRAN_str_at_level (t, ci, ")", ci[0].parens-1);
  FXTRAN_process_list (t, ci, ctx, ",",
	               _T(_S(LETTER) H _S(SPEC) H _S(LIST)), 
		       k-1, letter_spec, NULL);

  XAD(k);
  XET ();

  return 1;
}

def_extra_proto (IMPLICIT)
{
  int k;
  XAD(8);
  k = strlen (t);
  FXTRAN_process_list (t, ci, ctx, ",",
	               _T(_S(IMPLICIT) H _S(SPEC) H _S(LIST)), 
		       k, implicit_spec, NULL);
  
}

def_extra_proto (IMPLICITNONE)
{
  int k;
  XAD(8);
  XSP();
  XAD(4);

  if (t[0] == '\0')
    return;

  if (t[0] != '(')
    FXTRAN_ABORT ("Expected '('");

  XAD (1);

  XST (_T(_S(IMPLICIT) H _S(NONE) H _S(SPEC) H _S(LIST)));
  while (1)
    {
      if (t[0] == ')') /* List might be empty */
        break;
      k = FXTRAN_eat_word (t);
      if (k == 0)
        FXTRAN_ABORT ("Expected spec");

      XST (_T(_S(IMPLICIT) H _S(NONE) H _S(SPEC)));
      XAD (k);
      XET ();
      if (t[0] == ')')
        break;
      if (t[0] != ',')
        FXTRAN_ABORT ("Expected ','");
      XAD (1);
    }
  XET ();
}

def_process_list_elt_proto (module_procedure_rename)
{
  int k = FXTRAN_eat_word (t);

  XST (_T (_S (RENAME)));
  XNT (_T(_S (USE) H _S(NAME)), k);
  XAD(k);
  
  if (zstrcmp ("=>", t))
    {
      XAD(2);
      k = FXTRAN_eat_word (t);
      XNT (_T(_S (NAME)), k);
    }

  XET ();

  return 1;
}

def_process_list_elt_proto (module_procedure_name)
{
  int k = FXTRAN_eat_word (t);

  XNT (_T(_S(NAME)), k);
  XAD(k);
  
  return 1;
}

def_extra_proto (PROCEDURE)
{
  int k;
  int module;
  int cont = seen_contains (stack);
  int type = FXTRAN_stmt_in (stack, FXTRAN_TYPE) 
          || FXTRAN_stmt_in (stack, FXTRAN_CLASS);

  if (zstrcmp ("MODULEPROCEDURE", t))
    {
      XAD(15);
      if (cont)
        module = 0;
      else
        module = 1;
    }
  else if (zstrcmp ("PROCEDURE", t))
    {
      XAD(9);
      module = 0;
    }
  else
    {
      FXTRAN_THROW ("Expected `MODULEPROCEDURE' or `PROCEDURE'"); 
    }


  while (t[0] == ',')
    {
      XAD(1);
      k = FXTRAN_attr (t, ci, ctx);
      XAD(k);
    }

  skip_dc ();

  k = strlen (t);

  FXTRAN_process_list (t, ci, ctx, ",",
                      module 
                      ? _T(_S(MODULE) H _S(PROCEDURE) H _S(NAME) H _S(LIST)) 
	              : _T(_S(PROCEDURE) H _S(NAME) H _S(LIST)), 
		      k, 
                      type ? module_procedure_rename : module_procedure_name, 
                      NULL);

}

def_extra_proto (IFTHEN)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);

  XAD(3);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  XST (_T(_S(CONDITION) H _S(EXPR)));
  FXTRAN_expr (t, ci, k-1, ctx);
  XAD(k-1);
  XET ();
}

def_extra_proto (WHERECONSTRUCT)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);

  XAD(6);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  XST (_T(_S(MASK) H _S(EXPR)));
  FXTRAN_expr (t, ci, k-1, ctx);
  XAD(k-1);
  XET ();
}

static void stmt_forall_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, 
		               FXTRAN_xmlctx * ctx, int simple)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  XAD(k);

  XAD(6);

  k = forall_header (t, ci, stack, ctx);

  XAD (k);
   
  if (simple)
    {
      XST (_T(_S(ACTION) H _S(STMT)));
      k = strlen (t);
     
      FXTRAN_stmt (t, ci, stack, ctx, 0, 0, 0, 0);
     
      XAD(k);
      XET ();
    }
}

def_extra_proto (FORALLCONSTRUCT)
{
  return stmt_forall_extra (t, ci, stack, ctx, 0);

}

def_extra_proto (FORALL)
{                                                                  
  return stmt_forall_extra (t, ci, stack, ctx, 1);
}

def_extra_proto (GOTO)
{                                                                  
  int k;
  XAD(4);
  k = strlen (t);
  XST (_T(_S(LABEL)));
  XAD(k);
  XET ();
}

def_process_list_elt_proto (assigned_goto_label)
{
  XST (_T(_S(LABEL)));
  XAD(kmax);
  XET ();
  return 1;
}

def_extra_proto (ASSIGNEDGOTO)
{
  int kc, kp, k;
  XAD(4);
  kp = FXTRAN_str_at_level (t, ci, "(", 0);
  kc = FXTRAN_str_at_level (t, ci, ",", 0);
 
  k = 0;
  if (kc > 0)
    k = kc;
  if ((kp > 0) && ((kp < k) || (k == 0)))
    k = kp;

  XST (_T(_S(TEST) H _S(EXPR)));
  FXTRAN_expr (t, ci, k-1, ctx);
  XAD(k-1);
  XET ();

  if (t[0] == ',')
    XAD(1);

  XAD(1);

  k = strlen (t);

  FXTRAN_process_list (t, ci, ctx, ",",
	               _T(_S(LABEL) H _S(LIST)), 
		       k, assigned_goto_label, NULL);

}

def_extra_proto (COMPUTEDGOTO)
{
  int k;
  XAD(5);
  k = FXTRAN_str_at_level (t, ci, ")", 0);
  FXTRAN_process_list (t, ci, ctx, ",",
	               _T(_S(LABEL) H _S(LIST)), 
		       k, assigned_goto_label, NULL);
  XAD(k);

  if (t[0] == ',')
    XAD(1);

  k = strlen (t);
  XST (_T(_S(TEST) H _S(EXPR)));
  FXTRAN_expr (t, ci, k, ctx);
  XAD(k);
  XET ();
}

def_extra_proto (FORMAT)
{
  int k;
  XAD(6);
  k = strlen (t);

  FXTRAN_xml_word_tag (_T(_S(FORMAT) H _S(SPEC)), 
		       ci->offset, ci[k-1].offset+1, ctx);
}

def_process_list_elt_proto (import_name)
{
  XNT (_T(_S(NAME)), kmax);
  return 1;
}

def_extra_proto (IMPORT)
{
  int k;
  XAD(6);

  if (t[0] == 0)
    return;

  skip_dc ();

  k = strlen (t);
  FXTRAN_process_list (t, ci, ctx, ",",
	               _T(_S(IMPORT) H _S(NAME) H _S(LIST)), 
		       k, import_name, NULL);

}

def_process_list_elt_proto (output_item)
{
  XST (_T(_S(OUTPUT) H _S(ITEM)));
  FXTRAN_expr (t, ci, kmax, ctx);
  XAD(kmax);
  XET ();
  return 1;
}

def_extra_proto (WAIT)
{
  XAD(4);

  stmt_actual_args (t, ci, ctx, &saap_wait);

}

def_extra_proto (INQUIRE)
{
  int k;
  XAD(7);

  k = stmt_actual_args (t, ci, ctx, &saap_inquiry);
  XAD(k);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_process_list (t, ci, ctx, ",",
                    	   _T(_S(OUTPUT) H _S(ITEM) H _S(LIST)), 
			   k, output_item, NULL);
    }
}

def_process_list_elt_proto (input_item)
{
  XST (_T(_S(INPUT) H _S(ITEM)));
  FXTRAN_expr (t, ci, kmax, ctx);
  XAD(kmax);
  XET ();
  return 1;
}

def_extra_proto (READ)
{
  int k;
  XAD(4);

  k = stmt_actual_args (t, ci, ctx, &saap_io);
  XAD(k);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_process_list (t, ci, ctx, ",",
                    	   _T(_S(INPUT) H _S(ITEM) H _S(LIST)), 
			   k, input_item, NULL);
    }
}

def_extra_proto (WRITE)
{
  int k;
  XAD(5);

  k = stmt_actual_args (t, ci, ctx, &saap_io);
  XAD(k);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_process_list (t, ci, ctx, ",",
                    	   _T(_S(OUTPUT) H _S(ITEM) H _S(LIST)), 
			   k, output_item, NULL);
    }
}


def_extra_proto (PRINT)
{
  int k;
  XAD(5);

  k = FXTRAN_str_at_level (t, ci, ",", 0);
  if (k == 0)
    k = strlen (t);
  else
    k = k - 1;

  XST (_T(_S(FORMAT)));
  if (t[0] != '*')
    FXTRAN_expr (t, ci, k, ctx);
  XAD(k);
  XET ();

  if (t[0])
    {
      if (t[0] != ',')
        FXTRAN_THROW ("Expected `,'");
      XAD(1);
      k = strlen (t);
      FXTRAN_process_list (t, ci, ctx, ",",
                    	   _T(_S(OUTPUT) H _S(ITEM) H _S(LIST)), 
			   k, output_item, NULL);
    }


}

def_extra_proto (INCLUDE)
{
  int k;
  XAD(7);
  k = strlen (t);
  FXTRAN_xml_word_tag (_T(_S(FILENAME)), 
		       ci->offset, ci[k-1].offset+1, ctx);

}

def_extra_proto (RETURN)
{
  int k;
  XAD(6);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_xml_word_tag (_T(_S(RETURN) H _S(CODE)), 
		           ci->offset, ci[k-1].offset+1, ctx);
    }
}

def_extra_proto (ERRORSTOP)
{
  int k;
  XAD(9);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_xml_word_tag (_T(_S(STOP) H _S(CODE)), 
		           ci->offset, ci[k-1].offset+1, ctx);
    }
}

def_extra_proto (STOP)
{
  int k;
  XAD(4);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_xml_word_tag (_T(_S(STOP) H _S(CODE)), 
		           ci->offset, ci[k-1].offset+1, ctx);
    }
}

def_extra_proto (SYNCALL)
{
  XAD(4);
  XSP();
  XAD(3);
  if (t[0] == '(')
    stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (SYNCIMAGES)
{
  XAD(4);
  XSP();
  XAD(6);
  stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (SYNCMEMORY)
{
  XAD(4);
  XSP();
  XAD(6);
  if (t[0])
    stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (SYNCTEAM)
{
  XAD(4);
  XSP();
  XAD(4);
  stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (FORMTEAM)
{
  XAD(4);
  XSP();
  XAD(4);
  stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (EVENTPOST)
{
  XAD(4);
  XSP();
  XAD(5);
  stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (EVENTWAIT)
{
  XAD(4);
  XSP();
  XAD(5);
  stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (LOCK)
{
  XAD(4);
  stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (UNLOCK)
{
  XAD(6);
  stmt_actual_args (t, ci, ctx, &saap_sync);
}

def_extra_proto (PAUSE)
{
  int k;
  XAD(5);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_xml_word_tag (_T(_S(STOP) H _S(CODE)), 
		           ci->offset, ci[k-1].offset+1, ctx);
    }
}

static void dump_ctu (int * ctu, int offset, FXTRAN_xmlctx * ctx)
{
  while ((*ctu) > 0)
    {
      FXTRAN_xml_end_tag_unsafe (offset, ctx);
      (*ctu)--;
    }
}

static void dump_otu (const char ** otu, int offset, FXTRAN_xmlctx * ctx)
{
  int i;
  for (i = 0; otu[i]; i++)
    {
      FXTRAN_xml_start_tag (otu[i], offset, ctx);
      otu[i] = NULL;
    }
}

void FXTRAN_stmt (const char * text, const FXTRAN_char_info * ci, 
		  FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx,
		  int omp, int acc, int ddd, int label)
{
  int len = strlen (text);
  const int ncharmargin = 32;
  FXTRAN_char_info ci1[len+1];
  char text1[len+1+ncharmargin];

  FXTRAN_char_info_init (ci1, len);
  memset (&text1[len], '\0', ncharmargin);

  len = FXTRAN_restrict_tci (text1, ci1, text, ci, len);
  
  /* we compute dots and parens on a per statement basis, so that
   * we be able to parse all statements even though one of them is broken 
   */
  FXTRAN_set_char_info_dop (text1, ci1);

  /* check that dots and parens are balanced */

  if (FXTRAN_check_dpb (text1, ci1, len))
    FXTRAN_THROW ("Unbalanced parens or dots in `%s'\n", text);
    
  if (omp == 2)
    {
      FXTRAN_dump_ompd (text1, ci1, ctx);
    }
  else if (acc == 2)
    {
      FXTRAN_dump_accd (text1, ci1, ctx);
    }
  else if (ddd == 2)
    {
      FXTRAN_dump_dddd (text1, ci1, ctx);
    }
  else
    {
      FXTRAN_stmt_type type;
      int expect_pu = 0;
      const char * str;
      xml_tu tu;
      int broken = 0, strip = 0;
   
      memset (&tu, '\0', sizeof (tu));
   
      type = get_FXTRAN_stmt_type (text1, ci1, stack, ctx, &expect_pu, &tu);

      if (type == FXTRAN_NONE)
        {
          broken = 1;
        }
      if (FXTRAN_stmt_exec[type] && ctx->opts.strip_exec)
        { 
          strip = 1;
          type = FXTRAN_NONE;
        }

      if (strip)
        {
          FXTRAN_xml_advance (ctx, ci1->offset);
          FXTRAN_xml_skip (ctx, ci1[len-1].offset+1);
        }
      else
        {
          stmt_block_handle (text1, type, expect_pu, label, stack, ctx, &tu);

          if (broken)
            str = _T(_S(BROKEN) H _S(STMT));
          else
            str = stmt_as_str (type);

          if (tu.xml_ctu1)
            dump_ctu (&tu.xml_ctu1, ci1->offset, ctx);

          dump_otu (tu.xml_otu1, ci1->offset, ctx);

          FXTRAN_xml_start_tag (str, ci1->offset, ctx);
          ctx->in_stmt++;
   
          switch (type)
            {
#define macro_cextra(t,x,nn,isatt) \
case FXTRAN_##t: stmt_##t##_extra(text1, ci1, stack, ctx); break;

                FXTRAN_statement_list(macro_cextra)

#undef macro_cextra
         
              default:
              break;
            }

          FXTRAN_xml_end_tag (ci1[len-1].offset+1, ctx);
          ctx->in_stmt--;

          if (tu.xml_ctu2)
            dump_ctu (&tu.xml_ctu2, ci1[len-1].offset+1, ctx);
          dump_otu (tu.xml_otu2, ci1[len-1].offset+1, ctx);
        }

    }
}

void FXTRAN_dump_fc_stmt (const char * text, const FXTRAN_char_info * ci, int i1, int i2, 
		          FXTRAN_xmlctx * ctx, FXTRAN_stmt_stack * stack, int label)
{
  int len = i2-i1+1;
  char t[len+1];
  FXTRAN_char_info ci1[len+1];
  int i, j;
  int I1 = -1, I2 = -1;  /* actual bounds */
  int omp, acc, ddd;


  FXTRAN_char_info_init (ci1, len);

  for (i = i1, j = 0; i < i2+1; i++)
    if ((ci[i].mask == FXTRAN_COD) || (ci[i].mask == FXTRAN_STR))
      {
        if (I1 < 0)
          I1 = i;
	I2 = i;

        ci1[j] = ci[i];
        t[j] = text[i];
	j++;
      }

  if ((label > 0) && (I1 < 0) && (I2 < 0))
    FXTRAN_ABORT ("Label without statement");

  t[j] = 0;

  omp = FXTRAN_check_omp (text, ci, I1, I2, ctx);
  acc = FXTRAN_check_acc (text, ci, I1, I2, ctx);
  ddd = FXTRAN_check_ddd (text, ci, I1, I2, ctx);

  FXTRAN_stmt (t, ci1, stack, ctx, omp, acc, ddd, label);

}


void FXTRAN_stmt_stack_init (FXTRAN_stmt_stack * stack) 
{
  memset (stack, 0, sizeof (*stack)); 
  stack->lev = -1; 
}

FXTRAN_stmt_stack_state * FXTRAN_stmt_stack_curr (FXTRAN_stmt_stack * stack) 
{
  return ((stack->lev >= 0) && FXTRAN_stmt_stack_ok(stack)) 
       ? &((stack)->state[(stack)->lev]) : NULL;
}

void FXTRAN_stmt_stack_incr (FXTRAN_stmt_stack * stack, FXTRAN_stmt_type t)
{

  if (FXTRAN_stmt_stack_ok(stack)) 
    {           
      ++(stack)->lev;                            
      memset (&((stack)->state[(stack)->lev]), '\0', sizeof (FXTRAN_stmt_stack_state));   
      (stack)->state[(stack)->lev].type = t;     
    }                                            
}

void FXTRAN_stmt_stack_decr (FXTRAN_stmt_stack * stack) 
{
  if (FXTRAN_stmt_stack_ok(stack))   
    {                               
#ifdef UNDEF
      FXTRAN_stmt_stack_state * sts = FXTRAN_stmt_stack_curr (stack); 
      FXTRAN_stmt_dummy_arg_name * d, * e;
      for (d = sts->dumarglst; d; d = e)
        {
          e = d->next;
          free (d->name);
          free (d);
        }
#endif
      (stack)->lev--;                
    }                               
}

void FXTRAN_stmt_stack_break (FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx)
{
  (stack)->broken = 1;                   
  FXTRAN_THROW ("Unexpected statement"); 
}

int FXTRAN_stmt_stack_ok (FXTRAN_stmt_stack * stack) 
{
  return stack->broken == 0;
}

int FXTRAN_stmt_in (FXTRAN_stmt_stack * stack, FXTRAN_stmt_type t)
{
  return FXTRAN_stmt_stack_curr (stack) 
       ? FXTRAN_stmt_stack_curr (stack)->type == t : 0;
}

void FXTRAN_final_check_stack_empty (FXTRAN_xmlctx * ctx, FXTRAN_stmt_stack * stack)
{
  if (FXTRAN_stmt_stack_curr (stack))
    FXTRAN_ABORT ("Malformed Fortran program");

}

void FXTRAN_dump_stmt_list ()
{
  int i;

#define macro_print_stmt(t,x,nn,isatt) \
  do {                                                              \
    const char * str = stmt_as_str (FXTRAN_##t);                    \
    int len  = strlen (str);                                        \
    printf ("\"%s\"", str);                                         \
    for (i = len; i < 50; i++)                                      \
      printf (" ");                                                 \
    printf (", %4.4d, %d,\n", nn > 50 ? nn + 1900 : nn + 2000, x);  \
  } while (0);

FXTRAN_statement_list(macro_print_stmt)

#undef macro_print_stmt
}

  
