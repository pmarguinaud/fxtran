/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_STMT_H
#define _FXTRAN_STMT_H

#include <string.h>
#include <stdio.h>

#include "FXTRAN_XML.h"
#include "FXTRAN_CHARINFO.h"

extern const char * FXTRAN_ops[];
extern const char * FXTRAN_types[];
extern const int FXTRAN_types_with_kind[];
extern const int FXTRAN_types_with_leng[];
extern const int FXTRAN_types_with_name[];
extern const int FXTRAN_types_with_parm[];
extern const int FXTRAN_types_intrinsic[];


#define FXTRAN_statement_list(macro) \
      macro(ARITHMETICIF                          , 1,   77,  0 ) \
      macro(ASSIGNEDGOTO                          , 1,   77,  0 ) \
      macro(COMPONENTDECL                         , 0,   90,  0 ) \
      macro(POINTERASSIGNMENT                     , 1,   90,  0 ) \
      macro(ASSIGNMENT                            , 1,   77,  0 ) \
      macro(ASSOCIATE                             , 1,    3,  0 ) \
      macro(ASYNCHRONOUS                          , 1,    3,  1 ) \
      macro(IF                                    , 1,   77,  0 ) \
      macro(FORALL                                , 1,   95,  0 ) \
      macro(ALLOCATABLE                           , 0,   90,  1 ) \
      macro(ALLOCATE                              , 1,   90,  0 ) \
      macro(ASSIGN                                , 1,   77,  0 ) \
      macro(BACKSPACE                             , 1,   77,  0 ) \
      macro(BIND                                  , 0,    3,  1 ) \
      macro(BLOCK                                 , 1,    8,  0 ) \
      macro(BLOCKDATA                             , 0,   77,  0 ) \
      macro(CALL                                  , 1,   77,  0 ) \
      macro(CASE                                  , 1,   90,  0 ) \
      macro(CHANGETEAM                            , 1,    8,  0 ) \
      macro(CLASS                                 , 0,    3,  0 ) \
      macro(CLASSIS                               , 1,    3,  0 ) \
      macro(CLOSE                                 , 1,   77,  0 ) \
      macro(CRITICAL                              , 1,    8,  0 ) \
      macro(CODIMENSION                           , 0,    8,  1 ) \
      macro(COMMON                                , 0,   77,  0 ) \
      macro(COMPUTEDGOTO                          , 0,   77,  0 ) \
      macro(CONTAINS                              , 0,   90,  0 ) \
      macro(CONTIGUOUS                            , 1,    8,  0 ) \
      macro(CONTINUE                              , 1,   77,  0 ) \
      macro(CYCLE                                 , 1,   90,  0 ) \
      macro(TYPEDECL                              , 0,   77,  0 ) \
      macro(DATA                                  , 0,   77,  0 ) \
      macro(DEALLOCATE                            , 1,   90,  0 ) \
      macro(DIMENSION                             , 0,   77,  1 ) \
      macro(DO                                    , 1,   77,  0 ) \
      macro(DOLABEL                               , 1,   77,  0 ) \
      macro(ENDASSOCIATE                          , 1,    3,  0 ) \
      macro(ENDBLOCK                              , 1,    8,  0 ) \
      macro(ENDBLOCKDATA                          , 0,   77,  0 ) \
      macro(ENDCHANGETEAM                         , 1,    8,  0 ) \
      macro(ENDCLASS                              , 0,    3,  0 ) \
      macro(ENDCRITICAL                           , 1,    8,  0 ) \
      macro(ENDDO                                 , 1,   77,  0 ) \
      macro(ENDFORALL                             , 1,   95,  0 ) \
      macro(ENDFUNCTION                           , 0,   77,  0 ) \
      macro(ENDINTERFACE                          , 0,   90,  0 ) \
      macro(ENDMODULE                             , 0,   90,  0 ) \
      macro(ENDPROCEDURE                          , 0,    8,  0 ) \
      macro(ENDPROGRAM                            , 0,   77,  0 ) \
      macro(ENDSELECTCASE                         , 1,   90,  0 ) \
      macro(ENDSELECTRANK                         , 1,   18,  0 ) \
      macro(ENDSELECTTYPE                         , 1,    3,  0 ) \
      macro(ENDSUBMODULE                          , 0,    8,  0 ) \
      macro(ENDSUBROUTINE                         , 0,   77,  0 ) \
      macro(ENDTYPE                               , 0,   90,  0 ) \
      macro(ENDWHERE                              , 1,   95,  0 ) \
      macro(ENDFILE                               , 1,   77,  0 ) \
      macro(ELSEIF                                , 1,   77,  0 ) \
      macro(ELSE                                  , 1,   77,  0 ) \
      macro(ELSEWHERE                             , 1,   95,  0 ) \
      macro(ENDIF                                 , 1,   77,  0 ) \
      macro(ENTRY                                 , 0,   77,  0 ) \
      macro(ENDENUM                               , 0,    3,  0 ) \
      macro(ENUM                                  , 0,    3,  0 ) \
      macro(ENUMERATOR                            , 0,    3,  0 ) \
      macro(EQUIVALENCE                           , 0,   77,  0 ) \
      macro(EVENTPOST                             , 1,    8,  0 ) \
      macro(EVENTWAIT                             , 1,    8,  0 ) \
      macro(ERRORSTOP                             , 0,    3,  0 ) \
      macro(EXIT                                  , 1,   90,  0 ) \
      macro(EXTERNAL                              , 0,   77,  1 ) \
      macro(FINAL                                 , 0,    3,  0 ) \
      macro(FLUSH                                 , 1,    3,  0 ) \
      macro(FORALLCONSTRUCT                       , 1,   95,  0 ) \
      macro(FORMAT                                , 0,   77,  0 ) \
      macro(FORMTEAM                              , 1,    8,  0 ) \
      macro(FUNCTION                              , 0,   77,  0 ) \
      macro(GENERIC                               , 0,    3,  0 ) \
      macro(GOTO                                  , 1,   77,  0 ) \
      macro(IFTHEN                                , 1,   77,  0 ) \
      macro(IMPLICITNONE                          , 0,   77,  0 ) \
      macro(IMPLICIT                              , 0,   77,  0 ) \
      macro(IMPORT                                , 0,    3,  0 ) \
      macro(INCLUDE                               , 0,   77,  0 ) \
      macro(INQUIRE                               , 1,   90,  0 ) \
      macro(INTENT                                , 0,   90,  1 ) \
      macro(INTERFACE                             , 0,   90,  0 ) \
      macro(INTRINSIC                             , 0,   77,  1 ) \
      macro(LOCK                                  , 1,    8,  0 ) \
      macro(PROCEDURE                             , 0,   90,  0 ) \
      macro(MODULE                                , 0,   90,  0 ) \
      macro(NAMELIST                              , 0,   77,  0 ) \
      macro(NULLIFY                               , 1,   90,  0 ) \
      macro(OPEN                                  , 1,   77,  0 ) \
      macro(OPTIONAL                              , 0,   90,  1 ) \
      macro(PAUSE                                 , 1,   77,  0 ) \
      macro(PARAMETER                             , 0,   77,  1 ) \
      macro(CRAYPOINTER                           , 0,   90,  1 ) \
      macro(POINTER                               , 0,   90,  1 ) \
      macro(PROGRAM                               , 0,   77,  0 ) \
      macro(PRINT                                 , 1,   77,  0 ) \
      macro(PRIVATE                               , 0,   90,  1 ) \
      macro(PROTECTED                             , 0,    3,  1 ) \
      macro(PUBLIC                                , 0,   90,  1 ) \
      macro(SELECTRANKCASE                        , 1,   18,  0 ) \
      macro(READ                                  , 1,   77,  0 ) \
      macro(RETURN                                , 1,   77,  0 ) \
      macro(REWIND                                , 1,   77,  0 ) \
      macro(SAVE                                  , 0,   77,  1 ) \
      macro(SELECTCASE                            , 1,   90,  0 ) \
      macro(SELECTRANK                            , 1,   18,  0 ) \
      macro(SELECTTYPE                            , 1,    3,  0 ) \
      macro(SEQUENCE                              , 0,   90,  0 ) \
      macro(STOP                                  , 1,   77,  0 ) \
      macro(SUBMODULE                             , 0,    8,  0 ) \
      macro(SUBROUTINE                            , 0,   77,  0 ) \
      macro(SYNCALL                               , 1,    8,  0 ) \
      macro(SYNCIMAGES                            , 1,    8,  0 ) \
      macro(SYNCMEMORY                            , 1,    8,  0 ) \
      macro(SYNCTEAM                              , 1,    8,  0 ) \
      macro(TARGET                                , 0,   90,  1 ) \
      macro(TYPE                                  , 0,   90,  0 ) \
      macro(TYPEIS                                , 1,    3,  0 ) \
      macro(UNLOCK                                , 1,    8,  0 ) \
      macro(USE                                   , 0,   90,  0 ) \
      macro(VALUE                                 , 0,    3,  1 ) \
      macro(VOLATILE                              , 0,    3,  1 ) \
      macro(WAIT                                  , 1,    3,  0 ) \
      macro(WHERE                                 , 1,   95,  0 ) \
      macro(WHERECONSTRUCT                        , 1,   95,  0 ) \
      macro(WRITE                                 , 1,   77,  0 ) 


#define macro_enum(t,x,nn,isatt) \
  FXTRAN_##t,

typedef enum
{
 FXTRAN_NONE,
 FXTRAN_statement_list(macro_enum)
 FXTRAN_LAST
} FXTRAN_stmt_type;

#undef macro_enum

extern const char FXTRAN_stmt_exec[];
extern const int FXTRAN_stmt_std[];
extern const char FXTRAN_stmt_attr[];
extern const char * FXTRAN_stmt_name[];

#define FXTRAN_attr_list(macro) \
  macro(BIND               ,   3 ) \
  macro(PASS               ,   3 ) \
  macro(NOPASS             ,   3 ) \
  macro(EXTENDS            ,   3 ) \
  macro(CONTIGUOUS         ,   3 ) \
  macro(ABSTRACT           ,   3 ) \
  macro(NON_OVERRIDABLE    ,   3 ) \
  macro(KIND               ,   3 ) \
  macro(LEN                ,   3 ) \
  macro(DEFERRED           ,   3 ) 

extern const char * FXTRAN_attr_name[];

#ifdef UNDEF
typedef struct FXTRAN_stmt_dummy_arg_name
{
  struct FXTRAN_stmt_dummy_arg_name * next;
  char * name;
} FXTRAN_stmt_dummy_arg_name;
#endif

typedef struct FXTRAN_stmt_stack_state
{
  FXTRAN_stmt_type type;
  int seen_contains;
  int do_label;
  int nstmt;
#ifdef UNDEF
  FXTRAN_stmt_dummy_arg_name * dumarglst;
#endif
} FXTRAN_stmt_stack_state;

typedef struct FXTRAN_stmt_stack
{
  int seen_stmt;
  int broken;
  int lev;
  FXTRAN_stmt_stack_state state[1024];
} FXTRAN_stmt_stack;

void FXTRAN_stmt_stack_init (FXTRAN_stmt_stack *);
FXTRAN_stmt_stack_state * FXTRAN_stmt_stack_curr (FXTRAN_stmt_stack *);
void FXTRAN_stmt_stack_incr (FXTRAN_stmt_stack *, FXTRAN_stmt_type);
void FXTRAN_stmt_stack_decr (FXTRAN_stmt_stack *);
void FXTRAN_stmt_stack_break (FXTRAN_stmt_stack *, FXTRAN_xmlctx *);
int FXTRAN_stmt_stack_ok (FXTRAN_stmt_stack *);
int FXTRAN_stmt_in (FXTRAN_stmt_stack *, FXTRAN_stmt_type);


void FXTRAN_stmt (const char *, const FXTRAN_char_info *, FXTRAN_stmt_stack *, FXTRAN_xmlctx * ctx, int, int, int, int);
int FXTRAN_typespec (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);

#define def_process_list_elt_proto(f) \
static int f (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)


int FXTRAN_process_list (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *, const char *, 
		          const char *, int, 
		          int (*)(const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *, int, void *),
			  void * data);

int FXTRAN_actual_args (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);

void FXTRAN_dump_fc_stmt (const char *, const FXTRAN_char_info *, int, int, 
		          FXTRAN_xmlctx *, FXTRAN_stmt_stack *, int);

void FXTRAN_final_check_stack_empty (FXTRAN_xmlctx *, FXTRAN_stmt_stack *);

void FXTRAN_dump_stmt_list ();

#endif
