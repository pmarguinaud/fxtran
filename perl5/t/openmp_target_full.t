use strict;
use warnings;
use FindBin qw ($Bin);
use Test::More tests => 77;

BEGIN { use_ok ('fxtran') }
BEGIN { use_ok ('fxtran::xpath') }

use XML::LibXML;

$ENV{PATH} = "$Bin/../../bin:$ENV{PATH}";

my $xpc = 'XML::LibXML::XPathContext'->new ();
$xpc->registerNs ('f' => 'http://fxtran.net/#syntax');

sub parse_omt
{
  my $code = shift;
  chomp $code;
  my $xml = eval { &fxtran::run ('-openmp-target', '-construct-tag', '-no-include', $code) };
  $@ && die $@;
  return 'XML::LibXML'->load_xml (string => $xml);
}

sub xfind { return () unless defined $_[1]; my @n = $xpc->findnodes ($_[0], $_[1]); return @n }
sub has    { my @r = xfind (@_); ok (@r > 0,  "found: $_[0]") }
sub hasnt  { my @r = xfind (@_); ok (@r == 0, "absent: $_[0]") }
sub count  { is (scalar (xfind ($_[0], $_[1])), $_[2], "count $_[2]: $_[0]") }

# ============================================================
# Root-level flags
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET
!$OMP END TARGET
END PROGRAM
SRC
  is ($xpc->findvalue ('/f:object/@openmp-target', $doc), '1', 'openmp-target="1" on root element');
  is ($xpc->findvalue ('/f:object/@openmp',        $doc), '0', 'openmp="0" when only openmp-target');
  is ($xpc->findvalue ('/f:object/@openacc',       $doc), '0', 'openacc="0" when only openmp-target');
}

# ============================================================
# TARGET / END TARGET -- basic structure
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp',     $doc);
  has ('//f:end-target-openmp', $doc);
}

# ============================================================
# TARGET -- IF and DEVICE clauses
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET IF(N>0) DEVICE(0)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="IF"]',     $doc);
  has ('//f:target-openmp/f:clause[f:N="DEVICE"]', $doc);
}

# ============================================================
# TARGET -- MAP with map-type modifiers (to, from, tofrom, alloc)
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET MAP(to:A) MAP(from:B) MAP(tofrom:C) MAP(alloc:D)
!$OMP END TARGET
END PROGRAM
SRC
  count ('//f:target-openmp/f:clause[f:N="MAP"]',             $doc, 4);
  has   ('//f:target-openmp/f:clause[f:N="MAP"]/f:map-T[@n="TO"]',   $doc);
  has   ('//f:target-openmp/f:clause[f:N="MAP"]/f:map-T[@n="FROM"]', $doc);
}

# ============================================================
# TARGET -- MAP without type modifier
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET MAP(A,B)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="MAP"]', $doc);
}

# ============================================================
# TARGET -- PRIVATE and FIRSTPRIVATE
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PRIVATE(X) FIRSTPRIVATE(Y)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="PRIVATE"]',      $doc);
  has ('//f:target-openmp/f:clause[f:N="FIRSTPRIVATE"]', $doc);
}

# ============================================================
# TARGET -- SHARED
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET SHARED(A,B)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="SHARED"]', $doc);
}

# ============================================================
# TARGET -- REDUCTION with arithmetic operator
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET REDUCTION(+:S)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="REDUCTION"]', $doc);
}

# ============================================================
# TARGET -- multiple REDUCTION clauses including intrinsic names
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET REDUCTION(MAX:A) REDUCTION(MIN:B) REDUCTION(*:C)
!$OMP END TARGET
END PROGRAM
SRC
  count ('//f:target-openmp/f:clause[f:N="REDUCTION"]', $doc, 3);
}

# ============================================================
# TARGET -- DEPEND(in:) and DEPEND(out:)
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET DEPEND(in:A) DEPEND(out:B)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="DEPEND"]/f:depend-T[@n="IN"]',  $doc);
  has ('//f:target-openmp/f:clause[f:N="DEPEND"]/f:depend-T[@n="OUT"]', $doc);
}

# ============================================================
# TARGET -- NOWAIT
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET NOWAIT
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="NOWAIT"]', $doc);
}

# ============================================================
# TARGET -- IN_REDUCTION
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET IN_REDUCTION(+:S)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="IN_REDUCTION"]', $doc);
}

# ============================================================
# TARGET -- IS_DEVICE_PTR
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET IS_DEVICE_PTR(P)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="IS_DEVICE_PTR"]', $doc);
}

# ============================================================
# TARGET -- USES_ALLOCATORS
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET USES_ALLOCATORS(A)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="USES_ALLOCATORS"]', $doc);
}

# ============================================================
# TARGET -- DEFAULTMAP(tofrom:scalar)
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET DEFAULTMAP(tofrom:scalar)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="DEFAULTMAP"]',                          $doc);
  has ('//f:target-openmp/f:clause[f:N="DEFAULTMAP"]/f:defaultmap-T[@n="TOFROM"]', $doc);
}

# ============================================================
# TARGET DATA / END TARGET DATA -- basic structure
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET DATA MAP(to:A)
!$OMP END TARGET DATA
END PROGRAM
SRC
  has ('//f:target-data-openmp',     $doc);
  has ('//f:end-target-data-openmp', $doc);
}

# ============================================================
# TARGET DATA -- IF, MAP(to:), MAP(from:)
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET DATA IF(N>0) MAP(to:B) MAP(from:A)
!$OMP END TARGET DATA
END PROGRAM
SRC
  has ('//f:target-data-openmp/f:clause[f:N="IF"]',                             $doc);
  has ('//f:target-data-openmp/f:clause[f:N="MAP"]/f:map-T[@n="TO"]',   $doc);
  has ('//f:target-data-openmp/f:clause[f:N="MAP"]/f:map-T[@n="FROM"]', $doc);
}

# ============================================================
# TARGET ENTER DATA -- MAP, IF, DEPEND, NOWAIT
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET ENTER DATA MAP(to:A) IF(N>0) DEPEND(in:C) NOWAIT
END PROGRAM
SRC
  has ('//f:target-enter-data-openmp/f:clause[f:N="MAP"]',    $doc);
  has ('//f:target-enter-data-openmp/f:clause[f:N="IF"]',     $doc);
  has ('//f:target-enter-data-openmp/f:clause[f:N="DEPEND"]', $doc);
  has ('//f:target-enter-data-openmp/f:clause[f:N="NOWAIT"]', $doc);
}

# ============================================================
# TARGET EXIT DATA -- MAP, DEPEND, NOWAIT
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET EXIT DATA MAP(from:B) DEPEND(out:D) NOWAIT
END PROGRAM
SRC
  has ('//f:target-exit-data-openmp/f:clause[f:N="MAP"]',    $doc);
  has ('//f:target-exit-data-openmp/f:clause[f:N="DEPEND"]', $doc);
  has ('//f:target-exit-data-openmp/f:clause[f:N="NOWAIT"]', $doc);
}

# ============================================================
# TARGET UPDATE -- TO, FROM, IF, DEPEND, NOWAIT
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET UPDATE TO(A) FROM(B) IF(N>0) DEPEND(in:C) NOWAIT
END PROGRAM
SRC
  has ('//f:target-update-openmp',                              $doc);
  has ('//f:target-update-openmp/f:clause[f:N="TO"]',     $doc);
  has ('//f:target-update-openmp/f:clause[f:N="FROM"]',   $doc);
  has ('//f:target-update-openmp/f:clause[f:N="IF"]',     $doc);
  has ('//f:target-update-openmp/f:clause[f:N="DEPEND"]', $doc);
  has ('//f:target-update-openmp/f:clause[f:N="NOWAIT"]', $doc);
}

# ============================================================
# TARGET PARALLEL / END TARGET PARALLEL -- basic structure
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PARALLEL
!$OMP END TARGET PARALLEL
END PROGRAM
SRC
  has ('//f:target-parallel-openmp',     $doc);
  has ('//f:end-target-parallel-openmp', $doc);
}

# ============================================================
# TARGET PARALLEL -- DEFAULT clause with type value
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PARALLEL DEFAULT(none)
!$OMP END TARGET PARALLEL
END PROGRAM
SRC
  has ('//f:target-parallel-openmp/f:clause[f:N="DEFAULT"]',               $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="DEFAULT"]/f:T[text()="none"]', $doc);
}

# ============================================================
# TARGET PARALLEL -- SHARED, NUM_TEAMS, THREAD_LIMIT
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PARALLEL SHARED(A) NUM_TEAMS(4) THREAD_LIMIT(32)
!$OMP END TARGET PARALLEL
END PROGRAM
SRC
  has ('//f:target-parallel-openmp/f:clause[f:N="SHARED"]',       $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="NUM_TEAMS"]',    $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="THREAD_LIMIT"]', $doc);
}

# ============================================================
# TARGET PARALLEL DO -- DO, ORDERED, COLLAPSE
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PARALLEL DO ORDERED COLLAPSE(2)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET PARALLEL DO
END PROGRAM
SRC
  has ('//f:target-parallel-openmp/f:clause[f:N="DO"]',       $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="ORDERED"]',  $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="COLLAPSE"]', $doc);
}

# ============================================================
# TARGET PARALLEL DO -- LASTPRIVATE, SCHEDULE
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PARALLEL DO LASTPRIVATE(J) SCHEDULE(static,10)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET PARALLEL DO
END PROGRAM
SRC
  has ('//f:target-parallel-openmp/f:clause[f:N="LASTPRIVATE"]', $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="SCHEDULE"]',    $doc);
}

# ============================================================
# TARGET PARALLEL DO SIMD -- SIMD, SAFELEN, SIMDLEN
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PARALLEL DO SIMD SAFELEN(128) SIMDLEN(4)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET PARALLEL DO SIMD
END PROGRAM
SRC
  has ('//f:target-parallel-openmp/f:clause[f:N="SIMD"]',    $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="SAFELEN"]', $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="SIMDLEN"]', $doc);
}

# ============================================================
# TARGET PARALLEL DO SIMD -- ALIGNED, LINEAR
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PARALLEL DO SIMD ALIGNED(A:64) LINEAR(I:1)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET PARALLEL DO SIMD
END PROGRAM
SRC
  has ('//f:target-parallel-openmp/f:clause[f:N="ALIGNED"]', $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="LINEAR"]',  $doc);
}

# ============================================================
# TARGET TEAMS / END TARGET TEAMS -- basic structure
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET TEAMS
!$OMP END TARGET TEAMS
END PROGRAM
SRC
  has ('//f:target-teams-openmp',     $doc);
  has ('//f:end-target-teams-openmp', $doc);
}

# ============================================================
# TARGET TEAMS -- NUM_TEAMS, THREAD_LIMIT
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET TEAMS NUM_TEAMS(8) THREAD_LIMIT(64)
!$OMP END TARGET TEAMS
END PROGRAM
SRC
  has ('//f:target-teams-openmp/f:clause[f:N="NUM_TEAMS"]',    $doc);
  has ('//f:target-teams-openmp/f:clause[f:N="THREAD_LIMIT"]', $doc);
}

# ============================================================
# TARGET TEAMS DISTRIBUTE -- DISTRIBUTE, DIST_SCHEDULE
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE DIST_SCHEDULE(static,4) COLLAPSE(2)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET TEAMS DISTRIBUTE
END PROGRAM
SRC
  has ('//f:target-teams-openmp/f:clause[f:N="DISTRIBUTE"]',    $doc);
  has ('//f:target-teams-openmp/f:clause[f:N="DIST_SCHEDULE"]', $doc);
}

# ============================================================
# TARGET TEAMS DISTRIBUTE PARALLEL DO -- PARALLEL DO, COLLAPSE
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO COLLAPSE(3) SCHEDULE(dynamic)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO
END PROGRAM
SRC
  has ('//f:target-teams-openmp/f:clause[f:N="PARALLEL DO"]', $doc);
  has ('//f:target-teams-openmp/f:clause[f:N="COLLAPSE"]',    $doc);
}

# ============================================================
# TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD -- PARALLEL DO SIMD
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
END PROGRAM
SRC
  has ('//f:target-teams-openmp/f:clause[f:N="PARALLEL DO SIMD"]', $doc);
}

# ============================================================
# DECLARE TARGET / END DECLARE TARGET
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
MODULE MOD
!$OMP DECLARE TARGET
!$OMP END DECLARE TARGET
END MODULE
SRC
  has ('//f:declare-target-openmp',     $doc);
  has ('//f:end-declare-target-openmp', $doc);
}

# ============================================================
# Continuation lines (&) in TARGET directives
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET &
!$OMP & MAP(to:A) MAP(from:B)
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:target-openmp',                                             $doc);
  has ('//f:target-openmp/f:clause[f:N="MAP"]/f:map-T[@n="TO"]',   $doc);
  has ('//f:target-openmp/f:clause[f:N="MAP"]/f:map-T[@n="FROM"]', $doc);
}

# ============================================================
# No OpenMP Target directives -- no omptarget elements present
# ============================================================

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
  INTEGER :: I
END PROGRAM
SRC
  hasnt ('//f:target-openmp',  $doc);
  hasnt ('//f:broken-stmt',    $doc);
}
