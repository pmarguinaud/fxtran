/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include <stdio.h>
#include <string.h>
#include <ctype.h>


int f_buffer_append_escaped_str (f_buffer * buf, const char * str, int len, 
                                 int uppercase, int code, int strip_linefeed, int strip_spaces)
{
  int i;

  for (i = 0; i < len; i++)
    {
      unsigned char u;
      char c = str[i];
      switch (c)
        {
          case ' ':
            if (! strip_spaces)
              f_buffer_putc (buf, ' ');
          break;
          case '\n':
            {
              if (strip_linefeed)
                {
                  int j;
                  int len = f_buffer_len (buf);
                  if ((len > 0) && (f_buffer_cur (buf)[-1] == '\n'))
                    goto next;
                  for (j = len-1; j >= 0; j--)
                    if (f_buffer_str (buf)[j] == '\n')
                      {
                        buf->cur = buf->str + j + 1;
                        goto next;
                      }
                    else if (f_buffer_str (buf)[j] != ' ')
                      {
                        break;
                      }
                  f_buffer_putc (buf, '\n');
                }
	      else
                {
                  f_buffer_putc (buf, '\n');
		}
            }
            break;
          case '"':
            f_buffer_printf (buf, "&quot;");
            break;
          case '<':
            f_buffer_printf (buf, "&lt;");
            break;
          case '>':
            f_buffer_printf (buf, "&gt;");
            break;
          case '&':
            f_buffer_printf (buf, "&amp;");
            break;
          default:
            u = (unsigned char) c;
            if ((u > 31) && (u < 127))
              {
                if (uppercase)
                  c = toupper (c);
                f_buffer_putc (buf, c);
              }
            else if ((u >= 127) || (u == 9) || (u == 10) || (u == 13))
              {
                f_buffer_printf (buf, "&#%3.3d;", u);
              }
            else
              {
                f_buffer_printf (buf, "<unknown-char code=\"%d\">?</unknown-char>", u);
              }
	    break;
        }

next:
      continue;

    }
  return 0;
}

int f_buffer_printf (f_buffer * buf, const char * fmt, ...)
{
  int n;
  va_list ap;
  int size;

  while (1) 
    {
      size = f_buffer_spce (buf);

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

      f_buffer_extend (buf, n+1);

    }

  return 0;
}

int f_buffer_ncat (f_buffer * buf, int n, const char * str)
{
  f_buffer_extend (buf, n+1);
  memcpy (buf->cur, str, n);
  buf->cur += n;
  buf->cur[0] = 0;
  return n;
}

int f_buffer_append (f_buffer * buf1, const f_buffer * buf2)
{
  return f_buffer_ncat (buf1, f_buffer_len (buf2), f_buffer_str (buf2));
}

