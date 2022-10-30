OBJ=FXTRAN_EXPR.o FXTRAN_FBUFFER.o FXTRAN_FIXED.o FXTRAN_FREE.o FXTRAN_GDB.o \
    FXTRAN_MISC.o FXTRAN_OMP.o FXTRAN_STMT.o FXTRAN_XML.o FXTRAN_OPTS.o      \
    FXTRAN_FILE_FUNC.o FXTRAN_LOAD.o FXTRAN_CPP_INTF.o FXTRAN_XCP.o          \
    FXTRAN_BBT.o FXTRAN_FILE.o FXTRAN_NAMELIST.o FXTRAN_ACC.o FXTRAN_DDD.o   \
    FXTRAN_RUN.o FXTRAN_ERROR.o

EXE=../bin/fxtran
LIB=../lib/libfxtran.a

CFLAGS=-Wall -g -fPIC -I cpp -O2

all: $(EXE) $(LIB)


$(EXE): FXTRAN_ALPHA.h fxtran.o $(OBJ) 
	@mkdir -p ../bin
	cd cpp && make
	$(CC) -o $(EXE) fxtran.o $(OBJ) -Lcpp -lcpp -liberty

$(LIB): $(OBJ)
	@mkdir -p ../lib
	ar crv $(LIB) $(OBJ) cpp/*.o

FXTRAN_ALPHA.h: FXTRAN_ALPHA.pl
	@./FXTRAN_ALPHA.pl
clean:
	\rm -f *.o $(EXE) *~ $(LIB)
	cd cpp && make clean


