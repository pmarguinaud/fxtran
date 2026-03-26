"""
Tests OpenACC complets.
Transcription de perl5/t/openacc_full.t
"""
from conftest import parse_with_opts, xfind, xval, has, hasnt, count


def parse_acc(code):
    return parse_with_opts(code, '-openacc', '-construct-tag', '-no-include')



# ============================================================
# Root-level flags
# ============================================================

def test_root_flags():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL
!$ACC END PARALLEL
END PROGRAM""")
    assert xval('/f:object/@openacc', doc) == '1'
    assert xval('/f:object/@openmp',  doc) == '0'


# ============================================================
# PARALLEL / END PARALLEL -- basic structure
# ============================================================

def test_parallel_basic():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc',     doc)
    has('//f:end-parallel-openacc', doc)


# ============================================================
# PARALLEL -- scalar clauses
# ============================================================

def test_parallel_scalar_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL IF(N>0) ASYNC(1) WAIT(2) NUM_GANGS(4) NUM_WORKERS(32) VECTOR_LENGTH(128)
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc/f:clause[f:N="IF"]',            doc)
    has('//f:parallel-openacc/f:clause[f:N="ASYNC"]',         doc)
    has('//f:parallel-openacc/f:clause[f:N="WAIT"]',          doc)
    has('//f:parallel-openacc/f:clause[f:N="NUM_GANGS"]',     doc)
    has('//f:parallel-openacc/f:clause[f:N="NUM_WORKERS"]',   doc)
    has('//f:parallel-openacc/f:clause[f:N="VECTOR_LENGTH"]', doc)


# ============================================================
# PARALLEL -- data clauses: COPY, COPYOUT, NO_CREATE, PRESENT, ATTACH
# ============================================================

def test_parallel_data_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL COPY(A) COPYOUT(B) NO_CREATE(C) PRESENT(D) ATTACH(E)
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc/f:clause[f:N="COPY"]',      doc)
    has('//f:parallel-openacc/f:clause[f:N="COPYOUT"]',   doc)
    has('//f:parallel-openacc/f:clause[f:N="NO_CREATE"]', doc)
    has('//f:parallel-openacc/f:clause[f:N="PRESENT"]',   doc)
    has('//f:parallel-openacc/f:clause[f:N="ATTACH"]',    doc)


# ============================================================
# PARALLEL -- COPYIN / CREATE
# ============================================================

def test_parallel_copyin_create():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL COPYIN(A) CREATE(B)
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc/f:clause[f:N="COPYIN"]', doc)
    has('//f:parallel-openacc/f:clause[f:N="CREATE"]', doc)


# ============================================================
# PARALLEL -- PRIVATE, FIRSTPRIVATE, DEFAULT, SELF, REDUCTION
# ============================================================

def test_parallel_private_default_reduction():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL PRIVATE(A) FIRSTPRIVATE(B) DEFAULT(none) SELF(N>0) REDUCTION(+:S)
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc/f:clause[f:N="PRIVATE"]',      doc)
    has('//f:parallel-openacc/f:clause[f:N="FIRSTPRIVATE"]', doc)
    has('//f:parallel-openacc/f:clause[f:N="DEFAULT"]',      doc)
    has('//f:parallel-openacc/f:clause[f:N="SELF"]',         doc)
    has('//f:parallel-openacc/f:clause[f:N="REDUCTION"]',    doc)


# ============================================================
# PARALLEL -- DEFAULT_ASYNC, ASYNC without argument, SELF without argument
# ============================================================

def test_parallel_default_async_no_arg():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL DEFAULT_ASYNC(3) ASYNC SELF
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc/f:clause[f:N="DEFAULT_ASYNC"]', doc)
    has('//f:parallel-openacc/f:clause[f:N="ASYNC"]',         doc)
    has('//f:parallel-openacc/f:clause[f:N="SELF"]',          doc)


# ============================================================
# PARALLEL -- DTYPE
# ============================================================

def test_parallel_dtype():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL DTYPE(*)
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc/f:clause[f:N="DTYPE"]', doc)


# ============================================================
# PARALLEL -- REDUCTION with various operators
# ============================================================

def test_parallel_reduction_multiple():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL REDUCTION(MAX:A) REDUCTION(MIN:B) REDUCTION(*:C)
!$ACC END PARALLEL
END PROGRAM""")
    count('//f:parallel-openacc/f:clause[f:N="REDUCTION"]', doc, 3)


# ============================================================
# PARALLEL LOOP / END PARALLEL LOOP
# ============================================================

def test_parallel_loop_gang_vector():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL LOOP GANG VECTOR
DO I = 1, N
  A(I) = B(I)
END DO
!$ACC END PARALLEL LOOP
END PROGRAM""")
    has('//f:parallel-loop-openacc',                              doc)
    has('//f:end-parallel-loop-openacc',                         doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="GANG"]',        doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="VECTOR"]',      doc)


# ============================================================
# PARALLEL LOOP -- WORKER, SEQ, INDEPENDENT, AUTO, TILE, COLLAPSE, REDUCTION
# ============================================================

def test_parallel_loop_extra_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL LOOP WORKER SEQ INDEPENDENT AUTO TILE(2,4) COLLAPSE(2) REDUCTION(+:S)
!$ACC END PARALLEL LOOP
END PROGRAM""")
    has('//f:parallel-loop-openacc/f:clause[f:N="WORKER"]',      doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="SEQ"]',         doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="INDEPENDENT"]', doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="AUTO"]',        doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="TILE"]',        doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="COLLAPSE"]',    doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="REDUCTION"]',   doc)


# ============================================================
# PARALLEL LOOP -- GANG/WORKER/VECTOR with arguments
# ============================================================

def test_parallel_loop_gang_worker_vector_args():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL LOOP GANG(4) WORKER(8) VECTOR(128)
!$ACC END PARALLEL LOOP
END PROGRAM""")
    has('//f:parallel-loop-openacc/f:clause[f:N="GANG"]',   doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="WORKER"]', doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="VECTOR"]', doc)


# ============================================================
# KERNELS / END KERNELS
# ============================================================

def test_kernels_basic():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC KERNELS
!$ACC END KERNELS
END PROGRAM""")
    has('//f:kernels-openacc',     doc)
    has('//f:end-kernels-openacc', doc)


# ============================================================
# KERNELS -- IF, ASYNC, NUM_GANGS, NUM_WORKERS, VECTOR_LENGTH, DEFAULT
# ============================================================

def test_kernels_scalar_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC KERNELS IF(N>0) ASYNC(1) NUM_GANGS(8) NUM_WORKERS(64) VECTOR_LENGTH(256) DEFAULT(none)
!$ACC END KERNELS
END PROGRAM""")
    has('//f:kernels-openacc/f:clause[f:N="IF"]',            doc)
    has('//f:kernels-openacc/f:clause[f:N="ASYNC"]',         doc)
    has('//f:kernels-openacc/f:clause[f:N="NUM_GANGS"]',     doc)
    has('//f:kernels-openacc/f:clause[f:N="NUM_WORKERS"]',   doc)
    has('//f:kernels-openacc/f:clause[f:N="VECTOR_LENGTH"]', doc)
    has('//f:kernels-openacc/f:clause[f:N="DEFAULT"]',       doc)


# ============================================================
# KERNELS -- data clauses
# ============================================================

def test_kernels_data_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC KERNELS COPY(A) COPYOUT(B) CREATE(C) PRESENT(D)
!$ACC END KERNELS
END PROGRAM""")
    has('//f:kernels-openacc/f:clause[f:N="COPY"]',    doc)
    has('//f:kernels-openacc/f:clause[f:N="COPYOUT"]', doc)
    has('//f:kernels-openacc/f:clause[f:N="CREATE"]',  doc)
    has('//f:kernels-openacc/f:clause[f:N="PRESENT"]', doc)


# ============================================================
# KERNELS LOOP / END KERNELS LOOP
# ============================================================

def test_kernels_loop():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC KERNELS LOOP
!$ACC END KERNELS LOOP
END PROGRAM""")
    has('//f:kernels-loop-openacc',     doc)
    has('//f:end-kernels-loop-openacc', doc)


# ============================================================
# KERNELS LOOP -- clauses
# ============================================================

def test_kernels_loop_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC KERNELS LOOP GANG WORKER VECTOR REDUCTION(+:S) COLLAPSE(2) PRIVATE(A)
!$ACC END KERNELS LOOP
END PROGRAM""")
    has('//f:kernels-loop-openacc/f:clause[f:N="GANG"]',      doc)
    has('//f:kernels-loop-openacc/f:clause[f:N="WORKER"]',    doc)
    has('//f:kernels-loop-openacc/f:clause[f:N="VECTOR"]',    doc)
    has('//f:kernels-loop-openacc/f:clause[f:N="REDUCTION"]', doc)
    has('//f:kernels-loop-openacc/f:clause[f:N="COLLAPSE"]',  doc)
    has('//f:kernels-loop-openacc/f:clause[f:N="PRIVATE"]',   doc)


# ============================================================
# SERIAL / END SERIAL
# ============================================================

def test_serial_basic():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC SERIAL
!$ACC END SERIAL
END PROGRAM""")
    has('//f:serial-openacc',     doc)
    has('//f:end-serial-openacc', doc)


# ============================================================
# SERIAL -- IF, ASYNC, WAIT, DEFAULT, COPY, REDUCTION, PRIVATE, FIRSTPRIVATE
# ============================================================

def test_serial_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC SERIAL IF(N>0) ASYNC(1) WAIT(2) DEFAULT(none) COPY(A) REDUCTION(+:S) PRIVATE(B) FIRSTPRIVATE(C)
!$ACC END SERIAL
END PROGRAM""")
    has('//f:serial-openacc/f:clause[f:N="IF"]',           doc)
    has('//f:serial-openacc/f:clause[f:N="ASYNC"]',        doc)
    has('//f:serial-openacc/f:clause[f:N="WAIT"]',         doc)
    has('//f:serial-openacc/f:clause[f:N="DEFAULT"]',      doc)
    has('//f:serial-openacc/f:clause[f:N="COPY"]',         doc)
    has('//f:serial-openacc/f:clause[f:N="REDUCTION"]',    doc)
    has('//f:serial-openacc/f:clause[f:N="PRIVATE"]',      doc)
    has('//f:serial-openacc/f:clause[f:N="FIRSTPRIVATE"]', doc)


# ============================================================
# SERIAL -- COPYIN, COPYOUT, CREATE, NO_CREATE, PRESENT, ATTACH
# ============================================================

def test_serial_data_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC SERIAL COPYOUT(B) COPYIN(A) CREATE(C) NO_CREATE(D) PRESENT(E) ATTACH(F)
!$ACC END SERIAL
END PROGRAM""")
    has('//f:serial-openacc/f:clause[f:N="COPYIN"]',    doc)
    has('//f:serial-openacc/f:clause[f:N="COPYOUT"]',   doc)
    has('//f:serial-openacc/f:clause[f:N="CREATE"]',    doc)
    has('//f:serial-openacc/f:clause[f:N="NO_CREATE"]', doc)
    has('//f:serial-openacc/f:clause[f:N="PRESENT"]',   doc)
    has('//f:serial-openacc/f:clause[f:N="ATTACH"]',    doc)


# ============================================================
# SERIAL LOOP / END SERIAL LOOP
# ============================================================

def test_serial_loop():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC SERIAL LOOP
!$ACC END SERIAL LOOP
END PROGRAM""")
    has('//f:serial-loop-openacc',     doc)
    has('//f:end-serial-loop-openacc', doc)


# ============================================================
# SERIAL LOOP -- clauses
# ============================================================

def test_serial_loop_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC SERIAL LOOP GANG WORKER VECTOR SEQ INDEPENDENT AUTO TILE(4) COLLAPSE(2) REDUCTION(+:S)
!$ACC END SERIAL LOOP
END PROGRAM""")
    has('//f:serial-loop-openacc/f:clause[f:N="GANG"]',        doc)
    has('//f:serial-loop-openacc/f:clause[f:N="WORKER"]',      doc)
    has('//f:serial-loop-openacc/f:clause[f:N="VECTOR"]',      doc)
    has('//f:serial-loop-openacc/f:clause[f:N="SEQ"]',         doc)
    has('//f:serial-loop-openacc/f:clause[f:N="INDEPENDENT"]', doc)
    has('//f:serial-loop-openacc/f:clause[f:N="AUTO"]',        doc)
    has('//f:serial-loop-openacc/f:clause[f:N="TILE"]',        doc)
    has('//f:serial-loop-openacc/f:clause[f:N="COLLAPSE"]',    doc)
    has('//f:serial-loop-openacc/f:clause[f:N="REDUCTION"]',   doc)


# ============================================================
# LOOP directive
# ============================================================

def test_loop_directive():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC LOOP GANG WORKER VECTOR SEQ INDEPENDENT AUTO TILE(2,4) COLLAPSE(3) REDUCTION(+:S) PRIVATE(A)
END PROGRAM""")
    has('//f:loop-openacc',                                doc)
    has('//f:loop-openacc/f:clause[f:N="GANG"]',          doc)
    has('//f:loop-openacc/f:clause[f:N="WORKER"]',        doc)
    has('//f:loop-openacc/f:clause[f:N="VECTOR"]',        doc)
    has('//f:loop-openacc/f:clause[f:N="SEQ"]',           doc)
    has('//f:loop-openacc/f:clause[f:N="INDEPENDENT"]',   doc)
    has('//f:loop-openacc/f:clause[f:N="AUTO"]',          doc)
    has('//f:loop-openacc/f:clause[f:N="TILE"]',          doc)
    has('//f:loop-openacc/f:clause[f:N="COLLAPSE"]',      doc)
    has('//f:loop-openacc/f:clause[f:N="REDUCTION"]',     doc)
    has('//f:loop-openacc/f:clause[f:N="PRIVATE"]',       doc)


# ============================================================
# LOOP -- GANG/WORKER/VECTOR with named arguments
# ============================================================

def test_loop_gang_named_args():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC LOOP GANG(num:4) WORKER(num:8) VECTOR(length:128)
END PROGRAM""")
    has('//f:loop-openacc/f:clause[f:N="GANG"]',   doc)
    has('//f:loop-openacc/f:clause[f:N="WORKER"]', doc)
    has('//f:loop-openacc/f:clause[f:N="VECTOR"]', doc)


def test_loop_gang_static():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC LOOP GANG(static:*)
END PROGRAM""")
    has('//f:loop-openacc/f:clause[f:N="GANG"]', doc)


# ============================================================
# DATA / END DATA
# ============================================================

def test_data_basic():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DATA COPYIN(A) CREATE(C)
!$ACC END DATA
END PROGRAM""")
    has('//f:data-openacc',                         doc)
    has('//f:end-data-openacc',                     doc)
    has('//f:data-openacc/f:clause[f:N="COPYIN"]',  doc)
    has('//f:data-openacc/f:clause[f:N="CREATE"]',  doc)


# ============================================================
# DATA -- extra clauses
# ============================================================

def test_data_extra_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DATA COPY(A) COPYOUT(B) NO_CREATE(C) PRESENT(D) ATTACH(E) DEFAULT(none) ASYNC(1) WAIT(2)
!$ACC END DATA
END PROGRAM""")
    has('//f:data-openacc/f:clause[f:N="COPY"]',      doc)
    has('//f:data-openacc/f:clause[f:N="COPYOUT"]',   doc)
    has('//f:data-openacc/f:clause[f:N="NO_CREATE"]', doc)
    has('//f:data-openacc/f:clause[f:N="PRESENT"]',   doc)
    has('//f:data-openacc/f:clause[f:N="ATTACH"]',    doc)
    has('//f:data-openacc/f:clause[f:N="DEFAULT"]',   doc)
    has('//f:data-openacc/f:clause[f:N="ASYNC"]',     doc)
    has('//f:data-openacc/f:clause[f:N="WAIT"]',      doc)


# ============================================================
# DATA -- IF clause
# ============================================================

def test_data_if():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DATA IF(N>0) COPY(A)
!$ACC END DATA
END PROGRAM""")
    has('//f:data-openacc/f:clause[f:N="IF"]', doc)


# ============================================================
# ENTER DATA
# ============================================================

def test_enter_data():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ENTER DATA COPYIN(A)
!$ACC ENTER DATA CREATE(B) ATTACH(C) ASYNC(1) WAIT(2) IF(N>0)
END PROGRAM""")
    has('//f:enter-data-openacc[f:clause[f:N="COPYIN"]]', doc)
    has('//f:enter-data-openacc[f:clause[f:N="CREATE"]]', doc)
    has('//f:enter-data-openacc[f:clause[f:N="ATTACH"]]', doc)
    has('//f:enter-data-openacc[f:clause[f:N="ASYNC"]]',  doc)
    has('//f:enter-data-openacc[f:clause[f:N="WAIT"]]',   doc)
    has('//f:enter-data-openacc[f:clause[f:N="IF"]]',     doc)


# ============================================================
# EXIT DATA
# ============================================================

def test_exit_data():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC EXIT DATA DELETE(A)
!$ACC EXIT DATA COPYOUT(B) DETACH(C) FINALIZE ASYNC(1) WAIT(2) IF(N>0)
END PROGRAM""")
    has('//f:exit-data-openacc[f:clause[f:N="DELETE"]]',   doc)
    has('//f:exit-data-openacc[f:clause[f:N="COPYOUT"]]',  doc)
    has('//f:exit-data-openacc[f:clause[f:N="DETACH"]]',   doc)
    has('//f:exit-data-openacc[f:clause[f:N="FINALIZE"]]', doc)
    has('//f:exit-data-openacc[f:clause[f:N="ASYNC"]]',    doc)
    has('//f:exit-data-openacc[f:clause[f:N="WAIT"]]',     doc)
    has('//f:exit-data-openacc[f:clause[f:N="IF"]]',       doc)


# ============================================================
# HOST DATA / END HOST DATA
# ============================================================

def test_host_data():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC HOST_DATA USE_DEVICE(A,B) IF_PRESENT
!$ACC END HOST_DATA
END PROGRAM""")
    has('//f:host-data-openacc',                              doc)
    has('//f:end-host-data-openacc',                          doc)
    has('//f:host-data-openacc/f:clause[f:N="USE_DEVICE"]',  doc)
    has('//f:host-data-openacc/f:clause[f:N="IF_PRESENT"]',  doc)


# ============================================================
# DECLARE
# ============================================================

def test_declare_link():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DECLARE LINK(X)
END PROGRAM""")
    has('//f:declare-openacc/f:clause[f:N="LINK"]', doc)


def test_declare_data_clauses():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DECLARE COPY(A) CREATE(B) NO_CREATE(C) PRESENT(D) DEFAULT(none)
END PROGRAM""")
    has('//f:declare-openacc/f:clause[f:N="COPY"]',      doc)
    has('//f:declare-openacc/f:clause[f:N="CREATE"]',    doc)
    has('//f:declare-openacc/f:clause[f:N="NO_CREATE"]', doc)
    has('//f:declare-openacc/f:clause[f:N="PRESENT"]',   doc)
    has('//f:declare-openacc/f:clause[f:N="DEFAULT"]',   doc)


def test_declare_copyout_copyin():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DECLARE COPYOUT(A) COPYIN(B)
END PROGRAM""")
    has('//f:declare-openacc/f:clause[f:N="COPYOUT"]', doc)
    has('//f:declare-openacc/f:clause[f:N="COPYIN"]',  doc)


# ============================================================
# INIT
# ============================================================

def test_init():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC INIT
END PROGRAM""")
    has('//f:init-openacc', doc)


# ============================================================
# SHUTDOWN
# ============================================================

def test_shutdown():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC SHUTDOWN IF(N>0)
END PROGRAM""")
    has('//f:shutdown-openacc',                    doc)
    has('//f:shutdown-openacc/f:clause[f:N="IF"]', doc)


# ============================================================
# SET
# ============================================================

def test_set():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC SET DEFAULT_ASYNC(1)
!$ACC SET DTYPE(*)
END PROGRAM""")
    has('//f:set-openacc',                                doc)
    has('//f:set-openacc/f:clause[f:N="DEFAULT_ASYNC"]',  doc)
    has('//f:set-openacc/f:clause[f:N="DTYPE"]',          doc)


# ============================================================
# UPDATE
# ============================================================

def test_update():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC UPDATE SELF(A) HOST(B) DEVICE(C) IF(N>0) ASYNC(1) WAIT(2) IF_PRESENT FINALIZE
END PROGRAM""")
    has('//f:update-openacc',                              doc)
    has('//f:update-openacc/f:clause[f:N="SELF"]',         doc)
    has('//f:update-openacc/f:clause[f:N="HOST"]',         doc)
    has('//f:update-openacc/f:clause[f:N="DEVICE"]',       doc)
    has('//f:update-openacc/f:clause[f:N="IF"]',           doc)
    has('//f:update-openacc/f:clause[f:N="ASYNC"]',        doc)
    has('//f:update-openacc/f:clause[f:N="WAIT"]',         doc)
    has('//f:update-openacc/f:clause[f:N="IF_PRESENT"]',   doc)
    has('//f:update-openacc/f:clause[f:N="FINALIZE"]',     doc)


# ============================================================
# WAIT directive
# ============================================================

def test_wait_bare():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC WAIT
END PROGRAM""")
    has('//f:wait-openacc', doc)


def test_wait_with_args():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC WAIT (1, 2, 3)
END PROGRAM""")
    has('//f:wait-openacc', doc)


# ============================================================
# ATOMIC
# ============================================================

def test_atomic_read():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ATOMIC READ
A = B
!$ACC END ATOMIC
END PROGRAM""")
    has('//f:atomic-openacc',     doc)
    has('//f:end-atomic-openacc', doc)


def test_atomic_write():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ATOMIC WRITE
A = 1
!$ACC END ATOMIC
END PROGRAM""")
    has('//f:atomic-openacc', doc)


def test_atomic_update():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ATOMIC UPDATE
A = A + 1
!$ACC END ATOMIC
END PROGRAM""")
    has('//f:atomic-openacc', doc)


def test_atomic_capture():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ATOMIC CAPTURE
V = A
A = A + 1
!$ACC END ATOMIC
END PROGRAM""")
    has('//f:atomic-openacc', doc)


# ============================================================
# CACHE
# ============================================================

def test_cache_simple():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC CACHE (A, B)
END PROGRAM""")
    has('//f:cache-openacc', doc)


def test_cache_slice():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC CACHE (A(1:N))
END PROGRAM""")
    has('//f:cache-openacc', doc)


# ============================================================
# ROUTINE
# ============================================================

def test_routine_parallelism():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ROUTINE GANG
!$ACC ROUTINE WORKER
!$ACC ROUTINE VECTOR
!$ACC ROUTINE SEQ
END PROGRAM""")
    has('//f:routine-openacc[f:clause[f:N="GANG"]]',   doc)
    has('//f:routine-openacc[f:clause[f:N="WORKER"]]', doc)
    has('//f:routine-openacc[f:clause[f:N="VECTOR"]]', doc)
    has('//f:routine-openacc[f:clause[f:N="SEQ"]]',    doc)


def test_routine_nohost_bind_dtype():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ROUTINE NOHOST GANG
!$ACC ROUTINE BIND("myfunc") SEQ
!$ACC ROUTINE DTYPE(*) GANG
END PROGRAM""")
    has('//f:routine-openacc[f:clause[f:N="NOHOST"]]', doc)
    has('//f:routine-openacc[f:clause[f:N="BIND"]]',   doc)
    has('//f:routine-openacc[f:clause[f:N="DTYPE"]]',  doc)


def test_routine_with_name():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ROUTINE (mysub) GANG
END PROGRAM""")
    has('//f:routine-openacc',                      doc)
    has('//f:routine-openacc/f:clause[f:N="GANG"]', doc)


# ============================================================
# Continuation lines
# ============================================================

def test_continuation():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL &
!$ACC & NUM_GANGS(4) NUM_WORKERS(16) VECTOR_LENGTH(128)
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc',                                doc)
    has('//f:parallel-openacc/f:clause[f:N="NUM_GANGS"]',      doc)
    has('//f:parallel-openacc/f:clause[f:N="NUM_WORKERS"]',    doc)
    has('//f:parallel-openacc/f:clause[f:N="VECTOR_LENGTH"]',  doc)


# ============================================================
# Mixed OpenACC + regular Fortran
# ============================================================

def test_mixed_fortran_openacc():
    doc = parse_acc("""\
PROGRAM MAIN
  INTEGER :: I, N, S
  REAL :: A(100), B(100)
  N = 100
  S = 0
!$ACC PARALLEL LOOP REDUCTION(+:S)
  DO I = 1, N
    S = S + A(I)
  END DO
!$ACC END PARALLEL LOOP
END PROGRAM""")
    has('//f:parallel-loop-openacc/f:clause[f:N="REDUCTION"]', doc)
    hasnt('//f:broken-stmt', doc)


# ============================================================
# No ACC directives
# ============================================================

def test_no_acc_directives():
    doc = parse_acc("""\
PROGRAM MAIN
  INTEGER :: I
END PROGRAM""")
    hasnt('//f:parallel-openacc', doc)
    hasnt('//f:kernels-openacc',  doc)
    hasnt('//f:broken-stmt',      doc)


def test_device_num():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC INIT DEVICE_NUM(0)
END PROGRAM""")
    has('//f:init-openacc/f:clause[f:N="DEVICE_NUM"]', doc)


def test_device_type():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC INIT DEVICE_TYPE(nvidia)
END PROGRAM""")
    has('//f:init-openacc/f:clause[f:N="DEVICE_TYPE"]', doc)


def test_device_resident():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DECLARE DEVICE_RESIDENT(A)
END PROGRAM""")
    has('//f:declare-openacc/f:clause[f:N="DEVICE_RESIDENT"]', doc)


def test_deviceptr():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL DEVICEPTR(A)
!$ACC END PARALLEL
END PROGRAM""")
    has('//f:parallel-openacc/f:clause[f:N="DEVICEPTR"]', doc)


def test_copyin_copyout():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DATA COPYIN(A) COPYOUT(B)
!$ACC END DATA
END PROGRAM""")
    has('//f:data-openacc/f:clause[f:N="COPYIN"]',  doc)
    has('//f:data-openacc/f:clause[f:N="COPYOUT"]', doc)
