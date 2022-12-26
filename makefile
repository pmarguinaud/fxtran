all: 
	cd src && make
	cd perl && make
	cd python3 && make

clean: 
	cd src && make clean
	cd perl && make clean
	cd python3 && make clean
	./scripts/debian/clean.sh


