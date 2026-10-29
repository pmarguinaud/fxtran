#!/usr/bin/env perl
#
# Unit tests for the operator trees built by fxtran.
#
# Usage: make test, in perl5/
#        FXTRAN=path/to/fxtran prove t/expr.t
#
# Each case is the right-hand side of an assignment; its tree is printed as the
# source text with every op-E wrapped in [ ], so that A + B - C parsed as
# A + (B - C) reads [A + [B - C]]. Parentheses of the source stay ( ).
#
# Expected trees follow the Fortran precedence (F2018, 10.1.2), but chains of
# equal-precedence operators nest to the right wherever the result is
# mathematically equivalent (F2018, 10.1.5.2.4):
#
#   - add-op:  split at the first + ; with no +, nest - to the left
#              A - B + C - D -> [[A - B] + [C - D]]
#   - mult-op: split at the first * that is not followed by a / ; with none,
#              nest to the left: I * J / K is not I * (J / K) for integers
#   - ** nests to the right (this is the standard grouping)
#   - // .AND. .OR. .EQV. .NEQV. nest to the right (associative)
#   - defined binary operators nest to the left (unknown semantics)

use strict;
use warnings;
use FindBin qw ($Bin);
use File::Temp qw (tempdir);
use XML::LibXML;
use Test::More;

my $fxtran = $ENV{FXTRAN} || "$Bin/../../bin/fxtran";

my @cases =
(
  # primaries
  [ 'A',                         'A'                                  ],
  [ '1.5E0',                     '1.5E0'                              ],
  [ '(A)',                       '(A)'                                ],
  [ '((A + B))',                 '(([A + B]))'                        ],
  [ 'F (A + B, C)',              'F ([A + B], C)'                     ],
  [ 'Z (I + 1, :)',              'Z ([I + 1], :)'                     ],
  [ 'Y%Z + 1',                   '[Y%Z + 1]'                          ],
  [ '(/ A + B, C /)',            '(/ [A + B], C /)'                   ],
  [ '1.E-3 * A',                 '[1.E-3 * A]'                        ],
  [ '1.D+0 + A',                 '[1.D+0 + A]'                        ],
  [ '1._JPRB - A',               '[1._JPRB - A]'                      ],
  [ '.5 + A',                    '[.5 + A]'                           ],
  [ '(1.0, 2.0) * A',            '[(1.0, 2.0) * A]'                   ],
  [ '.TRUE. .AND. L1',           '[.TRUE. .AND. L1]'                  ],
  [ "'AB' // 'CD'",              "['AB' // 'CD']"                     ],

  # parentheses
  [ '(A + B) * C',               '[([A + B]) * C]'                    ],
  [ 'A * (B + C)',               '[A * ([B + C])]'                    ],
  [ 'A - (B - C)',               '[A - ([B - C])]'                    ],
  [ 'A / (B * C)',               '[A / ([B * C])]'                    ],
  [ '(A ** B) ** C',             '[([A ** B]) ** C]'                  ],

  # precedence between levels
  [ 'A + B * C',                 '[A + [B * C]]'                      ],
  [ 'A * B + C',                 '[[A * B] + C]'                      ],
  [ 'A * B ** C',                '[A * [B ** C]]'                     ],
  [ 'A ** B * C',                '[[A ** B] * C]'                     ],
  [ 'A + B * C ** D',            '[A + [B * [C ** D]]]'               ],
  [ 'A ** B / C - D',            '[[[A ** B] / C] - D]'               ],
  [ 'CA // CB == CC',            '[[CA // CB] == CC]'                 ],
  [ 'CA == CB // CC',            '[CA == [CB // CC]]'                 ],
  [ 'A + B == C',                '[[A + B] == C]'                     ],
  [ 'A + B /= C',                '[[A + B] /= C]'                     ],
  [ 'A /= B + C',                '[A /= [B + C]]'                     ],
  [ 'A * B /= C',                '[[A * B] /= C]'                     ],
  [ 'A /= B * C',                '[A /= [B * C]]'                     ],
  [ 'A ** B /= C',               '[[A ** B] /= C]'                    ],
  [ 'A <= B + C',                '[A <= [B + C]]'                     ],
  [ 'A + B >= C',                '[[A + B] >= C]'                     ],
  [ 'A < B * C',                 '[A < [B * C]]'                      ],
  [ 'A > B - C',                 '[A > [B - C]]'                      ],
  [ 'A .NE. B + C',              '[A .NE. [B + C]]'                   ],
  [ 'A .LT. B .OR. C .GE. D',    '[[A .LT. B] .OR. [C .GE. D]]'       ],
  [ 'A == B .AND. C < D',        '[[A == B] .AND. [C < D]]'           ],
  [ 'L1 .OR. L2 .AND. L3',       '[L1 .OR. [L2 .AND. L3]]'            ],
  [ 'L1 .AND. L2 .OR. L3',       '[[L1 .AND. L2] .OR. L3]'            ],
  [ 'L1 .EQV. L2 .OR. L3',       '[L1 .EQV. [L2 .OR. L3]]'            ],
  [ 'L1 .OR. L2 .NEQV. L3',      '[[L1 .OR. L2] .NEQV. L3]'           ],

  # unary operators
  [ '-A',                        '[-A]'                               ],
  [ '+A',                        '[+A]'                               ],
  [ '-A + B',                    '[[-A] + B]'                         ],
  [ '-A - B',                    '[[-A] - B]'                         ],
  [ '-A * B',                    '[-[A * B]]'                         ],
  [ '-A ** B',                   '[-[A ** B]]'                        ],
  [ '-A * B + C',                '[[-[A * B]] + C]'                   ],
  [ 'A * (-B)',                  '[A * ([-B])]'                       ],
  [ 'A * -B',                    '[A * [-B]]'                         ],
  [ 'A ** -B',                   '[A ** [-B]]'                        ],
  [ '.NOT. L1',                  '[.NOT. L1]'                         ],
  [ '.NOT. L1 .AND. L2',         '[[.NOT. L1] .AND. L2]'              ],
  [ 'L1 .AND. .NOT. L2',         '[L1 .AND. [.NOT. L2]]'              ],
  [ '.NOT. A == B',              '[.NOT. [A == B]]'                   ],
  [ '.NOT. .NOT. L1',            '[.NOT. [.NOT. L1]]'                 ],

  # add-op chains
  [ 'A + B + C',                 '[A + [B + C]]'                      ],
  [ 'A - B - C',                 '[[A - B] - C]'                      ],
  [ 'A + B - C',                 '[A + [B - C]]'                      ],
  [ 'A - B + C',                 '[[A - B] + C]'                      ],
  [ 'A - B + C - D',             '[[A - B] + [C - D]]'                ],
  [ 'A - B - C + D',             '[[[A - B] - C] + D]'                ],
  [ 'A + B + C - D',             '[A + [B + [C - D]]]'                ],
  [ 'A - B - C - D',             '[[[A - B] - C] - D]'                ],

  # mult-op chains
  [ 'A * B * C',                 '[A * [B * C]]'                      ],
  [ 'A / B / C',                 '[[A / B] / C]'                      ],
  [ 'A / B * C',                 '[[A / B] * C]'                      ],
  [ 'A * B / C',                 '[[A * B] / C]'                      ],
  [ 'A * B / C * D',             '[[[A * B] / C] * D]'                ],
  [ 'A * B * C / D',             '[[A * [B * C]] / D]'                ],
  [ 'A / B * C * D',             '[[A / B] * [C * D]]'                ],
  [ 'A / B / C * D',             '[[[A / B] / C] * D]'                ],

  # power chains
  [ 'A ** B ** C',               '[A ** [B ** C]]'                    ],
  [ 'A ** B ** C ** D',          '[A ** [B ** [C ** D]]]'             ],
  [ 'A * B ** C ** D',           '[A * [B ** [C ** D]]]'              ],

  # concatenation chains
  [ 'CA // CB // CC',            '[CA // [CB // CC]]'                 ],

  # logical chains
  [ 'L1 .AND. L2 .AND. L3',      '[L1 .AND. [L2 .AND. L3]]'           ],
  [ 'L1 .OR. L2 .OR. L3',        '[L1 .OR. [L2 .OR. L3]]'             ],
  [ 'L1 .EQV. L2 .EQV. L3',      '[L1 .EQV. [L2 .EQV. L3]]'           ],
  [ 'L1 .NEQV. L2 .NEQV. L3',    '[L1 .NEQV. [L2 .NEQV. L3]]'         ],

  # defined operators
  [ 'A .X. B',                   '[A .X. B]'                          ],
  [ '.X. A',                     '[.X. A]'                            ],
  [ '.X. A + B',                 '[[.X. A] + B]'                      ],
  [ 'A .X. B + C',               '[A .X. [B + C]]'                    ],
  [ 'A .X. B .X. C',             '[[A .X. B] .X. C]'                  ],
  [ 'A .X. B .Y. C',             '[[A .X. B] .Y. C]'                  ],
  [ 'L1 .AND. L2 .X. L3',        '[[L1 .AND. L2] .X. L3]'             ],

  # case and spacing
  [ 'a + b - c',                 '[a + [b - c]]'                      ],
  [ 'a /= b + c',                '[a /= [b + c]]'                     ],
  [ 'l1 .and. l2 .or. l3',       '[[l1 .and. l2] .or. l3]'            ],
  [ 'A*B/C',                     '[[A*B]/C]'                          ],
  [ 'A**B**C',                   '[A**[B**C]]'                        ],
  [ 'L1.AND.L2.OR.L3',           '[[L1.AND.L2].OR.L3]'                ],
  [ 'A/=B',                      '[A/=B]'                             ],
  [ 'CA//CB',                    '[CA//CB]'                           ],
);

# Source text with every op-E wrapped in [ ]

sub tree
{
  my $e = shift;
  return $e->data if ($e->nodeType == XML_TEXT_NODE);
  my $s = join ('', map { &tree ($_) } $e->childNodes ());
  return $e->localname eq 'op-E' ? "[$s]" : $s;
}

my $dir = tempdir (CLEANUP => 1);
my $f90 = "$dir/expr.F90";

open (my $fh, '>', $f90) or die ("$f90: $!\n");
print $fh "SUBROUTINE EXPR\n";
print $fh "X = $_->[0]\n" for (@cases);
print $fh "END SUBROUTINE\n";
close ($fh);

system ($fxtran, '-o', "$f90.xml", $f90) and BAIL_OUT ("$fxtran failed");

my $doc = 'XML::LibXML'->load_xml (location => "$f90.xml");
my $xpc = 'XML::LibXML::XPathContext'->new ($doc);
$xpc->registerNs (f => 'http://fxtran.net/#syntax');

my @rhs = $xpc->findnodes ('//f:a-stmt/f:E-2');

is (scalar (@rhs), scalar (@cases), 'number of assignments');

for my $i (0 .. $#cases)
  {
    my ($src, $exp) = @{ $cases[$i] };
    my $got = $rhs[$i] ? &tree ($rhs[$i]) : '';
    $got =~ s/^\s+|\s+$//go;
    is ($got, $exp, $src);
  }

done_testing ();
