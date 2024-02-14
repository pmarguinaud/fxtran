package MY;

use strict;

sub const_loadlibs
{
  my $self = shift;

  my $c = $self->SUPER::const_loadlibs (@_);

  my $debian = $ENV{DEB_BUILD_ARCH};

  if ($debian)
    {   
      $self->{LD_RUN_PATH} = ""; 
    }   

  return $c; 
}

package main;

use 5.016000;
use ExtUtils::MakeMaker;
use Cwd;

my $cwd = &cwd ();
my $TOP = "$cwd/..";

my $debian = $ENV{DEB_BUILD_ARCH};

my $rpath = "-Wl,-rpath,$TOP/lib";

my ($CFLAGS, $LDFLAGS) = ('', '');

if ($debian)
  {
    $rpath = '';
    $CFLAGS = $ENV{DEB_CFLAGS};
    $LDFLAGS = $ENV{DEB_LDFLAGS};
  }

&WriteMakefile
(
  LD                => "gcc $LDFLAGS $rpath",
  CC                => "gcc $CFLAGS",
  NAME              => 'fxtran',
  VERSION_FROM      => 'lib/fxtran.pm', 
  PREREQ_PM         => {'XML::XPath::Parser' => 1.44, 'XML::LibXML' => 2.0134}, 
  ABSTRACT_FROM     => 'lib/fxtran.pm', 
  AUTHOR            => 'Philippe Marguinaud <pmarguinaud@hotmail.com>',
  LICENSE           => 'GPL',
  LIBS              => ["-L$TOP/lib -lfxtran"], 
  DEFINE            => '', 
  INC               => "-I$TOP/include", 
  $debian 
?(PREFIX            => "$TOP/debian/tmp/usr",
  INSTALLDIRS       => 'vendor',) 
:()

);
