#!/usr/bin/perl -w

use strict;
use FileHandle;
use Data::Dumper;

my @x = qw[
  a                                                              ASSIGNMENT
  abstract                                                       ABSTRACT
  ac                                                             AC
  access                                                         ACCESS
  action                                                         ACTION
  all                                                            ALL
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
  change                                                         CHANGE
  character                                                      CHARACTER
  char                                                           CHAR
  chunk                                                          CHUNK
  class                                                          CLASS
  clause                                                         CLAUSE
  close                                                          CLOSE
  coarray                                                        COARRAY
  cobound                                                        COBOUND
  codimension                                                    CODIMENSION
  coshape                                                        COSHAPE
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
  cosection                                                      COSECTION
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
  error                                                          ERROR
  event                                                          EVENT
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
  form                                                           FORM
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
  images                                                         IMAGES
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
  lock                                                           LOCK
  logical                                                        LOGICAL
  loop                                                           LOOP
  lower                                                          LOWER
  LT                                                             LIST
  mark                                                           MARK
  mask                                                           MASK
  master                                                         MASTER
  memory                                                         MEMORY
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
  post                                                           POST
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
  selectrank                                                     SELECTRANK
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
  stat                                                           STAT
  status                                                         STATUS
  step                                                           STEP
  stmt                                                           STMT
  stop                                                           STOP
  stride                                                         STRIDE
  string                                                         STRING
  submodule                                                      SUBMODULE
  subroutine                                                     SUBROUTINE
  subscript                                                      SUBSCRIPT
  sync                                                           SYNC
  target                                                         TARGET
  team                                                           TEAM
  test                                                           TEST
  then                                                           THEN
  thread                                                         THREAD
  triplet                                                        TRIPLET
  T                                                              TYPE
  unit                                                           UNIT
  unlock                                                         UNLOCK
  unknown                                                        UNKNOWN
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
  my $fhp = 'FileHandle'->new ('>../perl5/lib/fxtran/alpha.pm');
  $fhp->print (<< 'EOF');
package fxtran::alpha;

use strict;

EOF


  my %a2f = @x;
  for (values (%a2f))
    {
      $_ = lc ($_);
    }
  for my $k (keys (%a2f))
    {
      delete $a2f{$k} if ($k eq $a2f{$k});
    }
  my %f2a = reverse (%a2f);

  local $Data::Dumper::Terse = 1;
  local $Data::Dumper::Sortkeys = 1;
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
