/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "FXTRAN_FBUFFER.h"

int FXTRAN_FBUFFER_append_escaped_str 
(FXTRAN_FBUFFER * buf, const char * str, int len, 
 int uppercase, int code, int strip_linefeed, 
 int strip_spaces, int in_stmt)
{
  int i;
  int pos0 = FXTRAN_FBUFFER_len (buf), pos1;
  for (i = 0; i < len; i++)
    {
      unsigned char u;
      char c = str[i];
      switch (c)
        {
          case ' ':
            if (! strip_spaces)
              FXTRAN_FBUFFER_putc (buf, ' ');
          break;
          case '\n':
            {
              if (strip_linefeed)
                {
                  int j;
                  int len = FXTRAN_FBUFFER_len (buf);
                  if ((len > 0) && (FXTRAN_FBUFFER_cur (buf)[-1] == '\n'))
                    goto next;
                  for (j = len-1; j >= 0; j--)
                    if (FXTRAN_FBUFFER_str (buf)[j] == '\n')
                      {
                        buf->cur = buf->str + j + 1;
                        goto next;
                      }
                    else if (FXTRAN_FBUFFER_str (buf)[j] != ' ')
                      {
                        break;
                      }
		  if (! in_stmt)
                    FXTRAN_FBUFFER_putc (buf, '\n');
                }
	      else
                {
                  FXTRAN_FBUFFER_putc (buf, '\n');
		}
            }
            break;
          case '"':
            FXTRAN_FBUFFER_printf (buf, "&quot;");
            break;
          case '<':
            FXTRAN_FBUFFER_printf (buf, "&lt;");
            break;
          case '>':
            FXTRAN_FBUFFER_printf (buf, "&gt;");
            break;
          case '&':
            FXTRAN_FBUFFER_printf (buf, "&amp;");
            break;
          default:
            u = (unsigned char) c;
            if ((u > 31) && (u < 127))
              {
                if (uppercase)
                  c = toupper (c);
		if (strip_spaces && code)
                  {
                    char c1 = i == 0 ? buf->str[buf->pos1oflaststr-1] : buf->cur[-1], c2 = c;
                    if (isalnum (c1) && (c2 == '('))
                      FXTRAN_FBUFFER_putc (buf, ' ');
                    if ((c1 == ')') && isalnum (c2))
                      FXTRAN_FBUFFER_putc (buf, ' ');
                  }
                FXTRAN_FBUFFER_putc (buf, c);
              }
            else if ((u >= 127) || (u == 9) || (u == 10) || (u == 13))
              {
                FXTRAN_FBUFFER_printf (buf, "&#%3.3d;", u);
              }
            else
              {
                FXTRAN_FBUFFER_printf (buf, "<unknown-char code=\"%d\">?</unknown-char>", u);
              }
	    break;
        }

next:
      continue;

    }
  pos1 = FXTRAN_FBUFFER_len (buf);
  if (pos0 < pos1)
    {
      buf->pos0oflaststr = pos0;
      buf->pos1oflaststr = pos1;
    }
  return 0;
}

int FXTRAN_FBUFFER_printf (FXTRAN_FBUFFER * buf, const char * fmt, ...)
{
  int n;
  va_list ap;
  int size;

  while (1) 
    {
      size = FXTRAN_FBUFFER_spce (buf);

      va_start (ap, fmt);
      n = vsnprintf (buf->cur, size, fmt, ap);
      va_end (ap);

      if (n < 0)
        return -1;

      if (n < size)
        {
          buf->cur += n;
	  buf->cur[0] = 0;
          return n;
	}

      FXTRAN_FBUFFER_extend (buf, n+1);

    }

  return 0;
}

int FXTRAN_FBUFFER_ncat (FXTRAN_FBUFFER * buf, int n, const char * str)
{
  FXTRAN_FBUFFER_extend (buf, n+1);
  memcpy (buf->cur, str, n);
  buf->cur += n;
  buf->cur[0] = 0;
  return n;
}

int FXTRAN_FBUFFER_append (FXTRAN_FBUFFER * buf1, const FXTRAN_FBUFFER * buf2)
{
  return FXTRAN_FBUFFER_ncat (buf1, FXTRAN_FBUFFER_len (buf2), FXTRAN_FBUFFER_str (buf2));
}

