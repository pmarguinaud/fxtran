all: 
	cd src && make

clean: 
	cd src && make clean

dist: clean
	perl -e ' my $$t = time (); my $$d = "fxtran-$$t"; mkdir ($$d); system ("cp -r src Makefile $$d/ ; tar zcvf $$d.tgz $$d ; rm -rf $$d"); '


