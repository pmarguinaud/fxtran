# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl fxtran.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use Data::Dumper;

use Test::More tests => 1;
BEGIN { use_ok('fxtran') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $xml = &fxtran::run ('-openmp', '-line-length' => 300, << "EOF");
REAL (KIND=JPRB) :: X (10)
END
EOF

print STDERR "\n" x 3, $xml, "\n" x 3;
