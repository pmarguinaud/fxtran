"""
Tests OpenMP Target complets.
Transcription de perl5/t/openmp_target_full.t
"""
from conftest import parse_with_opts, xfind, xval, has, hasnt, count


def parse_omt(code):
    return parse_with_opts(code, '-openmp-target', '-construct-tag', '-no-include')


# ============================================================
# Root-level flags
# ============================================================

def test_root_flags():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET
!$OMP END TARGET
END PROGRAM""")
    assert xval('/f:object/@openmp-target', doc) == '1'
    assert xval('/f:object/@openmp',        doc) == '0'
    assert xval('/f:object/@openacc',       doc) == '0'


# ============================================================
# TARGET / END TARGET -- basic structure
# ============================================================

def test_target_basic():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp',     doc)
    has('//f:end-target-openmp', doc)


# ============================================================
# TARGET -- IF and DEVICE clauses
# ============================================================

def test_target_if_device():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET IF(N>0) DEVICE(0)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="IF"]',     doc)
    has('//f:target-openmp/f:clause[f:N="DEVICE"]', doc)


# ============================================================
# TARGET -- MAP with map-type modifiers
# ============================================================

def test_target_map_types():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET MAP(to:A) MAP(from:B) MAP(tofrom:C) MAP(alloc:D)
!$OMP END TARGET
END PROGRAM""")
    count('//f:target-openmp/f:clause[f:N="MAP"]',                    doc, 4)
    has  ('//f:target-openmp/f:clause[f:N="MAP"]/f:map-T[@n="TO"]',   doc)
    has  ('//f:target-openmp/f:clause[f:N="MAP"]/f:map-T[@n="FROM"]', doc)


# ============================================================
# TARGET -- MAP without type modifier
# ============================================================

def test_target_map_no_type():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET MAP(A,B)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="MAP"]', doc)


# ============================================================
# TARGET -- PRIVATE and FIRSTPRIVATE
# ============================================================

def test_target_private():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PRIVATE(X) FIRSTPRIVATE(Y)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="PRIVATE"]',      doc)
    has('//f:target-openmp/f:clause[f:N="FIRSTPRIVATE"]', doc)


# ============================================================
# TARGET -- SHARED
# ============================================================

def test_target_shared():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET SHARED(A,B)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="SHARED"]', doc)


# ============================================================
# TARGET -- REDUCTION
# ============================================================

def test_target_reduction():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET REDUCTION(+:S)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="REDUCTION"]', doc)


# ============================================================
# TARGET -- multiple REDUCTION clauses
# ============================================================

def test_target_reduction_multiple():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET REDUCTION(MAX:A) REDUCTION(MIN:B) REDUCTION(*:C)
!$OMP END TARGET
END PROGRAM""")
    count('//f:target-openmp/f:clause[f:N="REDUCTION"]', doc, 3)


# ============================================================
# TARGET -- DEPEND(in:) and DEPEND(out:)
# ============================================================

def test_target_depend():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET DEPEND(in:A) DEPEND(out:B)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="DEPEND"]/f:depend-T[@n="IN"]',  doc)
    has('//f:target-openmp/f:clause[f:N="DEPEND"]/f:depend-T[@n="OUT"]', doc)


# ============================================================
# TARGET -- NOWAIT
# ============================================================

def test_target_nowait():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET NOWAIT
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="NOWAIT"]', doc)


# ============================================================
# TARGET -- IN_REDUCTION
# ============================================================

def test_target_in_reduction():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET IN_REDUCTION(+:S)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="IN_REDUCTION"]', doc)


# ============================================================
# TARGET -- IS_DEVICE_PTR
# ============================================================

def test_target_is_device_ptr():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET IS_DEVICE_PTR(P)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="IS_DEVICE_PTR"]', doc)


# ============================================================
# TARGET -- USES_ALLOCATORS
# ============================================================

def test_target_uses_allocators():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET USES_ALLOCATORS(A)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="USES_ALLOCATORS"]', doc)


# ============================================================
# TARGET -- DEFAULTMAP
# ============================================================

def test_target_defaultmap():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET DEFAULTMAP(tofrom:scalar)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="DEFAULTMAP"]',                             doc)
    has('//f:target-openmp/f:clause[f:N="DEFAULTMAP"]/f:defaultmap-T[@n="TOFROM"]', doc)


# ============================================================
# TARGET DATA / END TARGET DATA
# ============================================================

def test_target_data_basic():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET DATA MAP(to:A)
!$OMP END TARGET DATA
END PROGRAM""")
    has('//f:target-data-openmp',     doc)
    has('//f:end-target-data-openmp', doc)


# ============================================================
# TARGET DATA -- IF, MAP(to:), MAP(from:)
# ============================================================

def test_target_data_if_map():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET DATA IF(N>0) MAP(to:B) MAP(from:A)
!$OMP END TARGET DATA
END PROGRAM""")
    has('//f:target-data-openmp/f:clause[f:N="IF"]',                           doc)
    has('//f:target-data-openmp/f:clause[f:N="MAP"]/f:map-T[@n="TO"]',   doc)
    has('//f:target-data-openmp/f:clause[f:N="MAP"]/f:map-T[@n="FROM"]', doc)


# ============================================================
# TARGET ENTER DATA
# ============================================================

def test_target_enter_data():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET ENTER DATA MAP(to:A) IF(N>0) DEPEND(in:C) NOWAIT
END PROGRAM""")
    has('//f:target-enter-data-openmp/f:clause[f:N="MAP"]',    doc)
    has('//f:target-enter-data-openmp/f:clause[f:N="IF"]',     doc)
    has('//f:target-enter-data-openmp/f:clause[f:N="DEPEND"]', doc)
    has('//f:target-enter-data-openmp/f:clause[f:N="NOWAIT"]', doc)


# ============================================================
# TARGET EXIT DATA
# ============================================================

def test_target_exit_data():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET EXIT DATA MAP(from:B) DEPEND(out:D) NOWAIT
END PROGRAM""")
    has('//f:target-exit-data-openmp/f:clause[f:N="MAP"]',    doc)
    has('//f:target-exit-data-openmp/f:clause[f:N="DEPEND"]', doc)
    has('//f:target-exit-data-openmp/f:clause[f:N="NOWAIT"]', doc)


# ============================================================
# TARGET UPDATE
# ============================================================

def test_target_update():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET UPDATE TO(A) FROM(B) IF(N>0) DEPEND(in:C) NOWAIT
END PROGRAM""")
    has('//f:target-update-openmp',                              doc)
    has('//f:target-update-openmp/f:clause[f:N="TO"]',     doc)
    has('//f:target-update-openmp/f:clause[f:N="FROM"]',   doc)
    has('//f:target-update-openmp/f:clause[f:N="IF"]',     doc)
    has('//f:target-update-openmp/f:clause[f:N="DEPEND"]', doc)
    has('//f:target-update-openmp/f:clause[f:N="NOWAIT"]', doc)


# ============================================================
# TARGET PARALLEL / END TARGET PARALLEL
# ============================================================

def test_target_parallel_basic():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PARALLEL
!$OMP END TARGET PARALLEL
END PROGRAM""")
    has('//f:target-parallel-openmp',     doc)
    has('//f:end-target-parallel-openmp', doc)


# ============================================================
# TARGET PARALLEL -- DEFAULT clause
# ============================================================

def test_target_parallel_default():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PARALLEL DEFAULT(none)
!$OMP END TARGET PARALLEL
END PROGRAM""")
    has('//f:target-parallel-openmp/f:clause[f:N="DEFAULT"]',                    doc)
    has('//f:target-parallel-openmp/f:clause[f:N="DEFAULT"]/f:T[text()="none"]', doc)


# ============================================================
# TARGET PARALLEL -- SHARED, NUM_TEAMS, THREAD_LIMIT
# ============================================================

def test_target_parallel_shared_teams():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PARALLEL SHARED(A) NUM_TEAMS(4) THREAD_LIMIT(32)
!$OMP END TARGET PARALLEL
END PROGRAM""")
    has('//f:target-parallel-openmp/f:clause[f:N="SHARED"]',       doc)
    has('//f:target-parallel-openmp/f:clause[f:N="NUM_TEAMS"]',    doc)
    has('//f:target-parallel-openmp/f:clause[f:N="THREAD_LIMIT"]', doc)


# ============================================================
# TARGET PARALLEL DO -- DO, ORDERED, COLLAPSE
# ============================================================

def test_target_parallel_do_ordered_collapse():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PARALLEL DO ORDERED COLLAPSE(2)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET PARALLEL DO
END PROGRAM""")
    has('//f:target-parallel-openmp/f:clause[f:N="DO"]',       doc)
    has('//f:target-parallel-openmp/f:clause[f:N="ORDERED"]',  doc)
    has('//f:target-parallel-openmp/f:clause[f:N="COLLAPSE"]', doc)


# ============================================================
# TARGET PARALLEL DO -- LASTPRIVATE, SCHEDULE
# ============================================================

def test_target_parallel_do_lastprivate_schedule():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PARALLEL DO LASTPRIVATE(J) SCHEDULE(static,10)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET PARALLEL DO
END PROGRAM""")
    has('//f:target-parallel-openmp/f:clause[f:N="LASTPRIVATE"]', doc)
    has('//f:target-parallel-openmp/f:clause[f:N="SCHEDULE"]',    doc)


# ============================================================
# TARGET PARALLEL DO SIMD -- SIMD, SAFELEN, SIMDLEN
# ============================================================

def test_target_parallel_do_simd():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PARALLEL DO SIMD SAFELEN(128) SIMDLEN(4)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET PARALLEL DO SIMD
END PROGRAM""")
    has('//f:target-parallel-openmp/f:clause[f:N="SIMD"]',    doc)
    has('//f:target-parallel-openmp/f:clause[f:N="SAFELEN"]', doc)
    has('//f:target-parallel-openmp/f:clause[f:N="SIMDLEN"]', doc)


# ============================================================
# TARGET PARALLEL DO SIMD -- ALIGNED, LINEAR
# ============================================================

def test_target_parallel_do_simd_aligned_linear():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PARALLEL DO SIMD ALIGNED(A:64) LINEAR(I:1)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET PARALLEL DO SIMD
END PROGRAM""")
    has('//f:target-parallel-openmp/f:clause[f:N="ALIGNED"]', doc)
    has('//f:target-parallel-openmp/f:clause[f:N="LINEAR"]',  doc)


# ============================================================
# TARGET TEAMS / END TARGET TEAMS
# ============================================================

def test_target_teams_basic():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET TEAMS
!$OMP END TARGET TEAMS
END PROGRAM""")
    has('//f:target-teams-openmp',     doc)
    has('//f:end-target-teams-openmp', doc)


# ============================================================
# TARGET TEAMS -- NUM_TEAMS, THREAD_LIMIT
# ============================================================

def test_target_teams_num_thread():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET TEAMS NUM_TEAMS(8) THREAD_LIMIT(64)
!$OMP END TARGET TEAMS
END PROGRAM""")
    has('//f:target-teams-openmp/f:clause[f:N="NUM_TEAMS"]',    doc)
    has('//f:target-teams-openmp/f:clause[f:N="THREAD_LIMIT"]', doc)


# ============================================================
# TARGET TEAMS DISTRIBUTE
# ============================================================

def test_target_teams_distribute():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE DIST_SCHEDULE(static,4) COLLAPSE(2)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET TEAMS DISTRIBUTE
END PROGRAM""")
    has('//f:target-teams-openmp/f:clause[f:N="DISTRIBUTE"]',    doc)
    has('//f:target-teams-openmp/f:clause[f:N="DIST_SCHEDULE"]', doc)


# ============================================================
# TARGET TEAMS DISTRIBUTE PARALLEL DO
# ============================================================

def test_target_teams_distribute_parallel_do():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO COLLAPSE(3) SCHEDULE(dynamic)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO
END PROGRAM""")
    has('//f:target-teams-openmp/f:clause[f:N="PARALLEL DO"]', doc)
    has('//f:target-teams-openmp/f:clause[f:N="COLLAPSE"]',    doc)


# ============================================================
# TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
# ============================================================

def test_target_teams_distribute_parallel_do_simd():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
END PROGRAM""")
    has('//f:target-teams-openmp/f:clause[f:N="PARALLEL DO SIMD"]', doc)


# ============================================================
# DECLARE TARGET / END DECLARE TARGET
# ============================================================

def test_declare_target():
    doc = parse_omt("""\
MODULE MOD
!$OMP DECLARE TARGET
!$OMP END DECLARE TARGET
END MODULE""")
    has('//f:declare-target-openmp',     doc)
    has('//f:end-declare-target-openmp', doc)


# ============================================================
# Continuation lines
# ============================================================

def test_continuation():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET &
!$OMP & MAP(to:A) MAP(from:B)
!$OMP END TARGET
END PROGRAM""")
    has('//f:target-openmp',                                             doc)
    has('//f:target-openmp/f:clause[f:N="MAP"]/f:map-T[@n="TO"]',   doc)
    has('//f:target-openmp/f:clause[f:N="MAP"]/f:map-T[@n="FROM"]', doc)


# ============================================================
# No OpenMP Target directives
# ============================================================

def test_no_openmp_target():
    doc = parse_omt("""\
PROGRAM MAIN
  INTEGER :: I
END PROGRAM""")
    hasnt('//f:target-openmp', doc)
    hasnt('//f:broken-stmt',   doc)
