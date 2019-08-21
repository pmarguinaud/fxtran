/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_XCP_H
#define _FXTRAN_XCP_H

typedef struct FXTRAN_xcp_item
{
  struct FXTRAN_xcp *xcp;
  short int c1, c2; 
} FXTRAN_xcp_item;

typedef struct FXTRAN_xcp
{
  struct FXTRAN_xcp *next;
  void *macro;
  short int c1, c2; 
  short int n;
  FXTRAN_xcp_item s[0];
} FXTRAN_xcp;

typedef struct FXTRAN_xcp_mask_item
{
  short c;
  short c1; 
  short c2; 
  short done;
  void * id; 
} FXTRAN_xcp_mask_item;

typedef struct FXTRAN_xcp_mask
{
  int norig, ncode;
  short *orig;
  FXTRAN_xcp_mask_item *code;
  short data[0];
} FXTRAN_xcp_mask;


FXTRAN_xcp * FXTRAN_get_xcp (int, int);

void FXTRAN_push_xcp (FXTRAN_xcp *, void *);

struct FXTRAN_xmlctx;

FXTRAN_xcp_mask *
FXTRAN_delta_back (FXTRAN_xcp * xcp, int len, struct FXTRAN_xmlctx * ctx);

void FXTRAN_cpp_mask_free (FXTRAN_xcp_mask *);
void FXTRAN_xcp_list_free (FXTRAN_xcp *);

#endif

