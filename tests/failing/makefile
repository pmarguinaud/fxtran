
# Tests negatifs: fxtran doit echouer sur chacun de ces fichiers.
# Chaque test est considere PASS si fxtran retourne un code d'erreur non nul.

FXTRAN ?= ../../bin/fxtran

SOURCES = \
  fail_01_end_abstract_interface.f90 \
  fail_02_end_abstract_iface_cascades.f90

all: $(SOURCES:.f90=.f90.tested)

%.f90.tested: %.f90
	@if $(FXTRAN) $< -o /dev/null 2>/dev/null; then \
	  echo "UNEXPECTED PASS (fxtran should have failed): $<"; \
	  exit 1; \
	else \
	  echo "EXPECTED FAIL (ok): $<"; \
	  touch $@; \
	fi

clean:
	\rm -f $(SOURCES:.f90=.f90.tested)
