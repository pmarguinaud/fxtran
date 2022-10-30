/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include "FXTRAN_EXPR.h"
#include "FXTRAN_ALPHA.h"
#include "FXTRAN_NAMELIST.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_ERROR.h"


#define fc_isspace(c) (((c) == ' ') || ((c) == '\t'))

#define FXTRAN_NEXT_CHAR \
  do {                                   \
    ci[i].column = c;                    \
    ci[i].line = l;                      \
    if (text[i] == '\n')                 \
      {                                  \
        l++; c = 0;                      \
      }                                  \
    else                                 \
      {                                  \
        c++;                             \
      }                                  \
   if (c == 0)                           \
     {                                   \
       S = 1;                            \
     }                                   \
   else                                  \
     {                                   \
       S = S && (fc_isspace (text[i]));  \
     }                                   \
   i++;                                  \
 } while (0)

#define CASE_FXTRAN_HANDLE_NEW_LINE \
   case '\n':              \
     ci[i].mask = '\n';    \
     C = 0;                \
   break;

#define CASE_FXTRAN_SPACE \
   case ' ': case '\t'

#define CASE_FXTRAN_HANDLE_NEW_BANG \
   case '!':                                       \
     {                                             \
       ci[i].mask = FXTRAN_COM;                    \
       C = 1;                                      \
     }                                             \
   break;

#define CASE_FXTRAN_QUOTE \
   case '"': case '\''

#define CASE_FXTRAN_DIGIT \
   case '0': case '1': case '2': \
   case '3': case '4': case '5': \
   case '6': case '7': case '8': \
   case '9'

#define DUMP_FXTRAN_MASK(text,ci,len) \
  do {                                              \
    int i, j;                                       \
    for (i = 0, j = 0; i < len; i++)                \
      {                                             \
        fprintf (stderr, "%c", text[i]);            \
        if (text[i] == '\n')                        \
          for (; j <= i; j++)                       \
            fprintf (stderr, "%c", ci[j].mask);     \
      }                                             \
  } while (0)                             


#define CLEANUP() \
  do {                                 \
    free (ctx->text);                  \
    FXTRAN_char_info_free (&ctx->ci);  \
    ctx->text = NULL;                  \
    ctx->ci = NULL;                    \
  } while (0)

static int FXTRAN_NAMELIST_head (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int kn;

  XST (_T(_S(NAMELIST) H _S(BLOCK)));
  XAD (1);

  kn = FXTRAN_eat_word (t);

  XNT (_T(_S(NAMELIST) H _S(NAME)), kn);

  XAD (kn);

  return t - T;
}

static int FXTRAN_NAMELIST_tail (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;

  XST (_T(_S(NAMELIST) H _S(END) H _S(MARK)));

  if (t[0] == '/')
    XAD (1);
  else if (strncasecmp (t, "&end", 4) == 0)
    XAD (4);
  else
    FXTRAN_THROW ("Expected `/' or `&end'");

  XET ();

  XET ();

  return t - T;
}

static int FXTRAN_NAMELIST_value (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  XST (_T(_S(NAMELIST) H _S(VALUE)));

  if ((k = FXTRAN_eat_integer_constant (t)))
    if (t[k] == '*')
      {
        XST (_T(_S(REPEAT)));
        XAD(FXTRAN_expr_numeric_litteral_constant (t, ci, ctx, 0));
        XET ();

        XAD(1);
      }

  if ((k = FXTRAN_eat_integer_constant (t)))
    if ((t[k] == '_') && (t[k+1] == '"'))
      {    
        XAD(FXTRAN_expr_string_with_int_kind (t, ci, ctx));
        goto end; 
      }    

  if (t[0] == '"') 
    {    
      XAD(FXTRAN_expr_string (t, ci, ctx));
      goto end; 
    }    
    

  if (((!ci[0].dots) && (t[0] == '.')) || (isdigit (t[0])) || (t[0] == '+'))
    {    
      XAD(FXTRAN_expr_numeric_litteral_constant (t, ci, ctx, 1));
      goto end; 
    }    
  
  if (t[0] == '-')
    {     
      if ((t[1] == '.') || isdigit (t[1]))
        {
          XAD(FXTRAN_expr_numeric_litteral_constant (t, ci, ctx, 1));
        }
      else if (ctx->opts.namelist_diff)
        {
          XST (_T(_S(NAMELIST) H _S(VALUE) H _S(DELETE)));
          XAD (1);
          if (t[0] == '-')
            XAD (1);
          XET ();
        }
      goto end; 
    }    
 
  if (ci[0].dots)
    {    
      k = FXTRAN_eat_word (&t[1]);
      if ((t[k+1] == '.') && (strncmp ("TRUE", &t[1], k) == 0 || strncmp ("FALSE", &t[1], k) == 0))
        XAD(FXTRAN_expr_logical_litteral_constant (t, ci, ctx));
      goto end; 
    }    


end:

  XET ();

  return t - T;
}

static int FXTRAN_NAMELIST_item (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  if (ctx->opts.namelist_diff && (t[0] == '-'))
    {
      XST (_T(_S(NAMELIST) H _S(DELETE)));
      XAD (1);
      if (t[0] == '-')
        XAD (1);
      XET ();
      if (t[0] == ',')
        XAD (1);
    }


  k = FXTRAN_str_at_level (t, ci, "=", 0);
  if (k == 0)
    FXTRAN_THROW ("Expected `='");

  XST (_T(_S(NAMELIST) H _S(ITEM)));

  XST (_T(_S(EXPR)));

  FXTRAN_expr (t, ci, k-1, ctx);

  XAD(k-1);

  XET ();

  FXTRAN_xml_word_tag (_T(_S(ASSIGNMENT)), ci->offset, ci->offset+1, ctx);

  XAD(1);

  XST (_T(_S(NAMELIST) H _S(VALUE) H _S(LIST)));

  while (1)
    {

      if (t[0] == '&')
        break;
      else if (t[0] == '\0')
        break;
      else if (t[0] == '/')
        break;
      else if (t[0] == ' ')
        break;
      else if (('a' <= tolower (t[0])) && (tolower (t[0]) <= 'z'))
        break;

      k = FXTRAN_NAMELIST_value (t, ci, ctx);
      XAD(k);

      if (t[0] == ',')
        XAD (1);

    }

  XET (); /* VALUE-LIST */

  XET (); /* NAMELIST-ITEM */

  return t - T;
}

void FXTRAN_NAMELIST_decode (FXTRAN_xmlctx * ctx)
{
  char * text = ctx->text;
  FXTRAN_char_info * ci;

  int len, i;

  /* string flags are handled directly in the code */
  char q   = 0; /* quote when in string, 0 otherwise */

  /* C is handled by CASE_FXTRAN_HANDLE_NEW_LINE and CASE_FXTRAN_HANDLE_NEW_BANG */
  char C   = 0; /* true in comment */

  /* the following flags are handled by FXTRAN_NEXT_CHAR */
  char S   = 1; /* true if only space was seen since beginning of line */

  int c    = 0;  /* column number */
  int l    = 0;  /* line number */


  len = strlen (text);

  FXTRAN_char_info_alloc (&ci, len);
  ctx->ci = ci;

  for (i = 0; i < len;)
    {
      if (C) /* comment */
        {
          switch (text[i])
            {
              CASE_FXTRAN_HANDLE_NEW_LINE;
              default:
	        ci[i].mask = FXTRAN_COM;
	      break;
            }
        }
      else if (q)  /* string */
	{
          switch (text[i])
            {
	      case '\n':
		FXTRAN_THROW ("Unterminated character constant at (%d,%d)\n", l+1, c+1);
              break;
              CASE_FXTRAN_QUOTE:
                if (q == text[i])
                  {
                    ci[i].mask = FXTRAN_STR;
                    q = 0;
                  }
                else 
                  {
                    ci[i].mask = FXTRAN_STR;
                  }
	      break;
              default:
                ci[i].mask = FXTRAN_STR;
              break;
            }
        }
      else  /* code */
        {
          switch (text[i])
            {
	      CASE_FXTRAN_HANDLE_NEW_LINE;
	      CASE_FXTRAN_HANDLE_NEW_BANG;
              CASE_FXTRAN_QUOTE:
                q = text[i];
                ci[i].mask = FXTRAN_STR;
              break;
              CASE_FXTRAN_SPACE:
                ci[i].mask = FXTRAN_SPC;
	      break;
              default:
	        ci[i].mask = FXTRAN_COD;
              break;
            }
	}

      FXTRAN_NEXT_CHAR;
    }
  

  FXTRAN_set_char_info_off (text, ci);
  FXTRAN_set_char_info_dop (text, ci);

/*DUMP_FXTRAN_MASK(text,ci,len);*/

#define fc_isalnum(x) \
  (('0' <= (x) && (x) <= '9') || ('a' <= (x) && (x) <= 'z') || ('A' <= (x) && (x) <= 'Z') || ((x) == '_'))

  {
    char * text1;
    FXTRAN_char_info * ci1;
    int i, j;
    int len1;
    int in_nml = 0;
    int in_spc = 0;

    text1 = (char *)malloc (len+2);
    FXTRAN_char_info_alloc (&ci1, len+2);
   
    for (i = 0, j = 0; i < len; i++) 
      {
        int cod = ci[i].mask == FXTRAN_COD;
        int str = ci[i].mask == FXTRAN_STR;
        int spc = ci[i].mask == FXTRAN_SPC;
        if (cod || str)
          {    
   
            if (in_spc && fc_isalnum (text1[j-1]) && fc_isalnum (text[i]))
              {
                text1[j] = ' ';
                ci1[j] = ci[i-in_spc];
                j++;
              }

            ci1[j] = ci[i];

            if (str)
              text1[j] = '"';
            else
              text1[j] = text[i];

            j++; 
   
            if (str)
              for (; ci[i+2].mask == FXTRAN_STR; i++);
   
            in_spc = 0;
          }    
        else if (spc)
          {
            in_spc++;
          }
      }
   
    text1[j] = 0; 
    len1 = j;


    if (FXTRAN_check_dpb (text1, ci1, len1))
      FXTRAN_THROW ("Unbalanced parens or dots in `%s'\n", text);

    for (i = 0; i < len1; )
      {
        int count;
        if (text1[i] == ' ')
          {
            count = 1;
          }
        else if (text1[i] == '&')
          {
            if (in_nml)
              {
                count = FXTRAN_NAMELIST_tail (&text1[i], &ci1[i], ctx);
                in_nml = 0;
              }
            else
              {
                count = FXTRAN_NAMELIST_head (&text1[i], &ci1[i], ctx);
                in_nml = 1;
              }
          }
        else if ((text1[i] == '/') && in_nml)
          {
            count = FXTRAN_NAMELIST_tail (&text1[i], &ci1[i], ctx);
            in_nml = 0;
          }
        else if (in_nml)
          {
            count = FXTRAN_NAMELIST_item (&text1[i], &ci1[i], ctx); 
          }
        else
          {
            CLEANUP ();
            FXTRAN_THROW ("Unexpected namelist content");
          }
    
        i += count;
      }
  
    if (in_nml)
      XET ();


    FXTRAN_char_info_free (&ci1);
    free (text1);

  }


}
