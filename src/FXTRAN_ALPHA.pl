#!/usr/bin/perl -w
#unkwown                                                        UNKNOWN
#
use strict;
use FileHandle;
use Data::Dumper;


my @x = qw[
  abstract                                                       ABSTRACT
  ac                                                             AC
  access                                                         ACCESS
  action                                                         ACTION
  allocatable                                                    ALLOCATABLE
  allocate                                                       ALLOCATE
  alt                                                            ALT
  ambiguous                                                      AMBIGUOUS
  arg                                                            ARG
  arithmetic                                                     ARITHMETIC
  array                                                          ARRAY
  assign                                                         ASSIGN
  assigned                                                       ASSIGNED
  a                                                              ASSIGNMENT
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
  call                                                           CALL
  case                                                           CASE
  char                                                           CHAR
  character                                                      CHARACTER
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
  decl                                                           DECL
  deferred                                                       DEFERRED
  defined                                                        DEFINED
  definition                                                     DEFINITION
  delete                                                         DELETE
  derived                                                        DERIVED
  designator                                                     DESIGNATOR
  DIM                                                            DIMENSION
  do                                                             DO
  dtio                                                           DTIO
  dummy                                                          DUMMY
  else                                                           ELSE
  element                                                        ELEMENT
  elemental                                                      ELEMENTAL
  end                                                            END
  EN                                                             ENTITY
  entry                                                          ENTRY
  enum                                                           ENUM
  enumerator                                                     ENUMERATOR
  equivalence                                                    EQUIVALENCE
  exit                                                           EXIT
  explicit                                                       EXPLICIT
  E                                                              EXPR
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
  if                                                             IF
  hollerith                                                      HOLLERITH
  implicit                                                       IMPLICIT
  import                                                         IMPORT
  include                                                        INCLUDE
  inquire                                                        INQUIRE
  inquiry                                                        INQUIRY
  init                                                           INIT
  input                                                          INPUT
  intent                                                         INTENT
  interface                                                      INTERFACE
  integer                                                        INTEGER
  internal                                                       INTERNAL
  intrinsic                                                      INTRINSIC
  io                                                             IO
  is                                                             IS
  item                                                           ITEM
  iterator                                                       ITERATOR
  K                                                              KIND
  label                                                          LABEL
  len                                                            LEN
  letter                                                         LETTER
  LT                                                             LIST
  literal                                                        LITERAL
  LC                                                             LOCAL
  logical                                                        LOGICAL
  lower                                                          LOWER
  mark                                                           MARK
  mask                                                           MASK
  master                                                         MASTER
  module                                                         MODULE
  N                                                              NAME
  named                                                          NAMED
  NS                                                             NAMESPACE
  namelist                                                       NAMELIST
  nature                                                         NATURE
  none                                                           NONE
  non_overridable                                                NON_OVERRIDABLE
  nopass                                                         NOPASS
  nullify                                                        NULLIFY
  numeric                                                        NUMERIC
  obj                                                            OBJECT
  omp                                                            OMP
  open                                                           OPEN
  openmp                                                         OPENMP
  op                                                             OPERATOR
  optional                                                       OPTIONAL
  ordered                                                        ORDERED
  output                                                         OUTPUT
  parallel                                                       PARALLEL
  parameter                                                      PARAMETER
  parens                                                         PARENS
  pass                                                           PASS
  pause                                                          PAUSE
  pointee                                                        POINTEE
  pointer                                                        POINTER
  pos                                                            POS
  prefix                                                         PREFIX
  print                                                          PRINT
  private                                                        PRIVATE
  proc                                                           PROC
  procedure                                                      PROCEDURE
  program                                                        PROGRAM
  protected                                                      PROTECTED
  public                                                         PUBLIC
  pure                                                           PURE
  range                                                          RANGE
  read                                                           READ
  reduction                                                      REDUCTION
  R                                                              REF
  rank                                                           RANK
  real                                                           REAL
  recursive                                                      RECURSIVE
  rename                                                         RENAME
  repeat                                                         REPEAT
  result                                                         RESULT
  return                                                         RETURN
  rewind                                                         REWIND
  save                                                           SAVE
  saved                                                          SAVED
  section                                                        SECTION
  sections                                                       SECTIONS
  select                                                         SELECT
  selectcase                                                     SELECTCASE
  selecttype                                                     SELECTTYPE
  selector                                                       SELECTOR
  sequence                                                       SEQUENCE
  set                                                            SET
  shape                                                          SHAPE
  share                                                          SHARE
  single                                                         SINGLE
  size                                                           SIZE
  spec                                                           SPEC
  specific                                                       SPECIFIC
  star                                                           STAR
  status                                                         STATUS
  step                                                           STEP
  stmt                                                           STMT
  stop                                                           STOP
  stride                                                         STRIDE
  string                                                         STRING
  strip                                                          STRIP
  subroutine                                                     SUBROUTINE
  subscript                                                      SUBSCRIPT
  S                                                              SYMBOL
  target                                                         TARGET
  test                                                           TEST
  then                                                           THEN
  thread                                                         THREAD
  triplet                                                        TRIPLET
  T                                                              TYPE
  unit                                                           UNIT
  unkwown                                                        UNKNOWN
  upper                                                          UPPER
  use                                                            USE
  user                                                           USER
  value                                                          VALUE
  V                                                              VARIABLE
  volatile                                                       VOLATILE
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
