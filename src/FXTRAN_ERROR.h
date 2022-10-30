/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_ERROR_H
#define _FXTRAN_ERROR_H

#include <stdio.h>
#include "FXTRAN_XML.h"
#include "FXTRAN_GDB.h"

#define FXTRAN_THROW(...) \
  do {                                                           \
    fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100   \
		             ? ctx->fb.cur - 100 : ctx->fb.str); \
    fprintf (stderr, "At "__FILE__":%d\n", __LINE__);            \
    fprintf (stderr, __VA_ARGS__);                               \
    fprintf (stderr, "\n");                                      \
    if (ctx->opts.gdb)                                           \
      FXTRAN_save_where (__FILE__, __LINE__);                    \
    FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3);  \
    longjmp (ctx->env_buf, 1);                                   \
  } while (0)

#define FXTRAN_ABORT(...) FXTRAN_THROW(__VA_ARGS__)



#endif
