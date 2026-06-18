
FXTRAN ?= ../../bin/fxtran

SOURCES = \
  f03_01_oop_extends.f90 \
  f03_02_oop_abstract.f90 \
  f03_03_oop_typebound.f90 \
  f03_04_iso_c_binding.f90 \
  f03_05_proc_pointer.f90 \
  f03_06_alloc_enhanced.f90 \
  f03_07_enum.f90 \
  f03_08_io.f90 \
  f03_09_volatile_protected.f90 \
  f03_10_import.f90 \
  f03_11_iso_fortran_env.f90 \
  f03_12_intrinsics.f90 \
  f03_13_param_derived.f90 \
  f03_14_associate.f90 \
  f03_15_async.f90 \
  f03_16_ieee.f90

XMLS = $(SOURCES:.f90=.f90.xml)

all: $(XMLS)

%.f90.xml: %.f90
	$(FXTRAN) $< -o $@

clean:
	\rm -f $(XMLS)
