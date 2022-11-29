/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "FXTRAN_LOAD.h"
#include "FXTRAN_CPP_INTF.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_FBUFFER.h"
#include "FXTRAN_FILE.h"
#include "FXTRAN_FILE_FUNC.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_XCP.h"

#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>


typedef struct FXTRAN_cpp_helper
{
  FXTRAN_xmlctx * ctx;
  FXTRAN_FBUFFER fb;
}
FXTRAN_cpp_helper;

static void FXTRAN_cpp_helper_append (void * obj, char * text, int len)
{
  FXTRAN_cpp_helper * h = (FXTRAN_cpp_helper*)obj;
  FXTRAN_FBUFFER_ncat (&h->fb, len, text);
  FXTRAN_FBUFFER_ncat (&h->fb, 1, "\n");
}

static void text_cleanup (FXTRAN_xmlctx * ctx, char ** ptext)
{
  FXTRAN_file * f;

  for (f = ctx->root; f; f = f->next)
    FXTRAN_file_reset (f);

  if (ctx->opts.cpp)
    {
      FXTRAN_cpp2loc * Loc;
      for (Loc = ctx->c2l; Loc->file; Loc++)
        /* TODO : deallocate cpp_mask & xcp_list */
        Loc->xcp_mask = Loc->xcp_list ?  
                        FXTRAN_delta_back (Loc->xcp_list, Loc->len, ctx) : NULL;
    }

  if (ctx->opts.form == FXTRAN_FORM_FIXED)
    FXTRAN_remove_tabs (ptext, 8, 6);
  else if (ctx->opts.form == FXTRAN_FORM_FREE)
    FXTRAN_remove_cr (ptext);

}

char * FXTRAN_load_cpp (const char * f, FXTRAN_xmlctx * ctx)
{
  FXTRAN_cpp_helper h;
  char * text;
  int ret;


  h.ctx = ctx;
  FXTRAN_FBUFFER_init (&h.fb);

  ret = FXTRAN_cpp_intf (f, &ctx->root, &ctx->c2l, &ctx->opts,
		         (void*)&h, FXTRAN_cpp_helper_append);

  if (ret < 0)
    FXTRAN_ABORT ("Cannot cpp %s", f);

  FXTRAN_FBUFFER_take (&h.fb, &text);

  text_cleanup (ctx, &text);

  return text;
}

static const char * resolve_filename (const char * filename, char ** includes)
{
  static char buffer[256];
  char ** inc;
  struct stat stbuf;

  for (inc = includes; *inc; inc++)
    {
      strcpy (buffer, *inc);
      strcat (buffer, "/");
      strcat (buffer, filename);
      if (stat (buffer, &stbuf) == 0)
        return &buffer[0];
    }

  strcpy (buffer, filename);
  if (stat (buffer, &stbuf) == 0)
    return &buffer[0];

  return NULL;
}

static void FXTRAN_load_nocpp0 (FXTRAN_FBUFFER * fb, const char * filename, char * text,
                                FXTRAN_xmlctx * ctx, FXTRAN_cpp2loc_array * pcla, 
                                FXTRAN_file ** pcurrent, FXTRAN_file ** proot)
{
  char * t0;
  char * t0bol;
  const char * filename_r;

  if (filename)
    {
      filename_r = resolve_filename (filename, ctx->opts.includes);
      if (filename_r == NULL)
        FXTRAN_ABORT ("Cannot find included file `%s'", filename);
      t0 = FXTRAN_slurp (ctx, filename_r);
      FXTRAN_file_enter (filename_r, t0, pcurrent, proot);
    }
  else if (text)
    {
      filename_r = "string";
      t0 = text;
      FXTRAN_file_enter (filename_r, t0, pcurrent, proot);
    }
  else
    {
      FXTRAN_ABORT ("Expected filename or text");
    }


  for (t0bol = t0; *t0bol; t0bol++)
    {
      const char * inc;
      int ll;

      (*pcurrent)->line++;
      FXTRAN_grow_cpp2loc_array (pcla, 1);

      for (ll = 0; t0bol[ll] && (t0bol[ll] != '\n'); ll++);

      FXTRAN_curr_cpp2loc_array (pcla)->line     = (*pcurrent)->line-1;
      FXTRAN_curr_cpp2loc_array (pcla)->file     = (*pcurrent);
      FXTRAN_curr_cpp2loc_array (pcla)->len      = ll+1;
      FXTRAN_curr_cpp2loc_array (pcla)->xcp_list = NULL;
      FXTRAN_curr_cpp2loc_array (pcla)->xcp_mask = NULL;

      if ((inc = FXTRAN_grok_fortran_include (t0bol, ll, &ctx->opts)) != NULL)
        {
          if (ctx->opts.noinclude)
            {
              FXTRAN_FBUFFER_ncat (fb, ll+1, t0bol);
	      FXTRAN_incr_cpp2loc_array (pcla);
            }
	  else
            {
              FXTRAN_load_nocpp0 (fb, inc, NULL, ctx, pcla, pcurrent, proot);
	    }
        }
      else
        {
          FXTRAN_FBUFFER_ncat (fb, ll+1, t0bol);
	  FXTRAN_incr_cpp2loc_array (pcla);
        }

      t0bol += ll;
    }

  FXTRAN_file_leave (pcurrent, proot);

  if (text == NULL)
    free (t0);

}

char * FXTRAN_load_nocpp (const char * f, FXTRAN_xmlctx * ctx)
{
  FXTRAN_file * current = NULL;
  FXTRAN_FBUFFER fb;
  char * text;
  FXTRAN_cpp2loc_array cla;

  FXTRAN_init_cpp2loc_array (&cla);
 
  FXTRAN_FBUFFER_init (&fb);

  FXTRAN_load_nocpp0 (&fb, f, NULL, ctx, &cla, &current, &ctx->root);

  FXTRAN_FBUFFER_take (&fb, &text);
  FXTRAN_take_cpp2loc_array (&cla, &ctx->c2l);

  text_cleanup (ctx, &text);

  return text;
}

char * FXTRAN_load_text (char * text, FXTRAN_xmlctx * ctx)
{
  FXTRAN_file * current = NULL;
  FXTRAN_FBUFFER fb;
  FXTRAN_cpp2loc_array cla;

  FXTRAN_init_cpp2loc_array (&cla);
 
  FXTRAN_FBUFFER_init (&fb);

  FXTRAN_load_nocpp0 (&fb, NULL, text, ctx, &cla, &current, &ctx->root);

  FXTRAN_FBUFFER_take (&fb, &text);
  FXTRAN_take_cpp2loc_array (&cla, &ctx->c2l);

  text_cleanup (ctx, &text);

  return text;
}


