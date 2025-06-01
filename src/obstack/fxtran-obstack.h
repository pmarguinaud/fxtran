#ifndef FXTRAN_OBSTACK_H
#define FXTRAN_OBSTACK_H

#include <obstack.h>

#define fxtran_obstack_free(a,b) obstack_free(a,b)
#define fxtran_obstack_alloc(a,b) obstack_alloc(a,b)
#define _fxtran_obstack_begin(a,b,c,d,e) _obstack_begin(a,b,c,d,e)
#define fxtran_obstack_alignment_mask(a) obstack_alignment_mask(a)
#define fxtran_obstack_copy0(a,b,c) obstack_copy0(a,b,c)
#define fxtran_obstack_memory_used(a) obstack_memory_used(a)

typedef struct obstack fxtran_obstack_t;

#endif
