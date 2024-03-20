/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_ACC_H
#define _FXTRAN_ACC_H

#include "FXTRAN_MASK.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_CHARINFO.h"

int FXTRAN_check_acc (const char *, const FXTRAN_char_info *, int, int,
	              FXTRAN_xmlctx *);

int FXTRAN_handle_acc (const char *, FXTRAN_char_info *, int, int);

void FXTRAN_dump_accd (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);


#define FXTRAN_accd_list(macro) \
  macro (ATOMIC                     )        \
  macro (CACHE                      )        \
  macro (DATA                       )        \
  macro (DECLARE                    )        \
  macro (ENDATOMIC                  )        \
  macro (ENDDATA                    )        \
  macro (ENDHOST_DATA               )        \
  macro (ENDKERNELSLOOP             )        \
  macro (ENDKERNELS                 )        \
  macro (ENDPARALLELLOOP            )        \
  macro (ENDPARALLEL                )        \
  macro (ENDSERIALLOOP              )        \
  macro (ENDSERIAL                  )        \
  macro (ENTERDATA                  )        \
  macro (EXITDATA                   )        \
  macro (HOST_DATA                  )        \
  macro (INIT                       )        \
  macro (KERNELSLOOP                )        \
  macro (KERNELS                    )        \
  macro (LOOP                       )        \
  macro (PARALLELLOOP               )        \
  macro (PARALLEL                   )        \
  macro (ROUTINE                    )        \
  macro (SERIALLOOP                 )        \
  macro (SERIAL                     )        \
  macro (SET                        )        \
  macro (SHUTDOWN                   )        \
  macro (UPDATE                     )        \
  macro (WAIT                       )        

#define enum_macro(T) \
  FXTRAN_ACCD_##T,

typedef enum {
  FXTRAN_ACCD_NONE,
  FXTRAN_accd_list(enum_macro)
  FXTRAN_ACCD_LAST
} FXTRAN_accd_type;

#undef enum_macro


#define FXTRAN_accc_list(macro) \
  macro (DEVICE                    )       \
  macro (HOST                      )       \
  macro (BIND                      )       \
  macro (NOHOST                    )       \
  macro (LINK                      )       \
  macro (DEVICE_NUM                )       \
  macro (DEVICE_RESIDENT           )       \
  macro (TILE                      )       \
  macro (SEQ                       )       \
  macro (INDEPENDENT               )       \
  macro (AUTO                      )       \
  macro (WORKER                    )       \
  macro (COLLAPSE                  )       \
  macro (USE_DEVICE                )       \
  macro (IF_PRESENT                )       \
  macro (FINALIZE                  )       \
  macro (DETACH                    )       \
  macro (DELETE                    )       \
  macro (DTYPE                     )       \
  macro (DEVICE_TYPE               )       \
  macro (DEFAULT_ASYNC             )       \
  macro (DEFAULT                   )       \
  macro (ATTACH                    )       \
  macro (PRIVATE                   )       \
  macro (FIRSTPRIVATE              )       \
  macro (DEVICEPTR                 )       \
  macro (PRESENT                   )       \
  macro (NO_CREATE                 )       \
  macro (CREATE                    )       \
  macro (COPYOUT                   )       \
  macro (COPYIN                    )       \
  macro (COPY                      )       \
  macro (REDUCTION                 )       \
  macro (SELF                      )       \
  macro (IF                        )       \
  macro (ASYNC                     )       \
  macro (WAIT                      )       \
  macro (VECTOR_LENGTH             )       \
  macro (VECTOR                    )       \
  macro (GANG                      )       \
  macro (NUM_WORKERS               )       \
  macro (NUM_GANGS                 )       

/* TODO ACC INTRINSICS */

#endif

