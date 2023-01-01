all: blib/arch/auto/fxtran/fxtran.so

install: Makefile
	make install -f Makefile

Makefile:
	perl Makefile.PL

blib/arch/auto/fxtran/fxtran.so: fxtran.xs Makefile
	make -f Makefile

clean: Makefile
	make clean -f Makefile
	\rm -f Makefile.old

test: Makefile
	make test -f Makefile

