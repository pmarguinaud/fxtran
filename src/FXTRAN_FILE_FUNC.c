/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "FXTRAN_FILE_FUNC.h"
#include "FXTRAN_ALPHA.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_FBUFFER.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_TAG.h"

#include <string.h>

void FXTRAN_handle_empty (FXTRAN_xmlctx * ctx)
{
  FXTRAN_cpp2loc * Loc = &ctx->c2l[0];
  int empty = FXTRAN_FBUFFER_empty (&ctx->fb);

  if (!empty)
    return;

  FXTRAN_file_change (NULL, ctx->root, ctx);
  
  if (Loc->file != ctx->root)
    FXTRAN_file_change (ctx->root, Loc->file, ctx);
  
  FXTRAN_dump_uns (Loc->file, Loc->line, ctx);
  
  if (ctx->opts.show_lines)
    if (Loc->file == ctx->root)
      FXTRAN_FBUFFER_printf (&ctx->fb, "<L/>");
}

void FXTRAN_dump_uns (FXTRAN_file * f, int line, FXTRAN_xmlctx * ctx)
{

  if (f->line == line)
    return;

  if (f->line > line)
    FXTRAN_ABORT ("Line count mismatch in file `%s'", f->name);

  FXTRAN_FBUFFER_printf (&ctx->fb, "<unseen>");
  while (f->line < line)
    {
      const char * t;
      int len;
      if (FXTRAN_file_skip_line (f, &t, &len) < 0)
        FXTRAN_ABORT ("Could not skip line in file `%s'", f->name);
      if (ctx->opts.show_lines)
        FXTRAN_FBUFFER_printf (&ctx->fb, "<L/>");
      FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, t, len, 0, 0, 0, 0, 0);
    }
  FXTRAN_FBUFFER_printf (&ctx->fb, "</unseen>");
}


#define isspc(c) (((c) ==  ' ') || ((c) == '\t'))

int FXTRAN_dump_include (FXTRAN_file * f, FXTRAN_xmlctx * ctx, int do_abort, int do_skipline)
{
  int n1omp = -1;
  int n0, n1, n2, n3, n4; 
  char q;
  int i;

  if (ctx->opts.show_lines)
    FXTRAN_FBUFFER_printf (&ctx->fb, "<L/>");

  n0 = 0;
  n1 = n0;
  for (; isspc (f->text_cur[n1]); n1++);

  if (f->text_cur[n1] == '#')
    {   
      int n1a = n1 + 1;
      for (; isspc (f->text_cur[n1a]); n1a++);
      if (strncasecmp (&f->text_cur[n1a], "include", 7)) 
        goto malformed;
      n2 = n1a + 7;
    }   
  else
    {
      if (ctx->opts.openmp)
        if (strncmp (&f->text_cur[n1], "!$ ", 3) == 0)
          {
            n1omp = n1;
	    n0 = n0 + 2;
	    n1 = n0;
            for (; isspc (f->text_cur[n1]); n1++);
          }
      if (strncasecmp (&f->text_cur[n1], "include", 7)) 
        goto malformed;
      n2 = n1 + 7;
    }

  for (; isspc (f->text_cur[n2]); n2++);
  q = f->text_cur[n2++];

  for (n3 = n2 + 1; f->text_cur[n3] && (f->text_cur[n3] != q); n3++);

  if (f->text_cur[n3] == '\0')
    goto malformed;

  n4 = index (&f->text_cur[0], '\n') - &f->text_cur[0] - 1;

  if (n1omp >= 0)
    {
      FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &f->text_cur[0], n1omp, 0, 0, 0, 0, 0);
      FXTRAN_FBUFFER_printf (&ctx->fb, "<%s>", FXTRAN_OMC_TAG);
      FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &f->text_cur[n1omp], 2, 0, 0, 0, 0, 0);
      FXTRAN_FBUFFER_printf (&ctx->fb, "</%s>", FXTRAN_OMC_TAG);
    }

  FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &f->text_cur[n0], n1-n0, 0, 0, 0, 0, 0);

  FXTRAN_FBUFFER_printf (&ctx->fb, "<include>");

  FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &f->text_cur[n1], n2-n1, 0, 0, 0, 0, 0);

  FXTRAN_FBUFFER_printf (&ctx->fb, "<filename>");

  FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &f->text_cur[n2], n3-n2, 0, 0, 0, 0, 0);

  FXTRAN_FBUFFER_printf (&ctx->fb, "</filename>");

  FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &f->text_cur[n3], 1, 0, 0, 0, 0, 0);

  FXTRAN_FBUFFER_printf (&ctx->fb, "</include>");

  for (i = 0; i < n4-n3; i++)
    {
      if (f->text_cur[n3+1+i] == '!')
        {
          FXTRAN_FBUFFER_printf (&ctx->fb, "<%s>", FXTRAN_COM_TAG);
          FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &f->text_cur[n3+1+i], n4-n3-i, 0, 0, 0, 0, 0);
          FXTRAN_FBUFFER_printf (&ctx->fb, "</%s>", FXTRAN_COM_TAG);
          break;
        }
      if (! isspc (f->text_cur[n3+1+i]))
        {
          FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &f->text_cur[n3+1+i], n4-n3-i, 0, 0, 0, 0, 0);
          break;
        }
      FXTRAN_FBUFFER_printf (&ctx->fb, "%c", f->text_cur[n3+1+i]);
    }


  if (do_skipline && (FXTRAN_file_skip_line (f, NULL, NULL) < 0))
    FXTRAN_ABORT ("Could not skip line in file `%s'", f->name);

  return 0;

malformed:

  if (do_abort)
    FXTRAN_ABORT ("Malformed include line : %s", f->text_cur);

  return 1;
}

static void file_enter (FXTRAN_file * fo, FXTRAN_file * fn, FXTRAN_xmlctx * ctx)
{
  if (fn->up != fo)
    {
      file_enter (fo, fn->up, ctx);
      file_enter (fn->up, fn, ctx);
      return;
    }

  if (fo != NULL)
    {
      FXTRAN_dump_uns (fo, fn->inclusion_line-1, ctx);
      FXTRAN_dump_include (fo, ctx, 1, 1);
    }

  if (fn->up != NULL)
    FXTRAN_FBUFFER_printf (&ctx->fb, "\n");

  if (1) /* TODO : file tag */
    {
      FXTRAN_FBUFFER_printf (&ctx->fb, "<file name=\"%s\">", fn->name);
    }
  else
    {
      FXTRAN_XML_ATTR attr[2];
      attr[0].name  = "name";
      attr[0].value = fn->name;
      memset (attr, '\0', 2 * sizeof (FXTRAN_XML_ATTR));
      FXTRAN_xml_start_tag_attr (_T(_S(FILE)), -1, ctx, attr);
    }
}

static void file_leave (FXTRAN_file * fo, FXTRAN_file * fn, FXTRAN_xmlctx * ctx)
{
  if (fo->up != fn)
    {
      file_leave (fo, fo->up, ctx);
      file_leave (fo->up, fn, ctx);
      return;
    }

  if (fo != NULL)
    FXTRAN_dump_uns (fo, fo->line_total, ctx);

  if (1) /* TODO : file tag */
    {
      FXTRAN_FBUFFER_printf (&ctx->fb, "</file>");
    }
  else
    {
      FXTRAN_xml_end_tag (-1, ctx);
    }
}

static FXTRAN_file * fancestor (FXTRAN_file * f1, FXTRAN_file * f2)
{
  if ((f1 == NULL) || (f2 == NULL))
    return NULL;
  while (f1->include_level > f2->include_level)
    f1 = f1->up;
  while (f2->include_level > f1->include_level)
    f2 = f2->up;
  while (f1 != f2)
    {
      f1 = f1->up;
      f2 = f2->up;
    }
  return f1;
}


int FXTRAN_file_change (FXTRAN_file * fo, FXTRAN_file * fn, FXTRAN_xmlctx * ctx)
{
  FXTRAN_file * fa = fancestor (fo, fn);
  if (fo != fa)
    file_leave (fo, fa, ctx);
  if (fa != fn)
    file_enter (fa, fn, ctx);

  return 0;
}

void FXTRAN_file_reset (FXTRAN_file * f)
{
  int i;

  f->line = 0;
  f->text_cur = f->text;
  f->line_total = 0;

  for (i = 0; f->text[i]; i++)
    if (f->text[i] == '\n')
      f->line_total++;
}

int FXTRAN_file_skip_line (FXTRAN_file * f, const char ** pt, int * pl)
{
  if (pt)
    *pt = f->text_cur;
  for (; f->text_cur[0]; f->text_cur++)
    if (f->text_cur[0] == '\n')
      {
        f->line++;
	f->text_cur++;
	if (pl && pt)
	  *pl = f->text_cur - *pt;
	return 1;
      }
  return -1;
}

