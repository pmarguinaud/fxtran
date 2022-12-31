
fxtran.so: fxtran.c
	gcc -g -fPIC --shared `python3-config --includes` -I../include fxtran.c -Wl,-rpath,../lib -L../lib -lfxtran -o fxtran.so

clean:
	\rm -f *.so
