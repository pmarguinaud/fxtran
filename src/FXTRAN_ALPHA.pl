#!/usr/bin/perl -w
#unkwown                                                        UNKNOWN
#
use strict;
use FileHandle;
use Data::Dumper;



my @x = qw[
  a                                                              ASSIGNMENT
  abstract                                                       ABSTRACT
  ac                                                             AC
  access                                                         ACCESS
  action                                                         ACTION
  allocatable                                                    ALLOCATABLE
  allocate                                                       ALLOCATE
  alt                                                            ALT
  ambiguous                                                      AMBIGUOUS
  ancestor                                                       ANCESTOR
  arg                                                            ARG
  arithmetic                                                     ARITHMETIC
  array                                                          ARRAY
  assign                                                         ASSIGN
  assigned                                                       ASSIGNED
  associate                                                      ASSOCIATE
  association                                                    ASSOCIATION
  assumed                                                        ASSUMED
  asynchronous                                                   ASYNCHRONOUS
  atomic                                                         ATOMIC
  attribute                                                      ATTRIBUTE
  backspace                                                      BACKSPACE
  bind                                                           BIND
  binding                                                        BINDING
  block                                                          BLOCK
  bound                                                          BOUND
  broken                                                         BROKEN
  cache                                                          CACHE
  call                                                           CALL
  case                                                           CASE
  character                                                      CHARACTER
  char                                                           CHAR
  chunk                                                          CHUNK
  class                                                          CLASS
  clause                                                         CLAUSE
  close                                                          CLOSE
  co                                                             CO
  code                                                           CODE
  common                                                         COMMON
  complex                                                        COMPLEX
  component                                                      COMPONENT
  computed                                                       COMPUTED
  condition                                                      CONDITION
  connect                                                        CONNECT
  constant                                                       CONSTANT
  construct                                                      CONSTRUCT
  constructor                                                    CONSTRUCTOR
  contained                                                      CONTAINED
  contains                                                       CONTAINS
  contiguous                                                     CONTIGUOUS
  continue                                                       CONTINUE
  control                                                        CONTROL
  cray                                                           CRAY
  critical                                                       CRITICAL
  cycle                                                          CYCLE
  data                                                           DATA
  deallocate                                                     DEALLOCATE
  declare                                                        DECLARE
  decl                                                           DECL
  deferred                                                       DEFERRED
  defined                                                        DEFINED
  definition                                                     DEFINITION
  delete                                                         DELETE
  derived                                                        DERIVED
  designator                                                     DESIGNATOR
  device                                                         DEVICE
  DIM                                                            DIMENSION
  do                                                             DO
  dtio                                                           DTIO
  dummy                                                          DUMMY
  E                                                              EXPR
  elemental                                                      ELEMENTAL
  element                                                        ELEMENT
  else                                                           ELSE
  end                                                            END
  EN                                                             ENTITY
  enter                                                          ENTER
  entry                                                          ENTRY
  enum                                                           ENUM
  enumerator                                                     ENUMERATOR
  equivalence                                                    EQUIVALENCE
  exit                                                           EXIT
  explicit                                                       EXPLICIT
  extends                                                        EXTENDS
  external                                                       EXTERNAL
  file                                                           FILE
  filename                                                       FILENAME
  final                                                          FINAL
  finalizer                                                      FINALIZER
  flush                                                          FLUSH
  forall                                                         FORALL
  format                                                         FORMAT
  function                                                       FUNCTION
  generic                                                        GENERIC
  G                                                              GLOBAL
  goto                                                           GOTO
  group                                                          GROUP
  hollerith                                                      HOLLERITH
  host                                                           HOST
  identifier                                                     IDENTIFIER
  if                                                             IF
  implicit                                                       IMPLICIT
  import                                                         IMPORT
  include                                                        INCLUDE
  init                                                           INIT
  input                                                          INPUT
  inquire                                                        INQUIRE
  inquiry                                                        INQUIRY
  integer                                                        INTEGER
  intent                                                         INTENT
  interface                                                      INTERFACE
  internal                                                       INTERNAL
  intrinsic                                                      INTRINSIC
  io                                                             IO
  is                                                             IS
  item                                                           ITEM
  iterator                                                       ITERATOR
  kernels                                                        KERNELS
  K                                                              KIND
  label                                                          LABEL
  LC                                                             LOCAL
  len                                                            LEN
  letter                                                         LETTER
  literal                                                        LITERAL
  logical                                                        LOGICAL
  loop                                                           LOOP
  lower                                                          LOWER
  LT                                                             LIST
  mark                                                           MARK
  mask                                                           MASK
  master                                                         MASTER
  module                                                         MODULE
  named                                                          NAMED
  namelist                                                       NAMELIST
  nature                                                         NATURE
  N                                                              NAME
  none                                                           NONE
  non_overridable                                                NON_OVERRIDABLE
  nopass                                                         NOPASS
  NS                                                             NAMESPACE
  nullify                                                        NULLIFY
  numeric                                                        NUMERIC
  obj                                                            OBJECT
  omp                                                            OMP
  openacc                                                        OPENACC
  openmp                                                         OPENMP
  open                                                           OPEN
  op                                                             OPERATOR
  optional                                                       OPTIONAL
  ordered                                                        ORDERED
  output                                                         OUTPUT
  parallel                                                       PARALLEL
  parameter                                                      PARAMETER
  parens                                                         PARENS
  parent                                                         PARENT
  pass                                                           PASS
  pause                                                          PAUSE
  pointee                                                        POINTEE
  pointer                                                        POINTER
  pos                                                            POS
  prefix                                                         PREFIX
  print                                                          PRINT
  private                                                        PRIVATE
  procedure                                                      PROCEDURE
  proc                                                           PROC
  program                                                        PROGRAM
  protected                                                      PROTECTED
  public                                                         PUBLIC
  pure                                                           PURE
  range                                                          RANGE
  rank                                                           RANK
  read                                                           READ
  real                                                           REAL
  recursive                                                      RECURSIVE
  reduction                                                      REDUCTION
  rename                                                         RENAME
  repeat                                                         REPEAT
  result                                                         RESULT
  return                                                         RETURN
  rewind                                                         REWIND
  routine                                                        ROUTINE
  R                                                              REF
  saved                                                          SAVED
  save                                                           SAVE
  section                                                        SECTION
  sections                                                       SECTIONS
  selectcase                                                     SELECTCASE
  selector                                                       SELECTOR
  select                                                         SELECT
  selecttype                                                     SELECTTYPE
  sequence                                                       SEQUENCE
  serial                                                         SERIAL
  set                                                            SET
  shape                                                          SHAPE
  share                                                          SHARE
  shutdown                                                       SHUTDOWN
  single                                                         SINGLE
  size                                                           SIZE
  specific                                                       SPECIFIC
  spec                                                           SPEC
  S                                                              SYMBOL
  star                                                           STAR
  status                                                         STATUS
  step                                                           STEP
  stmt                                                           STMT
  stop                                                           STOP
  stride                                                         STRIDE
  string                                                         STRING
  submodule                                                      SUBMODULE
  subroutine                                                     SUBROUTINE
  subscript                                                      SUBSCRIPT
  target                                                         TARGET
  test                                                           TEST
  then                                                           THEN
  thread                                                         THREAD
  triplet                                                        TRIPLET
  T                                                              TYPE
  unit                                                           UNIT
  unkwown                                                        UNKNOWN
  update                                                         UPDATE
  upper                                                          UPPER
  user                                                           USER
  use                                                            USE
  value                                                          VALUE
  volatile                                                       VOLATILE
  V                                                              VARIABLE
  wait                                                           WAIT
  where                                                          WHERE
  work                                                           WORK
  write                                                          WRITE
];


{
  my $fhp = 'FileHandle'->new ('>../FXTRAN_ALPHA.pm');
  $fhp->print (<< 'EOF');
package FXTRAN_ALPHA;

use strict;

EOF


  my %a2f = @x;
  for (values (%a2f))
    {
      $_ = lc ($_);
    }
  my %f2a = reverse (%a2f);

  local $Data::Dumper::Terse = 1;
  $fhp->print ("my %U2S = %{");
  $fhp->print (&Dumper (\%f2a));
  $fhp->print ("};\n");
  $fhp->print ("my %S2U = %{");
  $fhp->print (&Dumper (\%a2f));
  $fhp->print ("};\n");
  $fhp->print (<< 'EOF');

sub lookupU2S
{
  my $x = shift;
  unless (exists ($U2S{$x}))
    {
      my @x = split (m/-/o, $x);
      $_ = $U2S{$_} for (@x);
      if (grep { !defined ($_) } @x)
        {
          die ("Cannot translate $x\n");
        }
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
      $_ = $S2U{$_} for (@x);
      if (grep { !defined ($_) } @x)
        {
          die ("Cannot translate $x\n");
        }
      $S2U{$x} = join ('-', @x);
      $U2S{$S2U{$x}} = $x;
    }
  return $S2U{$x};
}

1;
EOF
}


{
  my $fhh = 'FileHandle'->new ('>FXTRAN_ALPHA.h');

  $fhh->print (<< 'EOF');
#ifndef _FXTRAN_ALPHA_H
#define _FXTRAN_ALPHA_H


#define _S(x) FXTRAN_STRING_##x
#define H "-"
#define _T(x) x

EOF

  while (my ($str, $key) = splice (@x, 0, 2))
    {
      $fhh->printf ("#define FXTRAN_STRING_%-30s \"%s\"\n", $key, $str);
    }

  $fhh->print ("#endif\n");

}
