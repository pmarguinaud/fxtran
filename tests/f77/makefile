
FXTRAN ?= ../../bin/fxtran

SOURCES = \
  f77_01_program.f \
  f77_02_subroutine.f \
  f77_03_function.f \
  f77_04_block_data.f \
  f77_05_types.f \
  f77_06_specification.f \
  f77_07_control_if.f \
  f77_08_control_do.f \
  f77_09_control_goto.f \
  f77_10_io_write.f \
  f77_11_io_read.f \
  f77_12_io_file.f \
  f77_13_data_common.f \
  f77_14_equivalence.f \
  f77_15_intrinsic.f \
  f77_16_character.f

XMLS = $(SOURCES:.f=.f.xml)

all: $(XMLS)

%.f.xml: %.f
	$(FXTRAN) $< -o $@
	@diff $@ xml/$@

clean:
	\rm -f $(XMLS)
