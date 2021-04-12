/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <string.h>
#include <ctype.h>

#include "FXTRAN_DDD.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_ALPHA.h"

#define fc_isspace(c) (((c) == ' ') || ((c) == '\t'))


static int DDD_FXTRAN (const char * t, const FXTRAN_opts * opts)
{
  return 0 == strncmp (opts->directive, t, opts->directive_ln-2);
}

static int DDDS_FXTRAN (const char * t, const FXTRAN_opts * opts)
{
  return DDD_FXTRAN (t, opts) && fc_isspace ((t)[opts->directive_ln-2]);
}

#define CASE_FXTRAN_SPACE \
	case ' ': case '\t'

int FXTRAN_check_ddd (const char * t, const FXTRAN_char_info * ci, int i1, int i2,
	              FXTRAN_xmlctx * ctx)
{
  int i;
  int ci0mask;

/* Find beginning of line */
  for (i = i1; i; i--)
    if (t[i-1] == '\n')
      break;

/* Goto first non white-space char */
  for (; fc_isspace (t[i]); i++);

  ci0mask = ci[i].mask;
  
  if (ci0mask == FXTRAN_DDD)
    {
      for (; i < i2+1; i++)
        if (ci[i].column == 0)
          {
            int ci1mask;
            int seencode = 0;

            /* Goto first non white-space char */
            for (; fc_isspace (t[i]); i++);

            ci1mask = ci[i].mask;

            for (; i < i2+1; i++)
              if (t[i] == '\n')
                break;
              else if ((ci[i].mask == FXTRAN_COD) || (ci[i].mask == FXTRAN_STR))
                seencode = 1;
            if (seencode && (ci1mask != ci0mask))
              FXTRAN_THROW ("Malformed OpenACC directive");
          } 
      return 2;
    }
 
  return 0;
}

int FXTRAN_handle_ddd (const char * text, FXTRAN_char_info * ci, int i, int DDD, const FXTRAN_opts * opts)
{
  int ddd = 0;

  if (text[i+1] == '$')
    {
      int j;
      ddd = 1;
      for (j = i-1; j >= 0; j--)
        {
          switch (text[j])
            {
              case '\n':
                goto done;
              CASE_FXTRAN_SPACE:
              break;
              default:
                ddd = 0;
		goto done;
            }
        }
    }
done:

  if (ddd)
    {
      if ((DDDS_FXTRAN (text+i+2, opts)) || (DDD && DDD_FXTRAN (text+i+2, opts)))
        {
          int j;
          for (j = 0; j < opts->directive_ln; j++)
            ci[i+j].mask = FXTRAN_DDD;
          return opts->directive_ln;
	}
    }
  

  return 0;
}

void FXTRAN_dump_dddd (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  char tag[ctx->opts.directive_ln+15];
  
  strcpy (tag, ctx->opts.directive);
  strcat (tag, "-directive");

  XST (tag);

  XAD(strlen (t));

  XET ();

}

