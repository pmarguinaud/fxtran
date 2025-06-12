TOP=..

include $(TOP)/makefile.inc

OBJ=FXTRAN_EXPR.o FXTRAN_FBUFFER.o FXTRAN_FIXED.o FXTRAN_FREE.o FXTRAN_GDB.o \
    FXTRAN_MISC.o FXTRAN_OMP.o FXTRAN_STMT.o FXTRAN_XML.o FXTRAN_OPTS.o      \
    FXTRAN_FILE_FUNC.o FXTRAN_LOAD.o FXTRAN_CPP_INTF.o FXTRAN_XCP.o          \
    FXTRAN_BBT.o FXTRAN_FILE.o FXTRAN_NAMELIST.o FXTRAN_ACC.o FXTRAN_DDD.o   \
    FXTRAN_RUN.o FXTRAN_ERROR.o FXTRAN_CHARINFO.o

ifeq ($(DEB_BUILD_ARCH), )
RPATH=-Wl,-rpath,$(ROOT)/lib
endif

all: $(TOP)/bin/fxtran $(TOP)/lib/libfxtran.so.0

ifeq ($(STATIC), 1)

$(TOP)/bin/fxtran: FXTRAN_ALPHA.h fxtran.o $(TOP)/lib/libfxtran.so.0
	@mkdir -p ../bin
	$(CC) -o $(TOP)/bin/fxtran fxtran.o $(OBJ) cpp/*.o obstack/*.o -L$(TOP)/lib $(LDFLAGS)

else

$(TOP)/bin/fxtran: FXTRAN_ALPHA.h fxtran.o $(TOP)/lib/libfxtran.so.0
	@mkdir -p ../bin
	$(CC) -o $(TOP)/bin/fxtran fxtran.o $(RPATH) -L$(TOP)/lib -lfxtran $(LDFLAGS)

endif

$(TOP)/lib/libfxtran.so.0: $(OBJ)
	cd cpp && make
	cd obstack && make
	@mkdir -p ../lib
	$(CC) -shared -Wl,-soname,libfxtran.so.0 -o $(TOP)/lib/libfxtran.so.0 $(OBJ) cpp/*.o obstack/*.o $(LDFLAGS)
	@ln -sf libfxtran.so.0 $(TOP)/lib/libfxtran.so

FXTRAN_ALPHA.h: FXTRAN_ALPHA.pl
	@./FXTRAN_ALPHA.pl
clean:
	\rm -f *.o *~ $(TOP)/bin/fxtran $(TOP)/lib/libfxtran.so.0 $(TOP)/lib/libfxtran.so
	cd cpp && make clean
	cd obstack && make clean


