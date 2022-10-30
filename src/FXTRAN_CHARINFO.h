/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_CHAR_INFO_H
#define _FXTRAN_CHAR_INFO_H

typedef struct FXTRAN_char_info
{
  int parens;
  int dots;
  char mask;
  int column;
  int line;
  int rank;
  int offset;
} FXTRAN_char_info;


void FXTRAN_char_info_init (FXTRAN_char_info *, int);
void FXTRAN_char_info_alloc (FXTRAN_char_info **, int);
void FXTRAN_char_info_free (FXTRAN_char_info **);

#endif
