/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_ERROR_H
#define _FXTRAN_ERROR_H

#include <stdio.h>
#include "FXTRAN_XML.h"
#include "FXTRAN_GDB.h"

void FXTRAN_ERROR (FXTRAN_xmlctx *, const char *, 
                   const int, const char *, ...);

#define FXTRAN_THROW(...) \
  do {                                                           \
    FXTRAN_ERROR (ctx, __FILE__, __LINE__, __VA_ARGS__);         \
    if (ctx->opts.gdb)                                           \
      FXTRAN_save_where (__FILE__, __LINE__);                    \
    longjmp (ctx->env_buf, 1);                                   \
  } while (0)

#define FXTRAN_ABORT(...) FXTRAN_THROW(__VA_ARGS__)



#endif
