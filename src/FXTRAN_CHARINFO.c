#include "FXTRAN_CHARINFO.h"
#include "FXTRAN_MASK.h"

#include <string.h>
#include <stdlib.h>

void FXTRAN_char_info_init (FXTRAN_char_info * ci, int len)
{                                                                              
  int i;                                                                       
  memset (ci, '\0', (len+1) * sizeof (FXTRAN_char_info));                   
  for (i = 0; i < len; i++)                                                  
    ci[i].mask = FXTRAN_SPC;                                                  
} 

void FXTRAN_char_info_alloc (FXTRAN_char_info ** pci, int len)
{
  FXTRAN_char_info * ci = (FXTRAN_char_info*)malloc (((len)+1) * sizeof (FXTRAN_char_info));     
  FXTRAN_char_info_init (ci, len);                                           
  *pci = ci;                                                               
} 

void FXTRAN_char_info_free (FXTRAN_char_info ** pci)
{
  free (*pci);     
  *pci = NULL;        
}


