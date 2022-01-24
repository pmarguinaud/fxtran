/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_F_BUFFER_H
#define _FXTRAN_F_BUFFER_H

#include <stdlib.h>

#define F_BUFFER_FREE          free
#define F_BUFFER_MALLOC        malloc
#define F_BUFFER_REALLOC       realloc

#include "f_buffer.h"

#define FXTRAN_f_buffer_take                     f_buffer_take

#define FXTRAN_f_buffer_init                     f_buffer_init

#define FXTRAN_f_buffer_free                     f_buffer_free

#define FXTRAN_f_buffer_spce                     f_buffer_spce

#define FXTRAN_f_buffer_realloc                  f_buffer_realloc

#define FXTRAN_f_buffer_extend                   f_buffer_extend

#define FXTRAN_f_buffer_str                      f_buffer_str

#define FXTRAN_f_buffer_len                      f_buffer_len

#define FXTRAN_f_buffer_reset                    f_buffer_reset

#define FXTRAN_f_buffer_append_escaped_str       f_buffer_append_escaped_str

#define FXTRAN_f_buffer_printf                   f_buffer_printf

#define FXTRAN_f_buffer_ncat                     f_buffer_ncat

#define FXTRAN_f_buffer_append                   f_buffer_append

#define FXTRAN_f_buffer_putc                     f_buffer_putc

#define FXTRAN_f_buffer_empty                    f_buffer_empty

#endif

