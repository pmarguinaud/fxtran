# 1 "FXTRAN_OMP.c"
# 1 "/home/marguina/scratch/fxtran/src//"
# 1 "<interne>"
# 1 "<command-line>"
# 1 "FXTRAN_OMP.c"




# 1 "/usr/include/string.h" 1 3 4
# 26 "/usr/include/string.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 347 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 353 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 354 "/usr/include/sys/cdefs.h" 2 3 4
# 348 "/usr/include/features.h" 2 3 4
# 371 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 372 "/usr/include/features.h" 2 3 4
# 27 "/usr/include/string.h" 2 3 4






# 1 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stddef.h" 1 3 4
# 211 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 34 "/usr/include/string.h" 2 3 4









extern void *memcpy (void *__restrict __dest,
       __const void *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern void *memmove (void *__dest, __const void *__src, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));






extern void *memccpy (void *__restrict __dest, __const void *__restrict __src,
        int __c, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));





extern void *memset (void *__s, int __c, size_t __n) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int memcmp (__const void *__s1, __const void *__s2, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 94 "/usr/include/string.h" 3 4
extern void *memchr (__const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


# 125 "/usr/include/string.h" 3 4


extern char *strcpy (char *__restrict __dest, __const char *__restrict __src)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncpy (char *__restrict __dest,
        __const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern char *strcat (char *__restrict __dest, __const char *__restrict __src)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncat (char *__restrict __dest, __const char *__restrict __src,
        size_t __n) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcmp (__const char *__s1, __const char *__s2)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern int strncmp (__const char *__s1, __const char *__s2, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcoll (__const char *__s1, __const char *__s2)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern size_t strxfrm (char *__restrict __dest,
         __const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));






# 1 "/usr/include/xlocale.h" 1 3 4
# 28 "/usr/include/xlocale.h" 3 4
typedef struct __locale_struct
{

  struct locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
} *__locale_t;


typedef __locale_t locale_t;
# 162 "/usr/include/string.h" 2 3 4


extern int strcoll_l (__const char *__s1, __const char *__s2, __locale_t __l)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));

extern size_t strxfrm_l (char *__dest, __const char *__src, size_t __n,
    __locale_t __l) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2, 4)));




extern char *strdup (__const char *__s)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));






extern char *strndup (__const char *__string, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));
# 208 "/usr/include/string.h" 3 4

# 233 "/usr/include/string.h" 3 4
extern char *strchr (__const char *__s, int __c)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 260 "/usr/include/string.h" 3 4
extern char *strrchr (__const char *__s, int __c)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


# 279 "/usr/include/string.h" 3 4



extern size_t strcspn (__const char *__s, __const char *__reject)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern size_t strspn (__const char *__s, __const char *__accept)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 312 "/usr/include/string.h" 3 4
extern char *strpbrk (__const char *__s, __const char *__accept)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 340 "/usr/include/string.h" 3 4
extern char *strstr (__const char *__haystack, __const char *__needle)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strtok (char *__restrict __s, __const char *__restrict __delim)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));




extern char *__strtok_r (char *__restrict __s,
    __const char *__restrict __delim,
    char **__restrict __save_ptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2, 3)));

extern char *strtok_r (char *__restrict __s, __const char *__restrict __delim,
         char **__restrict __save_ptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2, 3)));
# 395 "/usr/include/string.h" 3 4


extern size_t strlen (__const char *__s)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern size_t strnlen (__const char *__string, size_t __maxlen)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern char *strerror (int __errnum) __attribute__ ((__nothrow__));

# 425 "/usr/include/string.h" 3 4
extern int strerror_r (int __errnum, char *__buf, size_t __buflen) __asm__ ("" "__xpg_strerror_r") __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));
# 443 "/usr/include/string.h" 3 4
extern char *strerror_l (int __errnum, __locale_t __l) __attribute__ ((__nothrow__));





extern void __bzero (void *__s, size_t __n) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));



extern void bcopy (__const void *__src, void *__dest, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern void bzero (void *__s, size_t __n) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int bcmp (__const void *__s1, __const void *__s2, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 487 "/usr/include/string.h" 3 4
extern char *index (__const char *__s, int __c)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 515 "/usr/include/string.h" 3 4
extern char *rindex (__const char *__s, int __c)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));




extern int ffs (int __i) __attribute__ ((__nothrow__)) __attribute__ ((__const__));
# 534 "/usr/include/string.h" 3 4
extern int strcasecmp (__const char *__s1, __const char *__s2)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strncasecmp (__const char *__s1, __const char *__s2, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 557 "/usr/include/string.h" 3 4
extern char *strsep (char **__restrict __stringp,
       __const char *__restrict __delim)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strsignal (int __sig) __attribute__ ((__nothrow__));


extern char *__stpcpy (char *__restrict __dest, __const char *__restrict __src)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpcpy (char *__restrict __dest, __const char *__restrict __src)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));



extern char *__stpncpy (char *__restrict __dest,
   __const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpncpy (char *__restrict __dest,
        __const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
# 644 "/usr/include/string.h" 3 4

# 6 "FXTRAN_OMP.c" 2

# 1 "FXTRAN_OMP.h" 1







# 1 "FXTRAN_MASK.h" 1
# 9 "FXTRAN_MASK.h"
enum
{
   FXTRAN_NON = '\0',
   FXTRAN_NAM = 'n',
   FXTRAN_OPR = '+',
   FXTRAN_LIT = '8',
   FXTRAN_BOZ = 'Z',
   FXTRAN_CPT = '%',
   FXTRAN_KWD = '_',

   FXTRAN_STR = '"',
   FXTRAN_OPT = '@',
   FXTRAN_COM = '!',
   FXTRAN_LAB = 'L',
   FXTRAN_CPP = '#',
   FXTRAN_COD = 'x',
   FXTRAN_SMC = ';',
   FXTRAN_SPC = ' ',
   FXTRAN_CO2 = '>',
   FXTRAN_OMD = '$',
   FXTRAN_OMC = '~',
   FXTRAN_MAR = 'R',


   FXTRAN_CO1 = '&',


   FXTRAN_MAL = 'M',
   FXTRAN_ZER = '0'
};
# 9 "FXTRAN_OMP.h" 2
# 1 "FXTRAN_XML.h" 1
# 10 "FXTRAN_XML.h"
# 1 "FXTRAN_FBUFFER.h" 1







# 1 "/usr/include/stdlib.h" 1 3 4
# 33 "/usr/include/stdlib.h" 3 4
# 1 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stddef.h" 1 3 4
# 323 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stddef.h" 3 4
typedef int wchar_t;
# 34 "/usr/include/stdlib.h" 2 3 4


# 96 "/usr/include/stdlib.h" 3 4


typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;







__extension__ typedef struct
  {
    long long int quot;
    long long int rem;
  } lldiv_t;


# 140 "/usr/include/stdlib.h" 3 4
extern size_t __ctype_get_mb_cur_max (void) __attribute__ ((__nothrow__)) ;




extern double atof (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern int atoi (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern long int atol (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;





__extension__ extern long long int atoll (__const char *__nptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;





extern double strtod (__const char *__restrict __nptr,
        char **__restrict __endptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





extern float strtof (__const char *__restrict __nptr,
       char **__restrict __endptr) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

extern long double strtold (__const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





extern long int strtol (__const char *__restrict __nptr,
   char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

extern unsigned long int strtoul (__const char *__restrict __nptr,
      char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




__extension__
extern long long int strtoq (__const char *__restrict __nptr,
        char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

__extension__
extern unsigned long long int strtouq (__const char *__restrict __nptr,
           char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





__extension__
extern long long int strtoll (__const char *__restrict __nptr,
         char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

__extension__
extern unsigned long long int strtoull (__const char *__restrict __nptr,
     char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;

# 311 "/usr/include/stdlib.h" 3 4
extern char *l64a (long int __n) __attribute__ ((__nothrow__)) ;


extern long int a64l (__const char *__s)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;




# 1 "/usr/include/sys/types.h" 1 3 4
# 29 "/usr/include/sys/types.h" 3 4


# 1 "/usr/include/bits/types.h" 1 3 4
# 28 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;







typedef long int __quad_t;
typedef unsigned long int __u_quad_t;
# 131 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 132 "/usr/include/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;

typedef int __daddr_t;
typedef long int __swblk_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;

typedef long int __ssize_t;



typedef __off64_t __loff_t;
typedef __quad_t *__qaddr_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;
# 32 "/usr/include/sys/types.h" 2 3 4



typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;




typedef __loff_t loff_t;



typedef __ino_t ino_t;
# 62 "/usr/include/sys/types.h" 3 4
typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;





typedef __off_t off_t;
# 100 "/usr/include/sys/types.h" 3 4
typedef __pid_t pid_t;




typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;
# 133 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/time.h" 1 3 4
# 74 "/usr/include/time.h" 3 4


typedef __time_t time_t;



# 92 "/usr/include/time.h" 3 4
typedef __clockid_t clockid_t;
# 104 "/usr/include/time.h" 3 4
typedef __timer_t timer_t;
# 134 "/usr/include/sys/types.h" 2 3 4
# 147 "/usr/include/sys/types.h" 3 4
# 1 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stddef.h" 1 3 4
# 148 "/usr/include/sys/types.h" 2 3 4



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;
# 195 "/usr/include/sys/types.h" 3 4
typedef int int8_t __attribute__ ((__mode__ (__QI__)));
typedef int int16_t __attribute__ ((__mode__ (__HI__)));
typedef int int32_t __attribute__ ((__mode__ (__SI__)));
typedef int int64_t __attribute__ ((__mode__ (__DI__)));


typedef unsigned int u_int8_t __attribute__ ((__mode__ (__QI__)));
typedef unsigned int u_int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int u_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int u_int64_t __attribute__ ((__mode__ (__DI__)));

typedef int register_t __attribute__ ((__mode__ (__word__)));
# 217 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 37 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 38 "/usr/include/endian.h" 2 3 4
# 61 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/byteswap.h" 1 3 4
# 28 "/usr/include/bits/byteswap.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/byteswap.h" 2 3 4
# 62 "/usr/include/endian.h" 2 3 4
# 218 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 23 "/usr/include/bits/select.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 24 "/usr/include/bits/select.h" 2 3 4
# 32 "/usr/include/sys/select.h" 2 3 4


# 1 "/usr/include/bits/sigset.h" 1 3 4
# 24 "/usr/include/bits/sigset.h" 3 4
typedef int __sig_atomic_t;




typedef struct
  {
    unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
  } __sigset_t;
# 35 "/usr/include/sys/select.h" 2 3 4



typedef __sigset_t sigset_t;





# 1 "/usr/include/time.h" 1 3 4
# 120 "/usr/include/time.h" 3 4
struct timespec
  {
    __time_t tv_sec;
    long int tv_nsec;
  };
# 45 "/usr/include/sys/select.h" 2 3 4

# 1 "/usr/include/bits/time.h" 1 3 4
# 69 "/usr/include/bits/time.h" 3 4
struct timeval
  {
    __time_t tv_sec;
    __suseconds_t tv_usec;
  };
# 47 "/usr/include/sys/select.h" 2 3 4


typedef __suseconds_t suseconds_t;





typedef long int __fd_mask;
# 67 "/usr/include/sys/select.h" 3 4
typedef struct
  {






    __fd_mask __fds_bits[1024 / (8 * (int) sizeof (__fd_mask))];


  } fd_set;






typedef __fd_mask fd_mask;
# 99 "/usr/include/sys/select.h" 3 4

# 109 "/usr/include/sys/select.h" 3 4
extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
# 121 "/usr/include/sys/select.h" 3 4
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);



# 221 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/sysmacros.h" 1 3 4
# 30 "/usr/include/sys/sysmacros.h" 3 4
__extension__
extern unsigned int gnu_dev_major (unsigned long long int __dev)
     __attribute__ ((__nothrow__));
__extension__
extern unsigned int gnu_dev_minor (unsigned long long int __dev)
     __attribute__ ((__nothrow__));
__extension__
extern unsigned long long int gnu_dev_makedev (unsigned int __major,
            unsigned int __minor)
     __attribute__ ((__nothrow__));
# 224 "/usr/include/sys/types.h" 2 3 4
# 235 "/usr/include/sys/types.h" 3 4
typedef __blkcnt_t blkcnt_t;



typedef __fsblkcnt_t fsblkcnt_t;



typedef __fsfilcnt_t fsfilcnt_t;
# 270 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 23 "/usr/include/bits/pthreadtypes.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 24 "/usr/include/bits/pthreadtypes.h" 2 3 4
# 50 "/usr/include/bits/pthreadtypes.h" 3 4
typedef unsigned long int pthread_t;


typedef union
{
  char __size[56];
  long int __align;
} pthread_attr_t;



typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;
# 76 "/usr/include/bits/pthreadtypes.h" 3 4
typedef union
{
  struct __pthread_mutex_s
  {
    int __lock;
    unsigned int __count;
    int __owner;

    unsigned int __nusers;



    int __kind;

    int __spins;
    __pthread_list_t __list;
# 101 "/usr/include/bits/pthreadtypes.h" 3 4
  } __data;
  char __size[40];
  long int __align;
} pthread_mutex_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_mutexattr_t;




typedef union
{
  struct
  {
    int __lock;
    unsigned int __futex;
    __extension__ unsigned long long int __total_seq;
    __extension__ unsigned long long int __wakeup_seq;
    __extension__ unsigned long long int __woken_seq;
    void *__mutex;
    unsigned int __nwaiters;
    unsigned int __broadcast_seq;
  } __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;





typedef union
{

  struct
  {
    int __lock;
    unsigned int __nr_readers;
    unsigned int __readers_wakeup;
    unsigned int __writer_wakeup;
    unsigned int __nr_readers_queued;
    unsigned int __nr_writers_queued;
    int __writer;
    int __shared;
    unsigned long int __pad1;
    unsigned long int __pad2;


    unsigned int __flags;
  } __data;
# 187 "/usr/include/bits/pthreadtypes.h" 3 4
  char __size[56];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[32];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;
# 271 "/usr/include/sys/types.h" 2 3 4



# 321 "/usr/include/stdlib.h" 2 3 4






extern long int random (void) __attribute__ ((__nothrow__));


extern void srandom (unsigned int __seed) __attribute__ ((__nothrow__));





extern char *initstate (unsigned int __seed, char *__statebuf,
   size_t __statelen) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));



extern char *setstate (char *__statebuf) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));







struct random_data
  {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
  };

extern int random_r (struct random_data *__restrict __buf,
       int32_t *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));

extern int srandom_r (unsigned int __seed, struct random_data *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));

extern int initstate_r (unsigned int __seed, char *__restrict __statebuf,
   size_t __statelen,
   struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2, 4)));

extern int setstate_r (char *__restrict __statebuf,
         struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));






extern int rand (void) __attribute__ ((__nothrow__));

extern void srand (unsigned int __seed) __attribute__ ((__nothrow__));




extern int rand_r (unsigned int *__seed) __attribute__ ((__nothrow__));







extern double drand48 (void) __attribute__ ((__nothrow__));
extern double erand48 (unsigned short int __xsubi[3]) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern long int lrand48 (void) __attribute__ ((__nothrow__));
extern long int nrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern long int mrand48 (void) __attribute__ ((__nothrow__));
extern long int jrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern void srand48 (long int __seedval) __attribute__ ((__nothrow__));
extern unsigned short int *seed48 (unsigned short int __seed16v[3])
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
extern void lcong48 (unsigned short int __param[7]) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





struct drand48_data
  {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    unsigned long long int __a;
  };


extern int drand48_r (struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int erand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int lrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int nrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int mrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));
extern int jrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern int srand48_r (long int __seedval, struct drand48_data *__buffer)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));

extern int seed48_r (unsigned short int __seed16v[3],
       struct drand48_data *__buffer) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));

extern int lcong48_r (unsigned short int __param[7],
        struct drand48_data *__buffer)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));









extern void *malloc (size_t __size) __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;

extern void *calloc (size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;










extern void *realloc (void *__ptr, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__warn_unused_result__));

extern void free (void *__ptr) __attribute__ ((__nothrow__));




extern void cfree (void *__ptr) __attribute__ ((__nothrow__));



# 1 "/usr/include/alloca.h" 1 3 4
# 25 "/usr/include/alloca.h" 3 4
# 1 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stddef.h" 1 3 4
# 26 "/usr/include/alloca.h" 2 3 4







extern void *alloca (size_t __size) __attribute__ ((__nothrow__));






# 498 "/usr/include/stdlib.h" 2 3 4




extern void *valloc (size_t __size) __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;




extern int posix_memalign (void **__memptr, size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




extern void abort (void) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
# 530 "/usr/include/stdlib.h" 3 4





extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));






extern void exit (int __status) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));
# 553 "/usr/include/stdlib.h" 3 4






extern void _Exit (int __status) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));






extern char *getenv (__const char *__name) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




extern char *__secure_getenv (__const char *__name)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





extern int putenv (char *__string) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





extern int setenv (__const char *__name, __const char *__value, int __replace)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));


extern int unsetenv (__const char *__name) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));






extern int clearenv (void) __attribute__ ((__nothrow__));
# 604 "/usr/include/stdlib.h" 3 4
extern char *mktemp (char *__template) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 615 "/usr/include/stdlib.h" 3 4
extern int mkstemp (char *__template) __attribute__ ((__nonnull__ (1))) ;
# 637 "/usr/include/stdlib.h" 3 4
extern int mkstemps (char *__template, int __suffixlen) __attribute__ ((__nonnull__ (1))) ;
# 658 "/usr/include/stdlib.h" 3 4
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 707 "/usr/include/stdlib.h" 3 4





extern int system (__const char *__command) ;

# 729 "/usr/include/stdlib.h" 3 4
extern char *realpath (__const char *__restrict __name,
         char *__restrict __resolved) __attribute__ ((__nothrow__)) ;






typedef int (*__compar_fn_t) (__const void *, __const void *);
# 747 "/usr/include/stdlib.h" 3 4



extern void *bsearch (__const void *__key, __const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     __attribute__ ((__nonnull__ (1, 2, 5))) ;



extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));
# 766 "/usr/include/stdlib.h" 3 4
extern int abs (int __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;
extern long int labs (long int __x) __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;



__extension__ extern long long int llabs (long long int __x)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;







extern div_t div (int __numer, int __denom)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;
extern ldiv_t ldiv (long int __numer, long int __denom)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;




__extension__ extern lldiv_t lldiv (long long int __numer,
        long long int __denom)
     __attribute__ ((__nothrow__)) __attribute__ ((__const__)) ;

# 802 "/usr/include/stdlib.h" 3 4
extern char *ecvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *fcvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *gcvt (double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3))) ;




extern char *qecvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qfcvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qgcvt (long double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3))) ;




extern int ecvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int fcvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));

extern int qecvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int qfcvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (3, 4, 5)));







extern int mblen (__const char *__s, size_t __n) __attribute__ ((__nothrow__)) ;


extern int mbtowc (wchar_t *__restrict __pwc,
     __const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__)) ;


extern int wctomb (char *__s, wchar_t __wchar) __attribute__ ((__nothrow__)) ;



extern size_t mbstowcs (wchar_t *__restrict __pwcs,
   __const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__));

extern size_t wcstombs (char *__restrict __s,
   __const wchar_t *__restrict __pwcs, size_t __n)
     __attribute__ ((__nothrow__));








extern int rpmatch (__const char *__response) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 907 "/usr/include/stdlib.h" 3 4
extern int posix_openpt (int __oflag) ;
# 942 "/usr/include/stdlib.h" 3 4
extern int getloadavg (double __loadavg[], int __nelem)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
# 958 "/usr/include/stdlib.h" 3 4

# 9 "FXTRAN_FBUFFER.h" 2





# 1 "f_buffer.h" 1
# 10 "f_buffer.h"
# 1 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 102 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 11 "f_buffer.h" 2

typedef struct f_buffer
{
  char * str;
  char * cur;
  int len;
}
f_buffer;
# 53 "f_buffer.h"
int f_buffer_append_escaped_str (f_buffer *, const char *, int);

int f_buffer_printf (f_buffer *, const char *, ...);

int f_buffer_ncat (f_buffer *, int, const char *);

int f_buffer_append (f_buffer *, const f_buffer *);
# 15 "FXTRAN_FBUFFER.h" 2
# 11 "FXTRAN_XML.h" 2
# 1 "FXTRAN_CHARINFO.h" 1







typedef struct FXTRAN_char_info
{
  int parens;
  int dots;
  char mask;
  int column;
  int line;
  int rank;
  int offset;
} FXTRAN_char_info;
# 12 "FXTRAN_XML.h" 2

# 1 "FXTRAN_OPTS.h" 1
# 9 "FXTRAN_OPTS.h"
typedef struct FXTRAN_opts
{
  int openmp;
  int flat_expr;
  int flat_op_expr;
  int show_lines;
  int xul_wrap;
  int code_tag;
  int name_attr;
  int construct_tag;
  int help;

  char * ffile;
  char * xfile;

  enum
  {
    FXTRAN_FORM_NONE = 0,
    FXTRAN_FORM_FREE,
    FXTRAN_FORM_FIXED
  } form;

  int line_length;

  int cpp;
  int nocpp;
  int noinclude;

  int gdb;
  int debugL;

  char ** includes;
  char ** defines;

} FXTRAN_opts;
# 14 "FXTRAN_XML.h" 2
# 1 "FXTRAN_FILE.h" 1
# 9 "FXTRAN_FILE.h"
# 1 "FXTRAN_XCP.h" 1







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
# 10 "FXTRAN_FILE.h" 2


typedef struct FXTRAN_file
{
  struct FXTRAN_file * up;
  struct FXTRAN_file * next;
  char * name;
  int include_level;
  char * text;
  char * text_cur;
  int line;
  int line_total;
  int inclusion_line;
} FXTRAN_file;

typedef struct FXTRAN_cpp2loc
{
  int line;
  int len;
  FXTRAN_file * file;
  FXTRAN_xcp * xcp_list;
  FXTRAN_xcp_mask * xcp_mask;
} FXTRAN_cpp2loc;

typedef struct FXTRAN_cpp2loc_array
{
  FXTRAN_cpp2loc * base;
  FXTRAN_cpp2loc * curr;
  int len;
} FXTRAN_cpp2loc_array;
# 48 "FXTRAN_FILE.h"
void FXTRAN_file_enter (const char *, const char *, FXTRAN_file **, FXTRAN_file **);
void FXTRAN_file_leave (FXTRAN_file **, FXTRAN_file **);
const char * FXTRAN_grok_fortran_include (const char *, int, FXTRAN_opts *);

void FXTRAN_init_cpp2loc_array (FXTRAN_cpp2loc_array *);
void FXTRAN_grow_cpp2loc_array (FXTRAN_cpp2loc_array *, int);
void FXTRAN_incr_cpp2loc_array (FXTRAN_cpp2loc_array *);
void FXTRAN_take_cpp2loc_array (FXTRAN_cpp2loc_array *, FXTRAN_cpp2loc **);
# 15 "FXTRAN_XML.h" 2



typedef struct FXTRAN_xmlctx_stack_elt
{
  const char * tag;
  int pos;
} FXTRAN_xmlctx_stack_elt;




typedef struct FXTRAN_xmlctx
{

  f_buffer fb;



  int pos;
  int line;

  char * text;
  FXTRAN_char_info * ci;


  int lev;
  FXTRAN_xmlctx_stack_elt stack[1024];


  FXTRAN_opts opts;

  FXTRAN_file * root;
  FXTRAN_cpp2loc * c2l;

} FXTRAN_xmlctx;

typedef struct FXTRAN_XML_ATTR
{
  const char * name;
  const char * value;
} FXTRAN_XML_ATTR;
# 66 "FXTRAN_XML.h"
void FXTRAN_xmlctx_free (FXTRAN_xmlctx *);
void FXTRAN_xml_start_tag (const char *, int, FXTRAN_xmlctx *);
void FXTRAN_xml_start_tag_attr (const char *, int, FXTRAN_xmlctx *, const FXTRAN_XML_ATTR *);
void FXTRAN_xml_end_tag (int, FXTRAN_xmlctx *);
void FXTRAN_xml_end_tag_unsafe (int, FXTRAN_xmlctx *);
void FXTRAN_xml_word_tag (const char *, int, int, FXTRAN_xmlctx *);
void FXTRAN_xml_mark (int, int, FXTRAN_xmlctx *, char);
void FXTRAN_xml_finish_doc (FXTRAN_xmlctx *);
# 111 "FXTRAN_XML.h"
void FXTRAN_xml_err (const char *, FXTRAN_xmlctx *);
# 137 "FXTRAN_XML.h"
extern int FXTRAN_XML_dump;




void FXTRAN_XML_print_section (const char *, const FXTRAN_char_info *, int, int);

void FXTRAN_xml_word_tag_name (const char *, int, int, FXTRAN_xmlctx *, const char *, int);
void FXTRAN_xml_word_tag_op (const char *, int, int, FXTRAN_xmlctx *, const char *, int);
void FXTRAN_xml_word_tag_keyword (const char *, int, int, FXTRAN_xmlctx *, const char *, int);
# 171 "FXTRAN_XML.h"
int FXTRAN_parse_opts (FXTRAN_xmlctx *, int, char * argv[]);
void FXTRAN_free_opts (FXTRAN_xmlctx *);
void FXTRAN_help_opts (FXTRAN_xmlctx *);
# 10 "FXTRAN_OMP.h" 2


int FXTRAN_check_omp (const char *, const FXTRAN_char_info *, int, int,
               FXTRAN_xmlctx *);

int FXTRAN_handle_omp (const char *, FXTRAN_char_info *, int, int);

void FXTRAN_dump_ompd (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);
# 50 "FXTRAN_OMP.h"
typedef enum {
  FXTRAN_OMPD_NONE,
  FXTRAN_OMPD_PARALLELDO, FXTRAN_OMPD_ENDPARALLELDO, FXTRAN_OMPD_PARALLELSECTIONS, FXTRAN_OMPD_ENDPARALLELSECTIONS, FXTRAN_OMPD_PARALLELWORKSHARE, FXTRAN_OMPD_ENDPARALLELWORKSHARE, FXTRAN_OMPD_DO, FXTRAN_OMPD_ENDDO, FXTRAN_OMPD_SINGLE, FXTRAN_OMPD_ENDSINGLE, FXTRAN_OMPD_WORKSHARE, FXTRAN_OMPD_ENDWORKSHARE, FXTRAN_OMPD_SECTIONS, FXTRAN_OMPD_ENDSECTIONS, FXTRAN_OMPD_ATOMIC, FXTRAN_OMPD_CRITICAL, FXTRAN_OMPD_ENDCRITICAL, FXTRAN_OMPD_ORDERED, FXTRAN_OMPD_ENDORDERED, FXTRAN_OMPD_PARALLEL, FXTRAN_OMPD_ENDPARALLEL, FXTRAN_OMPD_FLUSH, FXTRAN_OMPD_THREADPRIVATE, FXTRAN_OMPD_MASTER, FXTRAN_OMPD_ENDMASTER,
  FXTRAN_OMPD_LAST
} FXTRAN_ompd_type;
# 8 "FXTRAN_OMP.c" 2

# 1 "FXTRAN_EXPR.h" 1
# 11 "FXTRAN_EXPR.h"
void FXTRAN_expr (const char *, const FXTRAN_char_info *,
                   int, FXTRAN_xmlctx *);
# 10 "FXTRAN_OMP.c" 2
# 1 "FXTRAN_MISC.h" 1
# 10 "FXTRAN_MISC.h"
void FXTRAN_remove_tabs (char **, int, int);
void FXTRAN_remove_cr (char **);
char * FXTRAN_escape_string (const char *);
void FXTRAN_set_char_info_off (const char *, FXTRAN_char_info *);
void FXTRAN_set_char_info_dop (const char *, FXTRAN_char_info *);
int FXTRAN_eat_word (const char *);
int FXTRAN_restrict_tci (char *, FXTRAN_char_info *,
            const char *, const FXTRAN_char_info *,
            int);
char * FXTRAN_slurp (const char *);

int FXTRAN_str_at_level (const char *, const FXTRAN_char_info *, const char *, int);

int FXTRAN_str_at_level_ir (const char *, const FXTRAN_char_info *, const char *, int, int);


typedef enum
{
  FXTRAN_grok_parens_ERROR = -1,
  FXTRAN_grok_parens_UNKNW = 0,
  FXTRAN_grok_parens_ARGKW = 1,
  FXTRAN_grok_parens_RANGE = 2,
  FXTRAN_grok_parens_ITRTR = 3
} FXTRAN_grok_parens_type;

FXTRAN_grok_parens_type FXTRAN_grok_parens (const char *, const FXTRAN_char_info *);
# 11 "FXTRAN_OMP.c" 2


# 1 "FXTRAN_ERROR.h" 1







# 1 "/usr/include/stdio.h" 1 3 4
# 30 "/usr/include/stdio.h" 3 4




# 1 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stddef.h" 1 3 4
# 35 "/usr/include/stdio.h" 2 3 4
# 45 "/usr/include/stdio.h" 3 4
struct _IO_FILE;



typedef struct _IO_FILE FILE;





# 65 "/usr/include/stdio.h" 3 4
typedef struct _IO_FILE __FILE;
# 75 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/libio.h" 1 3 4
# 32 "/usr/include/libio.h" 3 4
# 1 "/usr/include/_G_config.h" 1 3 4
# 15 "/usr/include/_G_config.h" 3 4
# 1 "/usr/lib/gcc/x86_64-manbo-linux-gnu/4.4.3/include/stddef.h" 1 3 4
# 16 "/usr/include/_G_config.h" 2 3 4




# 1 "/usr/include/wchar.h" 1 3 4
# 83 "/usr/include/wchar.h" 3 4
typedef struct
{
  int __count;
  union
  {

    unsigned int __wch;



    char __wchb[4];
  } __value;
} __mbstate_t;
# 21 "/usr/include/_G_config.h" 2 3 4

typedef struct
{
  __off_t __pos;
  __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
  __off64_t __pos;
  __mbstate_t __state;
} _G_fpos64_t;
# 53 "/usr/include/_G_config.h" 3 4
typedef int _G_int16_t __attribute__ ((__mode__ (__HI__)));
typedef int _G_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int _G_uint16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int _G_uint32_t __attribute__ ((__mode__ (__SI__)));
# 33 "/usr/include/libio.h" 2 3 4
# 170 "/usr/include/libio.h" 3 4
struct _IO_jump_t; struct _IO_FILE;
# 180 "/usr/include/libio.h" 3 4
typedef void _IO_lock_t;





struct _IO_marker {
  struct _IO_marker *_next;
  struct _IO_FILE *_sbuf;



  int _pos;
# 203 "/usr/include/libio.h" 3 4
};


enum __codecvt_result
{
  __codecvt_ok,
  __codecvt_partial,
  __codecvt_error,
  __codecvt_noconv
};
# 271 "/usr/include/libio.h" 3 4
struct _IO_FILE {
  int _flags;




  char* _IO_read_ptr;
  char* _IO_read_end;
  char* _IO_read_base;
  char* _IO_write_base;
  char* _IO_write_ptr;
  char* _IO_write_end;
  char* _IO_buf_base;
  char* _IO_buf_end;

  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;



  int _flags2;

  __off_t _old_offset;



  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];



  _IO_lock_t *_lock;
# 319 "/usr/include/libio.h" 3 4
  __off64_t _offset;
# 328 "/usr/include/libio.h" 3 4
  void *__pad1;
  void *__pad2;
  void *__pad3;
  void *__pad4;
  size_t __pad5;

  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];

};


typedef struct _IO_FILE _IO_FILE;


struct _IO_FILE_plus;

extern struct _IO_FILE_plus _IO_2_1_stdin_;
extern struct _IO_FILE_plus _IO_2_1_stdout_;
extern struct _IO_FILE_plus _IO_2_1_stderr_;
# 364 "/usr/include/libio.h" 3 4
typedef __ssize_t __io_read_fn (void *__cookie, char *__buf, size_t __nbytes);







typedef __ssize_t __io_write_fn (void *__cookie, __const char *__buf,
     size_t __n);







typedef int __io_seek_fn (void *__cookie, __off64_t *__pos, int __w);


typedef int __io_close_fn (void *__cookie);
# 416 "/usr/include/libio.h" 3 4
extern int __underflow (_IO_FILE *);
extern int __uflow (_IO_FILE *);
extern int __overflow (_IO_FILE *, int);
# 460 "/usr/include/libio.h" 3 4
extern int _IO_getc (_IO_FILE *__fp);
extern int _IO_putc (int __c, _IO_FILE *__fp);
extern int _IO_feof (_IO_FILE *__fp) __attribute__ ((__nothrow__));
extern int _IO_ferror (_IO_FILE *__fp) __attribute__ ((__nothrow__));

extern int _IO_peekc_locked (_IO_FILE *__fp);





extern void _IO_flockfile (_IO_FILE *) __attribute__ ((__nothrow__));
extern void _IO_funlockfile (_IO_FILE *) __attribute__ ((__nothrow__));
extern int _IO_ftrylockfile (_IO_FILE *) __attribute__ ((__nothrow__));
# 490 "/usr/include/libio.h" 3 4
extern int _IO_vfscanf (_IO_FILE * __restrict, const char * __restrict,
   __gnuc_va_list, int *__restrict);
extern int _IO_vfprintf (_IO_FILE *__restrict, const char *__restrict,
    __gnuc_va_list);
extern __ssize_t _IO_padn (_IO_FILE *, int, __ssize_t);
extern size_t _IO_sgetn (_IO_FILE *, void *, size_t);

extern __off64_t _IO_seekoff (_IO_FILE *, __off64_t, int, int);
extern __off64_t _IO_seekpos (_IO_FILE *, __off64_t, int);

extern void _IO_free_backup_area (_IO_FILE *) __attribute__ ((__nothrow__));
# 76 "/usr/include/stdio.h" 2 3 4
# 89 "/usr/include/stdio.h" 3 4


typedef _G_fpos_t fpos_t;




# 141 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 142 "/usr/include/stdio.h" 2 3 4



extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;







extern int remove (__const char *__filename) __attribute__ ((__nothrow__));

extern int rename (__const char *__old, __const char *__new) __attribute__ ((__nothrow__));




extern int renameat (int __oldfd, __const char *__old, int __newfd,
       __const char *__new) __attribute__ ((__nothrow__));








extern FILE *tmpfile (void) ;
# 186 "/usr/include/stdio.h" 3 4
extern char *tmpnam (char *__s) __attribute__ ((__nothrow__)) ;





extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__)) ;
# 204 "/usr/include/stdio.h" 3 4
extern char *tempnam (__const char *__dir, __const char *__pfx)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;








extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);

# 229 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 243 "/usr/include/stdio.h" 3 4






extern FILE *fopen (__const char *__restrict __filename,
      __const char *__restrict __modes) ;




extern FILE *freopen (__const char *__restrict __filename,
        __const char *__restrict __modes,
        FILE *__restrict __stream) ;
# 272 "/usr/include/stdio.h" 3 4

# 283 "/usr/include/stdio.h" 3 4
extern FILE *fdopen (int __fd, __const char *__modes) __attribute__ ((__nothrow__)) ;
# 296 "/usr/include/stdio.h" 3 4
extern FILE *fmemopen (void *__s, size_t __len, __const char *__modes)
  __attribute__ ((__nothrow__)) ;




extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__)) ;






extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__));





extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__));








extern int fprintf (FILE *__restrict __stream,
      __const char *__restrict __format, ...);




extern int printf (__const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      __const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, __const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (__const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, __const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));





extern int snprintf (char *__restrict __s, size_t __maxlen,
       __const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));

# 394 "/usr/include/stdio.h" 3 4
extern int vdprintf (int __fd, __const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, __const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));








extern int fscanf (FILE *__restrict __stream,
     __const char *__restrict __format, ...) ;




extern int scanf (__const char *__restrict __format, ...) ;

extern int sscanf (__const char *__restrict __s,
     __const char *__restrict __format, ...) __attribute__ ((__nothrow__));
# 425 "/usr/include/stdio.h" 3 4
extern int fscanf (FILE *__restrict __stream, __const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf") ;


extern int scanf (__const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf") ;

extern int sscanf (__const char *__restrict __s, __const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__));
# 445 "/usr/include/stdio.h" 3 4








extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (__const char *__restrict __s,
      __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
# 476 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (__const char *__restrict __s, __const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf")



     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
# 504 "/usr/include/stdio.h" 3 4









extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);

# 532 "/usr/include/stdio.h" 3 4
extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 543 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);











extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);

# 576 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);








extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     ;






extern char *gets (char *__s) ;

# 638 "/usr/include/stdio.h" 3 4
extern __ssize_t __getdelim (char **__restrict __lineptr,
          size_t *__restrict __n, int __delimiter,
          FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
        size_t *__restrict __n, int __delimiter,
        FILE *__restrict __stream) ;







extern __ssize_t getline (char **__restrict __lineptr,
       size_t *__restrict __n,
       FILE *__restrict __stream) ;








extern int fputs (__const char *__restrict __s, FILE *__restrict __stream);





extern int puts (__const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (__const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s) ;

# 710 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (__const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream) ;








extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);

# 746 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off_t __off, int __whence);




extern __off_t ftello (FILE *__stream) ;
# 765 "/usr/include/stdio.h" 3 4






extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);




extern int fsetpos (FILE *__stream, __const fpos_t *__pos);
# 788 "/usr/include/stdio.h" 3 4

# 797 "/usr/include/stdio.h" 3 4


extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__)) ;




extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;








extern void perror (__const char *__s);






# 1 "/usr/include/bits/sys_errlist.h" 1 3 4
# 27 "/usr/include/bits/sys_errlist.h" 3 4
extern int sys_nerr;
extern __const char *__const sys_errlist[];
# 827 "/usr/include/stdio.h" 2 3 4




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;
# 846 "/usr/include/stdio.h" 3 4
extern FILE *popen (__const char *__command, __const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__));
# 886 "/usr/include/stdio.h" 3 4
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__));
# 916 "/usr/include/stdio.h" 3 4

# 9 "FXTRAN_ERROR.h" 2

# 1 "FXTRAN_GDB.h" 1
# 9 "FXTRAN_GDB.h"
void FXTRAN_save_args (int, char * []);
void FXTRAN_save_where (const char *, int);
# 11 "FXTRAN_ERROR.h" 2
# 14 "FXTRAN_OMP.c" 2
# 1 "FXTRAN_ALPHA.h" 1
# 15 "FXTRAN_OMP.c" 2
# 29 "FXTRAN_OMP.c"
int FXTRAN_check_omp (const char * t, const FXTRAN_char_info * ci, int i1, int i2,
               FXTRAN_xmlctx * ctx)
{
  int i;
  int ci0mask;


  for (i = i1; i; i--)
    if (t[i-1] == '\n')
      break;


  for (; (((t[i]) == ' ') || ((t[i]) == '\t')); i++);

  ci0mask = ci[i].mask;

  if ((ci0mask == FXTRAN_OMD) || (ci0mask == FXTRAN_OMC))
    {
      for (; i < i2+1; i++)
        if (ci[i].column == 0)
          {
            int ci1mask;
            int seencode = 0;


            for (; (((t[i]) == ' ') || ((t[i]) == '\t')); i++);

            ci1mask = ci[i].mask;

            for (; i < i2+1; i++)
              if (t[i] == '\n')
                break;
              else if ((ci[i].mask == FXTRAN_COD) || (ci[i].mask == FXTRAN_STR))
                seencode = 1;
            if (seencode && (ci1mask != ci0mask))
              do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 64); fprintf (stderr, "Malformed OpenMP statement or directive"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 64); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
          }
      return ci0mask == FXTRAN_OMC ? 1 : 2;
    }


  return 0;
}

int FXTRAN_handle_omp (const char * text, FXTRAN_char_info * ci, int i, int OMP)
{
  int omp = 0;

  if (text[i+1] == '$')
    {
      int j;
      omp = 1;
      for (j = i-1; j >= 0; j--)
        {
          switch (text[j])
            {
              case '\n':
                goto done;
              case ' ': case '\t':
              break;
              default:
                omp = 0;
  goto done;
            }
        }
    }
done:

  if (omp)
    {
      if (((((((text+i+2)[0] == 'O') || ((text+i+2)[0] == 'o')) && (((text+i+2)[1] == 'M') || ((text+i+2)[1] == 'm')) && (((text+i+2)[2] == 'P') || ((text+i+2)[2] == 'p'))) && ((((text+i+2)[3]) == ' ') || (((text+i+2)[3]) == '\t')))) || (OMP && ((((text+i+2)[0] == 'O') || ((text+i+2)[0] == 'o')) && (((text+i+2)[1] == 'M') || ((text+i+2)[1] == 'm')) && (((text+i+2)[2] == 'P') || ((text+i+2)[2] == 'p')))))
        {
          ci[i+0].mask = FXTRAN_OMD;
          ci[i+1].mask = FXTRAN_OMD;
          ci[i+2].mask = FXTRAN_OMD;
          ci[i+3].mask = FXTRAN_OMD;
          ci[i+4].mask = FXTRAN_OMD;
          return 5;
 }
      else if ((text[i+2] == ' ') || OMP)
        {
          ci[i+0].mask = FXTRAN_OMC;
          ci[i+1].mask = FXTRAN_OMC;
          return 2;
 }
    }


  return 0;
}

static FXTRAN_ompd_type get_FXTRAN_omp_type (const char * t)
{







do { int len = strlen ("PARALLELDO"); if (strncmp ("PARALLELDO", t, len)==0) return FXTRAN_OMPD_PARALLELDO; } while (0); do { int len = strlen ("ENDPARALLELDO"); if (strncmp ("ENDPARALLELDO", t, len)==0) return FXTRAN_OMPD_ENDPARALLELDO; } while (0); do { int len = strlen ("PARALLELSECTIONS"); if (strncmp ("PARALLELSECTIONS", t, len)==0) return FXTRAN_OMPD_PARALLELSECTIONS; } while (0); do { int len = strlen ("ENDPARALLELSECTIONS"); if (strncmp ("ENDPARALLELSECTIONS", t, len)==0) return FXTRAN_OMPD_ENDPARALLELSECTIONS; } while (0); do { int len = strlen ("PARALLELWORKSHARE"); if (strncmp ("PARALLELWORKSHARE", t, len)==0) return FXTRAN_OMPD_PARALLELWORKSHARE; } while (0); do { int len = strlen ("ENDPARALLELWORKSHARE"); if (strncmp ("ENDPARALLELWORKSHARE", t, len)==0) return FXTRAN_OMPD_ENDPARALLELWORKSHARE; } while (0); do { int len = strlen ("DO"); if (strncmp ("DO", t, len)==0) return FXTRAN_OMPD_DO; } while (0); do { int len = strlen ("ENDDO"); if (strncmp ("ENDDO", t, len)==0) return FXTRAN_OMPD_ENDDO; } while (0); do { int len = strlen ("SINGLE"); if (strncmp ("SINGLE", t, len)==0) return FXTRAN_OMPD_SINGLE; } while (0); do { int len = strlen ("ENDSINGLE"); if (strncmp ("ENDSINGLE", t, len)==0) return FXTRAN_OMPD_ENDSINGLE; } while (0); do { int len = strlen ("WORKSHARE"); if (strncmp ("WORKSHARE", t, len)==0) return FXTRAN_OMPD_WORKSHARE; } while (0); do { int len = strlen ("ENDWORKSHARE"); if (strncmp ("ENDWORKSHARE", t, len)==0) return FXTRAN_OMPD_ENDWORKSHARE; } while (0); do { int len = strlen ("SECTIONS"); if (strncmp ("SECTIONS", t, len)==0) return FXTRAN_OMPD_SECTIONS; } while (0); do { int len = strlen ("ENDSECTIONS"); if (strncmp ("ENDSECTIONS", t, len)==0) return FXTRAN_OMPD_ENDSECTIONS; } while (0); do { int len = strlen ("ATOMIC"); if (strncmp ("ATOMIC", t, len)==0) return FXTRAN_OMPD_ATOMIC; } while (0); do { int len = strlen ("CRITICAL"); if (strncmp ("CRITICAL", t, len)==0) return FXTRAN_OMPD_CRITICAL; } while (0); do { int len = strlen ("ENDCRITICAL"); if (strncmp ("ENDCRITICAL", t, len)==0) return FXTRAN_OMPD_ENDCRITICAL; } while (0); do { int len = strlen ("ORDERED"); if (strncmp ("ORDERED", t, len)==0) return FXTRAN_OMPD_ORDERED; } while (0); do { int len = strlen ("ENDORDERED"); if (strncmp ("ENDORDERED", t, len)==0) return FXTRAN_OMPD_ENDORDERED; } while (0); do { int len = strlen ("PARALLEL"); if (strncmp ("PARALLEL", t, len)==0) return FXTRAN_OMPD_PARALLEL; } while (0); do { int len = strlen ("ENDPARALLEL"); if (strncmp ("ENDPARALLEL", t, len)==0) return FXTRAN_OMPD_ENDPARALLEL; } while (0); do { int len = strlen ("FLUSH"); if (strncmp ("FLUSH", t, len)==0) return FXTRAN_OMPD_FLUSH; } while (0); do { int len = strlen ("THREADPRIVATE"); if (strncmp ("THREADPRIVATE", t, len)==0) return FXTRAN_OMPD_THREADPRIVATE; } while (0); do { int len = strlen ("MASTER"); if (strncmp ("MASTER", t, len)==0) return FXTRAN_OMPD_MASTER; } while (0); do { int len = strlen ("ENDMASTER"); if (strncmp ("ENDMASTER", t, len)==0) return FXTRAN_OMPD_ENDMASTER; } while (0);


  return FXTRAN_OMPD_NONE;
}

static const char * ompd_as_str (FXTRAN_ompd_type type)
{
  switch (type)
    {
      case FXTRAN_OMPD_PARALLELDO : return "parallel" "-" "do" ;
      case FXTRAN_OMPD_ENDPARALLELDO : return "end" "-" "parallel" "-" "do" ;
      case FXTRAN_OMPD_PARALLELSECTIONS : return "parallel" "-" "sections" ;
      case FXTRAN_OMPD_ENDPARALLELSECTIONS : return "end" "-" "parallel" "-" "sections" ;
      case FXTRAN_OMPD_PARALLELWORKSHARE : return "parallel" "-" "work" "-" "share" ;
      case FXTRAN_OMPD_ENDPARALLELWORKSHARE : return "end" "-" "parallel" "-" "work" "-" "share" ;
      case FXTRAN_OMPD_DO : return "do" ;
      case FXTRAN_OMPD_ENDDO : return "end" "-" "do" ;
      case FXTRAN_OMPD_SINGLE : return "single" ;
      case FXTRAN_OMPD_ENDSINGLE : return "end" "-" "single" ;
      case FXTRAN_OMPD_WORKSHARE : return "work" "-" "share" ;
      case FXTRAN_OMPD_ENDWORKSHARE : return "end" "-" "work" "-" "share" ;
      case FXTRAN_OMPD_SECTIONS : return "sections" ;
      case FXTRAN_OMPD_ENDSECTIONS : return "end" "-" "sections" ;
      case FXTRAN_OMPD_ATOMIC : return "atomic" ;
      case FXTRAN_OMPD_CRITICAL : return "critical" ;
      case FXTRAN_OMPD_ENDCRITICAL : return "end" "-" "critical" ;
      case FXTRAN_OMPD_ORDERED : return "ordered" ;
      case FXTRAN_OMPD_ENDORDERED : return "end" "-" "ordered" ;
      case FXTRAN_OMPD_PARALLEL : return "parallel" ;
      case FXTRAN_OMPD_ENDPARALLEL : return "end" "-" "parallel" ;
      case FXTRAN_OMPD_FLUSH : return "flush" ;
      case FXTRAN_OMPD_THREADPRIVATE : return "thread" "-" "private" ;
      case FXTRAN_OMPD_MASTER : return "master" ;
      case FXTRAN_OMPD_ENDMASTER : return "end" "-" "master" ;
      case FXTRAN_OMPD_NONE:
      case FXTRAN_OMPD_LAST:
      break;
   }
  return ((void *)0);
}

static int FXTRAN_omc_REDUCTION (const char * t, const FXTRAN_char_info * ci,
                   FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k, kp, kn;
  k = FXTRAN_eat_word (t);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("clause", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] != '(')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 183); fprintf (stderr, "Malformed OpenMP clause; expected `('"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 183); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);

  kp = FXTRAN_str_at_level (t, ci, ")", 0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", 1, kp);

  if (k == 0)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 191); fprintf (stderr, "Malformed OpenMP clause; expected `:'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 191); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  if ((kn = FXTRAN_eat_word (t)))
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("procedure" "-" "N", ci->offset, ci[(kn)-1].offset+1, ctx, t, kn); } while (0);
      do { int _n = (kn); ci += _n; t += _n; } while (0);
    }
  else
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_op ("op", ci->offset, ci[(k-1)-1].offset+1, ctx, t, k-1); } while (0);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
    }

  if (t[0] != ':')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 205); fprintf (stderr, "Malformed OpenMP clause; expected `:'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 205); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  do { int _n = (1); ci += _n; t += _n; } while (0);

  while (t[0] != ')')
    {
      kn = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("V", ci->offset, ci[(kn)-1].offset+1, ctx, t, kn); } while (0);
      do { int _n = (kn); ci += _n; t += _n; } while (0);
      if (t[0] == ',')
        do { int _n = (1); ci += _n; t += _n; } while (0);
      else if (t[0] != ')')
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 216); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 216); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
    }

  if (t[0] != ')')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 220); fprintf (stderr, "Malformed OpenMP clause; expected `)'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 220); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  do { int _n = (1); ci += _n; t += _n; } while (0);


  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return t - T;
}

static int FXTRAN_omc_list (const char * t, const FXTRAN_char_info * ci,
              FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = FXTRAN_eat_word (t);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("clause", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] != '(')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 240); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 240); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("LT", ci->offset, ctx); } while (0);
  while (t[0] != ')')
    {
      k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      if (t[0] == ',')
        do { int _n = (1); ci += _n; t += _n; } while (0);
    }
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return t - T;
}

static int FXTRAN_omc_expr (const char * t, const FXTRAN_char_info * ci,
              FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = FXTRAN_eat_word (t);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("clause", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] == '(')
    {
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return t - T;
}

static int FXTRAN_omc_SCHEDULE (const char * t, const FXTRAN_char_info * ci,
                  FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k, kp;
  k = FXTRAN_eat_word (t);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("clause", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] != '(')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 297); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 297); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  do { int _n = (1); ci += _n; t += _n; } while (0);

  k = FXTRAN_eat_word (t);

  if (k == 0)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 303); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 303); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("T", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] == ',')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("chunk" "-" "size", ci->offset, ctx); } while (0);
      kp = FXTRAN_str_at_level (t, ci, ")", 0);
      FXTRAN_expr (t, ci, kp-1, ctx);
      do { int _n = (kp-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

  if (t[0] != ')')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 320); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 320); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  do { int _n = (1); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return t - T;
}

static int FXTRAN_omc_ktype (const char * t, const FXTRAN_char_info * ci,
               FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = FXTRAN_eat_word (t);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("clause", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] != '(')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 339); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 339); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  k = FXTRAN_eat_word (t);

  if (k == 0)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 344); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 344); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("T", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] != ')')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 351); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 351); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return t - T;
}

static int FXTRAN_omc_simple (const char * t, const FXTRAN_char_info * ci,
                FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;
  k = FXTRAN_eat_word (t);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("clause", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return t - T;
}
# 399 "FXTRAN_OMP.c"
static int FXTRAN_omc_NOWAIT (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_simple (t, ci, ctx); }
static int FXTRAN_omc_ORDERED (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_simple (t, ci, ctx); }

static int FXTRAN_omc_DEFAULT (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_ktype (t, ci, ctx); }

static int FXTRAN_omc_IF (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_expr (t, ci, ctx); }
static int FXTRAN_omc_NUM_THREADS (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_expr (t, ci, ctx); }

static int FXTRAN_omc_COPYIN (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_list (t, ci, ctx); }
static int FXTRAN_omc_FIRSTPRIVATE (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_list (t, ci, ctx); }
static int FXTRAN_omc_LASTPRIVATE (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_list (t, ci, ctx); }
static int FXTRAN_omc_PRIVATE (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_list (t, ci, ctx); }
static int FXTRAN_omc_COPYPRIVATE (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_list (t, ci, ctx); }
static int FXTRAN_omc_SHARED (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { return FXTRAN_omc_list (t, ci, ctx); }

static void ompd_clause_list (const char * t, const FXTRAN_char_info * ci,
                FXTRAN_xmlctx * ctx)
{
  int len;
  int k;

  while (t[0])
    {
      k = 0;







      len = strlen ("COPYIN"); if (strncmp ("COPYIN", t, len) == 0) { k = FXTRAN_omc_COPYIN(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("COPYPRIVATE"); if (strncmp ("COPYPRIVATE", t, len) == 0) { k = FXTRAN_omc_COPYPRIVATE(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("DEFAULT"); if (strncmp ("DEFAULT", t, len) == 0) { k = FXTRAN_omc_DEFAULT(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("FIRSTPRIVATE"); if (strncmp ("FIRSTPRIVATE", t, len) == 0) { k = FXTRAN_omc_FIRSTPRIVATE(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("IF"); if (strncmp ("IF", t, len) == 0) { k = FXTRAN_omc_IF(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("LASTPRIVATE"); if (strncmp ("LASTPRIVATE", t, len) == 0) { k = FXTRAN_omc_LASTPRIVATE(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("NOWAIT"); if (strncmp ("NOWAIT", t, len) == 0) { k = FXTRAN_omc_NOWAIT(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("NUM_THREADS"); if (strncmp ("NUM_THREADS", t, len) == 0) { k = FXTRAN_omc_NUM_THREADS(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("ORDERED"); if (strncmp ("ORDERED", t, len) == 0) { k = FXTRAN_omc_ORDERED(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("PRIVATE"); if (strncmp ("PRIVATE", t, len) == 0) { k = FXTRAN_omc_PRIVATE(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("REDUCTION"); if (strncmp ("REDUCTION", t, len) == 0) { k = FXTRAN_omc_REDUCTION(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("SCHEDULE"); if (strncmp ("SCHEDULE", t, len) == 0) { k = FXTRAN_omc_SCHEDULE(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); } len = strlen ("SHARED"); if (strncmp ("SHARED", t, len) == 0) { k = FXTRAN_omc_SHARED(t, ci, ctx); do { int _n = (k); ci += _n; t += _n; } while (0); }


      if (k == 0)
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 434); fprintf (stderr, "Unknown OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 434); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

      if (t[0] == ',')
        do { int _n = (1); ci += _n; t += _n; } while (0);
    }
}


static void ompd_optional_name (const char * t, const FXTRAN_char_info * ci,
                  FXTRAN_xmlctx * ctx)
{
  int k;
  if (t[0] == '(')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
      do { int _n = (k+1); ci += _n; t += _n; } while (0);
    }
  if (t[0])
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 454); fprintf (stderr, "Malformed OpenMP directive"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 454); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
}
# 476 "FXTRAN_OMP.c"
static void ompd_FLUSH_extra (const char * t, const FXTRAN_char_info * ci,
                FXTRAN_xmlctx * ctx)
{
  int k;
  do { int _n = (5); ci += _n; t += _n; } while (0);
  if (t[0] == '(')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("list", ci->offset, ctx); } while (0);
      while (t[0] != ')')
        {
          k = FXTRAN_eat_word (t);
          do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("V", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
          do { int _n = (k); ci += _n; t += _n; } while (0);
          if (t[0] == ',')
            do { int _n = (1); ci += _n; t += _n; } while (0);
          else if (t[0] != ')')
            do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 493); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 493); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
        }
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
}

static void ompd_THREADPRIVATE_extra (const char * t, const FXTRAN_char_info * ci,
                        FXTRAN_xmlctx * ctx)
{
  int k;
  do { int _n = (13); ci += _n; t += _n; } while (0);
  if (t[0] != '(')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 505); fprintf (stderr, "Malformed OpenMP directive"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 505); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  do { int _n = (1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("LT", ci->offset, ctx); } while (0);
  while (t[0] != ')')
    {
      k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("V", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      if (t[0] == ',')
        do { int _n = (1); ci += _n; t += _n; } while (0);
      else if (t[0] != ')')
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_OMP.c"":%d\n", 516); fprintf (stderr, "Malformed OpenMP clause"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_OMP.c", 516); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
    }
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}

static void ompd_PARALLELDO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("PARALLELDO"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDPARALLELDO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDPARALLELDO"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_PARALLELSECTIONS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("PARALLELSECTIONS"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDPARALLELSECTIONS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDPARALLELSECTIONS"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_PARALLELWORKSHARE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("PARALLELWORKSHARE"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDPARALLELWORKSHARE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDPARALLELWORKSHARE"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_DO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("DO"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDDO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDDO"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_SINGLE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("SINGLE"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDSINGLE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDSINGLE"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_WORKSHARE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("WORKSHARE"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDWORKSHARE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDWORKSHARE"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_SECTIONS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("SECTIONS"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDSECTIONS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDSECTIONS"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ATOMIC_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ATOMIC"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ORDERED_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ORDERED"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDORDERED_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDORDERED"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_PARALLEL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("PARALLEL"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDPARALLEL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDPARALLEL"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_MASTER_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("MASTER"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }
static void ompd_ENDMASTER_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDMASTER"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_clause_list (t, ci, ctx); }

static void ompd_CRITICAL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("CRITICAL"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_optional_name (t, ci, ctx); }
static void ompd_ENDCRITICAL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx) { int k = strlen ("ENDCRITICAL"); do { int _n = (k); ci += _n; t += _n; } while (0); return ompd_optional_name (t, ci, ctx); }



void FXTRAN_dump_ompd (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int k = strlen (t);
  FXTRAN_ompd_type type = get_FXTRAN_omp_type (t);
  const char * str = type == FXTRAN_OMPD_NONE ? "broken" "-" "omp" : ompd_as_str (type);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (str, ci->offset, ctx); } while (0);





  switch (type)
    {
      case FXTRAN_OMPD_PARALLELDO: ompd_PARALLELDO_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDPARALLELDO: ompd_ENDPARALLELDO_extra (t, ci, ctx); break; case FXTRAN_OMPD_PARALLELSECTIONS: ompd_PARALLELSECTIONS_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDPARALLELSECTIONS: ompd_ENDPARALLELSECTIONS_extra (t, ci, ctx); break; case FXTRAN_OMPD_PARALLELWORKSHARE: ompd_PARALLELWORKSHARE_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDPARALLELWORKSHARE: ompd_ENDPARALLELWORKSHARE_extra (t, ci, ctx); break; case FXTRAN_OMPD_DO: ompd_DO_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDDO: ompd_ENDDO_extra (t, ci, ctx); break; case FXTRAN_OMPD_SINGLE: ompd_SINGLE_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDSINGLE: ompd_ENDSINGLE_extra (t, ci, ctx); break; case FXTRAN_OMPD_WORKSHARE: ompd_WORKSHARE_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDWORKSHARE: ompd_ENDWORKSHARE_extra (t, ci, ctx); break; case FXTRAN_OMPD_SECTIONS: ompd_SECTIONS_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDSECTIONS: ompd_ENDSECTIONS_extra (t, ci, ctx); break; case FXTRAN_OMPD_ATOMIC: ompd_ATOMIC_extra (t, ci, ctx); break; case FXTRAN_OMPD_CRITICAL: ompd_CRITICAL_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDCRITICAL: ompd_ENDCRITICAL_extra (t, ci, ctx); break; case FXTRAN_OMPD_ORDERED: ompd_ORDERED_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDORDERED: ompd_ENDORDERED_extra (t, ci, ctx); break; case FXTRAN_OMPD_PARALLEL: ompd_PARALLEL_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDPARALLEL: ompd_ENDPARALLEL_extra (t, ci, ctx); break; case FXTRAN_OMPD_FLUSH: ompd_FLUSH_extra (t, ci, ctx); break; case FXTRAN_OMPD_THREADPRIVATE: ompd_THREADPRIVATE_extra (t, ci, ctx); break; case FXTRAN_OMPD_MASTER: ompd_MASTER_extra (t, ci, ctx); break; case FXTRAN_OMPD_ENDMASTER: ompd_ENDMASTER_extra (t, ci, ctx); break;
      default:
      break;
    }


  if (type == FXTRAN_OMPD_NONE)
    do { int _n = (k); ci += _n; t += _n; } while (0);
  else
    do { int _n = (strlen (t)); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

}
