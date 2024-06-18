/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "cpp-config.h"
#include "system.h"
#include "cpplib.h"
#include "internal.h"

#include "FXTRAN_CPP_INTF.h"
#include "FXTRAN_FILE.h"
#include "FXTRAN_XCP.h"

typedef struct _cpp_page_alloc
{
  struct _cpp_page_alloc *next;
  int length;
  int where;
  char mem[1];
} _cpp_page_alloc;

typedef struct cpp_page_alloc_pair
{
  void * _cpp_page_alloc_head;
  void * _cpp_page_alloc_tail;
} cpp_page_alloc_pair;

static _cpp_page_alloc * _get_cpp_page_alloc (int length)
{
  _cpp_page_alloc *cpa = xcalloc (1, sizeof (struct _cpp_page_alloc) + length);
  cpa->length = length;
  cpa->where = 0;
  return cpa;
}

static void * get_cpp_mem (cpp_page_alloc_pair * pcpap, int size)
{
  _cpp_page_alloc 
    * _cpp_page_alloc_head = pcpap->_cpp_page_alloc_head,
    * _cpp_page_alloc_tail = pcpap->_cpp_page_alloc_tail;
   
  void *p = NULL;

  if (_cpp_page_alloc_head == NULL)
    {   
      _cpp_page_alloc_head =
      _cpp_page_alloc_tail = 
      _get_cpp_page_alloc (4000);
    }   
  if (_cpp_page_alloc_tail->where + size >= _cpp_page_alloc_tail->length)
    {   
      _cpp_page_alloc_tail->next = _get_cpp_page_alloc (4000 + size);
      _cpp_page_alloc_tail = _cpp_page_alloc_tail->next;
    }   

  p = &_cpp_page_alloc_tail->mem[_cpp_page_alloc_tail->where];
  _cpp_page_alloc_tail->where += size;

  pcpap->_cpp_page_alloc_head = _cpp_page_alloc_head;
  pcpap->_cpp_page_alloc_tail = _cpp_page_alloc_tail;

  return p;
}

static void free_cpp_mem (cpp_page_alloc_pair * pcpap)
{
  _cpp_page_alloc * _cpp_page_alloc_head = pcpap->_cpp_page_alloc_head;
  _cpp_page_alloc * cpa, * cpb;
  for (cpa = _cpp_page_alloc_head; cpa; )
    {
      cpb = cpa->next;
      free (cpa);
      cpa = cpb;
    }
}

typedef struct cpp_reader_data
{
  hash_table *ident_hash;
  struct line_maps line_table;
  FXTRAN_file * root;
  FXTRAN_file * current;
  cpp_page_alloc_pair cpap;
  FXTRAN_xcp * xcp_list;
  const FXTRAN_opts * opts;
} cpp_reader_data;

static void * alloc_subobject (size_t x, void *p) 
{
  cpp_reader * input = p;
  cpp_reader_data * data = input->data;
  return get_cpp_mem (&data->cpap, x);
}

static hashnode alloc_node (hash_table * table)
{
  cpp_reader_data * data = table->data;
  return get_cpp_mem (&data->cpap, sizeof (struct cpp_hashnode));
}



#ifdef UNDEF

static void my_cpp_error (cpp_reader *input, int level, const char *msgid, va_list *ap)
{
  cpp_reader_data * data = input->data;
  source_location src_loc;

  if (CPP_OPTION(input, traditional)) 
    {
      if (input->state.in_directive)
        src_loc = input->directive_line;
      else 
        src_loc = input->line_table->highest_line;
    } 
  else 
    {
      src_loc = input->cur_token[-1].src_loc;
    }

  if (_cpp_begin_message(input, level, src_loc, 0)) 
    {
      vfprintf(stderr, msgid, *ap);
      putc('\n', stderr);
    }    

//if (level == CPP_DL_ERROR)
//  data->error++;
}

#endif

static void FXTRAN_file_cpp_enter (const char * filename, cpp_reader * input)
{
  cpp_reader_data * data = input->data;
  FXTRAN_file_enter (filename, (char*)input->buffer->buf, &data->current, &data->root);
}

static void FXTRAN_file_cpp_leave (cpp_reader * input)
{
  cpp_reader_data * data = input->data;
  FXTRAN_file_leave (&data->current, &data->root);
}

static void include (cpp_reader * input, unsigned int directive_line, const unsigned char * directive_name,
                     const char * filename, int angle_brackets)
{
  cpp_reader_data * data = input->data;
  source_location n = input->out.first_line;
  const struct line_map * map = linemap_lookup (&data->line_table, n);
  data->current->line = SOURCE_LINE(map, n);
}

static int source_line (cpp_reader * input)
{ 
  cpp_reader_data * data = input->data;
  source_location n = input->out.first_line;
  const struct line_map * map = linemap_lookup (&data->line_table, n);
  return SOURCE_LINE(map, n);
}


static void file_change (cpp_reader * input, const struct line_map *map) 
{ 
  if (map == NULL)
    return; 
         
  if (map->reason == LC_ENTER) 
    FXTRAN_file_cpp_enter (map->to_file, input);
  else if (map->reason == LC_LEAVE) 
    FXTRAN_file_cpp_leave (input);
}  


static cpp_reader_data * cpp_reader_data_alloc (FXTRAN_file * root, const FXTRAN_opts * opts) 
{
  cpp_reader_data * data = (cpp_reader_data*)xmalloc (sizeof (cpp_reader_data));
  memset (data, '\0', sizeof (*data));
  data->ident_hash = ht_create (14);
  data->ident_hash->alloc_node = alloc_node;
  data->ident_hash->alloc_subobject = alloc_subobject;
  data->ident_hash->data = data;
  data->xcp_list = NULL;
  data->root = root;
  data->opts = opts;
  return data;
}

static void cpp_reader_data_free (cpp_reader_data * data)
{
  ht_destroy (data->ident_hash);
  linemap_free (&data->line_table);
  free (data);
}


int FXTRAN_cpp_intf (const char * f, FXTRAN_file ** pf, 
		     FXTRAN_cpp2loc ** pc2l, FXTRAN_opts * opts,
		     void * obj, void (*append)(void*, char*, int))
{
  cpp_reader * input;
  cpp_reader_data * data;
  FXTRAN_cpp2loc_array cla;
  int linecppoffset = 0;
  cpp_dir * h = NULL;

  FXTRAN_init_cpp2loc_array (&cla);

  data = cpp_reader_data_alloc (*pf, opts);
  
  input = cpp_create_reader (CLK_GNUC89, data->ident_hash, &data->line_table);       
  input->data = (void*)data;

  {
    cpp_callbacks * cb; 
    cb = cpp_get_callbacks (input);       
    cb->file_change    = file_change;      
    cb->include        = include;
    input->noinclude   = opts->noinclude;
//  cb->missing_header = missing_header;
//  cb->error          = my_cpp_error;
  }

  if (cpp_read_main_file (input, f) == NULL)
    return -1;

  CPP_OPTION (input, traditional) = 1; 
  cpp_post_options (input);      
  cpp_set_lang (input, CLK_STDC94);       
  CPP_OPTION (input, trigraphs) = 0;          
//CPP_OPTION(input, client_diagnostic) = 1;


  /* Builtins */

  cpp_init_builtins_ (input);

  if (0)
    {
      char ** r;
      static char * builtin_macros[] = {
      "__linux__ 1",
      "__unix__ 1",
       NULL };

      for (r = builtin_macros; *r != NULL; r++)
        _cpp_define_builtin (input, *r);
    }

  /* Define cpp macros */
  {
    int i;
    for (i = 0; opts->defines[i]; i++)
      if (opts->defines[i][1] == 'D')
        {
          cpp_define (input, &opts->defines[i][2]);
	  linecppoffset++;
	}
      else if (opts->defines[i][1] == 'U')
        {
          cpp_undef (input, &opts->defines[i][2]);
	  linecppoffset++;
	}
      else
        return -1;
  }

  /* Cpp includes */
  {
    cpp_dir * t = NULL;
    int i;
    for (i = 0; opts->includes[i]; i++)
      {
        cpp_dir * s = xmalloc (sizeof (cpp_dir));
        s->name = opts->includes[i];
        s->len = strlen (s->name);    
        s->user_supplied_p = true;  
        s->next = NULL;

	if (h == NULL)
          {
            h = t = s;
	  }
	else
          {
            t->next = s;
	    t = s;
	  }
      }

    cpp_set_include_chains (input, h, NULL, 0);        
  }
  
#define record_cpploc() \
  do { \
      FXTRAN_grow_cpp2loc_array (&cla, 1);                                                 \
                                                                                           \
      data->current->line = source_line (input);                                           \
      len = input->out.cur - input->out.base;                                              \
                                                                                           \
      FXTRAN_curr_cpp2loc_array (&cla)->line     = data->current->line-1-linecppoffset;    \
      FXTRAN_curr_cpp2loc_array (&cla)->file     = data->current;                          \
      FXTRAN_curr_cpp2loc_array (&cla)->len      = len;                                    \
      FXTRAN_curr_cpp2loc_array (&cla)->xcp_list = data->xcp_list;                         \
  } while (0)


  while (_cpp_read_logical_line_trad (input)) 
    {  
      const char * inc;
      int len; 

      record_cpploc ();

      data->xcp_list = NULL;

      if ((! opts->noinclude) && (inc = FXTRAN_grok_fortran_include ((char*)input->out.base, len, opts)) != NULL)
        {
          cpp_push_include (input, inc);
	}
      else
        {
          append (obj, (char*)input->out.base, len);
          FXTRAN_incr_cpp2loc_array (&cla);
	}
    }  

  /* Empty file ? */
  if (cla.base == NULL)
    {
      FXTRAN_grow_cpp2loc_array (&cla, 1);                            
      FXTRAN_curr_cpp2loc_array (&cla)->file = data->current;    
    }

#undef record_cpploc

  *pf = data->root;

  FXTRAN_take_cpp2loc_array (&cla, pc2l); 

  cpp_destroy (input);       

  free_cpp_mem (&data->cpap);

  cpp_reader_data_free (data);

  {
    cpp_dir * s;
    for (s = h; s; s = h)
     {
       h = s->next;
       free (s);
     }

  }

  return 0;
}



FXTRAN_xcp *
FXTRAN_get_xcp (int ss, int st) 
{
  int i;
  FXTRAN_xcp *xcp;
  xcp =
    (FXTRAN_xcp *) xcalloc (1, sizeof (FXTRAN_xcp) +
                               ss * 2 * sizeof (FXTRAN_xcp_item) + st);
  for (i = 0; i < ss; i++)
    xcp->s[i].xcp = xcp;
  xcp->n = ss; 
  xcp->next = NULL;
  return xcp;
}


void
FXTRAN_push_xcp (FXTRAN_xcp * xcp, void * data)
{
  cpp_reader_data * crd = data;
  xcp->next = crd->xcp_list;
  crd->xcp_list = xcp;
}






