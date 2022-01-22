/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_LOAD_H
#define _FXTRAN_LOAD_H

#include "FXTRAN_XML.h"

char * FXTRAN_load_cpp (const char *, FXTRAN_xmlctx *);
char * FXTRAN_load_nocpp (const char *, FXTRAN_xmlctx *);
char * FXTRAN_load_text (char *, FXTRAN_xmlctx *);

#endif
