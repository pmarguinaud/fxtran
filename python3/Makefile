
fxtran.so: fxtran.c
	gcc -g -fPIC --shared `python3-config --includes` -I../src fxtran.c -L../lib -lfxtran -o fxtran.so

clean:
	\rm -f *.so
