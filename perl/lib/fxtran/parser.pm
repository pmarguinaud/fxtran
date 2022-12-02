package fxtran::parser;

use strict;

sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}

=pod

     
  my @fopts = @{ $args{fopts} || [] };     
  my @xopts = @{ $args{xopts} || [] };     
     
  if ($args{string})     
    {     
      use File::Temp;     
      my $fh = 'File::Temp'->new (SUFFIX => '.F90');     
      $fh->print ($args{string});     
      $fh->flush ();     
      system (qw (fxtran -construct-tag -no-include), @fopts, $fh->filename)     
        && die ($args{string});     
      my $doc = 'XML::LibXML'->load_xml (location => $fh->filename . '.xml', @xopts);     
      return $doc;     
    }     
  elsif ($args{program})     
    {     
      chomp (my $program = $args{program});     
      my $xml = eval { &run ('-construct-tag', '-no-include', @fopts, $program) };
      $@ && &croak ($@);
      my $doc = 'XML::LibXML'->load_xml (string => $xml, @xopts);     
      $doc = $doc->lastChild->firstChild;     
      my @c = $doc->childNodes ();     
      return @c;     
    }     
  elsif ($args{fragment})     
    {     
      chomp (my $fragment = $args{fragment});     
      my $program = << "EOF";      
$fragment      
END      
EOF
      my $xml = eval { &run ('-construct-tag', '-no-include', @fopts, $program) };
      $@ && &croak ($@);
      my $doc = 'XML::LibXML'->load_xml (string => $xml, @xopts);     
      $doc = $doc->lastChild->firstChild;     
     
      $doc->lastChild->unbindNode () for (1 .. 2);     
      my @c = $doc->childNodes ();     
     
      return @c;     
    }     
  elsif ($args{statement})     
    {     
      my $program = << "EOF";      
$args{statement}      
END      
EOF
      my $xml = eval { &run ('-line-length', 512, $program) };
      $@ && &croak ($@);
      my $doc = 'XML::LibXML'->load_xml (string => $xml, @xopts);     
      my $n = $doc->documentElement->firstChild->firstChild;     
      return $n;     
    }     
  elsif ($args{expr})     
    {     
      my $program = << "EOF";      
X = $args{expr}      
END      
EOF
      my $xml = eval { &run ('-line-length', 512, $program) };
      $@ && &croak ($@);
      my $doc = 'XML::LibXML'->load_xml (string => $xml, @xopts);     
      my $n = $doc->documentElement->firstChild->firstChild->lastChild->firstChild;     
      return $n;     
    }     
  elsif (my $f = $args{location})     
    {     
      use File::stat;     
      use File::Basename;
      return unless (-f $f);     
     
      my $dir = $args{dir} || &dirname ($f);     
      my $xml = "$dir/" . &basename ($f) . '.xml';     
     
      my @cmd = (qw (fxtran -construct-tag -no-include), @fopts, -o => $xml, $f);     
      system (@cmd)     
        && croak ("`@cmd' failed\n");     
     
      my $doc = 'XML::LibXML'->load_xml (location => $xml, @xopts);     
      return $doc;
    }     

=cut

1;
