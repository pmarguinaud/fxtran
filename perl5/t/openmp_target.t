use strict;
use warnings;
use FindBin qw ($Bin);
use Test::More tests => 33;

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

sub xfind { my @n = $xpc->findnodes ($_[0], $_[1]); return @n }
sub has   { ok (xfind (@_) > 0,  "found: $_[0]") }
sub hasnt { ok (xfind (@_) == 0, "absent: $_[0]") }
sub count { is (scalar (xfind ($_[0], $_[1])), $_[2], "count $_[2]: $_[0]") }

# ---- openmp-target="1" flag --------------------------------------------------

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

# ---- !$OMP sentinel tag ------------------------------------------------------

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET
!$OMP END TARGET
END PROGRAM
SRC
  has ('//f:omptarget', $doc);
  count ('//f:omptarget', $doc, 2);
}

# ---- TARGET DATA with MAP clauses --------------------------------------------

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET DATA MAP(to:B) MAP(from:A)
!$OMP END TARGET DATA
END PROGRAM
SRC
  has ('//f:target-data-openmp', $doc);
  has ('//f:end-target-data-openmp', $doc);
  count ('//f:target-data-openmp/f:clause[f:N="MAP"]', $doc, 2);
}

# ---- TARGET TEAMS with DISTRIBUTE and PARALLEL DO clauses -------------------

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO PRIVATE(I)
DO I = 1, N
  A(I) = B(I)
END DO
!$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO
END PROGRAM
SRC
  has ('//f:target-teams-openmp', $doc);
  has ('//f:target-teams-openmp/f:clause[f:N="DISTRIBUTE"]',   $doc);
  has ('//f:target-teams-openmp/f:clause[f:N="PARALLEL DO"]',  $doc);
  has ('//f:target-teams-openmp/f:clause[f:N="PRIVATE"]',      $doc);
  # END directive carries the same composite clauses
  has ('//f:end-target-teams-openmp/f:clause[f:N="DISTRIBUTE"]',  $doc);
  has ('//f:end-target-teams-openmp/f:clause[f:N="PARALLEL DO"]', $doc);
  # DISTRIBUTE and PARALLEL DO are not embedded in the tag name
  hasnt ('//f:target-teams-distribute-parallel-do-openmp', $doc);
}

# ---- TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD --------------------------------

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
!$OMP END TARGET TEAMS DISTRIBUTE PARALLEL DO SIMD
END PROGRAM
SRC
  has ('//f:target-teams-openmp/f:clause[f:N="DISTRIBUTE"]',           $doc);
  has ('//f:target-teams-openmp/f:clause[f:N="PARALLEL DO SIMD"]',     $doc);
  has ('//f:end-target-teams-openmp/f:clause[f:N="PARALLEL DO SIMD"]', $doc);
}

# ---- TARGET PARALLEL DO SIMD with REDUCTION ----------------------------------

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET PARALLEL DO SIMD REDUCTION(+:S)
DO I = 1, N
  S = S + A(I)
END DO
!$OMP END TARGET PARALLEL DO SIMD
END PROGRAM
SRC
  has ('//f:target-parallel-openmp', $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="DO"]',        $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="SIMD"]',      $doc);
  has ('//f:target-parallel-openmp/f:clause[f:N="REDUCTION"]', $doc);
  has ('//f:end-target-parallel-openmp/f:clause[f:N="DO"]',    $doc);
  has ('//f:end-target-parallel-openmp/f:clause[f:N="SIMD"]',  $doc);
}

# ---- TARGET TEAMS LOOP -------------------------------------------------------

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET TEAMS LOOP COLLAPSE(2)
!$OMP END TARGET TEAMS LOOP
END PROGRAM
SRC
  has ('//f:target-teams-openmp/f:clause[f:N="LOOP"]',     $doc);
  has ('//f:target-teams-openmp/f:clause[f:N="COLLAPSE"]', $doc);
  has ('//f:end-target-teams-openmp/f:clause[f:N="LOOP"]', $doc);
}

# ---- TARGET SIMD (SIMD as clause of TARGET) ----------------------------------

{
  my $doc = parse_omt (<< 'SRC');
PROGRAM MAIN
!$OMP TARGET SIMD
!$OMP END TARGET SIMD
END PROGRAM
SRC
  has ('//f:target-openmp/f:clause[f:N="SIMD"]',     $doc);
  has ('//f:end-target-openmp/f:clause[f:N="SIMD"]', $doc);
}

# ---- DECLARE TARGET / END DECLARE TARGET -------------------------------------

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
