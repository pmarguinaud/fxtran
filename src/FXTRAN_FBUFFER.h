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


typedef struct FXTRAN_FBUFFER
{
  char * str;
  char * cur;
  int len;
  int len0;
  int pos0oflaststr;
  int pos1oflaststr;
}
FXTRAN_FBUFFER;


#define FXTRAN_FBUFFER_take(b,pt) \
  do { *(pt) = (b)->str; } while (0)

#define FXTRAN_FBUFFER_init(b) \
  do { memset(b, 0, sizeof (*(b))); (b)->len = 1024; \
       (b)->str = (b)->cur = (char*)F_BUFFER_MALLOC ((b)->len); (b)->cur[0] = 0; } while (0)

#define FXTRAN_FBUFFER_free(b) \
  do { F_BUFFER_FREE ((b)->str); } while (0)

#define FXTRAN_FBUFFER_spce(b) \
  ((b)->len - ((b)->cur - (b)->str))

#define FXTRAN_FBUFFER_realloc(b,n) \
  do { int k = (b)->cur - (b)->str; \
       (b)->len = n; (b)->str = (char*)F_BUFFER_REALLOC ((b)->str, (b)->len); \
       (b)->cur = (b)->str + k;  } while (0)

#define FXTRAN_FBUFFER_extend(b,n) \
  do { if ((n) > FXTRAN_FBUFFER_spce(b)) { FXTRAN_FBUFFER_realloc(b,(n)+2*(b)->len+1); } \
     } while (0)

#define FXTRAN_FBUFFER_str(b) \
  ((b)->str)

#define FXTRAN_FBUFFER_cur(b) \
  ((b)->cur)

#define FXTRAN_FBUFFER_len(b) \
  ((b)->cur - (b)->str)

#define FXTRAN_FBUFFER_reset(b) \
  do { (b)->cur = (b)->str; (b)->cur[0] = 0; } while (0)


int FXTRAN_FBUFFER_append_escaped_str (FXTRAN_FBUFFER *, const char *, int, int, int, int, int, int);

int FXTRAN_FBUFFER_printf (FXTRAN_FBUFFER *, const char *, ...);

int FXTRAN_FBUFFER_ncat (FXTRAN_FBUFFER *, int, const char *);

int FXTRAN_FBUFFER_append (FXTRAN_FBUFFER *, const FXTRAN_FBUFFER *);


#define FXTRAN_FBUFFER_putc(buf, c) \
  do {                               \
    FXTRAN_FBUFFER_extend (buf, 2); \
    (buf)->cur[0] = c;               \
    (buf)->cur++;                    \
    (buf)->cur[0] = 0;               \
  } while (0)

#define FXTRAN_FBUFFER_empty(buf) \
  ((buf)->len0 == FXTRAN_FBUFFER_len(buf))

#endif

