/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "FXTRAN_EXPR.h"
#include "FXTRAN_MISC.h"
#include "FXTRAN_STMT.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_ALPHA.h"
#include <ctype.h>
#include <string.h>


int FXTRAN_eat_integer_constant (const char * t)
{
  int k;
  for (k = 0; isdigit (t[k]); k++);
  return k;
}


static int FXTRAN_expr_kind_spec (const char * t, const FXTRAN_char_info * ci,
                                   FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  if (t[0] == '_')
    {
      int k;
      XST (_T(_S(KIND) H _S(SPEC)));
      XAD(1);
      if (isdigit (t[0]))
        {
          k = FXTRAN_eat_integer_constant (t);
          xml_mark_lit (ci->offset, ci[k-1].offset+1, ctx);
        }
      else if (isalpha (t[0]))
        {
          k = FXTRAN_eat_word (t);
	  XNT (_T(_S(NAME)), k);
        }
      else
        FXTRAN_THROW ("Expected either an integer or an identifier");
      XAD(k);
      XET ();
    }   

  return t - T;
}

int FXTRAN_expr_numeric_litteral_constant (const char * t, const FXTRAN_char_info * ci,
                                           FXTRAN_xmlctx * ctx, int op)
{
  const char * T = t;
  int seen_dot = 0;
  int k;

  if (! ctx->opts.flat_expr)
    XST (_T(_S(LITERAL) H _S(EXPR)));

  if (op && ((t[0] == '+') || (t[0] == '-')))
    XAD (1);
    

  while (1)
    {
      if (!(((!ci->dots) && (t[0] == '.')) || (isdigit (t[0]))))
        break;
      if (t[0] == '.')
        {
          if (seen_dot)
            break;
          seen_dot = 1;
        }
      XAD(1);
    }

  if (((t[0] == 'E') || (t[0] == 'D')))
    {
      const char * t1 = t;
      XAD(1);

      if ((t[0] == '+') || (t[0] == '-'))
        XAD(1);

      if (!isdigit (t[0]))
        {
          XAD(t1-t); /* backwards */
        }
      else
        {
          for (; isdigit (t[0]); )
            XAD(1);
        }

    }

  k = t - T;
  xml_mark_lit (ci[-k].offset, ci[-1].offset+1, ctx);

  XAD(FXTRAN_expr_kind_spec (t, ci, ctx));

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}

int FXTRAN_expr_logical_litteral_constant (const char * t, const FXTRAN_char_info * ci, 
                                           FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  if (! ctx->opts.flat_expr)
    XST (_T(_S(LITERAL) H _S(EXPR)));

  XAD(1);
  k = FXTRAN_eat_word (t);
  XAD(k);
  XAD(1);

  XAD(FXTRAN_expr_kind_spec (t, ci, ctx));

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}

static int FXTRAN_expr_boz_litteral_constant (const char * t, const FXTRAN_char_info * ci, 
                                               FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  if (! ctx->opts.flat_expr)
    XST (_T(_S(LITERAL) H _S(EXPR)));

  k = 3;
  xml_mark_boz (ci[0].offset, ci[k-1].offset+1, ctx);
  XAD(k);

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}

def_process_list_elt_proto(expr_parens_item) 
{
  int k;
  XST (_T(_S(ELEMENT)));

  if ((k = FXTRAN_str_at_level_ir (t, ci, ":", ci->parens, kmax)))
    {
      
    }
  else
    {
      FXTRAN_expr (t, ci, kmax, ctx);
    }

  XAD(kmax);
  XET ();
  return 1;
}

def_process_list_elt_proto (cosection_subscript)
{
  const char * T = t;
  int k;
  const char * tags[] = { _T(_S(LOWER) H _S(COBOUND)), 
	                  _T(_S(UPPER) H _S(COBOUND)), 
			  NULL };
  int itag = 0;
  int lev = ci->parens;

  k = FXTRAN_str_at_level_ir (t, ci, "=", lev, kmax);

  if (k > 0)
    return -1;

  XST (_T(_S(COSECTION) H _S(SUBSCRIPT)));

  k = FXTRAN_str_at_level_ir (t, ci, ":", lev, kmax);

  if (k)
    {
      if (k > 1)
        {
          XST (tags[itag]);
          FXTRAN_expr (t, ci, k-1, ctx);
          XAD(k-1);
          XET ();
        }
      itag++;
      XAD(1);

    }

  k = FXTRAN_str_at_level_ir (t, ci, ":", lev, kmax-(t-T));
  
  if (k)
    {
      if (k > 1)
        {
          XST (tags[itag]);
          FXTRAN_expr (t, ci, k-1, ctx);
          XAD(k-1);
          XET ();
        }
      itag++;
      XAD(1);
  
    }


  if (kmax-(t-T))
    {
      XST (tags[itag]);
      FXTRAN_expr (t, ci, kmax-(t-T), ctx);
      XAD(kmax-(t-T));
      XET ();
    }

  XET ();
  return 1;
}

def_process_list_elt_proto (section_subscript)
{
  const char * T = t;
  int k;
  const char * tags[] = { _T(_S(LOWER) H _S(BOUND)), 
	                  _T(_S(UPPER) H _S(BOUND)), 
			  _T(_S(STRIDE)), 
			  NULL };
  int itag = 0;
  int lev = ci->parens;

  XST (_T(_S(SECTION) H _S(SUBSCRIPT)));

  k = FXTRAN_str_at_level_ir (t, ci, ":", lev, kmax);

  if (k)
    {
      if (k > 1)
        {
          XST (tags[itag]);
          FXTRAN_expr (t, ci, k-1, ctx);
          XAD(k-1);
          XET ();
        }
      itag++;
      XAD(1);

    }

  k = FXTRAN_str_at_level_ir (t, ci, ":", lev, kmax-(t-T));
  
  if (k)
    {
      if (k > 1)
        {
          XST (tags[itag]);
          FXTRAN_expr (t, ci, k-1, ctx);
          XAD(k-1);
          XET ();
        }
      itag++;
      XAD(1);
  
    }


  if (kmax-(t-T))
    {
      XST (tags[itag]);
      FXTRAN_expr (t, ci, kmax-(t-T), ctx);
      XAD(kmax-(t-T));
      XET ();
    }

  XET ();
  return 1;
}

static int coarray_ref (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx *ctx)
{
  const char * T = t;
  int lev = ci[0].parens;
  int k, kpl, kpa;

  if (t[0] == '[')
    {
      XST (_T(_S(COARRAY) H _S(REF)));
      XAD(1);
      if ((k = FXTRAN_str_at_level (t, ci, "]", lev)))
        {

          kpl = FXTRAN_process_list (t, ci, ctx, ",", 
			             _T(_S(COSECTION) H _S(SUBSCRIPT) H _S(LIST)), 
			             k-1, cosection_subscript, NULL);
	  XAD(kpl);

          while (t[0] == ',')
            {
              XAD (1);
              k = FXTRAN_eat_word (t);
	      XST (_S(ARG));
              XNW (_T(_S(ARG) H _S(NAME)), k); 
	      XAD (k);
	      if (t[0] != '=')
                FXTRAN_ABORT ("Expected '='");
              XAD (1);
              k = FXTRAN_str_at_level (t, ci, ",", ci[0].parens);
              kpa = FXTRAN_str_at_level (t, ci, "]", ci[0].parens-1);
	      if ((kpa < k) || (k == 0))
                k = kpa;
              FXTRAN_expr (t, ci, k-1, ctx);
	      XAD (k-1);
	      XET ();
	    }

          XAD(1);
          XET ();
        }
      else
        FXTRAN_THROW ("Expected closing `]'"); 
       
    }

  return t - T;
}

static int array_ref (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx *ctx)
{
  const char * T = t;
  int lev = ci[0].parens;
  int k;

  if (t[0] == '(')
    {
      XST (_T(_S(ARRAY) H _S(REF)));
      XAD(1);
      if ((k = FXTRAN_str_at_level (t, ci, ")", lev)))
        {

          FXTRAN_process_list (t, ci, ctx, ",", 
			       _T(_S(SECTION) H _S(SUBSCRIPT) H _S(LIST)), 
			       k-1, section_subscript, NULL);
	  XAD(k-1);
          XAD(1);
          XET ();
        }
      else
        FXTRAN_THROW ("Expected closing `)'"); 
       
    }

  return t - T;
}

def_process_list_elt_proto (iterator_element)
{
  const char * T = t;
  int k;
  XST (_T(_S(ITERATOR) H _S(ELEMENT)));

  k = FXTRAN_eat_word (t);
  if ((t[k] == '=') && (t[k+1] != '='))
    {
      XST (_T(_S(VARIABLE) H _S(NAME)));
      XNT (_T(_S(VARIABLE) H _S(NAME)), k);
      XAD(k);
      XET ();
      XAD(1);
      FXTRAN_expr (t, ci, kmax - (t-T), ctx);
      XAD(kmax-(t-T));
    }
  else
    {
      FXTRAN_expr (t, ci, kmax, ctx);
      XAD(kmax);
    }
  XET ();
  return 1;
}


static int iterator (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx *ctx)
{
  const char * T = t;
  int lev = ci[0].parens;
  int k;

  if (t[0] == '(')
    {
      XST (_T(_S(ITERATOR)));
      XAD(1);
      if ((k = FXTRAN_str_at_level (t, ci, ")", lev)))
        {

          FXTRAN_process_list (t, ci, ctx, ",", 
			       _T(_S(ITERATOR) H _S(DEFINITION) H _S(LIST)), 
			       k, iterator_element, NULL);
	  XAD(k-1);
          XAD(1);
          XET ();
        }
      else
        FXTRAN_THROW ("Expected closing `)'"); 
       
    }

  return t - T;
}

static int FXTRAN_ref_parens (const char * t, const FXTRAN_char_info * ci, 
                               FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  FXTRAN_grok_parens_type type;


  k = FXTRAN_str_at_level (t, ci, ")", ci[0].parens);

  if (k == 0)
    FXTRAN_THROW ("Cannot find `)'");

  type = FXTRAN_grok_parens (t, ci);


  switch (type)
    {
      case FXTRAN_grok_parens_ERROR:
        FXTRAN_THROW ("Malformed expr");
	break;
      case FXTRAN_grok_parens_UNKNW:
        XST (_T(_S(PARENS) H _S(REF)));
        XAD(1);
        FXTRAN_process_list (t, ci, ctx, ",", _T(_S(ELEMENT) H _S(LIST)), k-2, expr_parens_item, NULL);
        XAD(k-1);  
        XET ();
	break;
      case FXTRAN_grok_parens_ARGKW:
        XST (_T(_S(PARENS) H _S(REF)));
        FXTRAN_actual_args (t, ci, ctx);
        XAD(k);  
        XET ();
	break;
      case FXTRAN_grok_parens_RANGE:
	array_ref (t, ci, ctx);
        XAD(k);  
	break;
      case FXTRAN_grok_parens_ITRTR:
	FXTRAN_THROW ("Malformed expr");
	break;
    }


  

  return t - T;
}

static int FXTRAN_ref_component (const char * t, const FXTRAN_char_info * ci, 
                                  FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  XST (_T(_S(COMPONENT) H _S(REF)));

  XAD(1);
  k = FXTRAN_eat_word (t);

  if (k == 0)
    FXTRAN_THROW ("`%%' is not followed by a valid name");

  xml_mark_comp (ci->offset, ci[k-1].offset+1, ctx);

  XAD(k);

  XET ();
  
  return t - T;
}

static int FXTRAN_ref_list (const char * t, const FXTRAN_char_info * ci, 
                             FXTRAN_xmlctx * ctx, int kmax)
{
  const char * T = t;
  int lst = 0;

  while (t < &T[kmax])
    {
      if (t[0] == '[')
        {
          if (lst++ == 0)
            XST (_T(_S(REF) H _S(LIST)));
          XAD(coarray_ref (t, ci, ctx));
        }
      else if (t[0] == '(')
        {
          if (lst++ == 0)
            XST (_T(_S(REF) H _S(LIST)));
          XAD(FXTRAN_ref_parens (t, ci, ctx));
        }
      else if (t[0] == '%')
        {
          if (lst++ == 0)
            XST (_T(_S(REF) H _S(LIST)));
          XAD(FXTRAN_ref_component (t, ci, ctx));
        }
      else
        break;
    }

  if (lst)
    XET ();

  return t - T;
}


int FXTRAN_expr_string (const char * t, const FXTRAN_char_info * ci, 
                        FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  
  if (! ctx->opts.flat_expr)
    XST (_T(_S(STRING) H _S(EXPR)));

  XAD(2);

  XAD(FXTRAN_ref_list (t, ci, ctx, strlen (t)));

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}


static int FXTRAN_expr_string_with_named_kind (const char * t, const FXTRAN_char_info * ci, 
                                                FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k = FXTRAN_eat_word (t);

  if (! ctx->opts.flat_expr)
    XST (_T(_S(STRING) H _S(EXPR)));

  XST (_T(_S(KIND)));
  XNT (_T(_S(NAME)), k);
  XAD(k);
  XET ();

  XAD(1);
  XAD(2);

  XAD(FXTRAN_ref_list (t, ci, ctx, strlen (t)));

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}

int FXTRAN_expr_string_with_int_kind (const char * t, const FXTRAN_char_info * ci, 
                                      FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k = FXTRAN_eat_integer_constant (t);

  if (! ctx->opts.flat_expr)
    XST (_T(_S(STRING) H _S(EXPR)));

  xml_mark_lit (ci->offset, ci[k-1].offset+1, ctx);
  XST (_T(_S(KIND)));
  XAD(k);
  XET ();

  XAD(1);
  XAD(2);

  XAD(FXTRAN_ref_list (t, ci, ctx, strlen (t)));

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}

static int FXTRAN_expr_named (const char * t, const FXTRAN_char_info * ci, 
                               FXTRAN_xmlctx * ctx, int kmax)
{
  const char * T = t;
  int k = FXTRAN_eat_word (t);

  if (! ctx->opts.flat_expr)
    XST (_T(_S(NAMED) H _S(EXPR)));

  XNT (_T(_S(NAME)), k);
  XAD(k);
  XAD(FXTRAN_ref_list (t, ci, ctx, kmax - (t-T)));

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}

def_process_list_elt_proto(ac_value) 
{
  XST (_T(_S(AC) H _S(VALUE)));
  FXTRAN_expr (t, ci, kmax, ctx);
  XAD(kmax);
  XET ();
  return 1;
}

static int FXTRAN_expr_array_constructor (const char * t, const FXTRAN_char_info * ci, 
                                           FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k = FXTRAN_str_at_level (t, ci, t[0] == '(' ? ")" : "]", ci[0].parens);
  int ki = t[0] == '(' ? 2 : 1;

  if ((ki == 2) && (t[k-2] != '/'))
    FXTRAN_THROW ("Array constructor does not end with a proper `/)'");

  if (! ctx->opts.flat_expr)
    XST (_T(_S(ARRAY) H _S(CONSTRUCTOR) H _S(EXPR)));

  XAD(ki);

  {
    int k1 = FXTRAN_str_at_level_ir (t, ci, "::", ci->parens, k- ki);
    int k2;
    if (k1)
      {
        int kdd = FXTRAN_eat_word (t);
	if ((t[kdd] == ':') && (t[kdd+1] == ':'))
          {
            int i;
	    for (i = 0; FXTRAN_types[i]; i++)
              if (FXTRAN_types_intrinsic[i])
                if (0 == strncmp (FXTRAN_types[i], t, kdd))
                  goto regular_ts;
	    XST (_S (TYPE) H _S (NAME));
	    XNT (_T(_S(NAME)), kdd);
	    XAD (kdd);
	    XET ();
            XAD (2);
	    k = k - kdd - 2;
            goto process_list;
          }
regular_ts:
        k2 = FXTRAN_typespec (t, ci, ctx);
        if (k1 != k2+1)
          FXTRAN_THROW ("Malformed typespec in array constructor");
        XAD(k2);
        XAD(2);
        k = k - k2 - 2;
      }
  }

process_list:
  FXTRAN_process_list (t, ci, ctx, ",", 
		       _T(_S(AC) H _S(VALUE) H _S(LIST)), 
		       k-2*ki, ac_value, NULL);

  XAD(k-ki);

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}


static int FXTRAN_expr_parens (const char * t, const FXTRAN_char_info * ci, 
                                FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int kp;
  int lev = ci->parens;

  if (! ctx->opts.flat_expr)
    XST (_T(_S(PARENS) H _S(EXPR)));

  kp = FXTRAN_str_at_level (t, ci, ")", lev);
  if (kp == 0)
    FXTRAN_THROW ("Cannot find ending `)'");

 
  if (FXTRAN_str_at_level_ir (t, ci, ",", lev+1, kp))
    {
      FXTRAN_grok_parens_type type = FXTRAN_grok_parens (t, ci);
      switch (type)
        {
          case FXTRAN_grok_parens_ERROR:
            FXTRAN_THROW ("Malformed expr");
            break;
          case FXTRAN_grok_parens_UNKNW:
            XAD(1);
            kp--;
            FXTRAN_process_list (t, ci, ctx, ",", 
			         _T(_S(ELEMENT) H _S(LIST)), 
				 kp, expr_parens_item, NULL);
            break;
          case FXTRAN_grok_parens_ARGKW:
            FXTRAN_actual_args (t, ci, ctx);
            break;
          case FXTRAN_grok_parens_RANGE:
            array_ref (t, ci, ctx);
            break;
          case FXTRAN_grok_parens_ITRTR:
	    iterator (t, ci, ctx);
            break;
        }
    }
  else
    {
      XAD(1);
      kp--;
      FXTRAN_expr (t, ci, kp-1, ctx);
    }
 

  XAD(kp);

  if (! ctx->opts.flat_expr)
    XET ();

  return t - T;
}

static int FXTRAN_expr_percent (const char * t, const FXTRAN_char_info * ci, 
                                FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  
  XST (_T (_S (FUNCTION)));

  /* Skip % */
  if (t[0] != '%')
    FXTRAN_ABORT ("Expected '('");
  XAD(1);

  /* Skip function name */
  k = FXTRAN_eat_word (t);
  XNT (_T(_S(NAME)), k);
  XAD (k);

  /* Skip ( */
  if (t[0] != '(')
    FXTRAN_ABORT ("Expected '('");
  XAD (1);

  /* Argument */
  XST (_T (_S (ARG)));

  k = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);

  FXTRAN_expr (t, ci, k-1, ctx);
  XAD (k-1);
  
  XET ();

  if (t[0] != ')')
    FXTRAN_ABORT ("Expected ')'");
  XAD (1);

  XET ();

  return t - T;
}

static int FXTRAN_expr_primary (const char * t, const FXTRAN_char_info * ci, 
                                 FXTRAN_xmlctx * ctx, int kmax)
{
  const char * T = t;
  int k;
  int n = strlen (t);

  if (((n > 1) && (t[0] == '(') && (t[1] == '/')) || (t[0] == '[')) 
    {
      XAD(FXTRAN_expr_array_constructor (t, ci, ctx));
      goto end;
    }

  if (n > 2)
    {
      if (((t[0] == 'B') || (t[0] == 'O') || (t[0] == 'Z') || (t[0] == 'X'))
        && (t[1] == '"') && (t[2] == '"'))
        {
          XAD(FXTRAN_expr_boz_litteral_constant (t, ci, ctx));
          goto end;
        }
      if (((t[2] == 'B') || (t[2] == 'O') || (t[2] == 'Z') || (t[2] == 'X'))
        && (t[0] == '"') && (t[1] == '"'))
        {
          XAD(FXTRAN_expr_boz_litteral_constant (t, ci, ctx));
          goto end;
        }
    }

  if ((n > 4) && (t[0] == '%') && (t[4] == '('))
    {
      XAD(FXTRAN_expr_percent (t, ci, ctx));
      goto end;
    }

  if ((k = FXTRAN_eat_word (t)))
    {
      if ((t[k] == '_') && (t[k+1] == '"'))
        XAD(FXTRAN_expr_string_with_named_kind (t, ci, ctx));
      else
        XAD(FXTRAN_expr_named (t, ci, ctx, kmax));
      goto end;
    }

  if ((k = FXTRAN_eat_integer_constant (t)))
    if ((t[k] == '_') && (t[k+1] == '"'))
      {
        XAD(FXTRAN_expr_string_with_int_kind (t, ci, ctx));
	goto end;
      }

  if (t[0] == '"')
    {
      XAD(FXTRAN_expr_string (t, ci, ctx));
      goto end;
    }
    

  if (t[0] == '(')
    {
      XAD(FXTRAN_expr_parens (t, ci, ctx));
      goto end;
    }

  if (((!ci[0].dots) && (t[0] == '.')) || (isdigit (t[0])))
    {
      XAD(FXTRAN_expr_numeric_litteral_constant (t, ci, ctx, 0));
      goto end;
    }
  
 
  if (ci[0].dots)
    {
      k = FXTRAN_eat_word (&t[1]);
      if ((t[k+1] == '.') && (strncmp ("TRUE", &t[1], k) == 0 || strncmp ("FALSE", &t[1], k) == 0))
        XAD(FXTRAN_expr_logical_litteral_constant (t, ci, ctx));
      goto end;
    }

end:
  return t - T;
}

static int match_op (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int i;
  int k;

  if (ci->dots && ci[1].dots && (t[0] == '.') &&
    strncmp (".TRUE.", t, 6) && strncmp (".FALSE.", t, 7))
    {

      k = FXTRAN_eat_word (&t[1]);
      if (k == 0)
        goto other;

      if (t[1+k] != '.')
        FXTRAN_THROW ("Malformed operator");

      return k+2;
    }

other:
  for (i = 0; FXTRAN_ops[i]; i++)
    {
      int len = strlen (FXTRAN_ops[i]);
      if (strncmp (t, FXTRAN_ops[i], len) == 0)
        return len;
    }


  return 0;
}

#define i_isalnum(c) \
  ((((c) >= 'A') && ((c) <= 'Z')) || (((c) >= '0') && ((c) <= '9')))

static void op_chrs (const char * t, int len, int unary, int * rank, int * order)
{
/*
 *  13          defined unary
 *  12  RTL     **
 *  11  LTR     * /
 *  10          unary + -
 *   9  LTR     binary + -
 *   8  LTR      //
 *   7          .EQ. .NE. .LT. .LE. .GT. .GE. == /= < <= > >=
 *   6          .NOT.
 *   5  LTR     .AND.
 *   4  LTR     .OR.
 *   3  LTR     .EQV.
 *   2  LTR     .NEQV.
 *   1  LTR     defined binary
 */
#define opcmp(op,r,o) \
  if (strncmp (op, t, strlen (op)) == 0) \
    {                                    \
      *rank = r;                         \
      *order = o;                        \
      return;                            \
    }

  opcmp ("**",  12, -1)
  opcmp ("*",   11, +1)
  opcmp ("/",   11, +1)

  if (unary)
    {
      opcmp ("+",   10, +1)
      opcmp ("-",   10, +1)
    }
  else
    {
      opcmp ("+",    9, +1)
      opcmp ("-",    9, +1)
    }

  opcmp ("//",    8, +1)

  opcmp (".EQ.",  7,  0)
  opcmp (".NE.",  7,  0)
  opcmp (".LT.",  7,  0)
  opcmp (".LE.",  7,  0)
  opcmp (".GT.",  7,  0)
  opcmp (".GE.",  7,  0)
  opcmp ("==",    7,  0)
  opcmp ("/=",    7,  0)
  opcmp ("<",     7,  0)
  opcmp ("<=",    7,  0)
  opcmp (">",     7,  0)
  opcmp (">=",    7,  0)

  opcmp (".NOT.", 6,  0)

  opcmp (".AND.", 5, +1)
  opcmp (".OR.",  4, +1)
  opcmp (".EQV.", 3, +1)
  opcmp (".NEQV.",2, +1)

#undef opcmp

  if (unary)
    {
      *rank = 13;
      *order = 0;
    }
  else
    {
      *rank = 0;
      *order = +1;
    }
}

static void FXTRAN_expr1 (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx,
		          const int * K1, const int * K2, const int * OP, 
			  const int * R,  const int * O,  int kop)
{
  int imin1 = -1, imin2 = -1, i;
  int rankmin = 9999;

  for (i = 0; i < kop; i++)
    if (OP[i] && ((i == 0) || OP[i-1] == 0))
      {
	if (rankmin > R[i])
          {
            rankmin = R[i];
	    imin1 = i;
	    imin2 = i;
          }
	else if (rankmin == R[i])
          {
            imin2 = i;
          }
      }

  if (imin1 == -1)
    {
      int j1 = K1[0];
      int j2 = K2[0];
      int j = FXTRAN_expr_primary (&t[j1], &ci[j1], ctx, j2 - j1);
      if (j2 -j1 != j)
        FXTRAN_THROW ("Cannot parse primary expr");
    }
  else
    {
      int i0 = O[imin1] >= 0 ? imin1 : imin2;
      int k1 = K1[0];
      int k2 = K2[kop-1];

      if (FXTRAN_XML_dump)                         
        if (! ctx->opts.flat_expr)
          FXTRAN_xml_start_tag (_T(_S(OPERATOR) H _S(EXPR)), ci[k1].offset, ctx);  

      if (i0 > 0)
        FXTRAN_expr1 (t, ci, ctx, K1, K2, OP, R, O, i0);

      {
        int j1 = K1[i0];
        int j2 = K2[i0];
        if (FXTRAN_XML_dump)                         
          FXTRAN_xml_word_tag_op (_T(_S(OPERATOR)), ci[j1].offset,   
             ci[j2-1].offset+1, ctx, &t[j1], j2-j1);      
      }
		  
      FXTRAN_expr1 (t, ci, ctx, K1+i0+1, K2+i0+1, OP+i0+1, R+i0+1, O+i0+1, kop-(i0+1));


      if (FXTRAN_XML_dump)                            
        if (! ctx->opts.flat_expr)
          FXTRAN_xml_end_tag (ci[k2-1].offset+1, ctx);   

    }

}

static void FXTRAN_expr0 (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx,
		          const int * K1, const int * K2, const int * OP, int kop)
{
  int i;
  int R[kop], O[kop];

  for (i = 0; i < kop; i++)
    if (OP[i])
      {
        int j = K1[i];
	int len = K2[i] - K1[i];
	int unary = (i == 0) || (OP[i-1]);
        op_chrs (&t[j], len, unary, &R[i], &O[i]);
      }
    else
      {
        R[i] = -99;
	O[i] = -99;
      }

  FXTRAN_expr1 (t, ci, ctx, K1, K2, OP, R, O, kop);
}

void FXTRAN_expr (const char * t, const FXTRAN_char_info * ci, 
                   int kmax, FXTRAN_xmlctx * ctx)
{
  int j1, j2, j3;
  int i, j, k;
  int parens = ci->parens;

  int K1[kmax], K2[kmax], OP[kmax];
  int kop = 0;

  int seen = 0;


  if ((kmax == 1) && (t[0] == '*'))
    {
      XST (_T(_S(STAR) H _S(EXPR)));
      XAD(1);
      XET ();
      return;
    }


  j1 = 0;
  for (i = 0; i < kmax;)
    {
      if (ci[i].parens == parens)
        {
          /* skip identifiers */
          if ((k = FXTRAN_eat_word (&t[i])))
            {
              i += k;
	      continue;
            }
          /* must detect them now because they contain ops */
	  else if (((!ci[i].dots) && (t[i] == '.')) || (isdigit (t[i])))
            {
              k = FXTRAN_eat_integer_constant (&t[i]);
	      if (k && (t[i+k] == '_') && (t[i+k+1] == '"')) /* this is a string with kind-spec */
                {
                  i++;
		  continue;
                }
              XSD(0);
              k = FXTRAN_expr_numeric_litteral_constant (&t[i], &ci[i], ctx, 0);
              XSD(1);
              i += k;
              continue;
            }
          else if (!i_isalnum (t[i])) 
            if ((k = match_op (&t[i], &ci[i], ctx)))
                {
                  j2 = i;
                  j3 = i+k;


		  if (ctx->opts.flat_op_expr)
                    {

                      if (seen == 0)
                        {
                          XST (_T(_S(OPERATOR) H _S(EXPR)));
              	          seen = 1;
                        }

                      if (j2 - j1)
                        {
                          j = FXTRAN_expr_primary (&t[j1], &ci[j1], ctx, j2 - j1);
              	          if (j2 -j1 != j)
                            FXTRAN_THROW ("Cannot parse primary expr");
                        }

                      if (FXTRAN_XML_dump)                         
                        FXTRAN_xml_word_tag_op (_T(_S(OPERATOR)), ci[j2].offset,   
                           ci[j3-1].offset+1, ctx, &t[j2], j3-j2);      
		    }
		  else
                    {
                      seen = 1;

                      if (j2 - j1)
                        {
                          K1[kop] = j1;
                          K2[kop] = j2;
                          OP[kop] = 0;
		          kop++;
                        }

		      K1[kop] = j2;
		      K2[kop] = j3;
		      OP[kop] = 1;
		      kop++;
		    }

                  j1 = j3;

                  i = j1;

                  continue;
                }
         }
       i++;
     }
      
  if (seen && ctx->opts.flat_op_expr)
    {
      j2 = i;

      if (j2 - j1)
        {
          j = FXTRAN_expr_primary (&t[j1], &ci[j1], ctx, kmax - j1);
          if (j2 -j1 != j)
            FXTRAN_THROW ("Cannot parse primary expr");
	}

      XAD(kmax);

      XET ();
    }
  else if (seen)
    {
      j2 = i;

      if (j2 - j1)
        {
          K1[kop] = j1;
          K2[kop] = j2;
          OP[kop] = 0;
          kop++;
	}

      FXTRAN_expr0 (t, ci, ctx, K1, K2, OP, kop);

    }
  else
    {
      j = FXTRAN_expr_primary (t, ci, ctx, kmax);
      if (j != kmax)
        FXTRAN_THROW ("Cannot parse primary expr");
    }


  return;
}


