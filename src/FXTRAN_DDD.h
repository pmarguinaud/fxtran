/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_DDD_H
#define _FXTRAN_DDD_H

#include "FXTRAN_MASK.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_OPTS.h"
#include "FXTRAN_CHARINFO.h"

int FXTRAN_check_ddd (const char *, const FXTRAN_char_info *, int, int,
	              FXTRAN_xmlctx *);

int FXTRAN_handle_ddd (const char *, FXTRAN_char_info *, int, int, const FXTRAN_opts *);

void FXTRAN_dump_dddd (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);

#endif

