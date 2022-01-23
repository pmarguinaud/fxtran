use 5.030000;
use ExtUtils::MakeMaker;
use Cwd;

my $pwd = &cwd ();

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'fxtran',
    VERSION_FROM      => 'lib/fxtran.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/fxtran.pm', # retrieve abstract from module
    AUTHOR            => 'Philippe Marguinaud <pmarguinaud@hotmail.com>',
    LICENSE           => 'GPL',
    LIBS              => ["-L$pwd/../lib -lfxtran"], 
    DEFINE            => '', 
    INC               => '-I../src', 
);
