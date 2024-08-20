/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_XML_H
#define _FXTRAN_XML_H

#include <string.h>
#include <setjmp.h>
#include <sys/resource.h>

#include "FXTRAN_FBUFFER.h"
#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_OPTS.h"
#include "FXTRAN_FILE.h"


/* TODO : make tag a pointer in current buffer and record its length */
typedef struct FXTRAN_xmlctx_stack_elt
{
  const char * tag;
  int pos;
} FXTRAN_xmlctx_stack_elt;

#define FXTRAN_XML_MAXLEV 1024
#define FXTRAN_XML_NS     1024
#define FXTRAN_XML_MAXERR 1024

typedef struct FXTRAN_xmlctx
{
  struct rlimit rlim;

  /* pointer to where we should go back when something goes wrong */
  jmp_buf env_buf;
  char err[FXTRAN_XML_MAXERR];

  /* buffer where XML is stored */
  FXTRAN_FBUFFER fb;

  /* current position in text and ci */
  int pos;    /* in output from cpp */
  int line;   /* in output from cpp */

  char * text;
  FXTRAN_char_info * ci;

  /* stack of xml tags */
  int lev;
  FXTRAN_xmlctx_stack_elt stack[FXTRAN_XML_MAXLEV];

  /* options from command line */
  FXTRAN_opts opts;

  FXTRAN_file * root;
  FXTRAN_cpp2loc * c2l;

  int in_stmt;
} FXTRAN_xmlctx;

typedef struct FXTRAN_XML_ATTR 
{
  const char * name;
  const char * value;
} FXTRAN_XML_ATTR;

FXTRAN_xmlctx * FXTRAN_xmlctx_new ();
#define FXTRAN_xmlctx_eval(ctx) setjmp ((ctx)->env_buf)
void FXTRAN_xmlctx_free (FXTRAN_xmlctx *);
void FXTRAN_xml_start_tag (const char *, int, FXTRAN_xmlctx *);
void FXTRAN_xml_start_tag_attr (const char *, int, FXTRAN_xmlctx *, const FXTRAN_XML_ATTR *);
void FXTRAN_xml_end_tag (int, FXTRAN_xmlctx *);
void FXTRAN_xml_end_tag_unsafe (int, FXTRAN_xmlctx *);
void FXTRAN_xml_word_tag (const char *, int, int, FXTRAN_xmlctx *);
void FXTRAN_xml_mark (int, int, FXTRAN_xmlctx *, char);
void FXTRAN_xml_finish_doc (FXTRAN_xmlctx *);
void FXTRAN_xml_advance (FXTRAN_xmlctx *, int);
void FXTRAN_xml_skip (FXTRAN_xmlctx *, int);

#define xml_mark_name(pos1,pos2,ctx) \
  do {                                              \
    if (FXTRAN_XML_dump)                            \
      FXTRAN_xml_mark (pos1,pos2,ctx,FXTRAN_NAM);   \
  } while (0)

#define xml_mark_op(pos1,pos2,ctx) \
  do {                                              \
    if (FXTRAN_XML_dump)                            \
      FXTRAN_xml_mark (pos1,pos2,ctx,FXTRAN_OPR);   \
  } while (0)

#define xml_mark_lit(pos1,pos2,ctx) \
  do {                                              \
    if (FXTRAN_XML_dump)                            \
      FXTRAN_xml_mark (pos1,pos2,ctx,FXTRAN_LIT);   \
  } while (0)

#define xml_mark_boz(pos1,pos2,ctx) \
  do {                                              \
    if (FXTRAN_XML_dump)                            \
      FXTRAN_xml_mark (pos1,pos2,ctx,FXTRAN_BOZ);   \
  } while (0)

#define xml_mark_comp(pos1,pos2,ctx) \
  do {                                              \
    if (FXTRAN_XML_dump)                            \
      FXTRAN_xml_mark (pos1,pos2,ctx,FXTRAN_CPT);   \
  } while (0)

#define xml_mark_keyword(pos1,pos2,ctx) \
  do {                                              \
    if (FXTRAN_XML_dump)                            \
      FXTRAN_xml_mark (pos1,pos2,ctx,FXTRAN_KWD);   \
  } while (0)

#define XST(S) \
  do {                                              \
    if (FXTRAN_XML_dump)                            \
      FXTRAN_xml_start_tag (S, ci->offset, ctx);    \
  } while (0)

#define XET() \
  do {                                              \
    if (FXTRAN_XML_dump)                            \
      FXTRAN_xml_end_tag (ci[-1].offset+1, ctx);    \
  } while (0)

#define XSP() \
  do {                                              \
    if (FXTRAN_XML_dump && ctx->opts.strip_spaces)  \
      {                                             \
        int pos = ci[-1].offset+1;                  \
        if (pos >= 0)                               \
          FXTRAN_xml_advance (ctx, pos);            \
        FXTRAN_FBUFFER_putc (&ctx->fb, ' ');        \
      }                                             \
  } while (0)

#define XSA(S) XST("_"S"_")
#define XEA() XET()



#define XAD(n) \
  do {             \
    int _n = (n);  \
    ci += _n;      \
    t += _n;       \
  } while (0)

extern int FXTRAN_XML_dump;
#define XSD(x) \
  do { FXTRAN_XML_dump = x; } while (0)


int FXTRAN_XML_print_section (char *, int, const char *, const FXTRAN_char_info *, int, int);

void FXTRAN_xml_word_tag_name (const char *, int, int, FXTRAN_xmlctx *, const char *, int);
void FXTRAN_xml_word_tag_op (const char *, int, int, FXTRAN_xmlctx *, const char *, int);
void FXTRAN_xml_word_tag_keyword (const char *, int, int, FXTRAN_xmlctx *, const char *, int);

#define XNT(tag, len) \
  do {                                           \
    if (FXTRAN_XML_dump)                         \
      FXTRAN_xml_word_tag_name (tag, ci->offset, \
         ci[(len)-1].offset+1, ctx, t, len);     \
  } while (0)

#define XNO(tag, len) \
  do {                                           \
    if (FXTRAN_XML_dump)                         \
      FXTRAN_xml_word_tag_op (tag, ci->offset,   \
         ci[(len)-1].offset+1, ctx, t, len);     \
  } while (0)

#define XNW(tag, len) \
  do {                                                \
    if (FXTRAN_XML_dump)                              \
      FXTRAN_xml_word_tag_keyword (tag, ci->offset,   \
         ci[(len)-1].offset+1, ctx, t, len);          \
  } while (0)



int FXTRAN_parse_opts (FXTRAN_xmlctx *, int, char * argv[]);
void FXTRAN_free_opts (FXTRAN_xmlctx *);
void FXTRAN_help_opts (FXTRAN_xmlctx *);

#endif
