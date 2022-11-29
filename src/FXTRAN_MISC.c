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

#include "FXTRAN_MISC.h"
#include "FXTRAN_MASK.h"
#include "FXTRAN_ERROR.h"

/* Remove margin tabs and \r (CR), add an extra '\n' if it is missing */
void FXTRAN_remove_tabs (char ** ptext, int N, int margin_width)
{
  char * t1 = *ptext;
  char * t2;
  int len1;
  int len2;
  int i, i1, i2;
  int c = 0, n;
  int s = 0;

  len1 = strlen (t1);
  len2 = len1;

  if (len1 == 0)
    {
      free (t1);
      t2 = (char*)malloc (2);
      strcpy (t2, "\n");
      *ptext = t2;
      return;
    }

  for (i = 0; t1[i]; i++)
    if (t1[i] == '\t')
      {
        len2 += N;
	s++;
      }
    else if (t1[i] == '\r')
      {
        len2--;
	s++;
      }

  if (t1[len1-1] != '\n')
    {
      len2++;
      s++;
    }

  if (s == 0)
    return;

  t2 = (char*)malloc (len2+1);
  *ptext = t2;

  for (i1 = 0, i2 = 0; t1[i1]; i1++)
    switch (t1[i1])
      {
        case '\r':
        break;
        case '\t':
          if ((!margin_width)  || (c < margin_width))
            {
              n = N - ( c % N );
              for (i = 0; i < n; i++)
                t2[i2++] = ' ';
              c += n;
	    }
        break;
        case '\n':
          t2[i2++] = t1[i1];
          c = 0;
        break;
        default:
          t2[i2++] = t1[i1];
          c++;
        break;
      }

  if (t2[i2-1] != '\n')
    t2[i2++] = '\n';

  t2[i2] = '\0';
    
  free (t1);
}

/* Remove evil MSDOS \r (CR), add an extra '\n' if it is missing */
void FXTRAN_remove_cr (char ** ptext)
{
  char * t1 = *ptext;
  char * t2;
  int len1;
  int len2;
  int i, i1, i2;
  int s = 0;

  len1 = strlen (t1);
  len2 = len1;

  if (len1 == 0)
    {
      free (t1);
      t2 = (char*)malloc (2);
      strcpy (t2, "\n");
      *ptext = t2;
      return;
    }

  for (i = 0; t1[i]; i++)
    if (t1[i] == '\r')
      {
        len2--;
	s++;
      }

  if (t1[len1-1] != '\n')
    {
      len2++;
      s++;
    }

  if (s == 0)
    return;

  t2 = (char*)malloc (len2+1);
  *ptext = t2;

  for (i1 = 0, i2 = 0; t1[i1]; i1++)
    switch (t1[i1])
      {
        case '\r':
        break;
        default:
          t2[i2++] = t1[i1];
        break;
      }

  if (t2[i2-1] != '\n')
    t2[i2++] = '\n';

  t2[i2] = '\0';
    
  free (t1);
}

char * FXTRAN_escape_string (const char * t)
{
  int i;
  int n;
  char * r = NULL;

again:
  n = 0;
  for (i = 0; t[i]; i++)
    switch (t[i])
      {
	case '\'':
        case '\\':
           if (r)
             {
               r[n] = '\\';
               r[n+1] = t[i];
             }
           n += 2;
	break;
        default:
	  if (r)
            r[n] = t[i];
          n++;
	break;
      }
  if (r == NULL)
    {
      r = (char*)malloc (n+1);
      goto again;
    }
  r[n] = '\0';

  return r;
}


/* return true if t[0::len-1] is E10[_jprb] */
static int match_exp (const char * t, int len)
{
  int i;
  if ((t[0] != 'E') && (t[0] != 'D'))
    return 0;

  for (i = 1; i < len; i++)
    if (!isdigit (t[i]))
      {
        if (t[i] != '_')
          return 0;
	i++;
	if (i == len)
          return 0;
	if (!(isalnum (t[i]) || (t[i] == '_')))
          return 0;
	i++;
        for (; i < len; i++)
	  if (!(isalnum (t[i]) || (t[i] == '_')))
            return 0;
      }

  return 1;
}


void FXTRAN_set_char_info_dop (const char * t, FXTRAN_char_info * ci)
{
  int i;
  int P = 0;
  int D = 0;

  /* count parens */
  for (i = 0; t[i]; i++)
    {
      if (ci[i].mask != FXTRAN_COD)
        {
          ci[i].parens = P;
          continue;
	}
      switch (t[i])
        {
          case '(': 
          case '[': ci[i].parens = P++; break;
          case ')': 
          case ']': ci[i].parens = --P; break;
          default:
            ci[i].parens = P;
          break;
        }
    }
  /* count dots */
  ci[0].dots = D;
  for (i = 1; t[i]; i++)
    {
      if (ci[i].mask != FXTRAN_COD) /* Propagate dot count */
        {
          ci[i].dots = D;
          continue;
        }
      if (t[i] == '.')
        {
          if (D) /* Exit dot section */
            {
              ci[i].dots = 1;
              D = 0;
            }
          else
            {
              int k = FXTRAN_eat_word (&t[i+1]);
              if ((k > 0) && (t[i+1+k] == '.')) /* we have an op or a logical cst; enter dot section */
                {
                  /* this could be 1.E6.OR. ; we must perform additionnal checks now */
                  int k1 = 0;
                  if (isdigit (t[i-1]) && match_exp (&t[i+1], k))
                    k1 = FXTRAN_eat_word (&t[i+2+k]);
                  if (k1 && (t[i+2+k+k1] == '.')) /* this was not an op */
                    {
                      D = ci[i].dots = 0;
                    }
		  else
                    {
                      D = ci[i].dots = 1;
		    }
                  

		}
              else                              /* this must be a number */
                {
                  D = ci[i].dots = 0;
		}
            }
        }
      else /* Propagate dot count */
        {
          ci[i].dots = D;
        }
      }

if(0){
  for (i = 0; t[i]; i++)
    printf ("%c", t[i]);
  printf ("\n");

  for (i = 0; t[i]; i++)
    printf ("%c", ci[i].dots ? 'X' : ' ');
  printf ("\n");
}
    
}
void FXTRAN_set_char_info_off (const char * t, FXTRAN_char_info * ci)
{
  int i;

  for (i = 0; t[i]; i++)
    ci[i].offset = ci[i].rank = i;

}

int FXTRAN_eat_word (const char * t)
{
  int k = 0;
  if (!isalpha (t[0]))
    return 0;
  for (k = 1; t[k]; k++)
    if ((!isalnum(t[k]) && (t[k] != '_')))
      goto end;
end:

  if ((t[k-1] == '_') && ((t[k] == '"') || (t[k] == '\'')))
    k--;

  return k;
}

int FXTRAN_restrict_tci (char * t1, FXTRAN_char_info * ci1, 
		  const char * t, const FXTRAN_char_info * ci, 
		  int len)
{
  int i, j;
  /* make copy (strip strings) */
  for (i = 0, j = 0; i < len; i++)
    if (ci[i].mask != FXTRAN_STR)
      {
        t1[j] = toupper (t[i]);
	ci1[j] = ci[i];
	ci1[j].rank = j;
	j++;
      }
    else if ((ci[i-1].mask != FXTRAN_STR) || (ci[i+1].mask != FXTRAN_STR))
      {
        t1[j] = '"';
	ci1[j] = ci[i];
	ci1[j].rank = j;
	j++;
      }
  t1[j] = '\0';
  return j;
}

char * FXTRAN_slurp (FXTRAN_xmlctx * ctx, const char * f)
{
  struct stat st;
  char * text;
  size_t size;
  FILE * fp;

  if (stat (f, &st) == -1)
    return NULL;

  size = st.st_size;
  text = (char*)malloc (size+2);

  if (text == NULL)
    return NULL;

  if ((fp = fopen (f, "r")) == NULL)
    return NULL;

  size_t n = fread (text, 1, size, fp);

  if (n != size)
    {
      printf ("Unexpected end of file encountered while reading `%s'\n", f);
      abort ();
    }

  fclose (fp);

  if (text[size-1] != '\n')
    {
      size = size + 1;
      text[size-1] = '\n';
    }

  text[size] = '\0';

  return text;
}

int FXTRAN_str_at_level (const char * text, const FXTRAN_char_info * ci, const char * str, 
		          int level)
{
  int len, len_str;
  int i;

  len = strlen (text);
  len_str = strlen (str);
  
  for (i = 0; i < len - len_str + 1; i++)
    {
      if (ci[i].parens == level)
        if (strncmp (str, &text[i], len_str) == 0)
          return i+1;
      continue;
    }


  return 0;
}


int FXTRAN_str_at_level_ir (const char * text, const FXTRAN_char_info * ci, const char * str, 
		             int level, int kmax)
{
  int len, len_str;
  int i;

  len = strlen (text);
  len = kmax < len ? kmax : len;

  len_str = strlen (str);
  
  for (i = 0; i < len - len_str + 1; i++)
    {
      if (ci[i].parens == level)
        if (strncmp (str, &text[i], len_str) == 0)
          return i+1;
      continue;
    }


  return 0;
}

/* grok whether we have a list of values (undetermined), a list of 
 * ranges ( i1:i2, j1:j2 ), a list of named args (x,a1=y), an iterator (x,y,i=1,2) */
FXTRAN_grok_parens_type FXTRAN_grok_parens (const char * t, const FXTRAN_char_info * ci)
{
  int k, kp;
  int lev = ci->parens;
  int seen_eq = 0;

  if (t[0] != '(')
    return FXTRAN_grok_parens_ERROR;

  XAD(1);

  kp = FXTRAN_str_at_level (t, ci, ")", lev);

  if (kp == 0)
    return FXTRAN_grok_parens_ERROR;

  if (FXTRAN_str_at_level_ir (t, ci, ":", lev+1, kp))
    return FXTRAN_grok_parens_RANGE;

  while (1)
    {
      k = FXTRAN_eat_word (t);
      if (k && (t[k] == '=') && (t[k+1] != '='))
        {
          if (seen_eq)
            return FXTRAN_grok_parens_ARGKW;
	  else
            seen_eq = 1;
        }
      else if (seen_eq)
        {
          return FXTRAN_grok_parens_ITRTR;
	}
      
      k = FXTRAN_str_at_level_ir (t, ci, ",", lev+1, kp);
      if (k)
        {
          XAD(k); kp = kp - k;
        }
      else
        {
          break;
        }
    }

  if (seen_eq)
    return FXTRAN_grok_parens_ARGKW;


  return FXTRAN_grok_parens_UNKNW;
}

/* Check that dots and parens are balanced */
int FXTRAN_check_dpb (const char * t, const FXTRAN_char_info * ci, const int len)
{
  int i;

  if (ci[0].parens || ci[len-1].parens || (t[0] == ')') || (t[len-1] == '('))
    goto err;

  for (i = 0; i < len; i++) 
    if (ci[i].parens < 0) 
      goto err;


  if ((ci[len-1].dots != 0) && (ci[len-1].dots != 1) && (t[len-1] != '.'))
    goto err;


  return 0;

err:

  return 1;

}


