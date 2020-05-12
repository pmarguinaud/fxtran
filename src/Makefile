OBJ=FXTRAN_EXPR.o FXTRAN_FBUFFER.o FXTRAN_FIXED.o FXTRAN_FREE.o FXTRAN_GDB.o \
    FXTRAN_MISC.o FXTRAN_OMP.o FXTRAN_STMT.o FXTRAN_XML.o FXTRAN_OPTS.o      \
    FXTRAN_FILE_FUNC.o FXTRAN_CPP.o FXTRAN_CPP_INTF.o FXTRAN_XCP.o           \
    FXTRAN_BBT.o FXTRAN_FILE.o FXTRAN_NAMELIST.o fxtran.o 

EXE=../fxtran
CFLAGS=-Wall -g -I cpp -O0


$(EXE): FXTRAN_ALPHA.h $(OBJ) 
	cd cpp && make
	cc -o $(EXE) $(OBJ) -Lcpp -lcpp -liberty

FXTRAN_ALPHA.h: FXTRAN_ALPHA.pl
	@./FXTRAN_ALPHA.pl
clean:
	\rm -f *.o $(EXE) *~
	cd cpp && make clean


