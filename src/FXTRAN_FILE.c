/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "FXTRAN_FILE.h"

#include <stdlib.h>
#include <string.h>

void FXTRAN_file_enter (const char * filename, const char * text, FXTRAN_file ** pcurrent, FXTRAN_file ** proot)
{
  FXTRAN_file * current = *pcurrent;
  FXTRAN_file * f = (FXTRAN_file*)malloc (sizeof (FXTRAN_file));
  int len;

  memset (f, '\0', sizeof (FXTRAN_file));

  f->up = current;
  f->include_level = current ? current->include_level + 1 : 0;

  *pcurrent = f;

  if (*proot)
    {
      FXTRAN_file * g;
      for (g = *proot; g->next; g = g->next);
      g->next = f;
    }
  else
    {
      *proot = f;
    }

  f->inclusion_line = f->up == NULL ? 0 : f->up->line;
  f->line = 0;
  f->name = strdup (filename);

  /* Add an extra carriage return if it is missing */
  len = strlen (text);
  if (text[len-1] != '\n')
    {
      f->text = (char*)malloc (len + 2);
      memcpy (f->text, text, len);
      f->text[len+0] = '\n';
      f->text[len+1] = '\0';
    }
  else
    {
      f->text = strdup (text);
    }

}

void FXTRAN_file_leave (FXTRAN_file ** pcurrent, FXTRAN_file ** proot)
{
  FXTRAN_file * current = *pcurrent;
  *pcurrent = current->up;
}

/* TODO : Handle OpenMP directives and EOL comments */
const char * FXTRAN_grok_fortran_include (const char * line, int len, FXTRAN_opts * opts)
{
  static char buffer[256];
  char quote; 
  const char * p, * start, * end;
  int i;

  buffer[0] = '\0';

  p = line;
  i = 0; 

#define incr(k) \
  do {            \
    i += k;       \
    if (i >= len) \
      return NULL;\
  } while (0)

#define incb(k) \
  do {            \
    i += k;       \
    if (i >= len) \
      break;      \
  } while (0)

#define skip_space() \
  do {                                  \
    while (p[i] == ' ' || p[i] == '\t') \
      incr (1);                         \
  } while (0)

  skip_space ();

  if (opts->openmp)
    if (strncmp (p+i, "!$ ", 3) == 0)
      {
        incr (3);
        skip_space ();
      }

  if (strncasecmp (p+i, "include", 7) != 0)
    return NULL;

  incr (7);

  skip_space ();

  quote = p[i];
  incr (1);
  if (quote != '"' && quote != '\'')
    return NULL;

  start = p + i; 

  while (p[i] != quote)
    incr (1);

  i++;
  end = p + i; 

  if (i < len)
    {

      while (p[i] == ' ' || p[i] == '\t') 
        incb (1);

      if (p[i] != '\0' && p[i] != '!' && i < opts->line_length)
        return NULL;

    }

  strncpy (buffer, start, end-start);

  buffer[end-start-1] = '\0';

  return &buffer[0];
#undef incr
#undef incb
#undef skip_space
}

void FXTRAN_init_cpp2loc_array (FXTRAN_cpp2loc_array * cla)
{
  memset (cla, '\0', sizeof (*cla));
}

void FXTRAN_grow_cpp2loc_array (FXTRAN_cpp2loc_array * cla, int m)
{
  if (cla->curr+m >= cla->base+cla->len)
    {
      int n = 2*(cla->len+m)+m;
      int k = cla->curr - cla->base;
      cla->base = (FXTRAN_cpp2loc*)realloc (cla->base, n * sizeof (FXTRAN_cpp2loc));
      cla->curr = cla->base + k;
      cla->len = n;
      memset (cla->curr, '\0', sizeof (*(cla->curr)) * (n-k)); /* Init to 0 newly allocated data */
    }
}

void FXTRAN_incr_cpp2loc_array (FXTRAN_cpp2loc_array * cla)
{
  FXTRAN_grow_cpp2loc_array (cla, 1);
  cla->curr++;
  memset (cla->curr, '\0', sizeof (*(cla->curr)));
}

void FXTRAN_take_cpp2loc_array (FXTRAN_cpp2loc_array * cla, FXTRAN_cpp2loc ** pc2l)
{
 *pc2l = cla->base;                 
 cla->base = cla->curr = NULL;      
 cla->len = 0;                        
}
