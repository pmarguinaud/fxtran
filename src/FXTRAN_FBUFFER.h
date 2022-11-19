/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_F_BUFFER_H
#define _FXTRAN_F_BUFFER_H

#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#define F_BUFFER_FREE          free
#define F_BUFFER_MALLOC        malloc
#define F_BUFFER_REALLOC       realloc


typedef struct FXTRAN_f_buffer
{
  char * str;
  char * cur;
  int len;
  int len0;
}
FXTRAN_f_buffer;


#define FXTRAN_f_buffer_take(b,pt) \
  do { *(pt) = (b)->str; } while (0)

#define FXTRAN_f_buffer_init(b) \
  do { memset(b, 0, sizeof (*(b))); (b)->len = 1024; \
       (b)->str = (b)->cur = (char*)F_BUFFER_MALLOC ((b)->len); (b)->cur[0] = 0; } while (0)

#define FXTRAN_f_buffer_free(b) \
  do { F_BUFFER_FREE ((b)->str); } while (0)

#define FXTRAN_f_buffer_spce(b) \
  ((b)->len - ((b)->cur - (b)->str))

#define FXTRAN_f_buffer_realloc(b,n) \
  do { int k = (b)->cur - (b)->str; \
       (b)->len = n; (b)->str = (char*)F_BUFFER_REALLOC ((b)->str, (b)->len); \
       (b)->cur = (b)->str + k;  } while (0)

#define FXTRAN_f_buffer_extend(b,n) \
  do { if ((n) > FXTRAN_f_buffer_spce(b)) { FXTRAN_f_buffer_realloc(b,(n)+2*(b)->len+1); } \
     } while (0)

#define FXTRAN_f_buffer_str(b) \
  ((b)->str)

#define FXTRAN_f_buffer_cur(b) \
  ((b)->cur)

#define FXTRAN_f_buffer_len(b) \
  ((b)->cur - (b)->str)

#define FXTRAN_f_buffer_reset(b) \
  do { (b)->cur = (b)->str; (b)->cur[0] = 0; } while (0)


int FXTRAN_f_buffer_append_escaped_str (FXTRAN_f_buffer *, const char *, int, int, int, int, int);

int FXTRAN_f_buffer_printf (FXTRAN_f_buffer *, const char *, ...);

int FXTRAN_f_buffer_ncat (FXTRAN_f_buffer *, int, const char *);

int FXTRAN_f_buffer_append (FXTRAN_f_buffer *, const FXTRAN_f_buffer *);


#define FXTRAN_f_buffer_putc(buf, c) \
  do {                               \
    FXTRAN_f_buffer_extend (buf, 2); \
    (buf)->cur[0] = c;               \
    (buf)->cur++;                    \
    (buf)->cur[0] = 0;               \
  } while (0)

#define FXTRAN_f_buffer_empty(buf) \
  ((buf)->len0 == FXTRAN_f_buffer_len(buf))

#endif

