/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_FILE_H
#define _FXTRAN_FILE_H


#include "FXTRAN_XCP.h"
#include "FXTRAN_OPTS.h"

typedef struct FXTRAN_file
{
  struct FXTRAN_file * up;
  struct FXTRAN_file * next;
  char * name;
  int include_level;
  char * text;
  char * text_cur;
  int line;
  int line_total;
  int inclusion_line;
} FXTRAN_file;

typedef struct FXTRAN_cpp2loc
{
  int line;
  int len;
  FXTRAN_file * file;
  FXTRAN_xcp * xcp_list;
  FXTRAN_xcp_mask * xcp_mask;
} FXTRAN_cpp2loc;

typedef struct FXTRAN_cpp2loc_array
{
  FXTRAN_cpp2loc * base;
  FXTRAN_cpp2loc * curr;
  int len;
} FXTRAN_cpp2loc_array;

#define FXTRAN_file_free(f) \
  do {                             \
    free (f->text);                \
    free (f->name);                \
    free (f);                      \
  } while (0)

void FXTRAN_file_enter (const char *, const char *, FXTRAN_file **, FXTRAN_file **);
void FXTRAN_file_leave (FXTRAN_file **, FXTRAN_file **);
const char * FXTRAN_grok_fortran_include (const char *, int, FXTRAN_opts *);

void FXTRAN_init_cpp2loc_array (FXTRAN_cpp2loc_array *);
void FXTRAN_grow_cpp2loc_array (FXTRAN_cpp2loc_array *, int);
void FXTRAN_incr_cpp2loc_array (FXTRAN_cpp2loc_array *);
void FXTRAN_take_cpp2loc_array (FXTRAN_cpp2loc_array *, FXTRAN_cpp2loc **);
#define FXTRAN_curr_cpp2loc_array(cla) ((cla)->curr)
 

#endif

