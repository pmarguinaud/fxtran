package fxtran;

use 5.016000;
use strict;
use warnings;

use base qw (Exporter);
use XML::LibXML;
use File::Basename;

use XSLoader;
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
  eval "use fxtran::parser";
  $@ && die $@;
  return $fxtran::parser::PARSER->parse (@_);
}      

sub setOptions
{
  eval "use fxtran::parser";
  $@ && die $@;
  return $fxtran::parser::PARSER->setOptions (@_);
}

sub help
{
  return &fxtran::run ('-help-xml', '');
}

1;

=pod

=head1 NAME

fxtran - Perl bindings for fxtran parser

=head1 AUTHOR

pmarguinaud@hotmail.com

=cut
