use strict;
use warnings;
use Data::Dumper;
use XML::LibXML;

use Test::More tests => 3;
BEGIN { use_ok('fxtran') };
BEGIN { use_ok('fxtran::xpath') };
BEGIN { use_ok('fxtran::parser') };

use FileHandle;

print STDERR &fxtran::help (), "\n";


my $doc = &s ('REAL (KIND=JPRB) :: X (10)');

my $fh = \*STDERR; # 'FileHandle'->new (">fxtran.log");

$fh->print ("\n" x 3, $doc, "\n" x 3);

$fh->print (&F ('//EN-decl', $doc), "\n");

eval
{
  &s ('X = ..');
};

$fh->print ($@, "\n");

my ($p) = &fxtran::parse (program => << "EOF");
SUBROUTINE SUB

END SUBROUTINE
EOF

$fh->print ("$p\n");


my $parser = 'fxtran::parser'->new ();

print STDERR $parser->parseExpression ('N + 1'), "\n";

$parser->setOptions ('Expression', '-canonic');

print STDERR $parser->parseExpression ('N + 1'), "\n";

$parser->setOptions ('Expression', '+canonic');

print STDERR $parser->parseExpression ('N + 1'), "\n";

print STDERR &fxtran::parse (expr => 'SIN (X)'), "\n";

print STDERR &e ('0'), "\n";
