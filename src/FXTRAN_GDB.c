/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "FXTRAN_GDB.h"
#include <stdio.h>

void FXTRAN_save_args (int argc, char * argv[])
{
  FILE * fp = fopen ("main.gdb", "w");
  int i;

  fprintf (fp, "start");
  for (i = 1; i < argc; i++)
    fprintf (fp, "  %s", argv[i]);
  fprintf (fp, "\n");
  
  fclose (fp);

}

void FXTRAN_save_where (const char * f, int l)
{
  FILE * fp = fopen ("main.gdb", "a");
  fprintf (fp, "b %s:%d\n", f, l);
  fprintf (fp, "cont\n");
  fprintf (fp, "where\n");
  fclose (fp);
}
