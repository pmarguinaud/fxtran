#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "FXTRAN/RUN.h"


MODULE = fxtran		PACKAGE = fxtran		

void
run (...)
PPCODE:
        int i;
        int argc = items+1;
        char * argv[argc > 1 ? argc : 2];
        if (items < 1)
          croak ("Usage: fxtran::run (option, ..., text)");
        argv[0] = "";
        for (i = 0; i < argc-2; i++)
          argv[i+1] = SvPV_nolen (ST (i));
        argv[argc-1] = "_.F90";
   
        char * Xml = NULL, * Err = NULL;
        char * Text = SvPV_nolen (ST (items-1));

        FXTRAN_RUN (argc, argv, Text, &Xml, &Err);
 
        if (Err)
          {
            /* croak_sv does not return: copy, then free what fxtran allocated */
            SV * err = sv_2mortal (newSVpv (Err, 0));
            free (Err);
            free (Xml);
            croak_sv (err);
          }
        else
          {
            EXTEND (SP, 1);
            PUSHs (sv_2mortal (newSVpv (Xml, 0)));
            free (Xml);
          }
        
