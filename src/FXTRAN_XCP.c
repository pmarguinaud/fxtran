/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "FXTRAN_XCP.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_XML.h"

#include <string.h>
#include <stdlib.h>

static int
delta (FXTRAN_xcp * xcp)
{
  int len = 0;
  int i;
  for (i = 0; i < xcp->n; i++)
    {
      FXTRAN_xcp_item *xci = &xcp->s[i];
      int cst = xci->c1 < 0;
      char *txt = cst ? (char *) xci->xcp + xci->c2 : NULL;
      len += (cst ? strlen (txt) : xci->c2 - xci->c1);
    }
  return xcp->c2 - xcp->c1 - len;
}

static FXTRAN_xcp_mask *
FXTRAN_get_xcp_mask (int norig, int ncode)
{
  FXTRAN_xcp_mask * cpp_mask =
    (FXTRAN_xcp_mask *) calloc (1, sizeof (FXTRAN_xcp_mask) +
				   sizeof (short) * (norig+1) +
				   sizeof (FXTRAN_xcp_mask_item) * (ncode+1));
  cpp_mask->norig = norig;
  cpp_mask->ncode = ncode;
  cpp_mask->orig = (short *) ((char *) cpp_mask + sizeof (FXTRAN_xcp_mask));
  cpp_mask->code =
    (FXTRAN_xcp_mask_item *) ((char *) cpp_mask->orig + sizeof (short) * (norig+1));

  return cpp_mask;
}


FXTRAN_xcp_mask *
FXTRAN_delta_back (FXTRAN_xcp * xcp, int len, struct FXTRAN_xmlctx * ctx)
{
  short *p0, *p1;
  int i, j, k = 0, i0, i1;
  int len0, len1;
  FXTRAN_xcp_mask * cpp_mask;

  if (xcp == NULL)
    return NULL;

#define PA(size) (short*)calloc (1, sizeof (short) * (size))
#define pP do { int i; for (i = 0; i < len0; i++) printf (" %2.2d", p0[i]); printf ("\n"); } while(0)
#undef DELTADEBUG

  len0 = len;
  p0 = PA (len0);
  for (i = 0; i < len0; i++)
    p0[i] = i + 1;

  for (; xcp; xcp = xcp->next, k++, len0 = len1, p0 = p1)
    {
#ifdef DELTADEBUG
      pP;
#endif
      len1 = len0 + delta (xcp);
#ifdef DELTADEBUG
      printf (" len1 = %d, len0 = %d, c1 = %d, c2 = %d\n", len1, len0,
	      xcp->c1, xcp->c2);
#endif
      p1 = PA (len1);
      for (i0 = 0, i1 = 0; i0 < len0; i0++, i1++)
	{
#ifdef DELTADEBUG
	  printf (" len1 = %d, i1 = %d, len0 = %d, i0 = %d, P0 = %d\n", len1,
		  i1, len0, i0, p0[i0]);
#endif
	  if (i1 + 1 < xcp->c1)
	    {
	      p1[i1] = p0[i0];
	    }
	  else if (i1 + 1 < xcp->c2)
	    {
	      int k = xcp->c1 > 0 ? 0 : 1;
	      if (k == 0)
		p1[i1] = p0[i0];
#ifdef DELTADEBUG
	      printf ("---\n");
#endif
	      i0 += (xcp->c2 - xcp->c1) - (len1 - len0) - k;
	      i1 += xcp->c2 - xcp->c1 - k;
	    }
	  else
	    {
#ifdef DELTADEBUG
	      printf ("+++\n");
#endif
	      if (!(i1 < len1))
		FXTRAN_ABORT ("cpp hacking failed");
	      p1[i1] = p0[i0];
	    }
	}
      free (p0);
    }
#ifdef DELTADEBUG
  pP;
#endif

  void * id = NULL;
  int kc1 = 0, kc2 = 0;
  cpp_mask = FXTRAN_get_xcp_mask (len0, len);
  for (i = 0; i < cpp_mask->norig; i++)
    {
      cpp_mask->orig[i] = p0[i];
      if (p0[i] > 0)
	{
	  for (j = 0; j < p0[i] - 1; j++)
	    if ((cpp_mask->code[j].c == 0) && (cpp_mask->code[j].c1 == 0))
	      {
		if (id == 0)
		  id = &cpp_mask->code[j].c1;
		cpp_mask->code[j].c1 = kc1;
		cpp_mask->code[j].c2 = kc2;
		cpp_mask->code[j].id = id;
	      }
	    else
	      {
		id = 0;
	      }
	  kc1 = kc2 = 0;
	  cpp_mask->code[p0[i] - 1].c = i + 1;
	}
      else if (kc1 == 0)
	{
	  kc2 = kc1 = i + 1;
	}
      else
	{
	  kc2 = i + 1;
	}
    }
  for (j = 0; j < len; j++)
    if ((cpp_mask->code[j].c == 0) && (cpp_mask->code[j].c1 == 0))
      {
	if (id == 0)
	  id = &cpp_mask->code[j].c1;
	cpp_mask->code[j].c1 = kc1;
	cpp_mask->code[j].c2 = kc2;
	cpp_mask->code[j].id = id;
      }
    else
      {
	id = 0;
      }

  free (p0);

  return cpp_mask;
}

void FXTRAN_cpp_mask_free (FXTRAN_xcp_mask * cpp_mask)
{
  free (cpp_mask);
}

void FXTRAN_xcp_list_free (FXTRAN_xcp * xcp)
{
  FXTRAN_xcp * xcp1;
  for (; xcp;)
    {
      xcp1 = xcp->next;
      free (xcp);
      xcp = xcp1;
    }
}
