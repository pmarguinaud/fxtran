/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_FILE_FUNC_H
#define _FXTRAN_FILE_FUNC_H

#include "FXTRAN_XML.h"
#include "FXTRAN_FILE.h"

int FXTRAN_file_change (FXTRAN_file *, FXTRAN_file *, FXTRAN_xmlctx *);
void FXTRAN_file_reset (FXTRAN_file *);
int FXTRAN_file_skip_line (FXTRAN_file *, const char **, int *);
void FXTRAN_dump_uns (FXTRAN_file *, int, FXTRAN_xmlctx *);
void FXTRAN_handle_empty (FXTRAN_xmlctx *);
int FXTRAN_dump_include (FXTRAN_file *, FXTRAN_xmlctx *, int, int);

#endif
