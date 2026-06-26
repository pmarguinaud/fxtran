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


/* OpenMP Target directives -- please sort in reverse alphabetic order (longest match first) */
#define FXTRAN_omptd_list(macro) \
  macro (WORKSHARE                            )   \
  macro (UNROLL                               )   \
  macro (TILE                                 )   \
  macro (THREADPRIVATE                        )   \
  macro (TEAMSDISTRIBUTEPARALLELDOSIMD        )   \
  macro (TEAMSDISTRIBUTEPARALLELDO            )   \
  macro (TEAMSDISTRIBUTESIMD                  )   \
  macro (TEAMSDISTRIBUTE                      )   \
  macro (TEAMSLOOP                            )   \
  macro (TEAMS                                )   \
  macro (TASKYIELD                            )   \
  macro (TASKWAIT                             )   \
  macro (TASKGROUP                            )   \
  macro (TASKLOOPSIMD                         )   \
  macro (TASKLOOP                             )   \
  macro (TASK                                 )   \
  macro (TARGETUPDATE                         )   \
  macro (TARGETTEAMSDISTRIBUTEPARALLELDOSIMD  )   \
  macro (TARGETTEAMSDISTRIBUTEPARALLELDO      )   \
  macro (TARGETTEAMSDISTRIBUTESIMD            )   \
  macro (TARGETTEAMSDISTRIBUTE                )   \
  macro (TARGETTEAMSLOOP                      )   \
  macro (TARGETTEAMS                          )   \
  macro (TARGETSIMD                           )   \
  macro (TARGETPARALLELDOSIMD                 )   \
  macro (TARGETPARALLELLOOP                   )   \
  macro (TARGETPARALLELDO                     )   \
  macro (TARGETPARALLEL                       )   \
  macro (TARGETEXITDATA                       )   \
  macro (TARGETENTERDATA                      )   \
  macro (TARGETDATA                           )   \
  macro (TARGET                               )   \
  macro (SINGLE                               )   \
  macro (SIMD                                 )   \
  macro (SECTIONS                             )   \
  macro (SECTION                              )   \
  macro (SCOPE                                )   \
  macro (SCAN                                 )   \
  macro (REQUIRES                             )   \
  macro (PARALLELWORKSHARE                    )   \
  macro (PARALLELSECTIONS                     )   \
  macro (PARALLELMASKEDTASKLOOPSIMD            )   \
  macro (PARALLELMASKEDTASKLOOP                )   \
  macro (PARALLELMASKED                       )   \
  macro (PARALLELMASTER                       )   \
  macro (PARALLELDOSIMD                       )   \
  macro (PARALLELDO                           )   \
  macro (PARALLELLOOP                         )   \
  macro (PARALLEL                             )   \
  macro (ORDERED                              )   \
  macro (MASKEDTASKLOOPSIMD                   )   \
  macro (MASKEDTASKLOOP                       )   \
  macro (MASTERTASKLOOPSIMD                   )   \
  macro (MASTERTASKLOOP                       )   \
  macro (MASTER                               )   \
  macro (MASKED                               )   \
  macro (LOOP                                 )   \
  macro (FLUSH                                )   \
  macro (ERROR                                )   \
  macro (ENDWORKSHARE                         )   \
  macro (ENDUNROLL                            )   \
  macro (ENDTILE                              )   \
  macro (ENDTEAMSDISTRIBUTEPARALLELDOSIMD     )   \
  macro (ENDTEAMSDISTRIBUTEPARALLELDO         )   \
  macro (ENDTEAMSDISTRIBUTESIMD               )   \
  macro (ENDTEAMSDISTRIBUTE                   )   \
  macro (ENDTEAMSLOOP                         )   \
  macro (ENDTEAMS                             )   \
  macro (ENDTASKGROUP                         )   \
  macro (ENDTASKLOOPSIMD                      )   \
  macro (ENDTASKLOOP                          )   \
  macro (ENDTASK                              )   \
  macro (ENDTARGETTEAMSDISTRIBUTEPARALLELDOSIMD)   \
  macro (ENDTARGETTEAMSDISTRIBUTEPARALLELDO   )   \
  macro (ENDTARGETTEAMSDISTRIBUTESIMD         )   \
  macro (ENDTARGETTEAMSDISTRIBUTE             )   \
  macro (ENDTARGETTEAMSLOOP                   )   \
  macro (ENDTARGETTEAMS                       )   \
  macro (ENDTARGETSIMD                        )   \
  macro (ENDTARGETPARALLELDOSIMD              )   \
  macro (ENDTARGETPARALLELLOOP                )   \
  macro (ENDTARGETPARALLELDO                  )   \
  macro (ENDTARGETPARALLEL                    )   \
  macro (ENDTARGETDATA                        )   \
  macro (ENDTARGET                            )   \
  macro (ENDSINGLE                            )   \
  macro (ENDSECTIONS                          )   \
  macro (ENDSECTION                           )   \
  macro (ENDSCOPE                             )   \
  macro (ENDPARALLELWORKSHARE                 )   \
  macro (ENDPARALLELSECTIONS                  )   \
  macro (ENDPARALLELMASKEDTASKLOOPSIMD         )   \
  macro (ENDPARALLELMASKEDTASKLOOP             )   \
  macro (ENDPARALLELMASKED                    )   \
  macro (ENDPARALLELMASTER                    )   \
  macro (ENDPARALLELDOSIMD                    )   \
  macro (ENDPARALLELDO                        )   \
  macro (ENDPARALLELLOOP                      )   \
  macro (ENDPARALLEL                          )   \
  macro (ENDORDERED                           )   \
  macro (ENDMASKEDTASKLOOPSIMD                )   \
  macro (ENDMASKEDTASKLOOP                    )   \
  macro (ENDMASTERTASKLOOPSIMD                )   \
  macro (ENDMASTERTASKLOOP                    )   \
  macro (ENDMASTER                            )   \
  macro (ENDMASKED                            )   \
  macro (ENDLOOP                              )   \
  macro (ENDDOSIMD                            )   \
  macro (ENDDO                                )   \
  macro (ENDDISTRIBUTEPARALLELDOSIMD          )   \
  macro (ENDDISTRIBUTEPARALLELDO              )   \
  macro (ENDDISTRIBUTESIMD                    )   \
  macro (ENDDISTRIBUTE                        )   \
  macro (ENDDECLARETARGET                     )   \
  macro (ENDCRITICAL                          )   \
  macro (ENDASSUME                            )   \
  macro (ENDATOMIC                            )   \
  macro (ENDALLOCATORS                        )   \
  macro (DOSIMD                               )   \
  macro (DO                                   )   \
  macro (DISTRIBUTEPARALLELDOSIMD             )   \
  macro (DISTRIBUTEPARALLELDO                 )   \
  macro (DISTRIBUTESIMD                       )   \
  macro (DISTRIBUTE                           )   \
  macro (DEPOBJ                               )   \
  macro (DECLARETARGET                        )   \
  macro (DECLARE                              )   \
  macro (CRITICAL                             )   \
  macro (BARRIER                              )   \
  macro (ASSUMES                              )   \
  macro (ASSUME                               )   \
  macro (ATOMIC                               )   \
  macro (ALLOCATORS                           )   

#define enum_macro(T) \
  FXTRAN_OMPTD_##T,

typedef enum {
  FXTRAN_OMPTD_NONE,
  FXTRAN_omptd_list(enum_macro)
  FXTRAN_OMPTD_LAST
} FXTRAN_omptd_type;

#undef enum_macro


/* OpenMP Target clauses; please sort in reverse alphabetic order */
#define FXTRAN_omptc_list(macro) \
  macro (WRITE            )  \
  macro (VARIANT          )  \
  macro (USES_ALLOCATORS  )  \
  macro (UPDATE           )  \
  macro (UNTIED           )  \
  macro (UNIFORM          )  \
  macro (UNIFIED_ADDRESS  )  \
  macro (UNIFIED_SHARED_MEMORY) \
  macro (TO               )  \
  macro (THREAD_LIMIT     )  \
  macro (TASK_REDUCTION   )  \
  macro (SIZES            )  \
  macro (SIMDLEN          )  \
  macro (SIMD             )  \
  macro (SHARED           )  \
  macro (SEVERITY         )  \
  macro (SCHEDULE         )  \
  macro (SAFELEN          )  \
  macro (REVERSE_OFFLOAD  )  \
  macro (RELEASE          )  \
  macro (REDUCTION        )  \
  macro (READ             )  \
  macro (PROC_BIND        )  \
  macro (PRIORITY         )  \
  macro (PRIVATE          )  \
  macro (PARTIAL          )  \
  macro (ORDERED          )  \
  macro (NUM_THREADS      )  \
  macro (NUM_TEAMS        )  \
  macro (NO_PARALLELISM   )  \
  macro (NOWAIT           )  \
  macro (NOTINBRANCH      )  \
  macro (NOGROUP          )  \
  macro (MESSAGE          )  \
  macro (MERGEABLE        )  \
  macro (MAP              )  \
  macro (LINEAR           )  \
  macro (LASTPRIVATE      )  \
  macro (IS_DEVICE_PTR    )  \
  macro (IN_REDUCTION     )  \
  macro (INDIRECT         )  \
  macro (INCLUSIVE        )  \
  macro (INBRANCH         )  \
  macro (IF               )  \
  macro (HOLDS            )  \
  macro (HINT             )  \
  macro (HAS_DEVICE_ADDR  )  \
  macro (GRAINSIZE        )  \
  macro (FULL             )  \
  macro (FROM             )  \
  macro (FIRSTPRIVATE     )  \
  macro (FINAL            )  \
  macro (FILTER           )  \
  macro (EXCLUSIVE        )  \
  macro (ENTER            )  \
  macro (DYNAMIC_ALLOCATORS)  \
  macro (DOACROSS         )  \
  macro (DIST_SCHEDULE    )  \
  macro (DEVICE_TYPE      )  \
  macro (DEVICE           )  \
  macro (DETACH           )  \
  macro (DEPEND           )  \
  macro (DEFAULTMAP       )  \
  macro (DEFAULT          )  \
  macro (COPYPRIVATE      )  \
  macro (COPYIN           )  \
  macro (COLLAPSE         )  \
  macro (CAPTURE          )  \
  macro (BIND             )  \
  macro (ACQ_REL          )  \
  macro (ATOMIC_DEFAULT_MEM_ORDER)  \
  macro (AT               )  \
  macro (ACQUIRE          )  \
  macro (ALIGNED          )  \
  macro (AFFINITY         )  





#endif
