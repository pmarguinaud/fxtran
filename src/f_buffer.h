/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _F_BUFFER_H
#define _F_BUFFER_H

#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

typedef struct f_buffer
{
  char * str;
  char * cur;
  int len;
  int len0;
}
f_buffer;


#define f_buffer_take(b,pt) \
  do { *(pt) = (b)->str; } while (0)

#define f_buffer_init(b) \
  do { memset(b, 0, sizeof (*(b))); (b)->len = 1024; \
       (b)->str = (b)->cur = (char*)F_BUFFER_MALLOC ((b)->len); (b)->cur[0] = 0; } while (0)

#define f_buffer_free(b) \
  do { F_BUFFER_FREE ((b)->str); } while (0)

#define f_buffer_spce(b) \
  ((b)->len - ((b)->cur - (b)->str))

#define f_buffer_realloc(b,n) \
  do { int k = (b)->cur - (b)->str; \
       (b)->len = n; (b)->str = (char*)F_BUFFER_REALLOC ((b)->str, (b)->len); \
       (b)->cur = (b)->str + k;  } while (0)

#define f_buffer_extend(b,n) \
  do { if ((n) > f_buffer_spce(b)) { f_buffer_realloc(b,(n)+2*(b)->len+1); } \
     } while (0)

#define f_buffer_str(b) \
  ((b)->str)

#define f_buffer_cur(b) \
  ((b)->cur)

#define f_buffer_len(b) \
  ((b)->cur - (b)->str)

#define f_buffer_reset(b) \
  do { (b)->cur = (b)->str; (b)->cur[0] = 0; } while (0)


int f_buffer_append_escaped_str (f_buffer *, const char *, int, int, int, int, int);

int f_buffer_printf (f_buffer *, const char *, ...);

int f_buffer_ncat (f_buffer *, int, const char *);

int f_buffer_append (f_buffer *, const f_buffer *);


#define f_buffer_putc(buf, c) \
  do {                        \
    f_buffer_extend (buf, 2); \
    (buf)->cur[0] = c;        \
    (buf)->cur++;             \
    (buf)->cur[0] = 0;        \
  } while (0)

#define f_buffer_empty(buf) \
  ((buf)->len0 == f_buffer_len(buf))

#endif

