
TOP=../..

include $(TOP)/makefile.inc

all: libfxtran-obstack.a

CFLAGS+=-g -I.

OBJ=fxtran-obstack.o

libfxtran-obstack.a: $(OBJ)
	ar rv libfxtran-obstack.a $(OBJ)
        
clean:
	\rm -f *.o *.a *~
