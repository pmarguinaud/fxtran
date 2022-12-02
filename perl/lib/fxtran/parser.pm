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

sub setOption
{
  my ($self, $what, @opt) = @_;

  my $list = $self->{"options$what"};

  while (@opt)
    {
      my $opt = shift (@opt);
      my ($c, $name) = ($opt =~ m/^([+-])(\w\S+\w)$/o);
      if ($opts{$name} eq 'FLAG')
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
              push @$list, "-$name", shift (@opt);
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

  if ($args{string})
    {
      return $self->parseString ($args{string})
    }
  elsif ($args{program})   
    {
      return $self->parseProgram ($args{program})
    }
  elsif ($args{location})
    {
      return $self->parseLocation ($args{location})
    }
  elsif ($args{fragment})
    {
      return $self->parseFragment ($args{fragment})
    }
  elsif ($args{statement})
    {
      return $self->parseStatement ($args{statement})
    }
  elsif ($args{expr})
    {
      return $self->parseExpression ($args{expr})
    }
}



sub parseString
{
  my $self = shift;

  use File::Temp;     
  my $fh = 'File::Temp'->new (SUFFIX => '.F90');     
  $fh->print ($_[0]);
  $fh->flush ();     
  system ('fxtran', @{ $self->{optionsString} }, $fh->filename)     
    && die ($_[0]);
  my $doc = 'XML::LibXML'->load_xml (location => $fh->filename . '.xml');
  return $doc;     
}

sub parseProgram
{
  my $self = shift;

  chomp (my $program = $_[0]);
  my $xml = eval { &fxtran::run (@{ $self->{optionsProgram} }, $program) };
  $@ && &croak ($@);
  my $doc = 'XML::LibXML'->load_xml (string => $xml);
  $doc = $doc->lastChild->firstChild;     
  my @c = $doc->childNodes ();     
  return @c;     
}     

sub parseFragment
{
  my $self = shift;

  chomp (my $fragment = $_[0]);
  my $program = << "EOF";      
$fragment      
END      
EOF
  my $xml = eval { &fxtran::run (@{ $self->{optionsFragment} }, $program) };
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

  my $program = << "EOF";      
$_[0]
END      
EOF
   my $xml = eval { &fxtran::run (@{ $self->{optionsStatement} }, $program) };
   $@ && &croak ($@);
   my $doc = 'XML::LibXML'->load_xml (string => $xml);
   my $n = $doc->documentElement->firstChild->firstChild;     
   return $n;     
}

sub parseExpression
{
  my $self = shift;

  my $program = << "EOF";      
X = $_[0]
END      
EOF

  my $xml = eval { &fxtran::run (@{ $self->{optionsExpression} }, $program) };
  $@ && &croak ($@);
  my $doc = 'XML::LibXML'->load_xml (string => $xml);
  my $n = $doc->documentElement->firstChild->firstChild->lastChild->firstChild;     
  return $n;     
}

sub parseLocation
{
  my $self = shift;

  my $f = $_[0];

  use File::stat;     
  use File::Basename;
  return unless (-f $f);     
     
  my $dir = $self->{dir} || &dirname ($f);     
  my $xml = "$dir/" . &basename ($f) . '.xml';     
     
  my @cmd = ('fxtran', @{ $self->{optionsLocation} }, -o => $xml, $f);     
  system (@cmd)     
     && &croak ("`@cmd' failed\n");     
     
  my $doc = 'XML::LibXML'->load_xml (location => $xml);
  return $doc;
}     

1;
