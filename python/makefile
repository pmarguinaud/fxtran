
fxtran.so: fxtran.c
	gcc -fPIC --shared `python-config --includes` -I../src fxtran.c -L../lib -lfxtran -o fxtran.so

clean:
	\rm -f *.so
