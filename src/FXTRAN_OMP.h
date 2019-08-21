/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_OMP_H
#define _FXTRAN_OMP_H

#include "FXTRAN_MASK.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_CHARINFO.h"

int FXTRAN_check_omp (const char *, const FXTRAN_char_info *, int, int,
	              FXTRAN_xmlctx *);

int FXTRAN_handle_omp (const char *, FXTRAN_char_info *, int, int);

void FXTRAN_dump_ompd (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);


#define FXTRAN_ompd_list(macro) \
  macro (PARALLELDO                 )        \
  macro (ENDPARALLELDO              )        \
  macro (PARALLELSECTIONS           )        \
  macro (ENDPARALLELSECTIONS        )        \
  macro (PARALLELWORKSHARE          )        \
  macro (ENDPARALLELWORKSHARE       )        \
  macro (DO                         )        \
  macro (ENDDO                      )        \
  macro (SINGLE                     )        \
  macro (ENDSINGLE                  )        \
  macro (WORKSHARE                  )        \
  macro (ENDWORKSHARE               )        \
  macro (SECTIONS                   )        \
  macro (ENDSECTIONS                )        \
  macro (ATOMIC                     )        \
  macro (CRITICAL                   )        \
  macro (ENDCRITICAL                )        \
  macro (ORDERED                    )        \
  macro (ENDORDERED                 )        \
  macro (PARALLEL                   )        \
  macro (ENDPARALLEL                )        \
  macro (FLUSH                      )        \
  macro (THREADPRIVATE              )        \
  macro (MASTER                     )        \
  macro (ENDMASTER                  ) 

#define enum_macro(T) \
  FXTRAN_OMPD_##T,

typedef enum {
  FXTRAN_OMPD_NONE,
  FXTRAN_ompd_list(enum_macro)
  FXTRAN_OMPD_LAST
} FXTRAN_ompd_type;

#undef enum_macro


#define FXTRAN_ompc_list(macro) \
  macro (COPYIN                     )        \
  macro (COPYPRIVATE                )        \
  macro (DEFAULT                    )        \
  macro (FIRSTPRIVATE               )        \
  macro (IF                         )        \
  macro (LASTPRIVATE                )        \
  macro (NOWAIT                     )        \
  macro (NUM_THREADS                )        \
  macro (ORDERED                    )        \
  macro (PRIVATE                    )        \
  macro (REDUCTION                  )        \
  macro (SCHEDULE                   )        \
  macro (SHARED                     )       

/* TODO OMP INTRINSICS */

#endif

