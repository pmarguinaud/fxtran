/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_OMP_TARGET_H
#define _FXTRAN_OMP_TARGET_H

#include "FXTRAN_MASK.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_CHARINFO.h"

int FXTRAN_check_omp_target (const char *, const FXTRAN_char_info *, int, int,
                              FXTRAN_xmlctx *);

int FXTRAN_handle_omp_target (const char *, FXTRAN_char_info *, int, int);

void FXTRAN_dump_omptd (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);


/* OpenMP Target directives -- longest match first within each group.
 * DISTRIBUTE, PARALLELDO, PARALLELDOSIMD, SIMD, LOOP, DO are clauses. */
#define FXTRAN_omptd_list(macro) \
  macro (TARGETENTERDATA                      )   \
  macro (TARGETEXITDATA                       )   \
  macro (TARGETPARALLEL                       )   \
  macro (TARGETUPDATE                         )   \
  macro (TARGETTEAMS                          )   \
  macro (TARGETDATA                           )   \
  macro (TARGET                               )   \
  macro (ENDTARGETPARALLEL                    )   \
  macro (ENDTARGETTEAMS                       )   \
  macro (ENDTARGETDATA                        )   \
  macro (ENDTARGET                            )   \
  macro (ENDDECLARETARGET                     )   \
  macro (DECLARETARGET                        )

#define enum_macro(T) \
  FXTRAN_OMPTD_##T,

typedef enum {
  FXTRAN_OMPTD_NONE,
  FXTRAN_omptd_list(enum_macro)
  FXTRAN_OMPTD_LAST
} FXTRAN_omptd_type;

#undef enum_macro


/* OpenMP Target clauses.
 * Ordering rules: DEFAULTMAP before DEFAULT (prefix conflict);
 *                 PARALLELDOSIMD before PARALLELDO (prefix conflict). */
#define FXTRAN_omptc_list(macro) \
  macro (IS_DEVICE_PTR    )  \
  macro (IN_REDUCTION     )  \
  macro (USES_ALLOCATORS  )  \
  macro (PARALLELDOSIMD   )  \
  macro (PARALLELDO       )  \
  macro (THREAD_LIMIT     )  \
  macro (FIRSTPRIVATE     )  \
  macro (LASTPRIVATE      )  \
  macro (DEFAULTMAP       )  \
  macro (DIST_SCHEDULE    )  \
  macro (DISTRIBUTE       )  \
  macro (NUM_TEAMS        )  \
  macro (REDUCTION        )  \
  macro (COLLAPSE         )  \
  macro (SCHEDULE         )  \
  macro (DEFAULT          )  \
  macro (PRIVATE          )  \
  macro (SAFELEN          )  \
  macro (SIMDLEN          )  \
  macro (ALIGNED          )  \
  macro (ORDERED          )  \
  macro (NOWAIT           )  \
  macro (LINEAR           )  \
  macro (SHARED           )  \
  macro (DEPEND           )  \
  macro (DEVICE           )  \
  macro (SIMD             )  \
  macro (LOOP             )  \
  macro (MAP              )  \
  macro (FROM             )  \
  macro (TO               )  \
  macro (DO               )  \
  macro (IF               )

#endif
