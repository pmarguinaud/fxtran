use strict;
use warnings;
use Data::Dumper;
use XML::LibXML;

use Test::More tests => 2;
BEGIN { use_ok('fxtran') };
BEGIN { use_ok('fxtran::xpath') };

use FileHandle;

my $doc = &s ('REAL (KIND=JPRB) :: X (10)');

my $fh = \*STDERR; # 'FileHandle'->new (">fxtran.log");

$fh->print ("\n" x 3, $doc, "\n" x 3);

$fh->print (&F ('//EN-decl', $doc), "\n");

$fh->print (&F ('//entity-decl', $doc), "\n");

eval
{
  &s ('X = ..');
};

$fh->print ($@, "\n");


