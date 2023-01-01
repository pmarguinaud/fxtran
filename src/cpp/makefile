
TOP=../..

include $(TOP)/makefile.inc

all: libcpp.a libiberty.a

CFLAGS+=-DHAVE_CONFIG_H -g -I.

OBJ_CPP=charset.o expr.o init.o macro.o   \
        symtab.o directives.o files.o lex.o mkdeps.o traditional.o \
        errors.o identifiers.o line-map.o pch.o

OBJ_IBERTY=xmalloc.o safe-ctype.o xmemdup.o xexit.o \
        hex.o xstrerror.o xstrdup.o lbasename.o md5.o hashtab.o 

libcpp.a: $(OBJ_CPP)
	ar rv libcpp.a $(OBJ_CPP)
        
libiberty.a: $(OBJ_IBERTY)
	ar rv libiberty.a $(OBJ_IBERTY)
        
clean:
	\rm -f *.o *.a *~
