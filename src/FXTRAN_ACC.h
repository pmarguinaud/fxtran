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
  macro (WAIT                       )        \
  macro (UPDATE                     )        \
  macro (SHUTDOWN                   )        \
  macro (SET                        )        \
  macro (SERIALLOOP                 )        \
  macro (SERIAL                     )        \
  macro (ROUTINE                    )        \
  macro (PARALLELLOOP               )        \
  macro (PARALLEL                   )        \
  macro (LOOP                       )        \
  macro (KERNELSLOOP                )        \
  macro (KERNELS                    )        \
  macro (INIT                       )        \
  macro (HOST_DATA                  )        \
  macro (EXITDATA                   )        \
  macro (ENTERDATA                  )        \
  macro (ENDSERIALLOOP              )        \
  macro (ENDSERIAL                  )        \
  macro (ENDPARALLELLOOP            )        \
  macro (ENDPARALLEL                )        \
  macro (ENDLOOP                    )        \
  macro (ENDKERNELSLOOP             )        \
  macro (ENDKERNELS                 )        \
  macro (ENDHOST_DATA               )        \
  macro (ENDDATA                    )        \
  macro (ENDATOMIC                  )        \
  macro (DECLARE                    )        \
  macro (DATA                       )        \
  macro (CACHE                      )        \
  macro (ATOMIC                     )        

#define enum_macro(T) \
  FXTRAN_ACCD_##T,

typedef enum {
  FXTRAN_ACCD_NONE,
  FXTRAN_accd_list(enum_macro)
  FXTRAN_ACCD_LAST
} FXTRAN_accd_type;

#undef enum_macro


#define FXTRAN_accc_list(macro) \
  macro (WORKER                    )       \
  macro (WAIT                      )       \
  macro (VECTOR_LENGTH             )       \
  macro (VECTOR                    )       \
  macro (USE_DEVICE                )       \
  macro (TILE                      )       \
  macro (SEQ                       )       \
  macro (SELF                      )       \
  macro (REDUCTION                 )       \
  macro (PRIVATE                   )       \
  macro (PRESENT_OR_CREATE         )       \
  macro (PRESENT                   )       \
  macro (PCREATE                   )       \
  macro (NUM_WORKERS               )       \
  macro (NUM_GANGS                 )       \
  macro (NOHOST                    )       \
  macro (NO_CREATE                 )       \
  macro (LINK                      )       \
  macro (INDEPENDENT               )       \
  macro (IF_PRESENT                )       \
  macro (IF                        )       \
  macro (HOST                      )       \
  macro (GANG                      )       \
  macro (FIRSTPRIVATE              )       \
  macro (FINALIZE                  )       \
  macro (DTYPE                     )       \
  macro (DEVICE_TYPE               )       \
  macro (DEVICE_RESIDENT           )       \
  macro (DEVICEPTR                 )       \
  macro (DEVICE_NUM                )       \
  macro (DEVICE                    )       \
  macro (DETACH                    )       \
  macro (DELETE                    )       \
  macro (DEFAULT_ASYNC             )       \
  macro (DEFAULT                   )       \
  macro (CREATE                    )       \
  macro (COPYOUT                   )       \
  macro (COPYIN                    )       \
  macro (COPY                      )       \
  macro (COLLAPSE                  )       \
  macro (BIND                      )       \
  macro (AUTO                      )       \
  macro (ATTACH                    )       \
  macro (ASYNC                     )       

/* TODO ACC INTRINSICS */

#endif

