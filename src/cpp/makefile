
all: libcpp.a libiberty.a

libcpp.a: charset.c expr.c init.c macro.c pch.c \
          directives.c files.c lex.c symtab.c   \
          errors.c identifiers.c line-map.c mkdeps.c traditional.c
	cc -fPIC -DHAVE_CONFIG_H -Wall -g -I. -c  charset.c expr.c init.c macro.c pch.c \
          directives.c files.c lex.c symtab.c   \
          errors.c identifiers.c line-map.c mkdeps.c traditional.c
	ar rv libcpp.a charset.o expr.o init.o macro.o   \
        symtab.o directives.o files.o lex.o mkdeps.o traditional.o \
        errors.o identifiers.o line-map.o pch.o
        
libiberty.a: xmalloc.c safe-ctype.c xmemdup.c xexit.c hex.c xstrerror.c \
        xstrdup.c lbasename.c md5.c hashtab.c 
	cc -fPIC -DHAVE_CONFIG_H -Wall -g -I. -c xmalloc.c safe-ctype.c xmemdup.c xexit.c hex.c \
        xstrerror.c xstrdup.c lbasename.c md5.c hashtab.c 
	ar rv libiberty.a xmalloc.o safe-ctype.o xmemdup.o xexit.o \
        hex.o xstrerror.o xstrdup.o lbasename.o md5.o hashtab.o \
        
clean:
	\rm -f *.o *.a *~
