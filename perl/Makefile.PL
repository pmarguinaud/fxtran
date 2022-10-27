use 5.016000;
use ExtUtils::MakeMaker;
use Cwd;

my $pwd = &cwd ();

&WriteMakefile
(
    NAME              => 'fxtran',
    VERSION_FROM      => 'lib/fxtran.pm', 
    PREREQ_PM         => {'XML::XPath::Parser' => 1.48, 'XML::LibXML' => 2.0207}, 
    ABSTRACT_FROM     => 'lib/fxtran.pm', 
    AUTHOR            => 'Philippe Marguinaud <pmarguinaud@hotmail.com>',
    LICENSE           => 'GPL',
    LIBS              => ["-L$pwd/../lib -lfxtran"], 
    DEFINE            => '', 
    INC               => '-I../src', 
);
