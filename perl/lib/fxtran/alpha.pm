package fxtran::alpha;

use strict;

my %U2S = %{{
  'assignment' => 'a',
  'dimension' => 'DIM',
  'entity' => 'EN',
  'expr' => 'E',
  'global' => 'G',
  'kind' => 'K',
  'list' => 'LT',
  'local' => 'LC',
  'name' => 'N',
  'namespace' => 'NS',
  'object' => 'obj',
  'operator' => 'op',
  'ref' => 'R',
  'symbol' => 'S',
  'type' => 'T',
  'variable' => 'V'
}
};
my %S2U = %{{
  'DIM' => 'dimension',
  'E' => 'expr',
  'EN' => 'entity',
  'G' => 'global',
  'K' => 'kind',
  'LC' => 'local',
  'LT' => 'list',
  'N' => 'name',
  'NS' => 'namespace',
  'R' => 'ref',
  'S' => 'symbol',
  'T' => 'type',
  'V' => 'variable',
  'a' => 'assignment',
  'obj' => 'object',
  'op' => 'operator'
}
};

sub lookupU2S
{
  my $x = shift;
  unless (exists ($U2S{$x}))
    {
      my @x = split (m/-/o, $x);
      $_ = $U2S{$_} || $_ for (@x);
      $U2S{$x} = join ('-', @x);
      $S2U{$U2S{$x}} = $x;
    }
  return $U2S{$x};
}

sub lookupS2U
{
  my $x = shift;
  unless (exists ($S2U{$x}))
    {
      my @x = split (m/-/o, $x);
      $_ = $S2U{$_} || $_ for (@x);
      $S2U{$x} = join ('-', @x);
      $U2S{$S2U{$x}} = $x;
    }
  return $S2U{$x};
}

1;
