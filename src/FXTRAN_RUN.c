/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "FXTRAN_FIXED.h"
#include "FXTRAN_FREE.h"
#include "FXTRAN_NAMELIST.h"
#include "FXTRAN_FILE_FUNC.h"
#include "FXTRAN_FBUFFER.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_OPTS.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_LOAD.h"
#include "FXTRAN_NS.h"

static const char * form_str (int form)
{
  switch (form)
    {
      case FXTRAN_FORM_FREE:
        return "FREE";
      case FXTRAN_FORM_FIXED:
        return "FIXED";
      default:
        return "UNKNOWN";
    }
  return NULL;
}

int FXTRAN_RUN (int argc, char * argv[], char * Text, char ** Xml, char ** Err)
{
  FILE * fpx;
  FXTRAN_xmlctx * ctx;

  ctx = FXTRAN_xmlctx_new ();

  if (FXTRAN_xmlctx_eval (ctx))
    goto cleanup;

  FXTRAN_parse_opts (ctx, argc, argv);

  if (ctx->opts.help)
    {
      FXTRAN_help_opts (ctx);
      FXTRAN_free_opts (ctx);
      FXTRAN_xmlctx_free (ctx);
      return 0;
    }

  if (Text)
    ctx->text = FXTRAN_load_text (Text, ctx);
  else if (ctx->opts.cpp)
    ctx->text = FXTRAN_load_cpp (ctx->opts.ffile, ctx);
  else
    ctx->text = FXTRAN_load_nocpp (ctx->opts.ffile, ctx);

  FXTRAN_f_buffer_printf (&ctx->fb, "<?xml version=\"1.0\"?>");

  if (ctx->opts.css)
    FXTRAN_f_buffer_printf (&ctx->fb, "<?xml-stylesheet type=\"text/css\" href=\"fxtran.css\"?>");

  if (ctx->opts.namelist)
    {
      FXTRAN_f_buffer_printf (&ctx->fb, "<namelist xmlns=\"" FXT_NS_NAM "\">");
    }
  else
    {
      FXTRAN_f_buffer_printf (&ctx->fb, "<object xmlns=\"" FXT_NS_SYN "\" source-form=\"%s\""
            	" source-width=\"%d\" openmp=\"%d\" openacc=\"%d\">", 
               form_str (ctx->opts.form), ctx->opts.line_length, ctx->opts.openmp, ctx->opts.openacc);
    }

  ctx->fb.len0 = FXTRAN_f_buffer_len (&ctx->fb);

  if (ctx->opts.namelist)
    FXTRAN_NAMELIST_decode (ctx);
  else
    switch (ctx->opts.form)
      {
        case FXTRAN_FORM_FREE:
          FXTRAN_FREE_decode (ctx);
          break;
        case FXTRAN_FORM_FIXED:
          FXTRAN_FIXED_decode (ctx);
          break;
        default:
          FXTRAN_THROW ("Unknown source code form");
          break;
      }

  FXTRAN_xml_finish_doc (ctx);

  if (ctx->opts.namelist)
    {
      FXTRAN_f_buffer_printf (&ctx->fb, "</namelist>");
    }
  else
    {
      FXTRAN_f_buffer_printf (&ctx->fb, "</object>");
    }

  FXTRAN_f_buffer_printf (&ctx->fb, "\n");

  if (Text)
    {
      int len = FXTRAN_f_buffer_len (&ctx->fb);
      char * buf = FXTRAN_f_buffer_str (&ctx->fb);
      *Xml = (char *)malloc (len + 1);
      memcpy (*Xml, buf, len);
      (*Xml)[len] = '\0';
    }
  else
    {
      if (strcmp (ctx->opts.xfile, "-") == 0)
        fpx = stdout;
      else
        fpx = fopen (ctx->opts.xfile, "w");

      if (fpx == NULL)
        FXTRAN_THROW ("Cannot open output file `%s'\n", ctx->opts.xfile);

      fwrite (FXTRAN_f_buffer_str (&ctx->fb), FXTRAN_f_buffer_len (&ctx->fb), 1, fpx);

      fclose (fpx);
    }

cleanup:

  if (ctx->err[0])
    {
      if (Err)
        *Err = strdup (ctx->err);
      else
	fprintf (stderr, "%s", ctx->err);
    }

  FXTRAN_free_opts (ctx);
  FXTRAN_xmlctx_free (ctx);

  return ctx->err[0];
}


