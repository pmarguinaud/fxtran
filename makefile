
export ROOT=$(shell pwd)

all: 
	cd src && $(MAKE)
	cd perl5 && $(MAKE)
	cd python3 && $(MAKE)
	@mkdir -p share/man/man1
	@LD_LIBRARY_PATH=lib ./bin/fxtran -help-pod | pod2man -n fxtran -r "" -c "" | gzip -c > share/man/man1/fxtran.1.gz

clean: 
	cd src && make clean
	cd perl5 && make clean
	cd python3 && make clean
	./scripts/debian/clean.sh


