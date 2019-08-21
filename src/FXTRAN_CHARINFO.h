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


#define FXTRAN_char_info_alloc(pci,len) \
  do {                                                                              \
    FXTRAN_char_info * _ci;                                                         \
    int i;                                                                          \
    _ci = (FXTRAN_char_info*)malloc (((len)+1) * sizeof (FXTRAN_char_info));        \
    memset (_ci, '\0', ((len)+1) * sizeof (FXTRAN_char_info));                      \
    for (i = 0; i < (len); i++)                                                     \
      _ci[i].mask = FXTRAN_SPC;                                                     \
    *(pci) = _ci;                                                                   \
  } while (0)

#define FXTRAN_char_info_free(pci) \
  do {                        \
    free (*(pci));            \
    *(pci) = NULL;            \
  } while (0)



#endif
