"""
Tests OpenACC (version courte).
Transcription de perl5/t/openacc.t
"""
from conftest import parse_with_opts, xfind, xval, has, hasnt, count


def parse_acc(code):
    return parse_with_opts(code, '-openacc', '-construct-tag', '-no-include')


# ---- openacc="1" flag --------------------------------------------------------

def test_openacc_flag():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL
!$ACC END PARALLEL
END PROGRAM""")
    assert xval('/f:object/@openacc', doc) == '1'
    assert xval('/f:object/@openmp',  doc) == '0'


# ---- PARALLEL LOOP with GANG and VECTOR clauses ------------------------------

def test_parallel_loop_gang_vector():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL LOOP GANG VECTOR
DO I = 1, N
  A(I) = B(I)
END DO
!$ACC END PARALLEL LOOP
END PROGRAM""")
    has('//f:parallel-loop-openacc', doc)
    has('//f:end-parallel-loop-openacc', doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="GANG"]',   doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="VECTOR"]', doc)


# ---- PARALLEL LOOP with REDUCTION and COLLAPSE -------------------------------

def test_parallel_loop_reduction_collapse():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC PARALLEL LOOP REDUCTION(+:S) COLLAPSE(2)
END PROGRAM""")
    has('//f:parallel-loop-openacc/f:clause[f:N="REDUCTION"]', doc)
    has('//f:parallel-loop-openacc/f:clause[f:N="COLLAPSE"]',  doc)


# ---- KERNELS LOOP ------------------------------------------------------------

def test_kernels_loop():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC KERNELS LOOP
!$ACC END KERNELS LOOP
END PROGRAM""")
    has('//f:kernels-loop-openacc', doc)
    has('//f:end-kernels-loop-openacc', doc)


# ---- SERIAL LOOP -------------------------------------------------------------

def test_serial_loop():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC SERIAL LOOP
!$ACC END SERIAL LOOP
END PROGRAM""")
    has('//f:serial-loop-openacc', doc)
    has('//f:end-serial-loop-openacc', doc)


# ---- DATA with COPYIN / CREATE -----------------------------------------------

def test_data_copyin_create():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DATA COPYIN(A) CREATE(C)
!$ACC END DATA
END PROGRAM""")
    has('//f:data-openacc',     doc)
    has('//f:end-data-openacc', doc)
    has('//f:data-openacc/f:clause[f:N="COPYIN"]', doc)
    has('//f:data-openacc/f:clause[f:N="CREATE"]', doc)


# ---- ENTER DATA / EXIT DATA --------------------------------------------------

def test_enter_exit_data():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC ENTER DATA COPYIN(A)
!$ACC EXIT DATA DELETE(A)
END PROGRAM""")
    has('//f:enter-data-openacc/f:clause[f:N="COPYIN"]', doc)
    has('//f:exit-data-openacc/f:clause[f:N="DELETE"]',  doc)


# ---- DECLARE -----------------------------------------------------------------

def test_declare():
    doc = parse_acc("""\
PROGRAM MAIN
!$ACC DECLARE LINK(X)
END PROGRAM""")
    has('//f:declare-openacc/f:clause[f:N="LINK"]', doc)
