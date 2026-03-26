"""
Tests OpenMP Target (version courte).
Transcription de perl5/t/openmp_target.t
"""
from conftest import parse_with_opts, xfind, xval, has, hasnt, count


def parse_omt(code):
    return parse_with_opts(code, '-openmp-target', '-construct-tag', '-no-include')


# ---- openmp-target="1" flag --------------------------------------------------

def test_openmp_target_flag():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET
!$OMP END TARGET
END PROGRAM""")
    assert xval('/f:object/@openmp-target', doc) == '1'
    assert xval('/f:object/@openmp',        doc) == '0'
    assert xval('/f:object/@openacc',       doc) == '0'


# ---- !$OMP sentinel tag ------------------------------------------------------

def test_omptarget_sentinel():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET
!$OMP END TARGET
END PROGRAM""")
    has  ('//f:omptarget', doc)
    count('//f:omptarget', doc, 2)


# ---- TARGET DATA with MAP clauses --------------------------------------------

def test_target_data_map():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET DATA MAP(to:B) MAP(from:A)
!$OMP END TARGET DATA
END PROGRAM""")
    has  ('//f:target-data-openmp',                          doc)
    has  ('//f:end-target-data-openmp',                      doc)
    count('//f:target-data-openmp/f:clause[f:N="MAP"]', doc, 2)


# ---- TARGET TEAMS with DISTRIBUTE and PARALLEL DO clauses -------------------

def test_target_teams_distribute_parallel_do():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO PRIVATE(I)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO
END PROGRAM""")
    has  ('//f:target-teams-openmp',                                     doc)
    has  ('//f:target-teams-openmp/f:clause[f:N="DISTRIBUTE"]',          doc)
    has  ('//f:target-teams-openmp/f:clause[f:N="PARALLEL DO"]',         doc)
    has  ('//f:target-teams-openmp/f:clause[f:N="PRIVATE"]',             doc)
    has  ('//f:end-target-teams-openmp/f:clause[f:N="DISTRIBUTE"]',      doc)
    has  ('//f:end-target-teams-openmp/f:clause[f:N="PARALLEL DO"]',     doc)
    hasnt('//f:target-teams-distribute-parallel-do-openmp',              doc)


# ---- TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD --------------------------------

def test_target_teams_distribute_parallel_do_simd():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
!$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
END PROGRAM""")
    has('//f:target-teams-openmp/f:clause[f:N="DISTRIBUTE"]',           doc)
    has('//f:target-teams-openmp/f:clause[f:N="PARALLEL DO SIMD"]',     doc)
    has('//f:end-target-teams-openmp/f:clause[f:N="PARALLEL DO SIMD"]', doc)


# ---- TARGET PARALLEL DO SIMD with REDUCTION ----------------------------------

def test_target_parallel_do_simd_reduction():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET PARALLEL DO SIMD REDUCTION(+:S)
DO I = 1, N
  S = S + A(I)
END DO
!$OMP END TARGET PARALLEL DO SIMD
END PROGRAM""")
    has('//f:target-parallel-openmp',                          doc)
    has('//f:target-parallel-openmp/f:clause[f:N="DO"]',       doc)
    has('//f:target-parallel-openmp/f:clause[f:N="SIMD"]',     doc)
    has('//f:target-parallel-openmp/f:clause[f:N="REDUCTION"]',doc)
    has('//f:end-target-parallel-openmp/f:clause[f:N="DO"]',   doc)
    has('//f:end-target-parallel-openmp/f:clause[f:N="SIMD"]', doc)


# ---- TARGET TEAMS LOOP -------------------------------------------------------

def test_target_teams_loop():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET TEAMS LOOP COLLAPSE(2)
!$OMP END TARGET TEAMS LOOP
END PROGRAM""")
    has('//f:target-teams-openmp/f:clause[f:N="LOOP"]',     doc)
    has('//f:target-teams-openmp/f:clause[f:N="COLLAPSE"]', doc)
    has('//f:end-target-teams-openmp/f:clause[f:N="LOOP"]', doc)


# ---- TARGET SIMD -------------------------------------------------------------

def test_target_simd():
    doc = parse_omt("""\
PROGRAM MAIN
!$OMP TARGET SIMD
!$OMP END TARGET SIMD
END PROGRAM""")
    has('//f:target-openmp/f:clause[f:N="SIMD"]',     doc)
    has('//f:end-target-openmp/f:clause[f:N="SIMD"]', doc)


# ---- DECLARE TARGET / END DECLARE TARGET -------------------------------------

def test_declare_target():
    doc = parse_omt("""\
MODULE MOD
!$OMP DECLARE TARGET
!$OMP END DECLARE TARGET
END MODULE""")
    has('//f:declare-target-openmp',     doc)
    has('//f:end-declare-target-openmp', doc)
