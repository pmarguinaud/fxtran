#!/usr/bin/perl -w
#
use strict;
use FileHandle;

while (my $file = shift (@ARGV))
  {
    my $text = do { local $/ = undef; my $fh = 'FileHandle'->new ("<$file"); <$fh> };
    
    my $fh = 'FileHandle'->new (">$file");
    $fh->print (<< 'EOF');
/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
EOF
    $fh->print ($text);
    $fh->close ();
  }
