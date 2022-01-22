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
#include "FXTRAN_FBUFFER.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_OPTS.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_CPP.h"
#include "FXTRAN_NS.h"

int main (int argc, char * argv[])
{
  FILE * fpx;
  char * text;
  const char * form = NULL;
  FXTRAN_xmlctx * ctx;

  FXTRAN_xmlctx_new (&ctx);

  FXTRAN_parse_opts (ctx, argc, argv);

  if (ctx->opts.help)
    {
      FXTRAN_help_opts (ctx);
      FXTRAN_free_opts (ctx);
      FXTRAN_xmlctx_free (ctx);
      return 0;
    }

  if (strcmp (ctx->opts.xfile, "-") == 0)
    fpx = stdout;
  else
    fpx = fopen (ctx->opts.xfile, "w");

  if (fpx == NULL)
    FXTRAN_THROW ("Cannot open output file `%s'\n", ctx->opts.xfile);

  if (ctx->opts.cpp)
    text = FXTRAN_load_cpp (ctx->opts.ffile, ctx);
  else
    text = FXTRAN_load_nocpp (ctx->opts.ffile, ctx);

  if (ctx->opts.namelist)
    FXTRAN_NAMELIST_decode (text, ctx);
  else
    switch (ctx->opts.form)
      {
        case FXTRAN_FORM_FREE:
          FXTRAN_FREE_decode (text, ctx);
          form = "FREE";
          break;
        case FXTRAN_FORM_FIXED:
          FXTRAN_FIXED_decode (text, ctx);
          form = "FIXED";
          break;
        default:
          FXTRAN_THROW ("Unknown source code form");
          break;
      }

  FXTRAN_xml_finish_doc (ctx);

  fprintf (fpx, "<?xml version=\"1.0\"?>");

  if (ctx->opts.css)
    fprintf (fpx, "<?xml-stylesheet type=\"text/css\" href=\"fxtran.css\"?>");

  if (ctx->opts.namelist)
    {
      fprintf (fpx, "<namelist xmlns=\"" FXT_NS_NAM "\">");
    }
  else
    {
      if (ctx->opts.xul_wrap)
        fprintf (fpx, "<window xmlns=\"" XUL_NS "\"><scrollbox flex=\"1\" style=\"overflow:auto;\"><description>");
     
      fprintf (fpx, "<object xmlns=\"" FXT_NS_SYN "\" source-form=\"%s\""
            	" source-width=\"%d\" openmp=\"%d\" openacc=\"%d\">", 
               form, ctx->opts.line_length, ctx->opts.openmp, ctx->opts.openacc);
    }


  fwrite (FXTRAN_f_buffer_str (&ctx->fb), FXTRAN_f_buffer_len (&ctx->fb), 1, fpx);

  if (ctx->opts.namelist)
    {
      fprintf (fpx, "</namelist>");
    }
  else
    {
      fprintf (fpx, "</object>");
     
      if (ctx->opts.xul_wrap)
        fprintf (fpx, "</description></scrollbox></window>");
    }

  fprintf (fpx, "\n");

  fclose (fpx);

  FXTRAN_free_opts (ctx);

  free (ctx->text);
  ctx->text = NULL;
  free (ctx->ci);
  ctx->ci = NULL;

  FXTRAN_xmlctx_free (ctx);

  return 0;
}

