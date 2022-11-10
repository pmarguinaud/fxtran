package fxtran;

use 5.016000;
use strict;
use warnings;

use base qw (Exporter);
use XML::LibXML;
use XSLoader;
use Carp qw (croak);

our @EXPORT = qw (parse s t e n);

our $VERSION = '0.02';

&XSLoader::load ('fxtran', $VERSION);

sub t
{
  'XML::LibXML::Text'->new ($_[0]);
}

sub s
{
  &parse (statement => $_[0]);
}

sub e
{
  &parse (expr => $_[0]);
}

sub n
{
  my $xml = shift;
  my $doc = 'XML::LibXML'->load_xml (string => '<?xml version="1.0"?><object xmlns="http://fxtran.net/#syntax">' . $xml . '</object>');

  my @c = $doc->documentElement ()->childNodes ();
  if (scalar (@c) > 1)
    {
      return @c;
    }
  else
    {
      return $c[0];
    }
}

sub parse
{      
  my %args = @_;     
     
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
  &croak ("@_");
}      

1;

=pod

=head NAME

fxtran - Perl binding for fxtran parser

=head AUTHOR

pmarguinaud@hotmail.com

=cut
