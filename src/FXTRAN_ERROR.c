#include <stdio.h>
#include <stdarg.h>

#include "FXTRAN_ERROR.h"

void FXTRAN_ERROR (FXTRAN_xmlctx * ctx, const char * file, 
                   const int line, const char * fmt, ...) 
{                                                           
  va_list ap;
  char * err, * errmin, * errmax;
  int size = FXTRAN_XML_MAXERR;

  err = errmin = &ctx->err[0];
  errmax = errmin + size;
  err[0] = '\0';

  err += snprintf (err, errmax - err, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100   
      	          ? ctx->fb.cur - 100 : ctx->fb.str); 
  err += snprintf (err, errmax - err, "At %s:%d\n", file, line);            
  va_start (ap, fmt);
  err += vsnprintf (err, errmax - err, fmt, ap);                               
  va_end (ap);
  err += snprintf (err, errmax - err, "\n");                                      
  err += FXTRAN_XML_print_section (err, errmax - err, ctx->text, ctx->ci, ctx->pos, 3);  
  longjmp (ctx->env_buf, 1);                                   
}

