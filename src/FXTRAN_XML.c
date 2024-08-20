/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "FXTRAN_XML.h"
#include "FXTRAN_FBUFFER.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_STMT.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_XCP.h"
#include "FXTRAN_FILE_FUNC.h"
#include "FXTRAN_TAG.h"

#include <string.h>
#include <ctype.h>

int FXTRAN_XML_dump = 1;

const char 
   * FXTRAN_STR_TAG=  "S",
   * FXTRAN_COM_TAG=  "C",
   * FXTRAN_LAB_TAG=  "label",
   * FXTRAN_OPT_TAG=  "opt",
   * FXTRAN_CPP_TAG=  "cpp",
   * FXTRAN_COD_TAG=  "c",
   * FXTRAN_CPT_TAG=  "ct",
   * FXTRAN_SMC_TAG=  "smc",
   * FXTRAN_CO2_TAG=  "cnt",
   * FXTRAN_CO1_TAG=  "cnt",
   * FXTRAN_MAL_TAG=  "m",
   * FXTRAN_MAR_TAG=  "rm",
   * FXTRAN_NAM_TAG=  "n",
   * FXTRAN_OPR_TAG=  "o",
   * FXTRAN_LIT_TAG=  "l",
   * FXTRAN_KWD_TAG=  "k",
   * FXTRAN_OMD_TAG=  "omp",
   * FXTRAN_OMC_TAG=  "omp",
   * FXTRAN_ACC_TAG=  "acc",
   * FXTRAN_BOZ_TAG=  "boz",
   * FXTRAN_ZER_TAG=  "zer"
;


static void dump_txt (FXTRAN_xmlctx * ctx, int pos1, int pos2, int code)
{
  if (pos1 == pos2)
    return;
  int uc = code && ctx->opts.uppercase;
  int sl = ctx->opts.strip_linefeed;
  int sp = ctx->opts.strip_spaces;
  FXTRAN_FBUFFER_append_escaped_str 
    (&ctx->fb, &ctx->text[pos1], pos2-pos1, uc, code, sl, sp, ctx->in_stmt);
}

static int check_id (const char * t, int len, FXTRAN_xmlctx * ctx)
{
  int i;
  if (! isalpha (t[0]))
    goto broken;

  for (i = 0; i < len; i++)
    if ((!isalnum (t[i]) && (t[i] != '_')))
      goto broken;

  return len;
broken:
  FXTRAN_THROW ("Not a valid identifier");
  return 0;
}

static int check_op (const char * t, int len, FXTRAN_xmlctx * ctx)
{
  int i;
  for (i = 0; FXTRAN_ops[i]; i++)
    if (strncmp (FXTRAN_ops[i], t, len) == 0)
      return len;

  if ((t[0] != '.') || (t[len-1] != '.'))
    FXTRAN_THROW ("Not a valid op");
  
  return 2 + check_id (t+1, len-2, ctx);
}


static void handle_canonic_space (FXTRAN_xmlctx * ctx)
{
  if (ctx->opts.strip_spaces && ctx->fb.pos1oflaststr)
    {
      char c1 = ctx->fb.str[ctx->fb.pos1oflaststr-1];
      char c2 = ctx->text[ctx->pos];
      if (isalnum (c1) && (isalnum (c2) && (c2 != '_')))
        FXTRAN_FBUFFER_putc (&ctx->fb, ' ');
      if ((c1 == ',') && (isalnum (c2)))
        FXTRAN_FBUFFER_putc (&ctx->fb, ' ');
      if (isalnum (c1) && (c2 == '('))
        FXTRAN_FBUFFER_putc (&ctx->fb, ' ');
      if ((c1 == ')') && isalnum (c2))
        FXTRAN_FBUFFER_putc (&ctx->fb, ' ');
      ctx->fb.pos1oflaststr = 0;
    }
}

static void dump_txt_tag (FXTRAN_xmlctx * ctx, int pos1, int pos2, int m, const char * tag)
{
  if (pos1 == pos2)
    return;
 
  if (ctx->opts.strip_comments && (m == FXTRAN_COM))
    return;

  if (ctx->opts.strip_continue && (m == FXTRAN_CO1 || m == FXTRAN_CO2))
    return;

  int cod = 
     ((m == FXTRAN_NAM) || (m == FXTRAN_CPT) || (m == FXTRAN_COD) 
      || (m == FXTRAN_KWD) || (m == FXTRAN_OPR) || (m == FXTRAN_OMD) || (m == FXTRAN_OMC));
  int uc = ctx->opts.uppercase && cod;
  int sl = ctx->opts.strip_linefeed;
  int sp = ctx->opts.strip_spaces && (m != FXTRAN_STR) && (m != FXTRAN_CPP) && (m != FXTRAN_COM);

  if (ctx->opts.strip_spaces && ((m == FXTRAN_MAR) || (m == FXTRAN_MAL)))
    {
      /* Do nothing */
    }
  else if (ctx->opts.strip_linefeed && (m == FXTRAN_SMC))
    {
      FXTRAN_FBUFFER_printf (&ctx->fb, "\n");
    }
  else
    {
      if (ctx->opts.canonic)
        {
          int len = strlen (tag);
          if (FXTRAN_FBUFFER_len(&ctx->fb) > len + 3)
            {
              if ((ctx->fb.cur[-3-len] == '<') && 
                  (ctx->fb.cur[-2-len] == '/') &&
                  (ctx->fb.cur[-1]     == '>') &&
                  (0 == strncmp (tag, &ctx->fb.cur[-len-1], len)))
                {
                  ctx->fb.cur = ctx->fb.cur - len - 3;
                  goto print_escaped_str;
                }
            }
        }
      FXTRAN_FBUFFER_printf (&ctx->fb, "<%s>", tag);
print_escaped_str:
      FXTRAN_FBUFFER_append_escaped_str 
        (&ctx->fb, &ctx->text[pos1], pos2-pos1, uc, cod, sl, sp, ctx->in_stmt);
      FXTRAN_FBUFFER_printf (&ctx->fb, "</%s>", tag);
    }
}


int FXTRAN_XML_print_section (char * buf, int size, const char * t, 
		              const FXTRAN_char_info * ci, int pos, int nl)
{
  int i, j;
  int i1, i2;
  int is = 0;
  char * bufmin = buf, * bufmax = buf + size;

  if ((t == NULL) || (ci == NULL))
    return 0;

  for (i1 = pos; i1 >= 0; i1--)
    if (ci[pos].line - ci[i1].line >= nl)
      break;

  if (i1 < 0)
    i1 = 0;

  for (i2 = pos; t[i2]; i2++)
    if (ci[i2].line - ci[pos].line >= nl+1)
      break;

  buf += snprintf (buf, bufmax - buf, "      | ");
  for (i = 0; i < 80; i++)
    if (i % 10 == 0)
      buf += snprintf (buf, bufmax - buf, "%d", i/10);
    else
      buf += snprintf (buf, bufmax - buf, " ");
  buf += snprintf (buf, bufmax - buf, "\n");

  for (i = i1; i < i2-1; i++)
    {
      if (i == 0)
        buf += snprintf (buf, bufmax - buf, "%5d | ", 1);
      buf += snprintf (buf, bufmax - buf, "%c", t[i]);
      if (t[i] == '\n')
        {
          if (is)
            {
	      buf += snprintf (buf, bufmax - buf, "        ");
              for (j = 0; j < ci[pos].column-1; j++)
                buf += snprintf (buf, bufmax - buf, " ");
	      buf += snprintf (buf, bufmax - buf, "^\n");
	      is = 0;
            }
	  buf += snprintf (buf, bufmax - buf, "%5d | ", ci[i+1].line+1);
        }
      if (i == pos)
        is = 1;
    }
  buf += snprintf (buf, bufmax - buf, "\n");
  if (is)
    {
      buf += snprintf (buf, bufmax - buf, "        ");
      for (j = 0; j < ci[pos].column-1; j++)
        buf += snprintf (buf, bufmax - buf, " ");
      buf += snprintf (buf, bufmax - buf, "^\n");
      is = 0;
    }

  return buf - bufmin;
}

static int adv_pos0 (FXTRAN_xmlctx * ctx, int pos, int noendtag, int print) 
{
  int pos1, pos2;

  pos1 = ctx->pos; 
  pos2 = pos;

  if (ctx->pos == pos)
    return 0;

  if (ctx->pos > pos)            
    FXTRAN_ABORT ("Unexpected position");


  {
    int len = pos2-pos1;
    int i, i1 = 0, i2 = 0;
    char mask1 = FXTRAN_SPC, mask2;

    for (i = 0; i < len+1; i++)
      {
        if (i < len)
          {
	    i2 = i;
	    mask2 = ctx->ci[pos1+i].mask;
          }
	else
          {
            i2 = i;
	    mask2 = FXTRAN_NON;
          }

        if ((mask1 != mask2) || (mask1 == '\n') || (mask2 == '\n'))
          {
            FXTRAN_cpp2loc * Loc = &ctx->c2l[ctx->line];

            if (print)
            switch (mask1)
              {
                case '\n':
                case FXTRAN_SPC:
                  dump_txt (ctx, pos1+i1, pos1+i2, 1);
                  break;
                case FXTRAN_COD:
		  if (ctx->opts.code_tag)
                    dump_txt_tag (ctx, pos1+i1, pos1+i2, FXTRAN_COD, FXTRAN_COD_TAG);
		  else
                    dump_txt (ctx, pos1+i1, pos1+i2, 1);
                  break;
		case FXTRAN_CPP:
                    if (ctx->opts.noinclude)
                      if (FXTRAN_dump_include (Loc->file, ctx, 0, 0) == 0)
                        break;
                    dump_txt_tag (ctx, pos1+i1, pos1+i2, FXTRAN_CPP, FXTRAN_CPP_TAG);
		  break;
#define dump_txt_by_mask(m) \
  case m: dump_txt_tag (ctx, pos1+i1, pos1+i2, m, m##_TAG); break
                dump_txt_by_mask (FXTRAN_OPT);
                dump_txt_by_mask (FXTRAN_STR);
                dump_txt_by_mask (FXTRAN_COM);
                dump_txt_by_mask (FXTRAN_LAB);
                dump_txt_by_mask (FXTRAN_SMC);
                dump_txt_by_mask (FXTRAN_CO2);
                dump_txt_by_mask (FXTRAN_CO1);
                dump_txt_by_mask (FXTRAN_MAL);
                dump_txt_by_mask (FXTRAN_MAR);
                dump_txt_by_mask (FXTRAN_ZER);
                dump_txt_by_mask (FXTRAN_NAM);
                dump_txt_by_mask (FXTRAN_OPR);
                dump_txt_by_mask (FXTRAN_LIT);
                dump_txt_by_mask (FXTRAN_BOZ);
                dump_txt_by_mask (FXTRAN_CPT);
                dump_txt_by_mask (FXTRAN_KWD);
                dump_txt_by_mask (FXTRAN_OMD);
                dump_txt_by_mask (FXTRAN_OMC);
                dump_txt_by_mask (FXTRAN_ACC);
#undef dump_txt_by_mask
                case FXTRAN_DDD:
                  dump_txt_tag (ctx, pos1+i1, pos1+i2, FXTRAN_DDD, ctx->opts.directive);
                  break;
                default:
                  FXTRAN_THROW ("Unexpected mask: `%c'", mask1);
              }

	    /* we have passed eol */
	    if (mask1 == '\n')
              {
                FXTRAN_cpp2loc * Loc1 = &ctx->c2l[ctx->line];
                FXTRAN_cpp2loc * Loc2 = &ctx->c2l[ctx->line+1];
                ctx->line++;

                /* Advance one line (this line has just been printed */
                if (FXTRAN_file_skip_line (Loc1->file, NULL, NULL) < 0)
                  FXTRAN_ABORT ("Could not skip line in file `%s'", Loc1->file->name);

		if (Loc1->file == Loc2->file) /* we remain in the same file */
                  {

		    /* We may have skipped some text */
		    if (print && (Loc2->file->line < Loc2->line))
                      FXTRAN_dump_uns (Loc2->file, Loc2->line, ctx);

		  }
		else if (noendtag) /* file has changed */
                  {
                    ctx->pos = pos1+i2;
                    return 1;
		  }
		else /* file has changed */
                  {
                    FXTRAN_file_change (Loc1->file, Loc2->file, ctx);
		    if (Loc2->file == NULL) /* end of code */
                      goto done;
                  }

		if (ctx->opts.show_lines && print)
                  {
                    if (ctx->opts.debugL)
                      FXTRAN_FBUFFER_printf (&ctx->fb, "<L c=\"%d,%d,%d\"/>", 
                          	              ctx->line, Loc2->line, Loc2->file->line);
                    else
                      FXTRAN_FBUFFER_printf (&ctx->fb, "<L/>");
		  }

	      }

	    if (mask1 == '\n')
              {
                ctx->pos = pos1+i2;
		goto end;
              }

            i1 = i2;
            mask1 = mask2;

          }

      }

  }

done:
  ctx->pos = pos;                

end:

  return 0;
}

static void adv_pos1 (FXTRAN_xmlctx * ctx, int pos, int noendtag, int print) 
{
  while (ctx->pos < pos)
    {
      int pos0 = ctx->pos;

      if (ctx->opts.cpp)
        {
          FXTRAN_cpp2loc * Loc = &ctx->c2l[ctx->line];
          FXTRAN_xcp_mask * cpp_mask = Loc->xcp_mask;
          
          if (cpp_mask)
            {
              int c;
              int c1_code = ctx->ci[ctx->pos].column; 
	      void * id = cpp_mask->code[c1_code].id;
              int cpp = id != NULL;
	      int end = 0;

              if (ctx->text[ctx->pos] == '\n')
                {
                  if (adv_pos0 (ctx, ctx->pos+1, noendtag, print) > 0)
                    return;
                  goto check;
                }

              for (c = c1_code; c < cpp_mask->ncode; c++)
                {
                  if (c == c1_code + pos - ctx->pos)
                    break;
                  if (cpp_mask->code[c].id != cpp_mask->code[c+1].id)
                    {
                      c++;
                      break;
                    }
                }

	      if (c > 0)
	        if (cpp_mask->code[c-1].id != cpp_mask->code[c].id)
	          if (cpp_mask->code[c-1].id != NULL)
                    end = 1;

              if (cpp)
                {

                  if (print)
                  FXTRAN_FBUFFER_printf (&ctx->fb, "<cpp ref=\"0x%llx\">", id);
                  if (adv_pos0 (ctx, ctx->pos-c1_code+c, noendtag, print) > 0)
                    return;
                  if (print)
                  FXTRAN_FBUFFER_printf (&ctx->fb, "</cpp>");

                  if (print)
                  if (end)
                    {
                      int c1_text = cpp_mask->code[c1_code].c1 - 1;
                      int c2_text = cpp_mask->code[c1_code].c2 - 1;
                      FXTRAN_FBUFFER_printf (&ctx->fb, "<cpp-section id=\"0x%llx\">", id);
                      FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, &Loc->file->text_cur[c1_text], c2_text-c1_text+1, 0, 0, 0, 0, 0);
                      FXTRAN_FBUFFER_printf (&ctx->fb, "</cpp-section>");
		    }
                }
              else
                {
                  if (adv_pos0 (ctx, ctx->pos-c1_code+c, noendtag, print))
                    return;
                }
 
              
              goto check;

            }

        }

      if (adv_pos0 (ctx, pos, noendtag, print) > 0)
        return;

check:
      if (pos0 == ctx->pos)
        FXTRAN_ABORT ("No advance");
    }
  return;
}


static void adv_pos (FXTRAN_xmlctx * ctx, int pos, int print)
{
  int empty = FXTRAN_FBUFFER_empty (&ctx->fb);
     
  if (empty)
    FXTRAN_handle_empty (ctx);

  adv_pos1 (ctx, pos, 0, print);
}

static void adv_pos_noendtag (FXTRAN_xmlctx * ctx, int pos, int print) 
{
  int empty = FXTRAN_FBUFFER_empty (&ctx->fb);
     
  if (empty)
    FXTRAN_handle_empty (ctx);

  adv_pos1 (ctx, pos, 1, print);
}

static void xml_start_tag (const char * tag, int pos, FXTRAN_xmlctx * ctx, const FXTRAN_XML_ATTR * attr)
{
  if (pos >= 0)
    adv_pos (ctx, pos, 1);

  handle_canonic_space (ctx);

  if (attr == NULL)
    {
      FXTRAN_FBUFFER_printf (&ctx->fb, "<%s>", tag);
    }
  else
    {
      int i;

      FXTRAN_FBUFFER_printf (&ctx->fb, "<%s", tag);

      for (i = 0; attr[i].name; i++)
        {
          const char * k = attr[i].name;
          const char * v = attr[i].value;
          FXTRAN_FBUFFER_printf (&ctx->fb, " %s=\"", k);
          FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, v, strlen (v), 0, 0, 0, 0, 0);
          FXTRAN_FBUFFER_printf (&ctx->fb, "\"");
	}

      FXTRAN_FBUFFER_printf (&ctx->fb, ">");
    }

  ctx->lev++;
  if (ctx->lev >= FXTRAN_XML_MAXLEV)
    FXTRAN_ABORT ("Exceeded number of XML levels : %d", FXTRAN_XML_MAXLEV);

  ctx->stack[ctx->lev].tag = tag;
}

void FXTRAN_xml_start_tag (const char * tag, int pos, FXTRAN_xmlctx * ctx)
{
  xml_start_tag (tag, pos, ctx, NULL);
}

void FXTRAN_xml_start_tag_attr (const char * tag, int pos, FXTRAN_xmlctx * ctx, const FXTRAN_XML_ATTR * attr)
{
  xml_start_tag (tag, pos, ctx, attr);
}

void FXTRAN_xml_end_tag (int pos, FXTRAN_xmlctx * ctx)
{
  int lev = ctx->lev;
  const char * tag = ctx->stack[lev].tag;
  ctx->lev--;

  if (tag == NULL)
    FXTRAN_ABORT ("Broken tag");

  if (1) /* TODO : file tag */
    {
      if (pos >= 0)
        adv_pos (ctx, pos, 1);
     
      FXTRAN_FBUFFER_printf (&ctx->fb, "</%s>", tag);
    }
  else
    {
      if (pos >= 0)
        adv_pos_noendtag (ctx, pos, 1);
     
      FXTRAN_FBUFFER_printf (&ctx->fb, "</%s>", tag);
     
      if (pos >= 0)
        adv_pos (ctx, pos, 1);
    }

  if (ctx->lev < -1)
    FXTRAN_ABORT ("Broken context");
}

void FXTRAN_xml_end_tag_unsafe (int pos, FXTRAN_xmlctx * ctx)
{
  if (ctx->lev < 0)
    return;
  FXTRAN_xml_end_tag (pos, ctx);
}

void FXTRAN_xml_word_tag (const char * tag, int pos1, int pos2, FXTRAN_xmlctx * ctx)
{
  FXTRAN_xml_start_tag (tag, pos1, ctx);
  FXTRAN_xml_end_tag (pos2, ctx);
}

void FXTRAN_xml_mark (int pos1, int pos2, FXTRAN_xmlctx * ctx, char mask)
{
  int i;

  for (i = 0; i < pos2-pos1; i++)
    if ((ctx->ci[pos1+i].mask == FXTRAN_COD) || 
     (mask == FXTRAN_BOZ && ctx->ci[pos1+i].mask == FXTRAN_STR))
        ctx->ci[pos1+i].mask = mask;
}

void FXTRAN_xml_finish_doc (FXTRAN_xmlctx * ctx)
{
  if (ctx->lev >= 0)
    FXTRAN_ABORT ("Unexpected EOF");
  adv_pos (ctx, strlen (ctx->text), 1);
}

void FXTRAN_xml_word_tag_name (const char * tag, int pos1, int pos2, 
		               FXTRAN_xmlctx * ctx, const char *n, int len)
{
  xml_mark_name (pos1, pos2, ctx);
  check_id (n, len, ctx);

  adv_pos (ctx, pos1, 1);

  if (ctx->opts.name_attr)
    FXTRAN_FBUFFER_printf (&ctx->fb, "<%s n=\"%*.*s\">", tag, len, len, n);
  else
    FXTRAN_FBUFFER_printf (&ctx->fb, "<%s>", tag, len, len, n);

  adv_pos (ctx, pos2, 1);

  FXTRAN_FBUFFER_printf (&ctx->fb, "</%s>", tag);
}

void FXTRAN_xml_word_tag_op (const char * tag, int pos1, int pos2, 
		             FXTRAN_xmlctx * ctx, const char *n, int len)
{
  xml_mark_op (pos1, pos2, ctx);
  check_op (n, len, ctx);

  adv_pos (ctx, pos1, 1);

  if (ctx->opts.name_attr)
    {
      FXTRAN_FBUFFER_printf (&ctx->fb, "<%s n=\"", tag, len, len, n);
      FXTRAN_FBUFFER_append_escaped_str (&ctx->fb, n, len, 0, 0, 0, 0, 0);
      FXTRAN_FBUFFER_printf (&ctx->fb, "\">");
    }
  else
    {
      FXTRAN_FBUFFER_printf (&ctx->fb, "<%s>", tag, len, len, n);
    }

  adv_pos (ctx, pos2, 1);

  FXTRAN_FBUFFER_printf (&ctx->fb, "</%s>", tag);
}

void FXTRAN_xml_word_tag_keyword (const char * tag, int pos1, int pos2, 
		                   FXTRAN_xmlctx * ctx, const char *n, int len)
{
  xml_mark_keyword (pos1, pos2, ctx);
  check_id (n, len, ctx);

  adv_pos (ctx, pos1, 1);

  FXTRAN_FBUFFER_printf (&ctx->fb, "<%s n=\"%*.*s\">", tag, len, len, n);

  adv_pos (ctx, pos2, 1);

  FXTRAN_FBUFFER_printf (&ctx->fb, "</%s>", tag);
}

FXTRAN_xmlctx * FXTRAN_xmlctx_new ()
{
  FXTRAN_xmlctx * ctx = (FXTRAN_xmlctx*)malloc (sizeof (FXTRAN_xmlctx)); 

  ctx->err[0] = '\0';

  memset (&ctx->fb, '\0', sizeof (ctx->fb));                            
  ctx->pos = 0;
  ctx->line = 0;

  ctx->text = NULL;
  ctx->ci = NULL;

  memset (&ctx->opts, '\0', sizeof (ctx->opts));                            
  ctx->root = NULL;
  ctx->c2l = NULL;
  FXTRAN_FBUFFER_init (&ctx->fb); 
  ctx->lev = -1;                       
  return ctx;
} 

void FXTRAN_xmlctx_free (FXTRAN_xmlctx * ctx) 
{
  FXTRAN_file * f, * g;
  FXTRAN_cpp2loc * Loc;

#define ff(x) do { if(x) free (x); x = NULL; } while (0)
  ff (ctx->text);
  ff (ctx->ci);
#undef ff

  FXTRAN_FBUFFER_free (&ctx->fb);  

  for (f = ctx->root; f; )
    {
      g = f->next;
      FXTRAN_file_free (f);
      f = g;
    }

  if (ctx->c2l)
    {
      for (Loc = ctx->c2l; Loc->file; Loc++)
        {
          if (Loc->xcp_mask)
            FXTRAN_cpp_mask_free (Loc->xcp_mask);
          if (Loc->xcp_list)
            FXTRAN_xcp_list_free (Loc->xcp_list);
        }
      
      free (ctx->c2l);
    }

  if (ctx->text)
    free (ctx->text);

  if (ctx->ci)
    free (ctx->ci);

  free (ctx);
}

void FXTRAN_xml_advance (FXTRAN_xmlctx * ctx, int pos)
{
  adv_pos (ctx, pos, 1);
}

void FXTRAN_xml_skip (FXTRAN_xmlctx * ctx, int pos)
{
  adv_pos (ctx, pos, 0);
}


