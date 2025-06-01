#ifndef FXTRAN_OBSTACK_H
#define FXTRAN_OBSTACK_H

#ifndef NO_OBSTACK

#include <obstack.h>

#define fxtran_obstack_free(a,b) obstack_free(a,b)
#define fxtran_obstack_alloc(a,b) obstack_alloc(a,b)
#define _fxtran_obstack_begin(a,b,c,d,e) _obstack_begin(a,b,c,d,e)
#define fxtran_obstack_alignment_mask(a) obstack_alignment_mask(a)
#define fxtran_obstack_copy0(a,b,c) obstack_copy0(a,b,c)
#define fxtran_obstack_memory_used(a) obstack_memory_used(a)

typedef struct obstack fxtran_obstack_t;

#else

/* obstack.h - object stack macros
   Copyright (C) 1988-2025 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <https://www.gnu.org/licenses/>.  */

/* Summary:

   All the apparent functions defined here are macros. The idea
   is that you would use these pre-tested macros to solve a
   very specific set of problems, and they would run fast.
   Caution: no side-effects in arguments please!! They may be
   evaluated MANY times!!

   These macros operate a stack of objects.  Each object starts life
   small, and may grow to maturity.  (Consider building a word syllable
   by syllable.)  An object can move while it is growing.  Once it has
   been "finished" it never changes address again.  So the "top of the
   stack" is typically an immature growing object, while the rest of the
   stack is of mature, fixed size and fixed address objects.

   These routines grab large chunks of memory, using a function you
   supply, called 'obstack_chunk_alloc'.  On occasion, they free chunks,
   by calling 'obstack_chunk_free'.  You must define them and declare
   them before using any obstack macros.

   Each independent stack is represented by a 'struct obstack'.
   Each of the obstack macros expects a pointer to such a structure
   as the first argument.

   One motivation for this package is the problem of growing char strings
   in symbol tables.  Unless you are "fascist pig with a read-only mind"
   --Gosper's immortal quote from HAKMEM item 154, out of context--you
   would not like to put any arbitrary upper limit on the length of your
   symbols.

   In practice this often means you will build many short symbols and a
   few long symbols.  At the time you are reading a symbol you don't know
   how long it is.  One traditional method is to read a symbol into a
   buffer, realloc()ating the buffer every time you try to read a symbol
   that is longer than the buffer.  This is beaut, but you still will
   want to copy the symbol from the buffer to a more permanent
   symbol-table entry say about half the time.

   With obstacks, you can work differently.  Use one obstack for all symbol
   names.  As you read a symbol, grow the name in the obstack gradually.
   When the name is complete, finalize it.  Then, if the symbol exists already,
   free the newly read name.

   The way we do this is to take a large chunk, allocating memory from
   low addresses.  When you want to build a symbol in the chunk you just
   add chars above the current "high water mark" in the chunk.  When you
   have finished adding chars, because you got to the end of the symbol,
   you know how long the chars are, and you can create a new object.
   Mostly the chars will not burst over the highest address of the chunk,
   because you would typically expect a chunk to be (say) 100 times as
   long as an average object.

   In case that isn't clear, when we have enough chars to make up
   the object, THEY ARE ALREADY CONTIGUOUS IN THE CHUNK (guaranteed)
   so we just point to it where it lies.  No moving of chars is
   needed and this is the second win: potentially long strings need
   never be explicitly shuffled. Once an object is formed, it does not
   change its address during its lifetime.

   When the chars burst over a chunk boundary, we allocate a larger
   chunk, and then copy the partly formed object from the end of the old
   chunk to the beginning of the new larger chunk.  We then carry on
   accreting characters to the end of the object as we normally would.

   A special macro is provided to add a single char at a time to a
   growing object.  This allows the use of register variables, which
   break the ordinary 'growth' macro.

   Summary:
	We allocate large chunks.
	We carve out one object at a time from the current chunk.
	Once carved, an object never moves.
	We are free to append data of any size to the currently
	  growing object.
	Exactly one object is growing in an obstack at any one time.
	You can run one obstack per control block.
	You may have as many control blocks as you dare.
	Because of the way we do it, you can "unwind" an obstack
	  back to a previous state. (You may remove objects much
	  as you would with a stack.)
 */


/* Don't do the contents of this file more than once.  */

#ifndef _OBSTACK_H
#define _OBSTACK_H 1

/* We need the type of a pointer subtraction.  If __PTRDIFF_TYPE__ is
   defined, as with GNU C, use that; that way we don't pollute the
   namespace with <stddef.h>'s symbols.  Otherwise, include <stddef.h>
   and use ptrdiff_t.  */

#ifdef __PTRDIFF_TYPE__
# define PTR_INT_TYPE __PTRDIFF_TYPE__
#else
# include <stddef.h>
# define PTR_INT_TYPE ptrdiff_t
#endif

/* If B is the base of an object addressed by P, return the result of
   aligning P to the next multiple of A + 1.  B and P must be of type
   char *.  A + 1 must be a power of 2.  */

#define __BPTR_ALIGN(B, P, A) ((B) + (((P) - (B) + (A)) & ~(A)))

/* Similar to _BPTR_ALIGN (B, P, A), except optimize the common case
   where pointers can be converted to integers, aligned as integers,
   and converted back again.  If PTR_INT_TYPE is narrower than a
   pointer (e.g., the AS/400), play it safe and compute the alignment
   relative to B.  Otherwise, use the faster strategy of computing the
   alignment relative to 0.  */

#define __PTR_ALIGN(B, P, A)						      \
  __BPTR_ALIGN (sizeof (PTR_INT_TYPE) < sizeof (void *) ? (B) : (char *) 0, \
		P, A)

#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

struct _fxtran_obstack_chunk           /* Lives at front of each chunk. */
{
  char *limit;                  /* 1 past end of this chunk */
  struct _fxtran_obstack_chunk *prev;  /* address of prior chunk or NULL */
  char contents[4];             /* objects begin here */
};

struct fxtran_obstack          /* control current object in current chunk */
{
  long chunk_size;              /* preferred size to allocate chunks in */
  struct _fxtran_obstack_chunk *chunk; /* address of current struct obstack_chunk */
  char *object_base;            /* address of object we are building */
  char *next_free;              /* where to add next char to current object */
  char *chunk_limit;            /* address of char after current chunk */
  union
  {
    PTR_INT_TYPE tempint;
    void *tempptr;
  } temp;                       /* Temporary for some macros.  */
  int alignment_mask;           /* Mask of alignment for each object. */
  /* These prototypes vary based on 'use_extra_arg', and we use
     casts to the prototypeless function type in all assignments,
     but having prototypes here quiets -Wstrict-prototypes.  */
  struct _fxtran_obstack_chunk *(*chunkfun) (void *, long);
  void (*freefun) (void *, struct _fxtran_obstack_chunk *);
  void *extra_arg;              /* first arg for chunk alloc/dealloc funcs */
  unsigned use_extra_arg : 1;     /* chunk alloc/dealloc funcs take extra arg */
  unsigned maybe_empty_object : 1; /* There is a possibility that the current
				      chunk contains a zero-length object.  This
				      prevents freeing the chunk if we allocate
				      a bigger chunk to replace it. */
  unsigned alloc_failed : 1;      /* No longer used, as we now call the failed
				     handler on error, but retained for binary
				     compatibility.  */
};

typedef struct fxtran_obstack fxtran_obstack_t;


/* Declare the external functions we use; they are in obstack.c.  */

extern void _fxtran_obstack_newchunk (struct fxtran_obstack *, int);
extern int _fxtran_obstack_begin (struct fxtran_obstack *, int, int,
			   void *(*)(long), void (*)(void *));
extern int _fxtran_obstack_begin_1 (struct fxtran_obstack *, int, int,
			     void *(*)(void *, long),
			     void (*)(void *, void *), void *);
extern int _fxtran_obstack_memory_used (struct fxtran_obstack *);

/* The default name of the function for freeing a chunk is 'obstack_free',
   but gnulib users can override this by defining '__obstack_free'.  */
#ifndef __fxtran_obstack_free
# define __fxtran_obstack_free fxtran_obstack_free
#endif
extern void __fxtran_obstack_free (struct fxtran_obstack *, void *);


/* Error handler called when 'obstack_chunk_alloc' failed to allocate
   more memory.  This can be set to a user defined function which
   should either abort gracefully or use longjump - but shouldn't
   return.  The default action is to print a message and abort.  */
extern void (*fxtran_obstack_alloc_failed_handler) (void);

/* Exit value used when 'print_and_abort' is used.  */
extern int fxtran_obstack_exit_failure;

/* Pointer to beginning of object being allocated or to be allocated next.
   Note that this might not be the final address of the object
   because a new chunk might be needed to hold the final size.  */

#define fxtran_obstack_base(h) ((void *) (h)->object_base)

/* Size for allocating ordinary chunks.  */

#define fxtran_obstack_chunk_size(h) ((h)->chunk_size)

/* Pointer to next byte not yet allocated in current chunk.  */

#define fxtran_obstack_next_free(h)    ((h)->next_free)

/* Mask specifying low bits that should be clear in address of an object.  */

#define fxtran_obstack_alignment_mask(h) ((h)->alignment_mask)

/* To prevent prototype warnings provide complete argument list.  */
#define fxtran_obstack_init(h)							      \
  _fxtran_obstack_begin ((h), 0, 0,						      \
		  (void *(*)(long))fxtran_obstack_chunk_alloc,			      \
		  (void (*)(void *))fxtran_obstack_chunk_free)

#define fxtran_obstack_begin(h, size)						      \
  _fxtran_obstack_begin ((h), (size), 0,					      \
		  (void *(*)(long))fxtran_obstack_chunk_alloc,			      \
		  (void (*)(void *))fxtran_obstack_chunk_free)

#define fxtran_obstack_specify_allocation(h, size, alignment, chunkfun, freefun)  \
  _fxtran_obstack_begin ((h), (size), (alignment),				  \
		  (void *(*)(long))(chunkfun),				          \
		  (void (*)(void *))(freefun))

#define fxtran_obstack_specify_allocation_with_arg(h, size, alignment, chunkfun, freefun, arg) \
  _fxtran_obstack_begin_1 ((h), (size), (alignment),				               \
		    (void *(*)(void *, long))(chunkfun),		                       \
		    (void (*)(void *, void *))(freefun), (arg))

#define fxtran_obstack_chunkfun(h, newchunkfun) \
  ((h)->chunkfun = (struct _fxtran_obstack_chunk *(*)(void *, long))(newchunkfun))

#define fxtran_obstack_freefun(h, newfreefun) \
  ((h)->freefun = (void (*)(void *, struct _fxtran_obstack_chunk *))(newfreefun))

#define fxtran_obstack_1grow_fast(h, achar) (*((h)->next_free)++ = (achar))

#define fxtran_obstack_blank_fast(h, n) ((h)->next_free += (n))

#define fxtran_obstack_memory_used(h) _fxtran_obstack_memory_used (h)

# define fxtran_obstack_object_size(h) \
  (unsigned) ((h)->next_free - (h)->object_base)

# define fxtran_obstack_room(h)						      \
  (unsigned) ((h)->chunk_limit - (h)->next_free)

# define fxtran_obstack_empty_p(h) \
  ((h)->chunk->prev == 0						      \
   && (h)->next_free == __PTR_ALIGN ((char *) (h)->chunk,		      \
				     (h)->chunk->contents,		      \
				     (h)->alignment_mask))

/* Note that the call to _obstack_newchunk is enclosed in (..., 0)
   so that we can avoid having void expressions
   in the arms of the conditional expression.
   Casting the third operand to void was tried before,
   but some compilers won't accept it.  */

# define fxtran_obstack_make_room(h, length)				      \
  ((h)->temp.tempint = (length),					      \
   (((h)->next_free + (h)->temp.tempint > (h)->chunk_limit)		      \
   ? (_fxtran_obstack_newchunk ((h), (h)->temp.tempint), 0) : 0))

# define fxtran_obstack_grow(h, where, length)				      \
  ((h)->temp.tempint = (length),					      \
   (((h)->next_free + (h)->temp.tempint > (h)->chunk_limit)		      \
   ? (_fxtran_obstack_newchunk ((h), (h)->temp.tempint), 0) : 0),	      \
   memcpy ((h)->next_free, where, (h)->temp.tempint),			      \
   (h)->next_free += (h)->temp.tempint)

# define fxtran_obstack_grow0(h, where, length)				      \
  ((h)->temp.tempint = (length),					      \
   (((h)->next_free + (h)->temp.tempint + 1 > (h)->chunk_limit)		      \
   ? (_fxtran_obstack_newchunk ((h), (h)->temp.tempint + 1), 0) : 0),	      \
   memcpy ((h)->next_free, where, (h)->temp.tempint),			      \
   (h)->next_free += (h)->temp.tempint,					      \
   *((h)->next_free)++ = 0)

# define fxtran_obstack_1grow(h, datum)					      \
  ((((h)->next_free + 1 > (h)->chunk_limit)				      \
    ? (_fxtran_obstack_newchunk ((h), 1), 0) : 0),			      \
   fxtran_obstack_1grow_fast (h, datum))

# define fxtran_obstack_ptr_grow(h, datum)				      \
  ((((h)->next_free + sizeof (char *) > (h)->chunk_limit)		      \
    ? (_fxtran_obstack_newchunk ((h), sizeof (char *)), 0) : 0),	      \
   fxtran_obstack_ptr_grow_fast (h, datum))

# define fxtran_obstack_int_grow(h, datum)				      \
  ((((h)->next_free + sizeof (int) > (h)->chunk_limit)			      \
    ? (_fxtran_obstack_newchunk ((h), sizeof (int)), 0) : 0),		      \
   fxtran_obstack_int_grow_fast (h, datum))

# define fxtran_obstack_ptr_grow_fast(h, aptr)				      \
  (((const void **) ((h)->next_free += sizeof (void *)))[-1] = (aptr))

# define fxtran_obstack_int_grow_fast(h, aint)				      \
  (((int *) ((h)->next_free += sizeof (int)))[-1] = (aint))

# define fxtran_obstack_blank(h, length)				      \
  ((h)->temp.tempint = (length),					      \
   (((h)->chunk_limit - (h)->next_free < (h)->temp.tempint)		      \
   ? (_fxtran_obstack_newchunk ((h), (h)->temp.tempint), 0) : 0),	      \
   fxtran_obstack_blank_fast (h, (h)->temp.tempint))

# define fxtran_obstack_alloc(h, length)				      \
  (fxtran_obstack_blank ((h), (length)), fxtran_obstack_finish ((h)))

# define fxtran_obstack_copy(h, where, length)				      \
  (fxtran_obstack_grow ((h), (where), (length)), fxtran_obstack_finish ((h)))

# define fxtran_obstack_copy0(h, where, length)				      \
  (fxtran_obstack_grow0 ((h), (where), (length)), fxtran_obstack_finish ((h)))

# define fxtran_obstack_finish(h)					      \
  (((h)->next_free == (h)->object_base					      \
    ? (((h)->maybe_empty_object = 1), 0)				      \
    : 0),								      \
   (h)->temp.tempptr = (h)->object_base,				      \
   (h)->next_free							      \
     = __PTR_ALIGN ((h)->object_base, (h)->next_free,			      \
		    (h)->alignment_mask),				      \
   (((h)->next_free - (char *) (h)->chunk				      \
     > (h)->chunk_limit - (char *) (h)->chunk)				      \
   ? ((h)->next_free = (h)->chunk_limit) : 0),				      \
   (h)->object_base = (h)->next_free,					      \
   (h)->temp.tempptr)

# define fxtran_obstack_free(h, obj)					      \
  ((h)->temp.tempint = (char *) (obj) - (char *) (h)->chunk,		      \
   ((((h)->temp.tempint > 0						      \
      && (h)->temp.tempint < (h)->chunk_limit - (char *) (h)->chunk))	      \
    ? (void) ((h)->next_free = (h)->object_base				      \
	      = (h)->temp.tempint + (char *) (h)->chunk)		      \
    : (__fxtran_obstack_free) (h, (h)->temp.tempint + (char *) (h)->chunk)))

#ifdef __cplusplus
}       /* C++ */
#endif

#endif

#endif

#endif
