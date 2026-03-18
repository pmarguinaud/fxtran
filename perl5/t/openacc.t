use strict;
use warnings;
use FindBin qw ($Bin);
use Test::More tests => 21;

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

sub xfind { my @n = $xpc->findnodes ($_[0], $_[1]); return @n }
sub has   { ok (xfind (@_) > 0,  "found: $_[0]") }
sub hasnt { ok (xfind (@_) == 0, "absent: $_[0]") }
sub count { is (scalar (xfind ($_[0], $_[1])), $_[2], "count $_[2]: $_[0]") }

# ---- openacc="1" flag --------------------------------------------------------

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL
!$ACC END PARALLEL
END PROGRAM
SRC
  is ($xpc->findvalue ('/f:object/@openacc', $doc), '1', 'openacc="1" on root element');
  is ($xpc->findvalue ('/f:object/@openmp',  $doc), '0', 'openmp="0" when only openacc');
}

# ---- PARALLEL LOOP with GANG and VECTOR clauses ------------------------------

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
  has ('//f:parallel-loop-openacc', $doc);
  has ('//f:end-parallel-loop-openacc', $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="GANG"]',   $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="VECTOR"]', $doc);
}

# ---- PARALLEL LOOP with REDUCTION and COLLAPSE -------------------------------

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC PARALLEL LOOP REDUCTION(+:S) COLLAPSE(2)
END PROGRAM
SRC
  has ('//f:parallel-loop-openacc/f:clause[f:N="REDUCTION"]', $doc);
  has ('//f:parallel-loop-openacc/f:clause[f:N="COLLAPSE"]',  $doc);
}

# ---- KERNELS LOOP ------------------------------------------------------------

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC KERNELS LOOP
!$ACC END KERNELS LOOP
END PROGRAM
SRC
  has ('//f:kernels-loop-openacc', $doc);
  has ('//f:end-kernels-loop-openacc', $doc);
}

# ---- SERIAL LOOP -------------------------------------------------------------

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC SERIAL LOOP
!$ACC END SERIAL LOOP
END PROGRAM
SRC
  has ('//f:serial-loop-openacc', $doc);
  has ('//f:end-serial-loop-openacc', $doc);
}

# ---- DATA with COPYIN / CREATE -----------------------------------------------

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DATA COPYIN(A) CREATE(C)
!$ACC END DATA
END PROGRAM
SRC
  has ('//f:data-openacc',     $doc);
  has ('//f:end-data-openacc', $doc);
  has ('//f:data-openacc/f:clause[f:N="COPYIN"]', $doc);
  has ('//f:data-openacc/f:clause[f:N="CREATE"]', $doc);
}

# ---- ENTER DATA / EXIT DATA --------------------------------------------------

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC ENTER DATA COPYIN(A)
!$ACC EXIT DATA DELETE(A)
END PROGRAM
SRC
  has ('//f:enter-data-openacc/f:clause[f:N="COPYIN"]', $doc);
  has ('//f:exit-data-openacc/f:clause[f:N="DELETE"]',  $doc);
}

# ---- DECLARE -----------------------------------------------------------------

{
  my $doc = parse_acc (<< 'SRC');
PROGRAM MAIN
!$ACC DECLARE LINK(X)
END PROGRAM
SRC
  has ('//f:declare-openacc/f:clause[f:N="LINK"]', $doc);
}
