/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_CPP_INTF_H
#define _FXTRAN_CPP_INTF_H

#include "FXTRAN_FILE.h"
#include "FXTRAN_OPTS.h"

int FXTRAN_cpp_intf (const char *, FXTRAN_file **, FXTRAN_cpp2loc **,
		     FXTRAN_opts *, void *,
		     void (*)(void*, char*, int));

#endif
