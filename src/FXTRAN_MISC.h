/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_MISC_H
#define _FXTRAN_MISC_H

#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_XML.h"

void FXTRAN_remove_tabs (char **, int, int);
void FXTRAN_remove_cr (char **);
char * FXTRAN_escape_string (const char *);
void FXTRAN_set_char_info_off (const char *, FXTRAN_char_info *);
void FXTRAN_set_char_info_dop (const char *, FXTRAN_char_info *);
int FXTRAN_eat_word (const char *);
int FXTRAN_restrict_tci (char *, FXTRAN_char_info *, 
		          const char *, const FXTRAN_char_info *, 
		          int);
char * FXTRAN_slurp (FXTRAN_xmlctx *, const char *);

int FXTRAN_str_at_level (const char *, const FXTRAN_char_info *, const char *, int);

int FXTRAN_str_at_level_ir (const char *, const FXTRAN_char_info *, const char *, int, int);


typedef enum 
{
  FXTRAN_grok_parens_ERROR = -1,
  FXTRAN_grok_parens_UNKNW = 0,
  FXTRAN_grok_parens_ARGKW = 1,
  FXTRAN_grok_parens_RANGE = 2,
  FXTRAN_grok_parens_ITRTR = 3
} FXTRAN_grok_parens_type;

FXTRAN_grok_parens_type FXTRAN_grok_parens (const char *, const FXTRAN_char_info *);

int FXTRAN_check_dpb (const char *, const FXTRAN_char_info *, const int);

#endif
