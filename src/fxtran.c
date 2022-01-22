/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */

#include <stdlib.h>

#include "FXTRAN_RUN.h"

int main (int argc, char * argv[])
{
  char * Text = 
"X = Y (1:KLON)\n"
"END\n"
;

  return FXTRAN_RUN (argc, argv, Text, NULL);
//return run (argc, argv, NULL, NULL);
}
