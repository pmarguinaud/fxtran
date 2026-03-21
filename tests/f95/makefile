
FXTRAN ?= ../../bin/fxtran

SOURCES = \
  f95_01_module.f90 \
  f95_02_derived_type.f90 \
  f95_03_interface.f90 \
  f95_04_select_case.f90 \
  f95_05_do.f90 \
  f95_06_where.f90 \
  f95_07_forall.f90 \
  f95_08_pointers.f90 \
  f95_09_attributes.f90 \
  f95_10_arrays.f90 \
  f95_11_namelist.f90 \
  f95_12_intrinsics.f90 \
  f95_13_io.f90 \
  f95_14_contains.f90

XMLS = $(SOURCES:.f90=.f90.xml)

all: $(XMLS)

%.f90.xml: %.f90
	$(FXTRAN) $< -o $@

clean:
	\rm -f $(XMLS)
