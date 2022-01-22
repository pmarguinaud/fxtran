/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */

#include <stdlib.h>
#include <stdio.h>

#include "FXTRAN_RUN.h"

int main (int argc, char * argv[])
{
#ifdef UNDEF
  char * Xml;
  char * Text = 
"X = Y (1:KLON)\n"
"END\n"
;

  int c = FXTRAN_RUN (argc, argv, Text, &Xml);
  printf ("%s", Xml);
  return c;
#endif
  return FXTRAN_RUN (argc, argv, NULL, NULL);
}
