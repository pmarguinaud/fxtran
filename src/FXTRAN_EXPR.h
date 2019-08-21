/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_EXPR_H
#define _FXTRAN_EXPR_H

#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_XML.h"

int FXTRAN_eat_integer_constant (const char *);

int FXTRAN_expr_string_with_int_kind (const char *, const FXTRAN_char_info *, 
                                      FXTRAN_xmlctx *);

int FXTRAN_expr_string (const char *, const FXTRAN_char_info *, 
                        FXTRAN_xmlctx *);

int FXTRAN_expr_numeric_litteral_constant (const char *, const FXTRAN_char_info *,
                                           FXTRAN_xmlctx *, int);

int FXTRAN_expr_logical_litteral_constant (const char *, const FXTRAN_char_info *, 
                                           FXTRAN_xmlctx *);

void FXTRAN_expr (const char *, const FXTRAN_char_info *, 
                   int, FXTRAN_xmlctx *);


#endif
