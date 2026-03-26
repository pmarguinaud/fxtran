use strict;
use warnings;
use FindBin qw ($Bin);
use Test::More tests => 191;

BEGIN { use_ok ('fxtran') }
BEGIN { use_ok ('fxtran::xpath') }

use XML::LibXML;

$ENV{PATH} = "$Bin/../../bin:$ENV{PATH}";

my $xpc = 'XML::LibXML::XPathContext'->new ();
$xpc->registerNs ('f' => 'http://fxtran.net/#syntax');

sub parse_acc
{
  my $code = shift;
  chomp $code;
  my $xml = eval { &fxtran::run ('-openacc', '-construct-tag', '-no-include', $code) };
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
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL
!$ACC END PARALLEL
END PROGRAM
SRC
  is ($xpc->findvalue ('/f:object/@openacc',  $doc), '1', 'openacc="1" on root element');
  is ($xpc->findvalue ('/f:object/@openmp',   $doc), '0', 'openmp="0" when only openacc');
}

# ============================================================
# PARALLEL / END PARALLEL -- basic structure
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc',     $doc);
  has ('//f:end-parallel-openacc', $doc);
}

# ============================================================
# PARALLEL -- scalar clauses: IF, ASYNC, WAIT, NUM_GANGS, NUM_WORKERS, VECTOR_LENGTH
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL IF(N>0) ASYNC(1) WAIT(2) NUM_GANGS(4) NUM_WORKERS(32) VECTOR_LENGTH(128)
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc/f:clause[f:N="IF"]',            $doc);
  has ('//f:parallel-openacc/f:clause[f:N="ASYNC"]',         $doc);
  has ('//f:parallel-openacc/f:clause[f:N="WAIT"]',          $doc);
  has ('//f:parallel-openacc/f:clause[f:N="NUM_GANGS"]',     $doc);
  has ('//f:parallel-openacc/f:clause[f:N="NUM_WORKERS"]',   $doc);
  has ('//f:parallel-openacc/f:clause[f:N="VECTOR_LENGTH"]', $doc);
}

# ============================================================
# PARALLEL -- data clauses: COPY, COPYOUT, NO_CREATE, PRESENT, ATTACH
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL COPY(A) COPYOUT(B) NO_CREATE(C) PRESENT(D) ATTACH(E)
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc/f:clause[f:N="COPY"]',      $doc);
  has ('//f:parallel-openacc/f:clause[f:N="COPYOUT"]',   $doc);
  has ('//f:parallel-openacc/f:clause[f:N="NO_CREATE"]', $doc);
  has ('//f:parallel-openacc/f:clause[f:N="PRESENT"]',   $doc);
  has ('//f:parallel-openacc/f:clause[f:N="ATTACH"]',    $doc);
}

# ============================================================
# PARALLEL -- COPYIN (separate; must not follow COPYOUT in same directive)
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL COPYIN(A) CREATE(B)
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc/f:clause[f:N="COPYIN"]',  $doc);
  has ('//f:parallel-openacc/f:clause[f:N="CREATE"]',  $doc);
}

# ============================================================
# PARALLEL -- PRIVATE, FIRSTPRIVATE, DEFAULT, SELF, REDUCTION
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL PRIVATE(A) FIRSTPRIVATE(B) DEFAULT(none) SELF(N>0) REDUCTION(+:S)
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc/f:clause[f:N="PRIVATE"]',      $doc);
  has ('//f:parallel-openacc/f:clause[f:N="FIRSTPRIVATE"]', $doc);
  has ('//f:parallel-openacc/f:clause[f:N="DEFAULT"]',      $doc);
  has ('//f:parallel-openacc/f:clause[f:N="SELF"]',         $doc);
  has ('//f:parallel-openacc/f:clause[f:N="REDUCTION"]',    $doc);
}

# ============================================================
# PARALLEL -- DEFAULT_ASYNC, ASYNC without argument, SELF without argument
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL DEFAULT_ASYNC(3) ASYNC SELF
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc/f:clause[f:N="DEFAULT_ASYNC"]', $doc);
  has ('//f:parallel-openacc/f:clause[f:N="ASYNC"]',         $doc);
  has ('//f:parallel-openacc/f:clause[f:N="SELF"]',          $doc);
}

# ============================================================
# PARALLEL -- DTYPE (device-type alias)
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL DTYPE(*)
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc/f:clause[f:N="DTYPE"]', $doc);
}

# ============================================================
# PARALLEL -- REDUCTION with various operators
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL REDUCTION(MAX:A) REDUCTION(MIN:B) REDUCTION(*:C)
!$ACC END PARALLEL
END PROGRAM
SRC
  count ('//f:parallel-openacc/f:clause[f:N="REDUCTION"]', $doc, 3);
}

# ============================================================
# PARALLEL LOOP / END PARALLEL LOOP
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL LOOP GANG VECTOR
DO I = 1, N
  A(I) = B(I)
END DO
!$ACC END PARALLEL LOOP
END PROGRAM
SRC
  has ('//f:parallel-loop-openacc',                              $doc);
  has ('//f:end-parallel-loop-openacc',                         $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="GANG"]',        $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="VECTOR"]',      $doc);
}

# ============================================================
# PARALLEL LOOP -- WORKER, SEQ, INDEPENDENT, AUTO, TILE, COLLAPSE, REDUCTION
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL LOOP WORKER SEQ INDEPENDENT AUTO TILE(2,4) COLLAPSE(2) REDUCTION(+:S)
!$ACC END PARALLEL LOOP
END PROGRAM
SRC
  has ('//f:parallel-loop-openacc/f:clause[f:N="WORKER"]',      $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="SEQ"]',         $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="INDEPENDENT"]', $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="AUTO"]',        $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="TILE"]',        $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="COLLAPSE"]',    $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="REDUCTION"]',   $doc);
}

# ============================================================
# PARALLEL LOOP -- GANG with argument, VECTOR with argument, WORKER with argument
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL LOOP GANG(4) WORKER(8) VECTOR(128)
!$ACC END PARALLEL LOOP
END PROGRAM
SRC
  has ('//f:parallel-loop-openacc/f:clause[f:N="GANG"]',   $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="WORKER"]', $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="VECTOR"]', $doc);
}

# ============================================================
# KERNELS / END KERNELS
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC KERNELS
!$ACC END KERNELS
END PROGRAM
SRC
  has ('//f:kernels-openacc',     $doc);
  has ('//f:end-kernels-openacc', $doc);
}

# ============================================================
# KERNELS -- IF, ASYNC, NUM_GANGS, NUM_WORKERS, VECTOR_LENGTH, DEFAULT
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC KERNELS IF(N>0) ASYNC(1) NUM_GANGS(8) NUM_WORKERS(64) VECTOR_LENGTH(256) DEFAULT(none)
!$ACC END KERNELS
END PROGRAM
SRC
  has ('//f:kernels-openacc/f:clause[f:N="IF"]',            $doc);
  has ('//f:kernels-openacc/f:clause[f:N="ASYNC"]',         $doc);
  has ('//f:kernels-openacc/f:clause[f:N="NUM_GANGS"]',     $doc);
  has ('//f:kernels-openacc/f:clause[f:N="NUM_WORKERS"]',   $doc);
  has ('//f:kernels-openacc/f:clause[f:N="VECTOR_LENGTH"]', $doc);
  has ('//f:kernels-openacc/f:clause[f:N="DEFAULT"]',       $doc);
}

# ============================================================
# KERNELS -- data clauses: COPY, COPYOUT, CREATE, PRESENT, COPYIN
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC KERNELS COPY(A) COPYOUT(B) CREATE(C) PRESENT(D)
!$ACC END KERNELS
END PROGRAM
SRC
  has ('//f:kernels-openacc/f:clause[f:N="COPY"]',    $doc);
  has ('//f:kernels-openacc/f:clause[f:N="COPYOUT"]', $doc);
  has ('//f:kernels-openacc/f:clause[f:N="CREATE"]',  $doc);
  has ('//f:kernels-openacc/f:clause[f:N="PRESENT"]', $doc);
}

# ============================================================
# KERNELS LOOP / END KERNELS LOOP
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC KERNELS LOOP
!$ACC END KERNELS LOOP
END PROGRAM
SRC
  has ('//f:kernels-loop-openacc',     $doc);
  has ('//f:end-kernels-loop-openacc', $doc);
}

# ============================================================
# KERNELS LOOP -- GANG, WORKER, VECTOR, REDUCTION, COLLAPSE, PRIVATE
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC KERNELS LOOP GANG WORKER VECTOR REDUCTION(+:S) COLLAPSE(2) PRIVATE(A)
!$ACC END KERNELS LOOP
END PROGRAM
SRC
  has ('//f:kernels-loop-openacc/f:clause[f:N="GANG"]',      $doc);
  has ('//f:kernels-loop-openacc/f:clause[f:N="WORKER"]',    $doc);
  has ('//f:kernels-loop-openacc/f:clause[f:N="VECTOR"]',    $doc);
  has ('//f:kernels-loop-openacc/f:clause[f:N="REDUCTION"]', $doc);
  has ('//f:kernels-loop-openacc/f:clause[f:N="COLLAPSE"]',  $doc);
  has ('//f:kernels-loop-openacc/f:clause[f:N="PRIVATE"]',   $doc);
}

# ============================================================
# SERIAL / END SERIAL
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC SERIAL
!$ACC END SERIAL
END PROGRAM
SRC
  has ('//f:serial-openacc',     $doc);
  has ('//f:end-serial-openacc', $doc);
}

# ============================================================
# SERIAL -- IF, ASYNC, WAIT, DEFAULT, COPY, REDUCTION, PRIVATE, FIRSTPRIVATE
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC SERIAL IF(N>0) ASYNC(1) WAIT(2) DEFAULT(none) COPY(A) REDUCTION(+:S) PRIVATE(B) FIRSTPRIVATE(C)
!$ACC END SERIAL
END PROGRAM
SRC
  has ('//f:serial-openacc/f:clause[f:N="IF"]',           $doc);
  has ('//f:serial-openacc/f:clause[f:N="ASYNC"]',        $doc);
  has ('//f:serial-openacc/f:clause[f:N="WAIT"]',         $doc);
  has ('//f:serial-openacc/f:clause[f:N="DEFAULT"]',      $doc);
  has ('//f:serial-openacc/f:clause[f:N="COPY"]',         $doc);
  has ('//f:serial-openacc/f:clause[f:N="REDUCTION"]',    $doc);
  has ('//f:serial-openacc/f:clause[f:N="PRIVATE"]',      $doc);
  has ('//f:serial-openacc/f:clause[f:N="FIRSTPRIVATE"]', $doc);
}

# ============================================================
# SERIAL -- COPYIN, COPYOUT, CREATE, NO_CREATE, PRESENT, ATTACH
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC SERIAL COPYOUT(B) COPYIN(A) CREATE(C) NO_CREATE(D) PRESENT(E) ATTACH(F)
!$ACC END SERIAL
END PROGRAM
SRC
  has ('//f:serial-openacc/f:clause[f:N="COPYIN"]',   $doc);
  has ('//f:serial-openacc/f:clause[f:N="COPYOUT"]',  $doc);
  has ('//f:serial-openacc/f:clause[f:N="CREATE"]',   $doc);
  has ('//f:serial-openacc/f:clause[f:N="NO_CREATE"]', $doc);
  has ('//f:serial-openacc/f:clause[f:N="PRESENT"]',  $doc);
  has ('//f:serial-openacc/f:clause[f:N="ATTACH"]',   $doc);
}

# ============================================================
# SERIAL LOOP / END SERIAL LOOP
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC SERIAL LOOP
!$ACC END SERIAL LOOP
END PROGRAM
SRC
  has ('//f:serial-loop-openacc',     $doc);
  has ('//f:end-serial-loop-openacc', $doc);
}

# ============================================================
# SERIAL LOOP -- GANG, WORKER, VECTOR, SEQ, INDEPENDENT, AUTO, TILE, COLLAPSE, REDUCTION
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC SERIAL LOOP GANG WORKER VECTOR SEQ INDEPENDENT AUTO TILE(4) COLLAPSE(2) REDUCTION(+:S)
!$ACC END SERIAL LOOP
END PROGRAM
SRC
  has ('//f:serial-loop-openacc/f:clause[f:N="GANG"]',        $doc);
  has ('//f:serial-loop-openacc/f:clause[f:N="WORKER"]',      $doc);
  has ('//f:serial-loop-openacc/f:clause[f:N="VECTOR"]',      $doc);
  has ('//f:serial-loop-openacc/f:clause[f:N="SEQ"]',         $doc);
  has ('//f:serial-loop-openacc/f:clause[f:N="INDEPENDENT"]', $doc);
  has ('//f:serial-loop-openacc/f:clause[f:N="AUTO"]',        $doc);
  has ('//f:serial-loop-openacc/f:clause[f:N="TILE"]',        $doc);
  has ('//f:serial-loop-openacc/f:clause[f:N="COLLAPSE"]',    $doc);
  has ('//f:serial-loop-openacc/f:clause[f:N="REDUCTION"]',   $doc);
}

# ============================================================
# LOOP directive
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC LOOP GANG WORKER VECTOR SEQ INDEPENDENT AUTO TILE(2,4) COLLAPSE(3) REDUCTION(+:S) PRIVATE(A)
END PROGRAM
SRC
  has ('//f:loop-openacc',                                $doc);
  has ('//f:loop-openacc/f:clause[f:N="GANG"]',          $doc);
  has ('//f:loop-openacc/f:clause[f:N="WORKER"]',        $doc);
  has ('//f:loop-openacc/f:clause[f:N="VECTOR"]',        $doc);
  has ('//f:loop-openacc/f:clause[f:N="SEQ"]',           $doc);
  has ('//f:loop-openacc/f:clause[f:N="INDEPENDENT"]',   $doc);
  has ('//f:loop-openacc/f:clause[f:N="AUTO"]',          $doc);
  has ('//f:loop-openacc/f:clause[f:N="TILE"]',          $doc);
  has ('//f:loop-openacc/f:clause[f:N="COLLAPSE"]',      $doc);
  has ('//f:loop-openacc/f:clause[f:N="REDUCTION"]',     $doc);
  has ('//f:loop-openacc/f:clause[f:N="PRIVATE"]',       $doc);
}

# ============================================================
# LOOP -- GANG with num:, static:*; WORKER with num:; VECTOR with length:
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC LOOP GANG(num:4) WORKER(num:8) VECTOR(length:128)
END PROGRAM
SRC
  has ('//f:loop-openacc/f:clause[f:N="GANG"]',   $doc);
  has ('//f:loop-openacc/f:clause[f:N="WORKER"]', $doc);
  has ('//f:loop-openacc/f:clause[f:N="VECTOR"]', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC LOOP GANG(static:*)
END PROGRAM
SRC
  has ('//f:loop-openacc/f:clause[f:N="GANG"]', $doc);
}

# ============================================================
# DATA / END DATA
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DATA COPYIN(A) CREATE(C)
!$ACC END DATA
END PROGRAM
SRC
  has ('//f:data-openacc',                                 $doc);
  has ('//f:end-data-openacc',                             $doc);
  has ('//f:data-openacc/f:clause[f:N="COPYIN"]',         $doc);
  has ('//f:data-openacc/f:clause[f:N="CREATE"]',         $doc);
}

# ============================================================
# DATA -- COPY, COPYOUT, NO_CREATE, PRESENT, ATTACH, DEFAULT, ASYNC, WAIT
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DATA COPY(A) COPYOUT(B) NO_CREATE(C) PRESENT(D) ATTACH(E) DEFAULT(none) ASYNC(1) WAIT(2)
!$ACC END DATA
END PROGRAM
SRC
  has ('//f:data-openacc/f:clause[f:N="COPY"]',       $doc);
  has ('//f:data-openacc/f:clause[f:N="COPYOUT"]',    $doc);
  has ('//f:data-openacc/f:clause[f:N="NO_CREATE"]',  $doc);
  has ('//f:data-openacc/f:clause[f:N="PRESENT"]',    $doc);
  has ('//f:data-openacc/f:clause[f:N="ATTACH"]',     $doc);
  has ('//f:data-openacc/f:clause[f:N="DEFAULT"]',    $doc);
  has ('//f:data-openacc/f:clause[f:N="ASYNC"]',      $doc);
  has ('//f:data-openacc/f:clause[f:N="WAIT"]',       $doc);
}

# ============================================================
# DATA -- IF clause
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DATA IF(N>0) COPY(A)
!$ACC END DATA
END PROGRAM
SRC
  has ('//f:data-openacc/f:clause[f:N="IF"]', $doc);
}

# ============================================================
# ENTER DATA
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ENTER DATA COPYIN(A)
!$ACC ENTER DATA CREATE(B) ATTACH(C) ASYNC(1) WAIT(2) IF(N>0)
END PROGRAM
SRC
  has ('//f:enter-data-openacc[f:clause[f:N="COPYIN"]]',  $doc);
  has ('//f:enter-data-openacc[f:clause[f:N="CREATE"]]',  $doc);
  has ('//f:enter-data-openacc[f:clause[f:N="ATTACH"]]',  $doc);
  has ('//f:enter-data-openacc[f:clause[f:N="ASYNC"]]',   $doc);
  has ('//f:enter-data-openacc[f:clause[f:N="WAIT"]]',    $doc);
  has ('//f:enter-data-openacc[f:clause[f:N="IF"]]',      $doc);
}

# ============================================================
# EXIT DATA
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC EXIT DATA DELETE(A)
!$ACC EXIT DATA COPYOUT(B) DETACH(C) FINALIZE ASYNC(1) WAIT(2) IF(N>0)
END PROGRAM
SRC
  has ('//f:exit-data-openacc[f:clause[f:N="DELETE"]]',   $doc);
  has ('//f:exit-data-openacc[f:clause[f:N="COPYOUT"]]',  $doc);
  has ('//f:exit-data-openacc[f:clause[f:N="DETACH"]]',   $doc);
  has ('//f:exit-data-openacc[f:clause[f:N="FINALIZE"]]', $doc);
  has ('//f:exit-data-openacc[f:clause[f:N="ASYNC"]]',    $doc);
  has ('//f:exit-data-openacc[f:clause[f:N="WAIT"]]',     $doc);
  has ('//f:exit-data-openacc[f:clause[f:N="IF"]]',       $doc);
}

# ============================================================
# HOST DATA / END HOST DATA
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC HOST_DATA USE_DEVICE(A,B) IF_PRESENT
!$ACC END HOST_DATA
END PROGRAM
SRC
  has ('//f:host-data-openacc',                                $doc);
  has ('//f:end-host-data-openacc',                            $doc);
  has ('//f:host-data-openacc/f:clause[f:N="USE_DEVICE"]',     $doc);
  has ('//f:host-data-openacc/f:clause[f:N="IF_PRESENT"]',     $doc);
}

# ============================================================
# DECLARE
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DECLARE LINK(X)
END PROGRAM
SRC
  has ('//f:declare-openacc/f:clause[f:N="LINK"]', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DECLARE COPY(A) CREATE(B) NO_CREATE(C) PRESENT(D) DEFAULT(none)
END PROGRAM
SRC
  has ('//f:declare-openacc/f:clause[f:N="COPY"]',      $doc);
  has ('//f:declare-openacc/f:clause[f:N="CREATE"]',    $doc);
  has ('//f:declare-openacc/f:clause[f:N="NO_CREATE"]', $doc);
  has ('//f:declare-openacc/f:clause[f:N="PRESENT"]',   $doc);
  has ('//f:declare-openacc/f:clause[f:N="DEFAULT"]',   $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DECLARE COPYOUT(A) COPYIN(B)
END PROGRAM
SRC
  has ('//f:declare-openacc/f:clause[f:N="COPYOUT"]', $doc);
  has ('//f:declare-openacc/f:clause[f:N="COPYIN"]',  $doc);
}

# ============================================================
# INIT
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC INIT
END PROGRAM
SRC
  has ('//f:init-openacc', $doc);
}

# ============================================================
# SHUTDOWN
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC SHUTDOWN IF(N>0)
END PROGRAM
SRC
  has ('//f:shutdown-openacc',                       $doc);
  has ('//f:shutdown-openacc/f:clause[f:N="IF"]',    $doc);
}

# ============================================================
# SET -- DEFAULT_ASYNC, DTYPE
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC SET DEFAULT_ASYNC(1)
!$ACC SET DTYPE(*)
END PROGRAM
SRC
  has ('//f:set-openacc',                                      $doc);
  has ('//f:set-openacc/f:clause[f:N="DEFAULT_ASYNC"]',        $doc);
  has ('//f:set-openacc/f:clause[f:N="DTYPE"]',                $doc);
}

# ============================================================
# UPDATE -- IF, ASYNC, WAIT, SELF, HOST, DEVICE, FINALIZE, IF_PRESENT
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC UPDATE SELF(A) HOST(B) DEVICE(C) IF(N>0) ASYNC(1) WAIT(2) IF_PRESENT FINALIZE
END PROGRAM
SRC
  has ('//f:update-openacc',                                $doc);
  has ('//f:update-openacc/f:clause[f:N="SELF"]',           $doc);
  has ('//f:update-openacc/f:clause[f:N="HOST"]',           $doc);
  has ('//f:update-openacc/f:clause[f:N="DEVICE"]',         $doc);
  has ('//f:update-openacc/f:clause[f:N="IF"]',             $doc);
  has ('//f:update-openacc/f:clause[f:N="ASYNC"]',          $doc);
  has ('//f:update-openacc/f:clause[f:N="WAIT"]',           $doc);
  has ('//f:update-openacc/f:clause[f:N="IF_PRESENT"]',     $doc);
  has ('//f:update-openacc/f:clause[f:N="FINALIZE"]',       $doc);
}

# ============================================================
# WAIT directive -- standalone, with argument list
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC WAIT
END PROGRAM
SRC
  has ('//f:wait-openacc', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC WAIT (1, 2, 3)
END PROGRAM
SRC
  has ('//f:wait-openacc', $doc);
}

# ============================================================
# ATOMIC READ / WRITE / UPDATE / CAPTURE + END ATOMIC
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ATOMIC READ
A = B
!$ACC END ATOMIC
END PROGRAM
SRC
  has ('//f:atomic-openacc',     $doc);
  has ('//f:end-atomic-openacc', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ATOMIC WRITE
A = 1
!$ACC END ATOMIC
END PROGRAM
SRC
  has ('//f:atomic-openacc', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ATOMIC UPDATE
A = A + 1
!$ACC END ATOMIC
END PROGRAM
SRC
  has ('//f:atomic-openacc', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ATOMIC CAPTURE
V = A
A = A + 1
!$ACC END ATOMIC
END PROGRAM
SRC
  has ('//f:atomic-openacc', $doc);
}

# ============================================================
# CACHE
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC CACHE (A, B)
END PROGRAM
SRC
  has ('//f:cache-openacc', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC CACHE (A(1:N))
END PROGRAM
SRC
  has ('//f:cache-openacc', $doc);
}

# ============================================================
# ROUTINE -- GANG, WORKER, VECTOR, SEQ, NOHOST, BIND, DTYPE
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ROUTINE GANG
!$ACC ROUTINE WORKER
!$ACC ROUTINE VECTOR
!$ACC ROUTINE SEQ
END PROGRAM
SRC
  has ('//f:routine-openacc[f:clause[f:N="GANG"]]',   $doc);
  has ('//f:routine-openacc[f:clause[f:N="WORKER"]]', $doc);
  has ('//f:routine-openacc[f:clause[f:N="VECTOR"]]', $doc);
  has ('//f:routine-openacc[f:clause[f:N="SEQ"]]',    $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ROUTINE NOHOST GANG
!$ACC ROUTINE BIND("myfunc") SEQ
!$ACC ROUTINE DTYPE(*) GANG
END PROGRAM
SRC
  has ('//f:routine-openacc[f:clause[f:N="NOHOST"]]', $doc);
  has ('//f:routine-openacc[f:clause[f:N="BIND"]]',   $doc);
  has ('//f:routine-openacc[f:clause[f:N="DTYPE"]]',  $doc);
}

# ============================================================
# ROUTINE -- optional subroutine name argument
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ROUTINE (mysub) GANG
END PROGRAM
SRC
  has ('//f:routine-openacc',                        $doc);
  has ('//f:routine-openacc/f:clause[f:N="GANG"]',   $doc);
}

# ============================================================
# Continuation lines (&) in directives
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL &
!$ACC & NUM_GANGS(4) NUM_WORKERS(16) VECTOR_LENGTH(128)
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc',                                 $doc);
  has ('//f:parallel-openacc/f:clause[f:N="NUM_GANGS"]',       $doc);
  has ('//f:parallel-openacc/f:clause[f:N="NUM_WORKERS"]',     $doc);
  has ('//f:parallel-openacc/f:clause[f:N="VECTOR_LENGTH"]',   $doc);
}

# ============================================================
# Mixed OpenACC + regular Fortran code
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
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
END PROGRAM
SRC
  has ('//f:parallel-loop-openacc/f:clause[f:N="REDUCTION"]', $doc);
  hasnt ('//f:broken-stmt', $doc);
}

# ============================================================
# No ACC directives -- no acc elements present
# ============================================================

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
  INTEGER :: I
END PROGRAM
SRC
  hasnt ('//f:parallel-openacc',  $doc);
  hasnt ('//f:kernels-openacc',   $doc);
  hasnt ('//f:broken-stmt',       $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC INIT DEVICE_NUM(0)
END PROGRAM
SRC
  has ('//f:init-openacc/f:clause[f:N="DEVICE_NUM"]', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC INIT DEVICE_TYPE(nvidia)
END PROGRAM
SRC
  has ('//f:init-openacc/f:clause[f:N="DEVICE_TYPE"]', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DECLARE DEVICE_RESIDENT(A)
END PROGRAM
SRC
  has ('//f:declare-openacc/f:clause[f:N="DEVICE_RESIDENT"]', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL DEVICEPTR(A)
!$ACC END PARALLEL
END PROGRAM
SRC
  has ('//f:parallel-openacc/f:clause[f:N="DEVICEPTR"]', $doc);
}

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DATA COPYIN(A) COPYOUT(B)
!$ACC END DATA
END PROGRAM
SRC
  has ('//f:data-openacc/f:clause[f:N="COPYIN"]',  $doc);
  has ('//f:data-openacc/f:clause[f:N="COPYOUT"]', $doc);
}
