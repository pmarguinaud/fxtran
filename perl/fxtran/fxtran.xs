#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "FXTRAN_RUN.h"


MODULE = fxtran		PACKAGE = fxtran		

void
hello()
    CODE:
        printf("Hello, world!\n");
        char * Xml;
        char * Text = "X = Y (1:KLON)\nEND\n" ;
        int argc = 2;
        char * argv[2] = {"", "_.F90"};
        FXTRAN_RUN (argc, argv, Text, &Xml);
        FILE * fp = fopen ("_.xml", "w");
        fprintf (fp, "%s", Xml);
        fclose (fp);
        


