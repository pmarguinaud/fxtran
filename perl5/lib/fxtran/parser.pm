package fxtran::parser;

use strict;
use XML::LibXML;
use Carp qw (croak);

our $PARSER = __PACKAGE__->new ();

my %opts;

sub new
{
  my $class = shift;
  my $self = bless 
    {
      optionsString     => [qw (-construct-tag -no-include)],
      optionsProgram    => [qw (-construct-tag -no-include)],
      optionsLocation   => [qw (-construct-tag -no-include)],
      optionsFragment   => [qw (-construct-tag -no-include)],
      optionsStatement  => [qw (-line-length 512)],
      optionsExpression => [qw (-line-length 512)],
    }, $class;
  return $self;
}

sub setOptions
{
  my $self = shift;
  
  my @what;

  while ($_[0] !~ m/^[+-]/o)
    {
      push @what, shift (@_);
    }

  if ((scalar (@what) == 1) && ($what[0] eq ':all'))
    {
      @what = grep { m/^options/o } sort keys (%$self);
      s/^options//o for (@what);
    }

  my @opt = @_;

  for my $what (@what)
    {
      my $list = $self->{"options$what"};

      my @o = @opt;     

      while (@o)
        {
          my $opt = shift (@o);
          my ($c, $name) = ($opt =~ m/^([+-])(\w\S+\w)$/o);
          if ($opts{$name}[0] eq 'FLAG')
            {
              @$list = grep { $_ ne "-$name" } @$list;
              if ($c eq '-')
                {
                  push @$list, "-$name";
                }
            }
          else
            {
              for my $i (0 .. $#{$list})
                {
                  if ($list->[$i] eq "-$name")
                    {
                      splice (@$list, $i, 2);
                      last;
                    }
                }
              if ($c eq '-')
                {
                  push @$list, "-$name", shift (@o);
                }
            }
        }
    }
}


{

my $help = 'XML::LibXML'->load_xml (string =>  &fxtran::run ('-help-xml', ''));

my $xpc = 'XML::LibXML::XPathContext'->new ();

for my $opt ($xpc->findnodes ('//option', $help))
  {
    my ($name, $type, $help) = map { $_->textContent } $opt->childNodes ();
    $opts{$name} = [$type, $help];
  }

}

sub parse
{
  my $self = shift;
  my %args = @_;

  if (defined (my $string = delete $args{string}))
    {
      return $self->parseString ($string, %args);
    }
  elsif (defined (my $program = delete $args{program}))   
    {
      return $self->parseProgram ($program, %args);
    }
  elsif (defined (my $location = delete $args{location}))
    {
      return $self->parseLocation ($location, %args);
    }
  elsif (defined (my $fragment = delete $args{fragment}))
    {
      return $self->parseFragment ($fragment, %args);
    }
  elsif (defined (my $statement = delete $args{statement}))
    {
      return $self->parseStatement ($statement, %args);
    }
  elsif (defined (my $expr = delete $args{expr}))
    {
      return $self->parseExpression ($expr, %args);
    }
}



sub parseString
{
  my $self = shift;
  my $string = shift;

  my %args = @_;
  my @fopts = @{ $args{fopts} || $self->{optionsString} };

  use File::Temp;     
  my $fh = 'File::Temp'->new (SUFFIX => '.F90');     
  $fh->print ($string);
  $fh->flush ();     
  system ('fxtran', @fopts, $fh->filename)     
    && die ($string);
  my $doc = 'XML::LibXML'->load_xml (location => $fh->filename . '.xml');
  return $doc;     
}

sub parseProgram
{
  my $self = shift;
  my $program = shift;

  my %args = @_;
  my @fopts = @{ $args{fopts} || $self->{optionsProgram} };

  chomp ($program);
  my $xml = eval { &fxtran::run (@fopts, $program) };
  $@ && &croak ($@);
  my $doc = 'XML::LibXML'->load_xml (string => $xml);
  $doc = $doc->lastChild->firstChild;     
  my @c = $doc->childNodes ();     
  return @c;     
}     

sub parseFragment
{
  my $self = shift;
  my $fragment = shift;

  my %args = @_;
  my @fopts = @{ $args{fopts} || $self->{optionsFragment} };

  chomp ($fragment);
  my $program = << "EOF";      
$fragment      
END      
EOF
  my $xml = eval { &fxtran::run (@fopts, $program) };
  $@ && &croak ($@);
  my $doc = 'XML::LibXML'->load_xml (string => $xml);
  $doc = $doc->lastChild->firstChild;     
  $doc->lastChild->unbindNode () for (1 .. 2);     
  my @c = $doc->childNodes ();     
  return @c;     
}     

sub parseStatement
{
  my $self = shift;
  my $statement = shift;

  my %args = @_;
  my @fopts = @{ $args{fopts} || $self->{optionsStatement} };

  my $program = << "EOF";      
$statement
END      
EOF
   my $xml = eval { &fxtran::run (@fopts, $program) };
   $@ && &croak ($@);
   my $doc = 'XML::LibXML'->load_xml (string => $xml);
   my $n = $doc->documentElement->firstChild->firstChild;     
   return $n;     
}

sub parseExpression
{
  my $self = shift;
  my $expression = shift;

  my %args = @_;
  my @fopts = @{ $args{fopts} || $self->{optionsExpression} };

  my $program = << "EOF";      
X = $expression
END      
EOF

  my $xml = eval { &fxtran::run (@fopts, $program) };
  $@ && &croak ($@);
  my $doc = 'XML::LibXML'->load_xml (string => $xml);
  my $n = $doc->documentElement->firstChild->firstChild->lastChild->firstChild;     
  return $n;     
}

sub parseLocation
{
  my $self = shift;
  my $location = shift;

  my %args = @_;
  my @fopts = @{ $args{fopts} || $self->{optionsLocation} };

  use File::stat;     
  use File::Basename;
  return unless (-f $location);     
     
  my $dir = $args{dir} || &dirname ($location); 
  my $xml = "$dir/" . &basename ($location) . '.xml';     
     
  my @cmd = ('fxtran', @fopts, -o => $xml, $location);     
  system (@cmd)     
     && &croak ("`@cmd' failed\n");     
     
  my $doc = 'XML::LibXML'->load_xml (location => $xml);
  return $doc;
}     

1;
