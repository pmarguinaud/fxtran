# 1 "FXTRAN_STMT.c"
# 1 "/home/gmap/mrpm/marguina/bin/fxtran-1369638055/src//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "FXTRAN_STMT.c"




# 1 "/usr/include/stdio.h" 1 3 4
# 28 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 361 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 373 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 374 "/usr/include/sys/cdefs.h" 2 3 4
# 362 "/usr/include/features.h" 2 3 4
# 385 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4



# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 5 "/usr/include/gnu/stubs.h" 2 3 4




# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 2 3 4
# 386 "/usr/include/features.h" 2 3 4
# 29 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h" 1 3 4
# 211 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 35 "/usr/include/stdio.h" 2 3 4

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
# 37 "/usr/include/stdio.h" 2 3 4
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
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h" 1 3 4
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
# 53 "/usr/include/libio.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 54 "/usr/include/libio.h" 2 3 4
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




typedef __gnuc_va_list va_list;
# 91 "/usr/include/stdio.h" 3 4
typedef __off_t off_t;
# 103 "/usr/include/stdio.h" 3 4
typedef __ssize_t ssize_t;







typedef _G_fpos_t fpos_t;




# 161 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 162 "/usr/include/stdio.h" 2 3 4



extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;









extern int remove (__const char *__filename) __attribute__ ((__nothrow__));

extern int rename (__const char *__old, __const char *__new) __attribute__ ((__nothrow__));




extern int renameat (int __oldfd, __const char *__old, int __newfd,
       __const char *__new) __attribute__ ((__nothrow__));








extern FILE *tmpfile (void) ;
# 208 "/usr/include/stdio.h" 3 4
extern char *tmpnam (char *__s) __attribute__ ((__nothrow__)) ;





extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__)) ;
# 226 "/usr/include/stdio.h" 3 4
extern char *tempnam (__const char *__dir, __const char *__pfx)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;








extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);

# 251 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 265 "/usr/include/stdio.h" 3 4






extern FILE *fopen (__const char *__restrict __filename,
      __const char *__restrict __modes) ;




extern FILE *freopen (__const char *__restrict __filename,
        __const char *__restrict __modes,
        FILE *__restrict __stream) ;
# 294 "/usr/include/stdio.h" 3 4

# 305 "/usr/include/stdio.h" 3 4
extern FILE *fdopen (int __fd, __const char *__modes) __attribute__ ((__nothrow__)) ;
# 318 "/usr/include/stdio.h" 3 4
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

# 416 "/usr/include/stdio.h" 3 4
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
# 447 "/usr/include/stdio.h" 3 4
extern int fscanf (FILE *__restrict __stream, __const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf")

                               ;
extern int scanf (__const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf")
                              ;
extern int sscanf (__const char *__restrict __s, __const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf")

                          __attribute__ ((__nothrow__));
# 467 "/usr/include/stdio.h" 3 4








extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (__const char *__restrict __s,
      __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
# 498 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (__const char *__restrict __s, __const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf")



     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
# 526 "/usr/include/stdio.h" 3 4









extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);

# 554 "/usr/include/stdio.h" 3 4
extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 565 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);











extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);

# 598 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);








extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     ;






extern char *gets (char *__s) ;

# 660 "/usr/include/stdio.h" 3 4
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

# 732 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (__const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream) ;








extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);

# 768 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off_t __off, int __whence);




extern __off_t ftello (FILE *__stream) ;
# 787 "/usr/include/stdio.h" 3 4






extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);




extern int fsetpos (FILE *__stream, __const fpos_t *__pos);
# 810 "/usr/include/stdio.h" 3 4

# 819 "/usr/include/stdio.h" 3 4


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
# 849 "/usr/include/stdio.h" 2 3 4




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__)) ;
# 868 "/usr/include/stdio.h" 3 4
extern FILE *popen (__const char *__command, __const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__));
# 908 "/usr/include/stdio.h" 3 4
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__));
# 938 "/usr/include/stdio.h" 3 4

# 6 "FXTRAN_STMT.c" 2
# 1 "/usr/include/stdlib.h" 1 3 4
# 33 "/usr/include/stdlib.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h" 1 3 4
# 323 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h" 3 4
typedef int wchar_t;
# 34 "/usr/include/stdlib.h" 2 3 4








# 1 "/usr/include/bits/waitflags.h" 1 3 4
# 43 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/bits/waitstatus.h" 1 3 4
# 65 "/usr/include/bits/waitstatus.h" 3 4
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
# 66 "/usr/include/bits/waitstatus.h" 2 3 4

union wait
  {
    int w_status;
    struct
      {

 unsigned int __w_termsig:7;
 unsigned int __w_coredump:1;
 unsigned int __w_retcode:8;
 unsigned int:16;







      } __wait_terminated;
    struct
      {

 unsigned int __w_stopval:8;
 unsigned int __w_stopsig:8;
 unsigned int:16;






      } __wait_stopped;
  };
# 44 "/usr/include/stdlib.h" 2 3 4
# 68 "/usr/include/stdlib.h" 3 4
typedef union
  {
    union wait *__uptr;
    int *__iptr;
  } __WAIT_STATUS __attribute__ ((__transparent_union__));
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
# 28 "/usr/include/sys/types.h" 3 4






typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;




typedef __loff_t loff_t;



typedef __ino_t ino_t;
# 61 "/usr/include/sys/types.h" 3 4
typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;
# 99 "/usr/include/sys/types.h" 3 4
typedef __pid_t pid_t;





typedef __id_t id_t;
# 116 "/usr/include/sys/types.h" 3 4
typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;
# 133 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/time.h" 1 3 4
# 58 "/usr/include/time.h" 3 4


typedef __clock_t clock_t;



# 74 "/usr/include/time.h" 3 4


typedef __time_t time_t;



# 92 "/usr/include/time.h" 3 4
typedef __clockid_t clockid_t;
# 104 "/usr/include/time.h" 3 4
typedef __timer_t timer_t;
# 134 "/usr/include/sys/types.h" 2 3 4
# 147 "/usr/include/sys/types.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h" 1 3 4
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
# 220 "/usr/include/sys/types.h" 3 4
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
# 75 "/usr/include/bits/time.h" 3 4
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





typedef __blksize_t blksize_t;






typedef __blkcnt_t blkcnt_t;



typedef __fsblkcnt_t fsblkcnt_t;



typedef __fsfilcnt_t fsfilcnt_t;
# 271 "/usr/include/sys/types.h" 3 4
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
# 272 "/usr/include/sys/types.h" 2 3 4



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
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h" 1 3 4
# 26 "/usr/include/alloca.h" 2 3 4







extern void *alloca (size_t __size) __attribute__ ((__nothrow__));






# 498 "/usr/include/stdlib.h" 2 3 4





extern void *valloc (size_t __size) __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) ;




extern int posix_memalign (void **__memptr, size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




extern void abort (void) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
# 531 "/usr/include/stdlib.h" 3 4





extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));






extern void exit (int __status) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));
# 554 "/usr/include/stdlib.h" 3 4






extern void _Exit (int __status) __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));






extern char *getenv (__const char *__name) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;




extern char *__secure_getenv (__const char *__name)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;





extern int putenv (char *__string) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));





extern int setenv (__const char *__name, __const char *__value, int __replace)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2)));


extern int unsetenv (__const char *__name) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));






extern int clearenv (void) __attribute__ ((__nothrow__));
# 606 "/usr/include/stdlib.h" 3 4
extern char *mktemp (char *__template) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 620 "/usr/include/stdlib.h" 3 4
extern int mkstemp (char *__template) __attribute__ ((__nonnull__ (1))) ;
# 642 "/usr/include/stdlib.h" 3 4
extern int mkstemps (char *__template, int __suffixlen) __attribute__ ((__nonnull__ (1))) ;
# 663 "/usr/include/stdlib.h" 3 4
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1))) ;
# 712 "/usr/include/stdlib.h" 3 4





extern int system (__const char *__command) ;

# 734 "/usr/include/stdlib.h" 3 4
extern char *realpath (__const char *__restrict __name,
         char *__restrict __resolved) __attribute__ ((__nothrow__)) ;






typedef int (*__compar_fn_t) (__const void *, __const void *);
# 752 "/usr/include/stdlib.h" 3 4



extern void *bsearch (__const void *__key, __const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     __attribute__ ((__nonnull__ (1, 2, 5))) ;



extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));
# 771 "/usr/include/stdlib.h" 3 4
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

# 808 "/usr/include/stdlib.h" 3 4
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
# 896 "/usr/include/stdlib.h" 3 4
extern int getsubopt (char **__restrict __optionp,
        char *__const *__restrict __tokens,
        char **__restrict __valuep)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2, 3))) ;
# 948 "/usr/include/stdlib.h" 3 4
extern int getloadavg (double __loadavg[], int __nelem)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));
# 964 "/usr/include/stdlib.h" 3 4

# 7 "FXTRAN_STMT.c" 2
# 1 "/usr/include/string.h" 1 3 4
# 29 "/usr/include/string.h" 3 4





# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stddef.h" 1 3 4
# 35 "/usr/include/string.h" 2 3 4









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
# 95 "/usr/include/string.h" 3 4
extern void *memchr (__const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


# 126 "/usr/include/string.h" 3 4


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

  struct __locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
} *__locale_t;


typedef __locale_t locale_t;
# 163 "/usr/include/string.h" 2 3 4


extern int strcoll_l (__const char *__s1, __const char *__s2, __locale_t __l)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));

extern size_t strxfrm_l (char *__dest, __const char *__src, size_t __n,
    __locale_t __l) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (2, 4)));





extern char *strdup (__const char *__s)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));






extern char *strndup (__const char *__string, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));
# 210 "/usr/include/string.h" 3 4

# 235 "/usr/include/string.h" 3 4
extern char *strchr (__const char *__s, int __c)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 262 "/usr/include/string.h" 3 4
extern char *strrchr (__const char *__s, int __c)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


# 281 "/usr/include/string.h" 3 4



extern size_t strcspn (__const char *__s, __const char *__reject)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern size_t strspn (__const char *__s, __const char *__accept)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 314 "/usr/include/string.h" 3 4
extern char *strpbrk (__const char *__s, __const char *__accept)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 342 "/usr/include/string.h" 3 4
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
# 397 "/usr/include/string.h" 3 4


extern size_t strlen (__const char *__s)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern size_t strnlen (__const char *__string, size_t __maxlen)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern char *strerror (int __errnum) __attribute__ ((__nothrow__));

# 427 "/usr/include/string.h" 3 4
extern int strerror_r (int __errnum, char *__buf, size_t __buflen) __asm__ ("" "__xpg_strerror_r") __attribute__ ((__nothrow__))

                        __attribute__ ((__nonnull__ (2)));
# 445 "/usr/include/string.h" 3 4
extern char *strerror_l (int __errnum, __locale_t __l) __attribute__ ((__nothrow__));





extern void __bzero (void *__s, size_t __n) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));



extern void bcopy (__const void *__src, void *__dest, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1, 2)));


extern void bzero (void *__s, size_t __n) __attribute__ ((__nothrow__)) __attribute__ ((__nonnull__ (1)));


extern int bcmp (__const void *__s1, __const void *__s2, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 489 "/usr/include/string.h" 3 4
extern char *index (__const char *__s, int __c)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 517 "/usr/include/string.h" 3 4
extern char *rindex (__const char *__s, int __c)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));




extern int ffs (int __i) __attribute__ ((__nothrow__)) __attribute__ ((__const__));
# 536 "/usr/include/string.h" 3 4
extern int strcasecmp (__const char *__s1, __const char *__s2)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strncasecmp (__const char *__s1, __const char *__s2, size_t __n)
     __attribute__ ((__nothrow__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 559 "/usr/include/string.h" 3 4
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
# 646 "/usr/include/string.h" 3 4

# 8 "FXTRAN_STMT.c" 2
# 1 "/usr/include/ctype.h" 1 3 4
# 30 "/usr/include/ctype.h" 3 4

# 48 "/usr/include/ctype.h" 3 4
enum
{
  _ISupper = ((0) < 8 ? ((1 << (0)) << 8) : ((1 << (0)) >> 8)),
  _ISlower = ((1) < 8 ? ((1 << (1)) << 8) : ((1 << (1)) >> 8)),
  _ISalpha = ((2) < 8 ? ((1 << (2)) << 8) : ((1 << (2)) >> 8)),
  _ISdigit = ((3) < 8 ? ((1 << (3)) << 8) : ((1 << (3)) >> 8)),
  _ISxdigit = ((4) < 8 ? ((1 << (4)) << 8) : ((1 << (4)) >> 8)),
  _ISspace = ((5) < 8 ? ((1 << (5)) << 8) : ((1 << (5)) >> 8)),
  _ISprint = ((6) < 8 ? ((1 << (6)) << 8) : ((1 << (6)) >> 8)),
  _ISgraph = ((7) < 8 ? ((1 << (7)) << 8) : ((1 << (7)) >> 8)),
  _ISblank = ((8) < 8 ? ((1 << (8)) << 8) : ((1 << (8)) >> 8)),
  _IScntrl = ((9) < 8 ? ((1 << (9)) << 8) : ((1 << (9)) >> 8)),
  _ISpunct = ((10) < 8 ? ((1 << (10)) << 8) : ((1 << (10)) >> 8)),
  _ISalnum = ((11) < 8 ? ((1 << (11)) << 8) : ((1 << (11)) >> 8))
};
# 81 "/usr/include/ctype.h" 3 4
extern __const unsigned short int **__ctype_b_loc (void)
     __attribute__ ((__nothrow__)) __attribute__ ((__const));
extern __const __int32_t **__ctype_tolower_loc (void)
     __attribute__ ((__nothrow__)) __attribute__ ((__const));
extern __const __int32_t **__ctype_toupper_loc (void)
     __attribute__ ((__nothrow__)) __attribute__ ((__const));
# 96 "/usr/include/ctype.h" 3 4






extern int isalnum (int) __attribute__ ((__nothrow__));
extern int isalpha (int) __attribute__ ((__nothrow__));
extern int iscntrl (int) __attribute__ ((__nothrow__));
extern int isdigit (int) __attribute__ ((__nothrow__));
extern int islower (int) __attribute__ ((__nothrow__));
extern int isgraph (int) __attribute__ ((__nothrow__));
extern int isprint (int) __attribute__ ((__nothrow__));
extern int ispunct (int) __attribute__ ((__nothrow__));
extern int isspace (int) __attribute__ ((__nothrow__));
extern int isupper (int) __attribute__ ((__nothrow__));
extern int isxdigit (int) __attribute__ ((__nothrow__));



extern int tolower (int __c) __attribute__ ((__nothrow__));


extern int toupper (int __c) __attribute__ ((__nothrow__));








extern int isblank (int) __attribute__ ((__nothrow__));


# 142 "/usr/include/ctype.h" 3 4
extern int isascii (int __c) __attribute__ ((__nothrow__));



extern int toascii (int __c) __attribute__ ((__nothrow__));



extern int _toupper (int) __attribute__ ((__nothrow__));
extern int _tolower (int) __attribute__ ((__nothrow__));
# 247 "/usr/include/ctype.h" 3 4
extern int isalnum_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int isalpha_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int iscntrl_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int isdigit_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int islower_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int isgraph_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int isprint_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int ispunct_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int isspace_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int isupper_l (int, __locale_t) __attribute__ ((__nothrow__));
extern int isxdigit_l (int, __locale_t) __attribute__ ((__nothrow__));

extern int isblank_l (int, __locale_t) __attribute__ ((__nothrow__));



extern int __tolower_l (int __c, __locale_t __l) __attribute__ ((__nothrow__));
extern int tolower_l (int __c, __locale_t __l) __attribute__ ((__nothrow__));


extern int __toupper_l (int __c, __locale_t __l) __attribute__ ((__nothrow__));
extern int toupper_l (int __c, __locale_t __l) __attribute__ ((__nothrow__));
# 323 "/usr/include/ctype.h" 3 4

# 9 "FXTRAN_STMT.c" 2

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
# 11 "FXTRAN_STMT.c" 2
# 1 "FXTRAN_STMT.h" 1
# 11 "FXTRAN_STMT.h"
# 1 "FXTRAN_XML.h" 1
# 10 "FXTRAN_XML.h"
# 1 "FXTRAN_FBUFFER.h" 1
# 14 "FXTRAN_FBUFFER.h"
# 1 "f_buffer.h" 1
# 10 "f_buffer.h"
# 1 "/usr/lib/gcc/x86_64-redhat-linux/4.4.7/include/stdarg.h" 1 3 4
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
  int namelist;
  int namelist_diff;
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

  int argc;
  char ** argv;

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
# 12 "FXTRAN_STMT.h" 2


extern const char * FXTRAN_ops[];
extern const char * FXTRAN_types[];
# 130 "FXTRAN_STMT.h"
typedef enum
{
 FXTRAN_NONE,
 FXTRAN_ARITHMETICIF, FXTRAN_ASSIGNEDGOTO, FXTRAN_COMPONENTDECL, FXTRAN_POINTERASSIGNMENT, FXTRAN_ASSIGNMENT, FXTRAN_ASSOCIATE, FXTRAN_ASYNCHRONOUS, FXTRAN_IF, FXTRAN_FORALL, FXTRAN_ALLOCATABLE, FXTRAN_ALLOCATE, FXTRAN_ASSIGN, FXTRAN_BACKSPACE, FXTRAN_BIND, FXTRAN_BLOCKDATA, FXTRAN_CALL, FXTRAN_CASE, FXTRAN_CLASS, FXTRAN_CLASSIS, FXTRAN_CLOSE, FXTRAN_COMMON, FXTRAN_COMPUTEDGOTO, FXTRAN_CONTAINS, FXTRAN_CONTINUE, FXTRAN_CYCLE, FXTRAN_TYPEDECL, FXTRAN_DATA, FXTRAN_DEALLOCATE, FXTRAN_DIMENSION, FXTRAN_DO, FXTRAN_DOLABEL, FXTRAN_ENDASSOCIATE, FXTRAN_ENDBLOCKDATA, FXTRAN_ENDCLASS, FXTRAN_ENDDO, FXTRAN_ENDFORALL, FXTRAN_ENDFUNCTION, FXTRAN_ENDINTERFACE, FXTRAN_ENDMODULE, FXTRAN_ENDPROGRAM, FXTRAN_ENDSELECTCASE, FXTRAN_ENDSELECTTYPE, FXTRAN_ENDSUBROUTINE, FXTRAN_ENDTYPE, FXTRAN_ENDWHERE, FXTRAN_ENDFILE, FXTRAN_ELSEIF, FXTRAN_ELSE, FXTRAN_ELSEWHERE, FXTRAN_ENDIF, FXTRAN_ENTRY, FXTRAN_ENDENUM, FXTRAN_ENUM, FXTRAN_ENUMERATOR, FXTRAN_EQUIVALENCE, FXTRAN_EXIT, FXTRAN_EXTERNAL, FXTRAN_FINAL, FXTRAN_FLUSH, FXTRAN_FORALLCONSTRUCT, FXTRAN_FORMAT, FXTRAN_FUNCTION, FXTRAN_GENERIC, FXTRAN_GOTO, FXTRAN_IFTHEN, FXTRAN_IMPLICITNONE, FXTRAN_IMPLICIT, FXTRAN_IMPORT, FXTRAN_INCLUDE, FXTRAN_INQUIRE, FXTRAN_INTENT, FXTRAN_INTERFACE, FXTRAN_INTRINSIC, FXTRAN_PROCEDURE, FXTRAN_MODULE, FXTRAN_NAMELIST, FXTRAN_NULLIFY, FXTRAN_OPEN, FXTRAN_OPTIONAL, FXTRAN_PAUSE, FXTRAN_PARAMETER, FXTRAN_CRAYPOINTER, FXTRAN_POINTER, FXTRAN_PROGRAM, FXTRAN_PRINT, FXTRAN_PRIVATE, FXTRAN_PROTECTED, FXTRAN_PUBLIC, FXTRAN_READ, FXTRAN_RETURN, FXTRAN_REWIND, FXTRAN_SAVE, FXTRAN_SELECTCASE, FXTRAN_SELECTTYPE, FXTRAN_SEQUENCE, FXTRAN_STOP, FXTRAN_SUBROUTINE, FXTRAN_TARGET, FXTRAN_TYPE, FXTRAN_TYPEIS, FXTRAN_USE, FXTRAN_VALUE, FXTRAN_VOLATILE, FXTRAN_WAIT, FXTRAN_WHERE, FXTRAN_WHERECONSTRUCT, FXTRAN_WRITE,
 FXTRAN_LAST
} FXTRAN_stmt_type;



extern const char FXTRAN_stmt_exec[];
extern const int FXTRAN_stmt_std[];
extern const char FXTRAN_stmt_attr[];
extern const char * FXTRAN_stmt_name[];
# 155 "FXTRAN_STMT.h"
extern const char * FXTRAN_attr_name[];
# 165 "FXTRAN_STMT.h"
typedef struct FXTRAN_stmt_stack_state
{
  FXTRAN_stmt_type type;
  int seen_contains;
  int do_label;
  int nstmt;



} FXTRAN_stmt_stack_state;

typedef struct FXTRAN_stmt_stack
{
  int seen_stmt;
  int broken;
  int lev;
  FXTRAN_stmt_stack_state state[1024];
} FXTRAN_stmt_stack;

void FXTRAN_stmt_stack_init (FXTRAN_stmt_stack *);
FXTRAN_stmt_stack_state * FXTRAN_stmt_stack_curr (FXTRAN_stmt_stack *);
void FXTRAN_stmt_stack_incr (FXTRAN_stmt_stack *, FXTRAN_stmt_type);
void FXTRAN_stmt_stack_decr (FXTRAN_stmt_stack *);
void FXTRAN_stmt_stack_break (FXTRAN_stmt_stack *, FXTRAN_xmlctx *);
int FXTRAN_stmt_stack_ok (FXTRAN_stmt_stack *);
int FXTRAN_stmt_in (FXTRAN_stmt_stack *, FXTRAN_stmt_type);


void FXTRAN_stmt (const char *, const FXTRAN_char_info *, FXTRAN_stmt_stack *, FXTRAN_xmlctx * ctx, int, int);
int FXTRAN_typespec (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);





int FXTRAN_process_list (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *, const char *,
            const char *, int,
            int (*)(const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *, int, void *),
     void * data);

int FXTRAN_actual_args (const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *);

void FXTRAN_dump_fc_stmt (const char *, const FXTRAN_char_info *, int, int,
            FXTRAN_xmlctx *, FXTRAN_stmt_stack *, int);
# 12 "FXTRAN_STMT.c" 2
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

int FXTRAN_check_dpb (const char *, const FXTRAN_char_info *, const int);
# 13 "FXTRAN_STMT.c" 2


# 1 "FXTRAN_EXPR.h" 1
# 11 "FXTRAN_EXPR.h"
int FXTRAN_eat_integer_constant (const char *);

int FXTRAN_expr_string_with_int_kind (const char *, const FXTRAN_char_info *,
                                      FXTRAN_xmlctx *);

int FXTRAN_expr_string (const char *, const FXTRAN_char_info *,
                        FXTRAN_xmlctx *);

int FXTRAN_expr_numeric_litteral_constant (const char *, const FXTRAN_char_info *,
                                           FXTRAN_xmlctx *, int);

int FXTRAN_expr_logical_litteral_constant (const char *, const FXTRAN_char_info *,
                                           FXTRAN_xmlctx *);

void FXTRAN_expr (const char *, const FXTRAN_char_info *,
                   int, FXTRAN_xmlctx *);
# 16 "FXTRAN_STMT.c" 2
# 1 "FXTRAN_ERROR.h" 1
# 10 "FXTRAN_ERROR.h"
# 1 "FXTRAN_GDB.h" 1
# 9 "FXTRAN_GDB.h"
void FXTRAN_save_args (int, char * []);
void FXTRAN_save_where (const char *, int);
# 11 "FXTRAN_ERROR.h" 2
# 17 "FXTRAN_STMT.c" 2
# 1 "FXTRAN_OMP.h" 1
# 12 "FXTRAN_OMP.h"
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
# 18 "FXTRAN_STMT.c" 2
# 1 "FXTRAN_ALPHA.h" 1
# 19 "FXTRAN_STMT.c" 2

const char * FXTRAN_ops[] = { "+", "-", "**", "*", "//", "/=", "/",
                              "==", ">=", ">", "<=", "<", ((void *)0) };
const char * FXTRAN_types[] = { "LOGICAL", "REAL", "COMPLEX", "INTEGER", "CHARACTER",
                                "DOUBLEPRECISION", "DOUBLECOMPLEX", "TYPE", "CLASS",
                                "PROCEDURE", ((void *)0) };
static const int FXTRAN_types_with_kind[] = { 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 };
static const int FXTRAN_types_with_leng[] = { 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 };
static const int FXTRAN_types_with_name[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 };
static const int FXTRAN_types_with_parm[] = { 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0 };
static const int FXTRAN_types_intrinsic[] = { 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0 };




const char * FXTRAN_attr_name[] = {
  "BIND", "PASS", "NOPASS", "EXTENDS", "ABSTRACT", "NON_OVERRIDABLE", "KIND", "LEN", "DEFERRED",
  ((void *)0)
};





const char FXTRAN_stmt_exec[] = {
  0,
  1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1,
  0
};






const int FXTRAN_stmt_std[] = {
  0,
  (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (03 < 50 ? 2000+03 : 1900+03), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (95 < 50 ? 2000+95 : 1900+95), (90 < 50 ? 2000+90 : 1900+90), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (03 < 50 ? 2000+03 : 1900+03), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (95 < 50 ? 2000+95 : 1900+95), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (95 < 50 ? 2000+95 : 1900+95), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (95 < 50 ? 2000+95 : 1900+95), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (03 < 50 ? 2000+03 : 1900+03), (03 < 50 ? 2000+03 : 1900+03), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (03 < 50 ? 2000+03 : 1900+03), (03 < 50 ? 2000+03 : 1900+03), (95 < 50 ? 2000+95 : 1900+95), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (03 < 50 ? 2000+03 : 1900+03), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (90 < 50 ? 2000+90 : 1900+90), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (03 < 50 ? 2000+03 : 1900+03), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (03 < 50 ? 2000+03 : 1900+03), (90 < 50 ? 2000+90 : 1900+90), (77 < 50 ? 2000+77 : 1900+77), (77 < 50 ? 2000+77 : 1900+77), (90 < 50 ? 2000+90 : 1900+90), (90 < 50 ? 2000+90 : 1900+90), (03 < 50 ? 2000+03 : 1900+03), (90 < 50 ? 2000+90 : 1900+90), (03 < 50 ? 2000+03 : 1900+03), (03 < 50 ? 2000+03 : 1900+03), (03 < 50 ? 2000+03 : 1900+03), (95 < 50 ? 2000+95 : 1900+95), (95 < 50 ? 2000+95 : 1900+95), (77 < 50 ? 2000+77 : 1900+77),
  0
};






const char FXTRAN_stmt_attr[] = {
  0,
  0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0,
  -1
};






const char * FXTRAN_stmt_name[] = {
  ((void *)0),
  "ARITHMETICIF", "ASSIGNEDGOTO", "COMPONENTDECL", "POINTERASSIGNMENT", "ASSIGNMENT", "ASSOCIATE", "ASYNCHRONOUS", "IF", "FORALL", "ALLOCATABLE", "ALLOCATE", "ASSIGN", "BACKSPACE", "BIND", "BLOCKDATA", "CALL", "CASE", "CLASS", "CLASSIS", "CLOSE", "COMMON", "COMPUTEDGOTO", "CONTAINS", "CONTINUE", "CYCLE", "TYPEDECL", "DATA", "DEALLOCATE", "DIMENSION", "DO", "DOLABEL", "ENDASSOCIATE", "ENDBLOCKDATA", "ENDCLASS", "ENDDO", "ENDFORALL", "ENDFUNCTION", "ENDINTERFACE", "ENDMODULE", "ENDPROGRAM", "ENDSELECTCASE", "ENDSELECTTYPE", "ENDSUBROUTINE", "ENDTYPE", "ENDWHERE", "ENDFILE", "ELSEIF", "ELSE", "ELSEWHERE", "ENDIF", "ENTRY", "ENDENUM", "ENUM", "ENUMERATOR", "EQUIVALENCE", "EXIT", "EXTERNAL", "FINAL", "FLUSH", "FORALLCONSTRUCT", "FORMAT", "FUNCTION", "GENERIC", "GOTO", "IFTHEN", "IMPLICITNONE", "IMPLICIT", "IMPORT", "INCLUDE", "INQUIRE", "INTENT", "INTERFACE", "INTRINSIC", "PROCEDURE", "MODULE", "NAMELIST", "NULLIFY", "OPEN", "OPTIONAL", "PAUSE", "PARAMETER", "CRAYPOINTER", "POINTER", "PROGRAM", "PRINT", "PRIVATE", "PROTECTED", "PUBLIC", "READ", "RETURN", "REWIND", "SAVE", "SELECTCASE", "SELECTTYPE", "SEQUENCE", "STOP", "SUBROUTINE", "TARGET", "TYPE", "TYPEIS", "USE", "VALUE", "VOLATILE", "WAIT", "WHERE", "WHERECONSTRUCT", "WRITE",
  ((void *)0)
};
# 108 "FXTRAN_STMT.c"
typedef struct xml_tu
{
  int xml_ctu1;
  const char * xml_otu1[20];
  int xml_ctu2;
  const char * xml_otu2[20];
} xml_tu;

static const char * stmt_as_str (FXTRAN_stmt_type type)
{

  switch (type)
    {
      case FXTRAN_ARITHMETICIF : return "arithmetic" "-" "if" "-" "stmt";
      case FXTRAN_ASSIGNEDGOTO : return "assigned" "-" "goto" "-" "stmt";
      case FXTRAN_COMPONENTDECL : return "component" "-" "decl" "-" "stmt";
      case FXTRAN_POINTERASSIGNMENT : return "pointer" "-" "a" "-" "stmt";
      case FXTRAN_ASSIGNMENT : return "a" "-" "stmt";
      case FXTRAN_ASSOCIATE : return "associate" "-" "stmt";
      case FXTRAN_ASYNCHRONOUS : return "asynchronous" "-" "stmt";
      case FXTRAN_IF : return "if" "-" "stmt";
      case FXTRAN_FORALL : return "forall" "-" "stmt";
      case FXTRAN_ALLOCATABLE : return "allocatable" "-" "stmt";
      case FXTRAN_ALLOCATE : return "allocate" "-" "stmt";
      case FXTRAN_ASSIGN : return "assign" "-" "stmt";
      case FXTRAN_BACKSPACE : return "backspace" "-" "stmt";
      case FXTRAN_BIND : return "bind" "-" "stmt";
      case FXTRAN_BLOCKDATA : return "block" "-" "data" "-" "stmt";
      case FXTRAN_CALL : return "call" "-" "stmt";
      case FXTRAN_CASE : return "case" "-" "stmt";
      case FXTRAN_CLASS : return "class" "-" "stmt";
      case FXTRAN_CLASSIS : return "class" "-" "is" "-" "stmt";
      case FXTRAN_CLOSE : return "close" "-" "stmt";
      case FXTRAN_COMMON : return "common" "-" "stmt";
      case FXTRAN_COMPUTEDGOTO : return "computed" "-" "goto" "-" "stmt";
      case FXTRAN_CONTAINS : return "contains" "-" "stmt";
      case FXTRAN_CONTINUE : return "continue" "-" "stmt";
      case FXTRAN_CRAYPOINTER : return "cray" "-" "pointer" "-" "stmt";
      case FXTRAN_CYCLE : return "cycle" "-" "stmt";
      case FXTRAN_TYPEDECL : return "T" "-" "decl" "-" "stmt";
      case FXTRAN_DATA : return "data" "-" "stmt";
      case FXTRAN_DEALLOCATE : return "deallocate" "-" "stmt";
      case FXTRAN_DIMENSION : return "DIM" "-" "stmt";
      case FXTRAN_DO : return "do" "-" "stmt";
      case FXTRAN_DOLABEL : return "do" "-" "label" "-" "stmt";
      case FXTRAN_ENDASSOCIATE : return "end" "-" "associate" "-" "stmt";
      case FXTRAN_ENDBLOCKDATA : return "end" "-" "block" "-" "data" "-" "stmt";
      case FXTRAN_ENDCLASS : return "end" "-" "class" "-" "stmt";
      case FXTRAN_ENDDO : return "end" "-" "do" "-" "stmt";
      case FXTRAN_ENDFORALL : return "end" "-" "forall" "-" "stmt";
      case FXTRAN_ENDFUNCTION : return "end" "-" "function" "-" "stmt";
      case FXTRAN_ENDINTERFACE : return "end" "-" "interface" "-" "stmt";
      case FXTRAN_ENDMODULE : return "end" "-" "module" "-" "stmt";
      case FXTRAN_ENDPROGRAM : return "end" "-" "program" "-" "stmt";
      case FXTRAN_ENDSELECTCASE : return "end" "-" "select" "-" "case" "-" "stmt";
      case FXTRAN_ENDSELECTTYPE : return "end" "-" "select" "-" "T" "-" "stmt";
      case FXTRAN_ENDSUBROUTINE : return "end" "-" "subroutine" "-" "stmt";
      case FXTRAN_ENDTYPE : return "end" "-" "T" "-" "stmt";
      case FXTRAN_ENDWHERE : return "end" "-" "where" "-" "stmt";
      case FXTRAN_ENDFILE : return "end" "-" "file" "-" "stmt";
      case FXTRAN_ELSEIF : return "else" "-" "if" "-" "stmt";
      case FXTRAN_ELSE : return "else" "-" "stmt";
      case FXTRAN_ELSEWHERE : return "else" "-" "where" "-" "stmt";
      case FXTRAN_ENDIF : return "end" "-" "if" "-" "stmt";
      case FXTRAN_ENTRY : return "entry" "-" "stmt";
      case FXTRAN_ENDENUM : return "end" "-" "enum" "-" "stmt";
      case FXTRAN_ENUM : return "enum" "-" "stmt";
      case FXTRAN_ENUMERATOR : return "enumerator" "-" "stmt";
      case FXTRAN_EQUIVALENCE : return "equivalence" "-" "stmt";
      case FXTRAN_EXIT : return "exit" "-" "stmt";
      case FXTRAN_EXTERNAL : return "external" "-" "stmt";
      case FXTRAN_FINAL : return "final" "-" "stmt";
      case FXTRAN_FLUSH : return "flush" "-" "stmt";
      case FXTRAN_FORALLCONSTRUCT : return "forall" "-" "construct" "-" "stmt";
      case FXTRAN_FORMAT : return "format" "-" "stmt";
      case FXTRAN_FUNCTION : return "function" "-" "stmt";
      case FXTRAN_GENERIC : return "generic" "-" "stmt";
      case FXTRAN_GOTO : return "goto" "-" "stmt";
      case FXTRAN_IFTHEN : return "if" "-" "then" "-" "stmt";
      case FXTRAN_IMPLICITNONE : return "implicit" "-" "none" "-" "stmt";
      case FXTRAN_IMPLICIT : return "implicit" "-" "stmt";
      case FXTRAN_IMPORT : return "import" "-" "stmt";
      case FXTRAN_INCLUDE : return "include" "-" "stmt";
      case FXTRAN_INQUIRE : return "inquire" "-" "stmt";
      case FXTRAN_INTENT : return "intent" "-" "stmt";
      case FXTRAN_INTERFACE : return "interface" "-" "stmt";
      case FXTRAN_INTRINSIC : return "intrinsic" "-" "stmt";
      case FXTRAN_PROCEDURE : return "procedure" "-" "stmt";
      case FXTRAN_MODULE : return "module" "-" "stmt";
      case FXTRAN_NAMELIST : return "namelist" "-" "stmt";
      case FXTRAN_NULLIFY : return "nullify" "-" "stmt";
      case FXTRAN_OPEN : return "open" "-" "stmt";
      case FXTRAN_OPTIONAL : return "optional" "-" "stmt";
      case FXTRAN_PAUSE : return "pause" "-" "stmt";
      case FXTRAN_PARAMETER : return "parameter" "-" "stmt";
      case FXTRAN_POINTER : return "pointer" "-" "stmt";
      case FXTRAN_PROGRAM : return "program" "-" "stmt";
      case FXTRAN_PRINT : return "print" "-" "stmt";
      case FXTRAN_PRIVATE : return "private" "-" "stmt";
      case FXTRAN_PROTECTED : return "protected" "-" "stmt";
      case FXTRAN_PUBLIC : return "public" "-" "stmt";
      case FXTRAN_READ : return "read" "-" "stmt";
      case FXTRAN_RETURN : return "return" "-" "stmt";
      case FXTRAN_REWIND : return "rewind" "-" "stmt";
      case FXTRAN_SAVE : return "save" "-" "stmt";
      case FXTRAN_SELECTCASE : return "select" "-" "case" "-" "stmt";
      case FXTRAN_SELECTTYPE : return "select" "-" "T" "-" "stmt";
      case FXTRAN_SEQUENCE : return "sequence" "-" "stmt";
      case FXTRAN_STOP : return "stop" "-" "stmt";
      case FXTRAN_SUBROUTINE : return "subroutine" "-" "stmt";
      case FXTRAN_TARGET : return "target" "-" "stmt";
      case FXTRAN_TYPE : return "T" "-" "stmt";
      case FXTRAN_TYPEIS : return "T" "-" "is" "-" "stmt";
      case FXTRAN_USE : return "use" "-" "stmt";
      case FXTRAN_VALUE : return "value" "-" "stmt";
      case FXTRAN_VOLATILE : return "volatile" "-" "stmt";
      case FXTRAN_WAIT : return "wait" "-" "stmt";
      case FXTRAN_WHERE : return "where" "-" "stmt";
      case FXTRAN_WHERECONSTRUCT : return "where" "-" "construct" "-" "stmt";
      case FXTRAN_WRITE : return "write" "-" "stmt";
      case FXTRAN_NONE:
      case FXTRAN_LAST:
      break;
   }
  return ((void *)0);
}
# 253 "FXTRAN_STMT.c"
static int stmt_unit_name (const char * t, const FXTRAN_char_info * ci,
             const char * T, const char * N, FXTRAN_xmlctx * ctx)
{
  int k1 = strlen (T);
  int k2;

  if (k1 > strlen (t))
    return 0;

  k2 = FXTRAN_eat_word (&t[k1]);

  do { int _n = (k1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (N, ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k2)-1].offset+1, ctx, t, k2); } while (0);
  do { int _n = (k2); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return k1+k2;
}



static int stmt_eos_named_label (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int k = FXTRAN_eat_word (t);

  if (k == 0)
    return 0;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);

  return k+1;
}

static int stmt_bos_named_label (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  int k = FXTRAN_eat_word (t);

  if (k == 0)
    return 0;

  if (t[k] == ':')
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
      return k+1;
    }

  return 0;
}

static int stmt_endunit_name (const char * t, const FXTRAN_char_info * ci,
                              const char * s, const char * N, FXTRAN_xmlctx * ctx)
{
  int k;
  const char * T = t;

  if ((!strncmp (s,t,strlen(s))))
    {
      int len = strlen (s);
      do { int _n = (len); ci += _n; t += _n; } while (0);
    }
  else
    {
      return 0;
    }

  k = strlen (t);
  if (k == 0)
    return 0;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (N, ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return t - T;
}


static int stmt_unit_dummy_args (const char * t, const FXTRAN_char_info * ci,
                   FXTRAN_xmlctx * ctx, FXTRAN_stmt_stack * stack)
{
  int
    k1 = FXTRAN_str_at_level (t, ci, "(", 0),
    k2 = FXTRAN_str_at_level (t, ci, ")", 0);


  if (k2-k1-1 > 0)
    {
      do { int _n = (k1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("dummy" "-" "arg" "-" "LT", ci->offset, ctx); } while (0);

      while (t[0])
        {
          int k;

          if (t[0] == '*')
            {
              FXTRAN_xml_word_tag ("alt" "-" "return" "-" "spec", ci->offset, ci->offset+1, ctx);
       do { int _n = (1); ci += _n; t += _n; } while (0);
            }
   else
            {
       k = FXTRAN_eat_word (t);
       do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("arg" "-" "N", ci->offset, ctx); } while (0);
       do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
       do { int _n = (k); ci += _n; t += _n; } while (0);
       do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
     }

   if (t[0] != ',')
            break;

          do { int _n = (1); ci += _n; t += _n; } while (0);

        }

      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
  else if (k1 > 0)
    {
      do { int _n = (k1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("dummy" "-" "arg" "-" "LT", ci->offset, ctx); } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

  return k2;
}


typedef struct stmt_actual_args_parms
{
  const char * argl;
  const char * argn;
}
stmt_actual_args_parms;





static stmt_actual_args_parms saap_actual = { "arg" "-" "spec", "arg" };
static stmt_actual_args_parms saap_filepos = { "pos" "-" "spec" "-" "spec", "pos" "-" "spec" };
static stmt_actual_args_parms saap_close = { "close" "-" "spec" "-" "spec", "close" "-" "spec" };
static stmt_actual_args_parms saap_open = { "connect" "-" "spec" "-" "spec", "connect" "-" "spec" };
static stmt_actual_args_parms saap_flush = { "flush" "-" "spec" "-" "spec", "flush" "-" "spec" };
static stmt_actual_args_parms saap_inquiry = { "inquiry" "-" "spec" "-" "spec", "inquiry" "-" "spec" };
static stmt_actual_args_parms saap_io = { "io" "-" "control" "-" "spec", "io" "-" "control" };
static stmt_actual_args_parms saap_wait = { "wait" "-" "spec" "-" "spec", "wait" "-" "spec" };
static stmt_actual_args_parms saap_kindsel = { "K" "-" "spec" "-" "spec", "K" "-" "spec" };
static stmt_actual_args_parms saap_charsel = { "char" "-" "spec" "-" "spec", "char" "-" "spec" };
static stmt_actual_args_parms saap_typeparm = { "T" "-" "parameter" "-" "spec" "-" "spec", "T" "-" "parameter" "-" "spec" };



static int stmt_actual_args (const char * t, const FXTRAN_char_info * ci,
               FXTRAN_xmlctx * ctx, const stmt_actual_args_parms * saap)
{
  const char * T = t;

  if (t[0] != '(')
    return 0;

  do { int _n = (1); ci += _n; t += _n; } while (0);

  if (t[0] == ')')
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (saap->argl, ci->offset, ctx); } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      return 2;
    }


  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (saap->argl, ci->offset, ctx); } while (0);

  while (t[0])
    {
      int kn = FXTRAN_eat_word (t);
      int kc;
      int kp = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);

      kc = FXTRAN_str_at_level_ir (t, ci, ",", ci->parens, kp);

      if (!kc)
        kc = kp;

      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (saap->argn, ci->offset, ctx); } while (0);

      if (kn && (t[kn] == '=') && (t[kn+1] != '='))
        {
          do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_keyword ("arg" "-" "N", ci->offset, ci[(kn)-1].offset+1, ctx, t, kn); } while (0);
          do { int _n = (kn+1); ci += _n; t += _n; } while (0);
          kc = kc - (kn+1);
        }

      FXTRAN_expr (t, ci, kc-1, ctx);
      do { int _n = (kc-1); ci += _n; t += _n; } while (0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);


      if (t[0] == ')')
        break;

      do { int _n = (1); ci += _n; t += _n; } while (0);

    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return t - T + 1;
}

int FXTRAN_actual_args (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return stmt_actual_args (t, ci, ctx, &saap_actual);
}

int FXTRAN_process_list (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, const char * sep,
           const char * lstn, int kmax,
           int (*process_list_elt)(const char *, const FXTRAN_char_info *, FXTRAN_xmlctx *, int, void *),
    void * data)
{
  int lev = ci->parens;
  const char * T = t;
  int i;
  int k;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (lstn, ci->offset, ctx); } while (0);

  while (t[0] && (t - T < kmax))
    {
      k = FXTRAN_str_at_level (t, ci, sep, lev);
      if (k == 0)
        k = strlen (t);
      else
 k = k - 1;
      for (i = 0; i < k; i++)
        if ((ci[i].parens < lev) || (&t[i] - T >= kmax))
          {
            k = i;
     break;
   }
      if (k == 0)
        goto done;
      if (process_list_elt (t, ci, ctx, k, data) < 0)
        {
          if ((t - T > 0) && (t[-1] == ','))
            do { int _n = (-1); ci += _n; t += _n; } while (0);
   goto done;
        }
      do { int _n = (k); ci += _n; t += _n; } while (0);
      if (t[0] == ',')
        do { int _n = (1); ci += _n; t += _n; } while (0);
    }
done:

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return t - T;
}

static int shape_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  const char * T = t;
  int k;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("shape" "-" "spec", ci->offset, ctx); } while (0);

  k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax);

  if (k)
    {
      if (k > 1)
        {
          do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("lower" "-" "bound", ci->offset, ctx); } while (0);
          FXTRAN_expr (t, ci, k-1, ctx);
          do { int _n = (k-1); ci += _n; t += _n; } while (0);
          do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
        }
      do { int _n = (1); ci += _n; t += _n; } while (0);

      kmax = kmax - (t - T);
    }

  if (kmax)
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("upper" "-" "bound", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, kmax, ctx);
      do { int _n = (kmax); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}


static int array_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx *ctx)
{
  const char * T = t;
  int lev = ci[0].parens;
  int k;

  if (t[0] == '(')
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("array" "-" "spec", ci->offset, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
      if ((k = FXTRAN_str_at_level (t, ci, ")", lev)))
        {

          FXTRAN_process_list (t, ci, ctx, ",", "shape" "-" "spec" "-" "LT", k,
           shape_spec, ((void *)0));
   do { int _n = (k-1); ci += _n; t += _n; } while (0);
          do { int _n = (1); ci += _n; t += _n; } while (0);
          do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
        }

    }

  return t - T;
}

static int stmt_old_cl (const char * t , const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  if (t[0] == '*')
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("char" "-" "selector", ci->offset, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
      if (t[0] == '(')
        {
          int k = FXTRAN_str_at_level (t, ci, ")", ci->parens);

          do { int _n = (1); ci += _n; t += _n; } while (0);
   k = k - 1;
   FXTRAN_expr (t, ci, k-1, ctx);
   do { int _n = (k); ci += _n; t += _n; } while (0);
 }
      else if (((*__ctype_b_loc ())[(int) ((t[0]))] & (unsigned short int) _ISdigit))
        {
          int k;
   do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("literal" "-" "E", ci->offset, ctx); } while (0);

          for (k = 0; ((*__ctype_b_loc ())[(int) ((t[k]))] & (unsigned short int) _ISdigit); k++);

          do { if (FXTRAN_XML_dump) FXTRAN_xml_mark (ci->offset,ci[k-1].offset+1,ctx,FXTRAN_LIT); } while (0);
          do { int _n = (k); ci += _n; t += _n; } while (0);

          do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
        }

      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
  else
    {
      return 0;
    }
  return t - T;
}

static int FXTRAN_stmt_init_expr (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int lev = ci[0].parens;
  int k;

  if ((t[0] == '=') && (t[1] == '>'))
    do { int _n = (2); ci += _n; t += _n; } while (0);
  else if (t[0] == '=')
    do { int _n = (1); ci += _n; t += _n; } while (0);
  else
    return 0;

  if ((k = FXTRAN_str_at_level (t, ci, ",", lev)) == 0)
    k = lev == 0 ? strlen (t) : FXTRAN_str_at_level (t, ci, ")", lev-1)-1;
  else
    k = k - 1;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("init" "-" "E", ci->offset, ctx); } while (0);

  FXTRAN_expr (t, ci, k, ctx);

  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return t - T;
}

typedef struct stmt_entity_decl_parms
{
  const char * lst;
  const char * lste;
  const char * lsten;
}
stmt_entity_decl_parms;


static stmt_entity_decl_parms seda_entity =
{
  "EN" "-" "decl" "-" "LT",
  "EN" "-" "decl",
  "EN" "-" "N"
};

static stmt_entity_decl_parms seda_common =
{
  "common" "-" "block" "-" "obj" "-" "LT",
  "common" "-" "block" "-" "obj",
  "common" "-" "block" "-" "obj" "-" "N"
};

static stmt_entity_decl_parms seda_namelist =
{
  "namelist" "-" "group" "-" "obj" "-" "LT",
  "namelist" "-" "group" "-" "obj",
  "namelist" "-" "group" "-" "obj" "-" "N"
};

static stmt_entity_decl_parms seda_enumerator =
{
  "enumerator" "-" "LT",
  "enumerator",
  "named" "-" "constant"
};

static int stmt_entity (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx,
          const stmt_entity_decl_parms * seda, FXTRAN_stmt_stack * stack)
{
  int k;
  int lev;
  const char * T;

  T = t;

  if (t[0] == 0)
    return 0;

  lev = ci[0].parens;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (seda->lste, ci->offset, ctx); } while (0);

  k = FXTRAN_eat_word (t);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (seda->lsten, ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] == '\0')
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      return t - T;
    }


  k = array_spec (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  k = stmt_old_cl (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  k = FXTRAN_stmt_init_expr (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);


  if ((k = FXTRAN_str_at_level (t, ci, ",", lev)))
    {
      FXTRAN_expr (t, ci, k-1, ctx);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
    }
  else if (t[0])
    {
      k = lev == 0 ? strlen (t) : FXTRAN_str_at_level (t, ci, ")", lev-1)-1;
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return t - T;
}

static void stmt_entity_list (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx,
         const stmt_entity_decl_parms * seda, FXTRAN_stmt_stack * stack)
{
  int k;

  if (t[0] == 0)
    return;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (seda->lst, ci->offset, ctx); } while (0);
  while (t[0] && (k = stmt_entity (t, ci, ctx, seda, stack)))
    {
      do { int _n = (k); ci += _n; t += _n; } while (0);
      if (t[0] == ',')
        do { int _n = (1); ci += _n; t += _n; } while (0);
      else
        break;
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return;
}


static int FXTRAN_generic_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  if ((!strncmp ("OPERATOR(",t,strlen("OPERATOR("))))
    {
      do { int _n = (9); ci += _n; t += _n; } while (0);
      k = FXTRAN_str_at_level (t, ci, ")", 0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_op ("op", ci->offset, ci[(k-1)-1].offset+1, ctx, t, k-1); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
    }
  else if ((!strncmp ("READ(",t,strlen("READ("))) || (!strncmp ("WRITE(",t,strlen("WRITE("))))
    {
      k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("dtio" "-" "spec" "-" "N", ci->offset, ctx); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_str_at_level (t, ci, ")", 0);


      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("dtio" "-" "spec" "-" "format", ci->offset, ctx); } while (0);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
    }
  else if ((!strncmp ("ASSIGNMENT(=)",t,strlen("ASSIGNMENT(=)"))))
    {
      do { int _n = (11); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("a", ci->offset, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
    }
  else if ((k = FXTRAN_eat_word (t)))
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
    }

  return t - T;
}

static int clkd_of_type (const char * t, const FXTRAN_char_info * ci,
                         FXTRAN_xmlctx * ctx, const char * spn,
                         stmt_actual_args_parms * saap)
{
  const char * T = t;
  int i;
  int k = 0;

  if ((t[0] == '*') && (((*__ctype_b_loc ())[(int) ((t[1]))] & (unsigned short int) _ISdigit)))
    {
      for (i = 1; t[i]; i++)
        if (!((*__ctype_b_loc ())[(int) ((t[i]))] & (unsigned short int) _ISdigit))
          {
     do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (spn, ci->offset, ctx); } while (0);
     do { int _n = (1); ci += _n; t += _n; } while (0);
            k = i-1;

            do { if (FXTRAN_XML_dump) FXTRAN_xml_mark (ci->offset,ci[k-1].offset+1,ctx,FXTRAN_LIT); } while (0);
     do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("literal" "-" "E", ci->offset, ctx); } while (0);
            do { int _n = (k); ci += _n; t += _n; } while (0);
     do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

            do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
            goto end;
          }
    }

  if ((t[0] == '(') || (!strncmp ("*(",t,strlen("*("))))
    {
      int k;

      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (spn, ci->offset, ctx); } while (0);
      if (t[0] == '*')
        do { int _n = (1); ci += _n; t += _n; } while (0);
      k = stmt_actual_args (t, ci, ctx, saap);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      goto end;
    }

end:
  return t - T;
}

static int leng_of_type (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return clkd_of_type (t, ci, ctx, "char" "-" "selector", &saap_charsel);
}

static int kind_of_type (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return clkd_of_type (t, ci, ctx, "K" "-" "selector", &saap_kindsel);
}

static int parm_of_type (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int k;

  if (t[0] != '(')
    return 0;

  do { int _n = (1); ci += _n; t += _n; } while (0);
  if ((t[0] == '*') && (t[1] == ')'))
    {
      k = 1;
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("T" "-" "N", ci->offset, ctx); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
  else
    {
      k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("T" "-" "N", ci->offset, ctx); } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

  if (t[0] == '(')
    {
      k = stmt_actual_args (t, ci, ctx, &saap_typeparm);
      do { int _n = (k); ci += _n; t += _n; } while (0);
    }

  if (t[0] != ')')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 892); fprintf (stderr, "Expected closing `)'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 892); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);

  return t - T;
}

static int name_of_type (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return parm_of_type (t, ci, ctx);
}

static int typespec_ext (const char * t, const FXTRAN_char_info * ci,
                         FXTRAN_xmlctx * ctx, const int ktype)
{
  if (FXTRAN_types_with_kind[ktype])
    return kind_of_type (t, ci, ctx);
  else if (FXTRAN_types_with_leng[ktype])
    return leng_of_type (t, ci, ctx);
  else if (FXTRAN_types_with_name[ktype])
    return name_of_type (t, ci, ctx);
  else if (FXTRAN_types_with_parm[ktype])
    return parm_of_type (t, ci, ctx);
  return 0;
}


int FXTRAN_typespec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  int i;
  int k;


  for (i = 0; FXTRAN_types[i]; i++)
    {
      int len = strlen (FXTRAN_types[i]);
      if (strncmp (FXTRAN_types[i], t, len) == 0)
        {
          if (FXTRAN_types_intrinsic[i])
            {
              do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("intrinsic" "-" "T" "-" "spec", ci->offset, ctx); } while (0);
              do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("T" "-" "N", ci->offset, ctx); } while (0);
       do { int _n = (len); ci += _n; t += _n; } while (0);
       do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
     }
   else
            {
              do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("derived" "-" "T" "-" "spec", ci->offset, ctx); } while (0);
       do { int _n = (len); ci += _n; t += _n; } while (0);
     }


          k = typespec_ext (t, ci, ctx, i);

   do { int _n = (k); ci += _n; t += _n; } while (0);

   do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
   break;
        }
    }

  return t - T;
}

static int bind_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  const char * T = t;
  if ((!strncmp ("C)",t,strlen("C)"))))
    {
      do { int _n = (2); ci += _n; t += _n; } while (0);
    }
  else if ((!strncmp ("C,NAME=",t,strlen("C,NAME="))))
    {
      int k;
      do { int _n = (7); ci += _n; t += _n; } while (0);
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
  else if ((!strncmp ("C,",t,strlen("C,"))))
    {
      int k;
      do { int _n = (2); ci += _n; t += _n; } while (0);
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
  return t - T;
}

static int FXTRAN_attr0 (const char * t, const FXTRAN_char_info * ci,
                          FXTRAN_xmlctx * ctx, const char * attr)
{
  const char * T = t;
  int k;
  int an = attr == ((void *)0);

  if (an)
    {
      int i;
      k = -1;

      if (!((*__ctype_b_loc ())[(int) ((t[0]))] & (unsigned short int) _ISalpha))
        return 0;


      for (i = 0; FXTRAN_stmt_attr[i] >= 0; i++)
        if (FXTRAN_stmt_attr[i])
          if ((!strncmp (FXTRAN_stmt_name[i],t,strlen(FXTRAN_stmt_name[i]))))
            k = strlen (FXTRAN_stmt_name[i]);

      if (k < 0)
        for (i = 0; FXTRAN_attr_name[i]; i++)
          if ((!strncmp (FXTRAN_attr_name[i],t,strlen(FXTRAN_attr_name[i]))))
            k = strlen (FXTRAN_attr_name[i]);

      if (k < 0)
        return 0;
    }
  else
    {
      k = strlen (attr);
    }

  if (an)
    do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute", ci->offset, ctx); } while (0);


  if (t[k] != '(')
    {
      if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute" "-" "N", ci->offset, ctx); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
  else
    {
      if ((k = FXTRAN_str_at_level (t, ci, ")", 0)))
        {

          if ((!strncmp ("DIMENSION",T,strlen("DIMENSION"))))
            {
              if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute" "-" "N", ci->offset, ctx); } while (0);
              do { int _n = (9); ci += _n; t += _n; } while (0);
              if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
              k = array_spec (t, ci, ctx);
              do { int _n = (k); ci += _n; t += _n; } while (0);
            }
          else if ((!strncmp ("BIND",T,strlen("BIND"))))
            {
              if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute" "-" "N", ci->offset, ctx); } while (0);
       do { int _n = (4); ci += _n; t += _n; } while (0);
       if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
       do { int _n = (1); ci += _n; t += _n; } while (0);
              k = bind_spec (t, ci, ctx);
              do { int _n = (k-5); ci += _n; t += _n; } while (0);
            }
          else if ((!strncmp ("EXTENDS",T,strlen("EXTENDS"))))
            {
              if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute" "-" "N", ci->offset, ctx); } while (0);
              do { int _n = (7); ci += _n; t += _n; } while (0);
              if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
              do { int _n = (1); ci += _n; t += _n; } while (0);
       do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k-9)-1].offset+1, ctx, t, k-9); } while (0);
              do { int _n = (k-8); ci += _n; t += _n; } while (0);
            }
          else if ((!strncmp ("PASS",T,strlen("PASS"))))
            {
              if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute" "-" "N", ci->offset, ctx); } while (0);
              do { int _n = (4); ci += _n; t += _n; } while (0);
       if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
       do { int _n = (1); ci += _n; t += _n; } while (0);
       do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k-5)-1].offset+1, ctx, t, k-5); } while (0);
              do { int _n = (k-5); ci += _n; t += _n; } while (0);
            }
   else if ((!strncmp ("INTENT",T,strlen("INTENT"))))
            {
              if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute" "-" "N", ci->offset, ctx); } while (0);
              do { int _n = (6); ci += _n; t += _n; } while (0);
       if (an) do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
       do { int _n = (1); ci += _n; t += _n; } while (0);
              k = FXTRAN_eat_word (t);
       do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("intent" "-" "spec", ci->offset, ctx); } while (0);
       do { int _n = (k); ci += _n; t += _n; } while (0);
       do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
       do { int _n = (1); ci += _n; t += _n; } while (0);
            }

        }
    }


  if (attr == ((void *)0))
    do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return t - T;
}

static int FXTRAN_attr (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  return FXTRAN_attr0 (t, ci, ctx, ((void *)0));
}

static void FXTRAN_stmt_attr_extra (const char * t, const FXTRAN_char_info * ci,
                      FXTRAN_xmlctx * ctx, const char * attr, FXTRAN_stmt_stack * stack)
{
  int k = FXTRAN_attr0 (t, ci, ctx, attr);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1105); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1105); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  stmt_entity_list (t, ci, ctx, &seda_entity, stack);
}







static void stmt_ASYNCHRONOUS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "ASYNCHRONOUS", stack); };
static void stmt_ALLOCATABLE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "ALLOCATABLE", stack); };
static void stmt_FINAL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "FINAL", stack); };
static void stmt_TARGET_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "TARGET", stack); };
static void stmt_POINTER_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "POINTER", stack); };
static void stmt_EXTERNAL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "EXTERNAL", stack); };
static void stmt_INTRINSIC_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "INTRINSIC", stack); };
static void stmt_OPTIONAL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "OPTIONAL", stack); };
static void stmt_PROTECTED_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "PROTECTED", stack); };

static void stmt_VOLATILE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "VOLATILE", stack); };
static void stmt_VALUE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return FXTRAN_stmt_attr_extra (t, ci, ctx, "VALUE", stack); };



static void stmt_CRAYPOINTER_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  int kp, kc;

  do { int _n = (7); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("cray" "-" "pointer" "-" "LT", ci->offset, ctx); } while (0);

  while (1)
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("cray" "-" "pointer" "-" "association", ci->offset, ctx); } while (0);
      if (t[0] != '(')
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1144); fprintf (stderr, "Expected `('"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1144); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("cray" "-" "pointer", ci->offset, ctx); } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);

      if (t[0] != ',')
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1153); fprintf (stderr, "Expected `,'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1153); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("cray" "-" FXTRAN_STRING_POINTEE, ci->offset, ctx); } while (0);
      kp = FXTRAN_str_at_level (t, ci, ")", ci->parens-1);
      kc = FXTRAN_str_at_level_ir (t, ci, ",", ci->parens, kp);
      FXTRAN_expr (t, ci, kc-1, ctx);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (kc-1); ci += _n; t += _n; } while (0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

      if (t[0] != ')')
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1167); fprintf (stderr, "Expected `)'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1167); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);

      switch (t[0])
        {
          case ',':
            do { int _n = (1); ci += _n; t += _n; } while (0);
            break;
          case '\0':
            goto end;
          default:
            break;
        }
    }
end:

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

}

static int pupr_entity (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  int k;
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("EN", ci->offset, ctx); } while (0);
  k = FXTRAN_generic_spec (t, ci, ctx);
  if (k != kmax)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1193); fprintf (stderr, "Malformed generic spec"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1193); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}

static void stmt_pupr_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx)
{
  if (t[0] == '\0')
    return;

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1204); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1204); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  FXTRAN_process_list (t, ci, ctx, ",", "EN" "-" "LT", strlen (t),
          pupr_entity, ((void *)0));

}

static void stmt_PUBLIC_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (6); ci += _n; t += _n; } while (0);
  return stmt_pupr_extra (t, ci, ctx);
}

static void stmt_PRIVATE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (7); ci += _n; t += _n; } while (0);
  return stmt_pupr_extra (t, ci, ctx);
}


static int saved_entity (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  int seen_slash = 0;
  int k;
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("saved" "-" "EN", ci->offset, ctx); } while (0);
  if (t[0] == '/')
    {
      seen_slash = 1;
      do { int _n = (1); ci += _n; t += _n; } while (0);
    }
  k = FXTRAN_eat_word (t);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("EN" "-" "N", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (seen_slash)
    {
      if (t[0] == '/')
        do { int _n = (1); ci += _n; t += _n; } while (0);
      else
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1246); fprintf (stderr, "Expected closing '/'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1246); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return 1;
}


static void stmt_SAVE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (4); ci += _n; t += _n; } while (0);

  if (t[0] == '\0')
    return;

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1262); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1262); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  FXTRAN_process_list (t, ci, ctx, ",", "saved" "-" "EN" "-" "LT", strlen (t),
          saved_entity, ((void *)0));
}

static void stmt_DIMENSION_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k = FXTRAN_attr0 (t, ci, ctx, "DIMENSION");

  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1274); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1274); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  stmt_entity_list (t, ci, ctx, &seda_entity, stack);
}

static void stmt_INTENT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k = FXTRAN_attr0 (t, ci, ctx, "INTENT");

  do { int _n = (k); ci += _n; t += _n; } while (0);

  k = FXTRAN_str_at_level (t, ci, ")", 0);

  if (k)
    do { int _n = (k); ci += _n; t += _n; } while (0);

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1290); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1290); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  stmt_entity_list (t, ci, ctx, &seda_entity, stack);
}

static void stmt_BIND_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{

  int k = FXTRAN_attr0 (t, ci, ctx, "BIND");
  const char * T = ((void *)0);
  const FXTRAN_char_info * CI = ((void *)0);
  int K;

  do { int _n = (k); ci += _n; t += _n; } while (0);

  T = t+1;
  CI = ci+1;


  K = k = FXTRAN_str_at_level (t, ci, ")", 0);
  if (k)
    do { int _n = (k); ci += _n; t += _n; } while (0);

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1313); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1313); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  if (T)
    FXTRAN_expr (T, CI, K, ctx);

  stmt_entity_list (t, ci, ctx, &seda_entity, stack);

}

static void stmt_INTERFACE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  if ((!strncmp ("ABSTRACT",t,strlen("ABSTRACT"))))
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute", ci->offset, ctx); } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("attribute" "-" "N", ci->offset, ctx); } while (0);
      do { int _n = (8); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

  do { int _n = (9); ci += _n; t += _n; } while (0);

  if (t[0])
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
      k = FXTRAN_generic_spec (t, ci, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
}

static void stmt_ENDINTERFACE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;

  do { int _n = (12); ci += _n; t += _n; } while (0);

  if (t[0])
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
      k = FXTRAN_generic_spec (t, ci, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
}

static void stmt_clty_extra (const char * t, const FXTRAN_char_info * ci,
                             FXTRAN_xmlctx * ctx, const char * T, const char * N)
{
  do { int _n = (strlen (T)); ci += _n; t += _n; } while (0);

  while (t[0] == ',')
    {
      int k;
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_attr (t, ci, ctx);
      if (k == 0)
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1371); fprintf (stderr, "Cannot parse type attribute"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1371); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
    }

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1375); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1375); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  stmt_unit_name (t, ci, "", N, ctx);
}

static void stmt_TYPE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  return stmt_clty_extra (t, ci, ctx, "TYPE", "T" "-" "N");
}

static void stmt_CLASS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  return stmt_clty_extra (t, ci, ctx, "CLASS", "class" "-" "N");
}

static void stmt_ENDTYPE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (7); ci += _n; t += _n; } while (0);
  if (t[0])
    stmt_unit_name (t, ci, "", "T" "-" "N", ctx);
}

static void stmt_ENDCLASS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (8); ci += _n; t += _n; } while (0);
  if (t[0])
    stmt_unit_name (t, ci, "", "class" "-" "N", ctx);
}

static void stmt_DEALLOCATE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (10); ci += _n; t += _n; } while (0);
  stmt_actual_args (t, ci, ctx, &saap_actual);
}

static void stmt_ALLOCATE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (8); ci += _n; t += _n; } while (0);
  stmt_actual_args (t, ci, ctx, &saap_actual);
}

static void stmt_NULLIFY_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (7); ci += _n; t += _n; } while (0);
  stmt_actual_args (t, ci, ctx, &saap_actual);
}

static void stmt_CALL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  int kargs = -1;

  do { int _n = (4); ci += _n; t += _n; } while (0);
  k = strlen (t);
  if (t[k-1] == ')')
    {
      for (kargs = k-1; kargs >= 0; kargs--)
        if ((t[kargs] == '(') && (ci[kargs].parens == 0))
          break;
    }

  if (kargs >= 0)
    k = kargs;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("procedure" "-" "designator", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (kargs >= 0)
    stmt_actual_args (t, ci, ctx, &saap_actual);
}


static void suffix (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx,
      int func, FXTRAN_stmt_stack * stack)
{

  while (t[0])
    {
      if ((!strncmp ("BIND(C)",t,strlen("BIND(C)"))))
        {
          FXTRAN_xml_word_tag ("bind" "-" "spec", ci->offset, ci->offset+7, ctx);
          do { int _n = (7); ci += _n; t += _n; } while (0);
        }
      else if ((!strncmp ("BIND(C,NAME=",t,strlen("BIND(C,NAME="))))
        {
          int k;
          do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("bind" "-" "spec", ci->offset, ctx); } while (0);
   do { int _n = (12); ci += _n; t += _n; } while (0);
          k = FXTRAN_str_at_level (t, ci, ")", 0);
          FXTRAN_expr (t, ci, k-1, ctx);
          do { int _n = (k); ci += _n; t += _n; } while (0);
          do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
        }
     else if (func && (!strncmp ("RESULT(",t,strlen("RESULT("))))
       {
          int k;
          do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("result" "-" "spec", ci->offset, ctx); } while (0);
   do { int _n = (7); ci += _n; t += _n; } while (0);
          if ((k = FXTRAN_str_at_level (t, ci, ")", 0)))
            {
       do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k-1)-1].offset+1, ctx, t, k-1); } while (0);
       do { int _n = (k); ci += _n; t += _n; } while (0);
     }
   else
            {
              do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1482); fprintf (stderr, "Missing closing `)'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1482); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
            }
          do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
       }
     else
       {
         do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1488); fprintf (stderr, "Unexpected suffix : `%s'\n", t); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1488); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
       }
    }
}

static void stmt_FUNCTION_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k2;
  int k3;
  const char * prefix[] = { "RECURSIVE", "PURE", "ELEMENTAL", ((void *)0) };
  int seen_ts = 0;
# 1509 "FXTRAN_STMT.c"
  while (1)
    {
      int k;
      int i;
      int ad = 0;
      for (i = 0; prefix[i]; i++)
        if ((!strncmp (prefix[i],t,strlen(prefix[i]))))
          {
            int len = strlen (prefix[i]);
     FXTRAN_xml_word_tag ("prefix", ci->offset, ci[len-1].offset+1, ctx);
     do { int _n = (len); ci += _n; t += _n; } while (0);
     ad++;
     prefix[i] = "!";
          }
      if (!seen_ts && (k = FXTRAN_typespec (t, ci, ctx)))
        {
          seen_ts = 1;
   do { int _n = (k); ci += _n; t += _n; } while (0);
   ad++;
   do { if (t[0] == ',') { do { int _n = (1); ci += _n; t += _n; } while (0); } } while (0);
        }

      if ((!strncmp ("FUNCTION",t,strlen("FUNCTION"))))
        break;

      if (ad == 0)
        {
          if ((k = FXTRAN_attr0 (t, ci, ctx, ((void *)0))))
            {
              do { int _n = (k); ci += _n; t += _n; } while (0);
       do { if (t[0] == ',') { do { int _n = (1); ci += _n; t += _n; } while (0); } } while (0);
            }
   else
            break;
 }
    }



  k2 = stmt_unit_name (t, ci, "FUNCTION", "function" "-" "N", ctx);
  do { int _n = (k2); ci += _n; t += _n; } while (0);
  k3 = stmt_unit_dummy_args (t, ci, ctx, stack);
  do { int _n = (k3); ci += _n; t += _n; } while (0);

  suffix (t, ci, ctx, 1, stack);
}


static void stmt_TYPEDECL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  int nattr = 0;
  int isoldchar;

  isoldchar = (!strncmp ("CHARACTER*",t,strlen("CHARACTER*")));

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("_""T" "-" "spec""_", ci->offset, ctx); } while (0);
  k = FXTRAN_typespec (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] == 0)
    return;

  while (t[0] == ',')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_attr (t, ci, ctx);
      if ((nattr == 0) && (k == 0) && isoldchar)
        break;
      do { int _n = (k); ci += _n; t += _n; } while (0);
      nattr++;
    }

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1583); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1583); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  stmt_entity_list (t, ci, ctx, &seda_entity, stack);

}


static int binding_name (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("binding" "-" "N", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(kmax)-1].offset+1, ctx, t, kmax); } while (0);
  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}


static void stmt_GENERIC_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (7); ci += _n; t += _n; } while (0);

  while (t[0] == ',')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_attr (t, ci, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
    }

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1612); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1612); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("generic" "-" "spec", ci->offset, ctx); } while (0);
  k = FXTRAN_generic_spec (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if ((t[0] == '=') && (t[1] == '>'))
    {
      do { int _n = (2); ci += _n; t += _n; } while (0);
    }
  else
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1624); fprintf (stderr, "Expected `=>'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1624); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  FXTRAN_process_list (t, ci, ctx, ",", "binding" "-" "N" "-" "LT", strlen (t),
          binding_name, ((void *)0));


  return;
}

static void stmt_COMPONENTDECL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  return stmt_TYPEDECL_extra (t, ci, stack, ctx);
}

static void stmt_BLOCKDATA_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  if (t[9])
    stmt_unit_name (t, ci, "BLOCKDATA", "block" "-" "data" "-" "N", ctx);
}







static void stmt_MODULE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { stmt_unit_name (t, ci, "MODULE", "module" "-" "N", ctx); };
static void stmt_PROGRAM_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { stmt_unit_name (t, ci, "PROGRAM", "program" "-" "N", ctx); };
# 1661 "FXTRAN_STMT.c"
static void stmt_ENDPROGRAM_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { stmt_endunit_name (t, ci, "END""PROGRAM", "program" "-" "N", ctx); };
static void stmt_ENDMODULE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { stmt_endunit_name (t, ci, "END""MODULE", "module" "-" "N", ctx); };
static void stmt_ENDFUNCTION_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { stmt_endunit_name (t, ci, "END""FUNCTION", "function" "-" "N", ctx); };
static void stmt_ENDSUBROUTINE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { stmt_endunit_name (t, ci, "END""SUBROUTINE", "subroutine" "-" "N", ctx); };

static void stmt_ENDBLOCKDATA_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  stmt_endunit_name (t, ci, "ENDBLOCKDATA", "block" "-" "data" "-" "N", ctx);
}




static void stmt_PARAMETER_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{

  do { int _n = (10); ci += _n; t += _n; } while (0);

  stmt_entity_list (t, ci, ctx, &seda_entity, stack);
}

static void stmt_USE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;

  do { int _n = (3); ci += _n; t += _n; } while (0);

  if (t[0] == ',')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("module" "-" "nature", ci->offset, ctx); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1697); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1697); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  k = FXTRAN_eat_word (t);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("module" "-" "N", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);


  if (t[0] == 0)
    return;

  if (t[0] == ',')
    do { int _n = (1); ci += _n; t += _n; } while (0);


  if ((!strncmp ("ONLY:",t,strlen("ONLY:"))))
    do { int _n = (5); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("rename" "-" "LT", ci->offset, ctx); } while (0);

  while (t[0])
    {
      int first = 1;
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("rename", ci->offset, ctx); } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("use" "-" "N", ci->offset, ctx); } while (0);
again:

      k = FXTRAN_generic_spec (t, ci, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

      if ((!strncmp ("=>",t,strlen("=>"))) && first)
        {
          first = 0;
   do { int _n = (2); ci += _n; t += _n; } while (0);
          do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("N", ci->offset, ctx); } while (0);
          goto again;
 }

      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      if (t[0] == ',')
        do { int _n = (1); ci += _n; t += _n; } while (0);
      else
        break;
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}

static void stmt_ENUM_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (4); ci += _n; t += _n; } while (0);
  if ((!strncmp (",BIND(C)",t,strlen(",BIND(C)"))))
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("bind" "-" "spec", ci->offset, ctx); } while (0);
      do { int _n = (7); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
}

static void stmt_ENUMERATOR_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (10); ci += _n; t += _n; } while (0);
  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1764); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1764); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  stmt_entity_list (t, ci, ctx, &seda_enumerator, stack);
}

static void stmt_SELECTTYPE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { int _n = (11); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  if (k == 0)
    return;

  k = FXTRAN_str_at_level (t, ci, "=>", ci[0].parens);

  if (k)
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("associate" "-" "N", ci->offset, ci[(k-1)-1].offset+1, ctx, t, k-1); } while (0);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (2); ci += _n; t += _n; } while (0);
    }

  k = FXTRAN_str_at_level (t, ci, ")", 0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("selector", ci->offset, ctx); } while (0);

  FXTRAN_expr (t, ci, k-1, ctx);

  do { int _n = (k-1); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

}

static void stmt_SELECTCASE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { int _n = (11); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  if (k == 0)
    return;
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("case" "-" "E", ci->offset, ctx); } while (0);

  FXTRAN_expr (t, ci, k-1, ctx);

  do { int _n = (k-1); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}

static int association (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  const char * T = t;
  int k = FXTRAN_eat_word (t);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("associate", ci->offset, ctx); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("associate" "-" "N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  if (!(!strncmp ("=>",t,strlen("=>"))))
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1835); fprintf (stderr, "Expected `=>'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1835); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  do { int _n = (2); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("selector", ci->offset, ctx); } while (0);

  k = kmax - (t - T);

  FXTRAN_expr (t, ci, k, ctx);

  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return 1;
}

static void stmt_ASSOCIATE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { int _n = (10); ci += _n; t += _n; } while (0);
  k = strlen (t);

  FXTRAN_process_list (t, ci, ctx, ",",
                 "associate" "-" "LT", k,
          association, ((void *)0));


}

static int equivalence_object (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("equivalence" "-" "obj", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, kmax, ctx);
  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}

static int equivalence_set (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  int k;
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("equivalence" "-" "set", ci->offset, ctx); } while (0);
  do { int _n = (1); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);
  FXTRAN_process_list (t, ci, ctx, ",",
                "equivalence" "-" "obj" "-" "LT", k,
         equivalence_object, ((void *)0));
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}

static void stmt_EQUIVALENCE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (11); ci += _n; t += _n; } while (0);
  FXTRAN_process_list (t, ci, ctx, ",",
                "equivalence" "-" "set" "-" "LT", strlen (t),
         equivalence_set, ((void *)0));
}

static int data_stmt_object (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("data" "-" "stmt" "-" "obj", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, kmax, ctx);
  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}

static int data_stmt_value (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  int i;
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("data" "-" "stmt" "-" "value", ci->offset, ctx); } while (0);

  for (i = 0; t[i] && (i < kmax); i++)
    if (!((*__ctype_b_loc ())[(int) ((t[i]))] & (unsigned short int) _ISalnum) && (t[i] != '_'))
      break;
  if (t[i] == '*')
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("data" "-" "stmt" "-" "repeat", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, i, ctx);
      do { int _n = (i); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
      kmax = kmax - i - 1;
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("data" "-" "stmt" "-" "constant", ci->offset, ctx); } while (0);

  FXTRAN_expr (t, ci, kmax, ctx);

  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return 1;
}

static void stmt_DATA_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (4); ci += _n; t += _n; } while (0);

  while (t[0])
    {
      k = FXTRAN_str_at_level (t, ci, "/", 0);

      if (k == 0)
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1948); fprintf (stderr, "Expected `/'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1948); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("data" "-" "stmt" "-" "set", ci->offset, ctx); } while (0);
      FXTRAN_process_list (t, ci, ctx, ",", "data" "-" "stmt" "-" "obj" "-" "LT",
             k-1, data_stmt_object, ((void *)0));

      do { int _n = (k); ci += _n; t += _n; } while (0);

      k = FXTRAN_str_at_level (t, ci, "/", 0);

      if (k == 0)
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 1959); fprintf (stderr, "Expected `/'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 1959); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

      FXTRAN_process_list (t, ci, ctx, ",",
             "data" "-" "stmt" "-" "value" "-" "LT",
      k-1, data_stmt_value, ((void *)0));

      do { int _n = (k); ci += _n; t += _n; } while (0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

      if (t[0] == ',')
        do { int _n = (1); ci += _n; t += _n; } while (0);
    }

}

static void stmt_DO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  k = stmt_bos_named_label (t, ci, ctx);

  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { int _n = (2); ci += _n; t += _n; } while (0);

  if (((*__ctype_b_loc ())[(int) ((t[0]))] & (unsigned short int) _ISdigit))
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("label", ci->offset, ctx); } while (0);
      for (k = 0; ((*__ctype_b_loc ())[(int) ((t[k]))] & (unsigned short int) _ISdigit); k++);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

  if (t[0] == '\0')
    return;

  if (t[0] == ',')
    do { int _n = (1); ci += _n; t += _n; } while (0);

  if ((!strncmp ("WHILE(",t,strlen("WHILE("))))
    {
      int k;
      do { int _n = (6); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("test" "-" "E", ci->offset, ctx); } while (0);
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      FXTRAN_expr (t, ci, k-1, ctx);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
  else
    {
      int k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("do" "-" "V", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      if (t[0] != '=')
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2015); fprintf (stderr, "Expected `='"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2015); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);

      k = FXTRAN_str_at_level (t, ci, ",", 0);
      if (k == 0)
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2020); fprintf (stderr, "Expected `,'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2020); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("lower" "-" "bound", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k-1, ctx);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);

      k = FXTRAN_str_at_level (t, ci, ",", 0);
      if (k == 0)
        k = strlen (t);
      else
        k = k - 1;

      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("upper" "-" "bound", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

      if (t[0] == '\0')
        return;

      do { int _n = (1); ci += _n; t += _n; } while (0);

      k = strlen (t);

      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("step", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
}

static void stmt_DOLABEL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  stmt_DO_extra (t, ci, stack, ctx);
}

static int case_value_range (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  int k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("case" "-" "value" "-" "range", ci->offset, ctx); } while (0);

  if ((k != 0) && (k <= kmax))
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("case" "-" "value", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k-1, ctx);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
      kmax = kmax - k;
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("case" "-" "value", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, kmax, ctx);
  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return 1;
}


static void stmt_cltpis_extra (const char * t, const FXTRAN_char_info * ci,
                 FXTRAN_xmlctx * ctx, const char * N)
{
  int k;

  switch (t[0])
    {
      case '(':
        do { int _n = (1); ci += _n; t += _n; } while (0);
        k = FXTRAN_str_at_level (t, ci, ")", 0);
 do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("T" "-" "N", ci->offset, ci[(k-1)-1].offset+1, ctx, t, k-1); } while (0);
        do { int _n = (k); ci += _n; t += _n; } while (0);
      break;
      case 'D':
        if ((!strncmp ("DEFAULT",t,strlen("DEFAULT"))))
          do { int _n = (7); ci += _n; t += _n; } while (0);
 else
          do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2102); fprintf (stderr, "Expected `DEFAULT'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2102); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
      break;
      default:
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2105); fprintf (stderr, "Malformed case"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2105); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
        return;
      break;
    }



  if (t[0])
    stmt_unit_name (t, ci, "", N, ctx);
}

static void stmt_CLASSIS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (7); ci += _n; t += _n; } while (0);
  return stmt_cltpis_extra (t, ci, ctx, "named" "-" "label");
}

static void stmt_TYPEIS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (6); ci += _n; t += _n; } while (0);
  return stmt_cltpis_extra (t, ci, ctx, "named" "-" "label");
}

static void stmt_CASE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (4); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("case" "-" "selector", ci->offset, ctx); } while (0);

  switch (t[0])
    {
      case '(':
        do { int _n = (1); ci += _n; t += _n; } while (0);
        k = FXTRAN_str_at_level (t, ci, ")", 0);
        FXTRAN_process_list (t, ci, ctx, ",",
               "case" "-" "value" "-" "range" "-" "LT",
        k-1, case_value_range, ((void *)0));
        do { int _n = (k); ci += _n; t += _n; } while (0);
      break;
      case 'D':
        if ((!strncmp ("DEFAULT",t,strlen("DEFAULT"))))
          do { int _n = (7); ci += _n; t += _n; } while (0);
 else
          do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2148); fprintf (stderr, "Expected `DEFAULT'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2148); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
      break;
      default:
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2151); fprintf (stderr, "Malformed case"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2151); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
      break;
    }


  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0])
    stmt_unit_name (t, ci, "", "named" "-" "label", ctx);
}
# 2172 "FXTRAN_STMT.c"
static void stmt_ELSE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { int k; k = strlen ("ELSE"); do { int _n = (k); ci += _n; t += _n; } while (0); if (t[0]) stmt_eos_named_label (t, ci, ctx); }
static void stmt_ENDIF_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { int k; k = strlen ("ENDIF"); do { int _n = (k); ci += _n; t += _n; } while (0); if (t[0]) stmt_eos_named_label (t, ci, ctx); }
static void stmt_ENDWHERE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { int k; k = strlen ("ENDWHERE"); do { int _n = (k); ci += _n; t += _n; } while (0); if (t[0]) stmt_eos_named_label (t, ci, ctx); }
static void stmt_ENDASSOCIATE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { int k; k = strlen ("ENDASSOCIATE"); do { int _n = (k); ci += _n; t += _n; } while (0); if (t[0]) stmt_eos_named_label (t, ci, ctx); }
static void stmt_ENDDO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { int k; k = strlen ("ENDDO"); do { int _n = (k); ci += _n; t += _n; } while (0); if (t[0]) stmt_eos_named_label (t, ci, ctx); }
static void stmt_ENDFORALL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { int k; k = strlen ("ENDFORALL"); do { int _n = (k); ci += _n; t += _n; } while (0); if (t[0]) stmt_eos_named_label (t, ci, ctx); }
static void stmt_EXIT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { int k; k = strlen ("EXIT"); do { int _n = (k); ci += _n; t += _n; } while (0); if (t[0]) stmt_eos_named_label (t, ci, ctx); }
static void stmt_CYCLE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { int k; k = strlen ("CYCLE"); do { int _n = (k); ci += _n; t += _n; } while (0); if (t[0]) stmt_eos_named_label (t, ci, ctx); }



static void stmt_ENDSELECTTYPE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (9); ci += _n; t += _n; } while (0);
  if (t[0])
    stmt_eos_named_label (t, ci, ctx);
}

static void stmt_ENDSELECTCASE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (9); ci += _n; t += _n; } while (0);
  if (t[0])
    stmt_eos_named_label (t, ci, ctx);
}

static void stmt_ELSEIF_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (7); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("condition" "-" "E", ci->offset, ctx); } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);
  FXTRAN_expr (t, ci, k-1, ctx);
  do { int _n = (k-1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  do { int _n = (5); ci += _n; t += _n; } while (0);

  if (t[0])
    stmt_eos_named_label (t, ci, ctx);
}

static void stmt_ELSEWHERE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (9); ci += _n; t += _n; } while (0);

  if (t[0] == '(')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("mask" "-" "E", ci->offset, ctx); } while (0);
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      FXTRAN_expr (t, ci, k-1, ctx);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
    }

  if (t[0])
    stmt_eos_named_label (t, ci, ctx);
}

static void stmt_CLOSE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (5); ci += _n; t += _n; } while (0);
  stmt_actual_args (t, ci, ctx, &saap_close);
}

static void stmt_OPEN_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (4); ci += _n; t += _n; } while (0);
  stmt_actual_args (t, ci, ctx, &saap_open);
}

static void stmt_FLUSH_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (5); ci += _n; t += _n; } while (0);
  if (t[0] == '(')
    {
      stmt_actual_args (t, ci, ctx, &saap_flush);
    }
  else
    {
      int k;
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("external" "-" "file" "-" "unit", ci->offset, ctx); } while (0);
      k = strlen (t);
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

}

static void stmt_filepos_extra (const char * t, const FXTRAN_char_info * ci,
                  FXTRAN_xmlctx * ctx, const char * T)
{
  int k = strlen (T);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  if (t[0] == '(')
    {
      stmt_actual_args (t, ci, ctx, &saap_filepos);
    }
  else
    {
      int k;
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("external" "-" "file" "-" "unit", ci->offset, ctx); } while (0);
      k = strlen (t);
      FXTRAN_expr (t, ci, k, ctx);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }

}







static void stmt_BACKSPACE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return stmt_filepos_extra (t, ci, ctx, "BACKSPACE"); }
static void stmt_ENDFILE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return stmt_filepos_extra (t, ci, ctx, "ENDFILE"); }
static void stmt_REWIND_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { return stmt_filepos_extra (t, ci, ctx, "REWIND"); }



static void stmt_comnml_extra (const char * t, const FXTRAN_char_info * ci,
                 FXTRAN_xmlctx * ctx, stmt_entity_decl_parms * seda,
          const char * name, FXTRAN_stmt_stack * stack)
{
  int k;

again:

  if (t[0] == '/')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_eat_word (t);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name (name, ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);
      do { int _n = (k); ci += _n; t += _n; } while (0);
      if (t[0] != '/')
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2313); fprintf (stderr, "Expected `/'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2313); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
    }

  k = FXTRAN_str_at_level (t, ci, "/", 0);
  if (k == 0)
    k = strlen (t);
  else
    {
      k = k - 1;
      if (t[k-1] == ',')
        k--;
    }

  {
    char t1[k];
    FXTRAN_char_info ci1[k];
    FXTRAN_restrict_tci (t1, ci1, t, ci, k);
    stmt_entity_list (t1, ci1, ctx, seda, stack);
    do { int _n = (k); ci += _n; t += _n; } while (0);
  }

  if (t[0] == ',')
    do { int _n = (1); ci += _n; t += _n; } while (0);

  if (t[0] == '/')
    goto again;
}

static void stmt_COMMON_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (6); ci += _n; t += _n; } while (0);
  stmt_comnml_extra (t, ci, ctx, &seda_common, "common" "-" "block" "-" "N", stack);
}

static void stmt_NAMELIST_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (8); ci += _n; t += _n; } while (0);
  stmt_comnml_extra (t, ci, ctx, &seda_namelist, "namelist" "-" "group" "-" "N", stack);
}


static void stmt_ENTRY_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k = stmt_unit_name (t, ci, "ENTRY", "entry" "-" "N", ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  k = stmt_unit_dummy_args (t, ci, ctx, stack);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  suffix (t, ci, ctx, 1, stack);
}

static void stmt_SUBROUTINE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k2;
  int k3;
  const char * prefix[] = { "RECURSIVE", "PURE", "ELEMENTAL", ((void *)0) };

  while (1)
    {
      int i;
      int ad = 0;

      for (i = 0; prefix[i]; i++)
        if ((!strncmp (prefix[i],t,strlen(prefix[i]))))
          {
            int len = strlen (prefix[i]);
            FXTRAN_xml_word_tag ("prefix", ci[0].offset, ci[len-1].offset+1, ctx);
     do { int _n = (len); ci += _n; t += _n; } while (0);
     ad++;
     prefix[i] = "!";
          }

      if ((!strncmp ("SUBROUTINE",t,strlen("SUBROUTINE"))))
        break;

      if (ad == 0)
        break;

    }

  k2 = stmt_unit_name (t, ci, "SUBROUTINE", "subroutine" "-" "N", ctx);
  do { int _n = (k2); ci += _n; t += _n; } while (0);
  k3 = stmt_unit_dummy_args (t, ci, ctx, stack);
  do { int _n = (k3); ci += _n; t += _n; } while (0);

  suffix (t, ci, ctx, 0, stack);
}

static void stmt_assignment_extra (const char * t, const FXTRAN_char_info * ci,
                     FXTRAN_xmlctx * ctx, const char * op)
{
  int k = FXTRAN_str_at_level (t, ci, op, 0);

  if (k == 0)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2409); fprintf (stderr, "Expected `%s'", op); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2409); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("E" "-" "1", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k-1, ctx);

  do { int _n = (k-1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  k = strlen (op);
  FXTRAN_xml_word_tag ("a", ci->offset, ci[k-1].offset+1, ctx);

  do { int _n = (k); ci += _n; t += _n; } while (0);

  k = strlen (t);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("E" "-" "2", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}

static void stmt_POINTERASSIGNMENT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  return stmt_assignment_extra (t, ci, ctx, "=>");
}

static void stmt_ASSIGNMENT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  return stmt_assignment_extra (t, ci, ctx, "=");
}

static void def_construct_end_ (FXTRAN_stmt_type TFO, FXTRAN_stmt_type TF, int blk,
                  FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, xml_tu * tu)
{
  FXTRAN_stmt_stack_state * sts = FXTRAN_stmt_stack_curr (stack);
  if (sts->type != TFO)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2445); fprintf (stderr, "Unexpected %s statement", stmt_as_str (TF)); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2445); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  if (ctx->opts.construct_tag)
    tu->xml_ctu2 = blk ? 2 : 1;
  FXTRAN_stmt_stack_decr (stack);
}

static void def_construct_alt_ (FXTRAN_stmt_type TFO, FXTRAN_stmt_type TF, const char * ss,
                  FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, xml_tu * tu)
{
  FXTRAN_stmt_stack_state * sts = FXTRAN_stmt_stack_curr (stack);
  if (sts->type != TFO)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 2456); fprintf (stderr, "Unexpected %s statement", stmt_as_str (TF)); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 2456); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
  if (ctx->opts.construct_tag)
    {
      tu->xml_ctu1 = 1;
      tu->xml_otu1[0] = ss;
      tu->xml_otu1[1] = ((void *)0);
    }
}

static void def_construct_opn_ (FXTRAN_stmt_type TF, int blk, const char * ss1, const char * ss2,
                  FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, xml_tu * tu)
{
  if (ctx->opts.construct_tag)
    {
      tu->xml_otu1[0] = ((void *)0);
      tu->xml_otu1[1] = ((void *)0);
      tu->xml_otu1[2] = ((void *)0);
      tu->xml_otu1[0] = ss1;
      if (blk)
        tu->xml_otu1[1] = ss2;
    }
  FXTRAN_stmt_stack_incr (stack, TF);
}

static int stmt_prog_unit_expected (FXTRAN_stmt_stack * stack)
{
  FXTRAN_stmt_stack_state * st = FXTRAN_stmt_stack_curr(stack);
  if (st == ((void *)0))
    return 1;
  if (st->seen_contains)
    return 1;
  return 0;
}

static FXTRAN_stmt_type grok_fs (const char * t, const FXTRAN_char_info * ci)
{

  int k = 0;
  int i;
  const char * prefix[] = { "RECURSIVE", "ELEMENTAL", "PURE", ((void *)0) };
  while (1)
    {
      int k1 = k;
      for (i = 0; prefix[i]; i++)
        if ((!strncmp (prefix[i],&t[k],strlen(prefix[i]))))
          {
     k += strlen (prefix[i]);
            prefix[i] = "!";
          }
      if (k1 == k)
        break;
    }
  if ((!strncmp ("SUBROUTINE",&t[k],strlen("SUBROUTINE"))))
    return FXTRAN_SUBROUTINE;

  if ((k = FXTRAN_str_at_level (t, ci, "FUNCTION", 0)))
    {
      int j;

      if ((j = FXTRAN_eat_word (&t[k])) == 0)
        return FXTRAN_NONE;

      k += j;

      if ((t[k] == '(') && ((t[k+1] == ')') || ((*__ctype_b_loc ())[(int) ((t[k+1]))] & (unsigned short int) _ISalpha)))
        return FXTRAN_FUNCTION;

      return FXTRAN_NONE;
    }
  return FXTRAN_NONE;
}

static int get_do_label (const char * t)
{
  int i;
  int do_label = 0;
  for (i = 2; ((*__ctype_b_loc ())[(int) ((t[i]))] & (unsigned short int) _ISdigit); i++)
    do_label = do_label * 10 + (t[i] - '0');
  return do_label;
}
# 2555 "FXTRAN_STMT.c"
static FXTRAN_stmt_type get_FXTRAN_stmt_type (const char * t, const FXTRAN_char_info * ci,
                                FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx,
           int * pexpect_pu, xml_tu * tu)
{
  int len;
  FXTRAN_stmt_type Type = FXTRAN_NONE;

  *pexpect_pu = 0;
  len = strlen (t);

  if ((!stmt_prog_unit_expected (stack)) || (!stack->seen_stmt))
  if (!FXTRAN_str_at_level (t, ci, "::", 0))
    {
      int k;
      if (!FXTRAN_str_at_level (t, ci, ",", 0))
        {
          FXTRAN_stmt_type tt = FXTRAN_NONE;
          if (FXTRAN_str_at_level (t, ci, "=>", 0))
            tt = FXTRAN_POINTERASSIGNMENT;
          else if (FXTRAN_str_at_level (t, ci, "=", 0))
            tt = FXTRAN_ASSIGNMENT;

   if (tt)
            {
# 2589 "FXTRAN_STMT.c"
              do { if ((!strncmp ("IF""(",t,strlen("IF""(")))) { if ((k = FXTRAN_str_at_level (t, ci, ")", 0))) if (((*__ctype_b_loc ())[(int) ((t[k]))] & (unsigned short int) _ISalpha)) goto other; } } while (0);
              do { if ((!strncmp ("WHERE""(",t,strlen("WHERE""(")))) { if ((k = FXTRAN_str_at_level (t, ci, ")", 0))) if (((*__ctype_b_loc ())[(int) ((t[k]))] & (unsigned short int) _ISalpha)) goto other; } } while (0);
              do { if ((!strncmp ("FORALL""(",t,strlen("FORALL""(")))) { if ((k = FXTRAN_str_at_level (t, ci, ")", 0))) if (((*__ctype_b_loc ())[(int) ((t[k]))] & (unsigned short int) _ISalpha)) goto other; } } while (0);

              do { Type = tt; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
     }
        }
      if ((k = FXTRAN_str_at_level (t, ci, ":", 0)))
        {
   if (FXTRAN_eat_word (t) != k-1)
            goto other;
          return get_FXTRAN_stmt_type (&t[k], &ci[k], stack, ctx, pexpect_pu, tu);
 }
    }

  if (stmt_prog_unit_expected (stack))
    {
      FXTRAN_stmt_type type;

      do { if ((!strncmp ("MODULE",t,strlen("MODULE")))) do { Type = FXTRAN_MODULE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
      do { if ((!strncmp ("BLOCKDATA",t,strlen("BLOCKDATA")))) do { Type = FXTRAN_BLOCKDATA; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
      do { if ((!strncmp ("PROGRAM",t,strlen("PROGRAM")))) do { Type = FXTRAN_PROGRAM; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

      type = grok_fs (t, ci);

      if (type == FXTRAN_NONE)
        {
          if (!stack->seen_stmt)
            {


              FXTRAN_stmt_stack_incr (stack, FXTRAN_PROGRAM);
       tu->xml_otu1[0] = "program" "-" "unit";
       tu->xml_otu1[1] = ((void *)0);
            }
   else
            {
              *pexpect_pu = 1;
            }
 }
      else
        {
          do { Type = type; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
 }
    }
  else if (FXTRAN_stmt_in(stack,FXTRAN_INTERFACE))
    {
      FXTRAN_stmt_type type;

      if ((!strncmp ("MODULEPROCEDURE",t,strlen("MODULEPROCEDURE"))))
        do { Type = FXTRAN_PROCEDURE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
      else if ((!strncmp ("PROCEDURE",t,strlen("PROCEDURE"))))
        do { Type = FXTRAN_PROCEDURE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

      type = grok_fs (t, ci);

      if (type == FXTRAN_NONE)
        goto other;
      else
        do { Type = type; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
    }




other:

  switch (t[0])
    {
 case 'A':

        if ((!strcmp ("ABSTRACTINTERFACE",t)))
          do { Type = FXTRAN_INTERFACE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
        do { if ((!strncmp ("ALLOCATABLE",t,strlen("ALLOCATABLE")))) do { Type = FXTRAN_ALLOCATABLE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("ALLOCATE",t,strlen("ALLOCATE")))) do { Type = FXTRAN_ALLOCATE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("ASSIGN",t,strlen("ASSIGN")))) do { Type = FXTRAN_ASSIGN; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("ASSOCIATE",t,strlen("ASSOCIATE")))) do { Type = FXTRAN_ASSOCIATE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
 do { if ((!strncmp ("ASYNCHRONOUS",t,strlen("ASYNCHRONOUS")))) do { Type = FXTRAN_ASYNCHRONOUS; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'B':

        do { if ((!strncmp ("BACKSPACE",t,strlen("BACKSPACE")))) do { Type = FXTRAN_BACKSPACE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
        do { if ((!strncmp ("BIND",t,strlen("BIND")))) do { Type = FXTRAN_BIND; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

        case 'C':

        if ((!strncmp ("CLASSIS(",t,strlen("CLASSIS("))))
          do { Type = FXTRAN_CLASSIS; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

        if ((!strncmp ("CLASSDEFAULT",t,strlen("CLASSDEFAULT"))))
          do { Type = FXTRAN_CLASSIS; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

        if ((!strncmp ("CLASS(",t,strlen("CLASS("))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

        if ((!strncmp ("CHARACTER",t,strlen("CHARACTER"))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

        if ((!strncmp ("COMPLEX",t,strlen("COMPLEX"))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

        do { if ((!strncmp ("CALL",t,strlen("CALL")))) do { Type = FXTRAN_CALL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("CASE",t,strlen("CASE")))) do { Type = FXTRAN_CASE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("CLOSE",t,strlen("CLOSE")))) do { Type = FXTRAN_CLOSE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("COMMON",t,strlen("COMMON")))) do { Type = FXTRAN_COMMON; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
        do { if ((!strcmp ("CONTAINS",t))) do { Type = FXTRAN_CONTAINS; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("CONTINUE",t,strlen("CONTINUE")))) do { Type = FXTRAN_CONTINUE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("CYCLE",t,strlen("CYCLE")))) do { Type = FXTRAN_CYCLE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'D':

        if ((!strncmp ("DOUBLEPRECISION",t,strlen("DOUBLEPRECISION"))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
        if ((!strncmp ("DOUBLECOMPLEX",t,strlen("DOUBLECOMPLEX"))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
        do { if ((!strncmp ("DATA",t,strlen("DATA")))) do { Type = FXTRAN_DATA; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("DEALLOCATE",t,strlen("DEALLOCATE")))) do { Type = FXTRAN_DEALLOCATE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("DIMENSION",t,strlen("DIMENSION")))) do { Type = FXTRAN_DIMENSION; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 if ((!strncmp ("DO",t,strlen("DO"))))
          {
            if (((*__ctype_b_loc ())[(int) ((t[2]))] & (unsigned short int) _ISdigit))
              do { Type = FXTRAN_DOLABEL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
            else
       do { Type = FXTRAN_DO; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
   }

 break;

 case 'E':

        do { if ((!strncmp ("ENUMERATOR",t,strlen("ENUMERATOR")))) do { Type = FXTRAN_ENUMERATOR; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
        do { if ((!strncmp ("ENUM",t,strlen("ENUM")))) do { Type = FXTRAN_ENUM; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 if ((t[1] == 'N') && (t[2] == 'D'))
          {
            do { do { if ((!strncmp ("ENDASSOCIATE",t,strlen("ENDASSOCIATE")))) do { Type = FXTRAN_ENDASSOCIATE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDBLOCKDATA",t,strlen("ENDBLOCKDATA")))) do { Type = FXTRAN_ENDBLOCKDATA; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDCLASS",t,strlen("ENDCLASS")))) do { Type = FXTRAN_ENDCLASS; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDDO",t,strlen("ENDDO")))) do { Type = FXTRAN_ENDDO; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0);
     do { do { if ((!strncmp ("ENDFORALL",t,strlen("ENDFORALL")))) do { Type = FXTRAN_ENDFORALL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDFUNCTION",t,strlen("ENDFUNCTION")))) do { Type = FXTRAN_ENDFUNCTION; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDIF",t,strlen("ENDIF")))) do { Type = FXTRAN_ENDIF; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDINTERFACE",t,strlen("ENDINTERFACE")))) do { Type = FXTRAN_ENDINTERFACE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0);
     do { do { if ((!strncmp ("ENDMODULE",t,strlen("ENDMODULE")))) do { Type = FXTRAN_ENDMODULE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDPROGRAM",t,strlen("ENDPROGRAM")))) do { Type = FXTRAN_ENDPROGRAM; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDSUBROUTINE",t,strlen("ENDSUBROUTINE")))) do { Type = FXTRAN_ENDSUBROUTINE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { do { if ((!strncmp ("ENDTYPE",t,strlen("ENDTYPE")))) do { Type = FXTRAN_ENDTYPE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0);
            do { do { if ((!strncmp ("ENDWHERE",t,strlen("ENDWHERE")))) do { Type = FXTRAN_ENDWHERE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0); do { if ((!strncmp ("ENDFILE",t,strlen("ENDFILE")))) do { Type = FXTRAN_ENDFILE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { do { if ((!strncmp ("ENDENUM",t,strlen("ENDENUM")))) do { Type = FXTRAN_ENDENUM; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); } while (0);

            if (FXTRAN_stmt_stack_ok (stack))
              {

                FXTRAN_stmt_stack_state * st = FXTRAN_stmt_stack_curr(stack);
                if (t[3] == '\0')
                  {
             if (st)
                      switch (FXTRAN_stmt_stack_curr(stack)->type)
                        {
                          case FXTRAN_MODULE: do { Type = FXTRAN_ENDMODULE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
                          case FXTRAN_PROGRAM: do { Type = FXTRAN_ENDPROGRAM; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
                          case FXTRAN_FUNCTION: do { Type = FXTRAN_ENDFUNCTION; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
                          case FXTRAN_SUBROUTINE: do { Type = FXTRAN_ENDSUBROUTINE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
                          case FXTRAN_BLOCKDATA: do { Type = FXTRAN_ENDBLOCKDATA; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
                   default:
                            FXTRAN_stmt_stack_break (stack, ctx);
                        }
             else
                      do { Type = FXTRAN_ENDPROGRAM; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
                  }
                else if ((!strncmp ("ENDSELECT",t,strlen("ENDSELECT"))) && st)
                  {
                    int labok = 1;
                    const char * s = t + 9;
                    for (; *s; s++)
                      labok = labok && (((*__ctype_b_loc ())[(int) ((*s))] & (unsigned short int) _ISalnum) || *s == '_');
                    if (labok)
                      {
                        switch (FXTRAN_stmt_stack_curr(stack)->type)
                          {
                            case FXTRAN_SELECTCASE: do { Type = FXTRAN_ENDSELECTCASE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
                            case FXTRAN_SELECTTYPE: do { Type = FXTRAN_ENDSELECTTYPE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
                            default:
                              break;
                          }
                      }
                  }
              }

   }

 if ((!strncmp ("ELSEIF(",t,strlen("ELSEIF("))))
          do { Type = FXTRAN_ELSEIF; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

 if (FXTRAN_stmt_in (stack, FXTRAN_WHERECONSTRUCT))
   if ((!strncmp ("ELSEWHERE",t,strlen("ELSEWHERE"))))
            return FXTRAN_ELSEWHERE;

        do { if ((!strncmp ("ELSE",t,strlen("ELSE")))) do { Type = FXTRAN_ELSE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("ENDIF",t,strlen("ENDIF")))) do { Type = FXTRAN_ENDIF; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("ENTRY",t,strlen("ENTRY")))) do { Type = FXTRAN_ENTRY; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("EQUIVALENCE",t,strlen("EQUIVALENCE")))) do { Type = FXTRAN_EQUIVALENCE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
 do { if ((!strncmp ("EXIT",t,strlen("EXIT")))) do { Type = FXTRAN_EXIT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("EXTERNAL",t,strlen("EXTERNAL")))) do { Type = FXTRAN_EXTERNAL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'F':

        do { if ((!strncmp ("FINAL",t,strlen("FINAL")))) do { Type = FXTRAN_FINAL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("FLUSH",t,strlen("FLUSH")))) do { Type = FXTRAN_FLUSH; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 if ((!strncmp ("FORALL",t,strlen("FORALL"))))
          {
     int k = FXTRAN_str_at_level (t, ci, ")", 0);
     int len = strlen (t);
     if (k != len)
              do { Type = FXTRAN_FORALL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
     else
       do { Type = FXTRAN_FORALLCONSTRUCT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
          }

        do { if ((!strncmp ("FORMAT",t,strlen("FORMAT")))) do { Type = FXTRAN_FORMAT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'G':

        do { if ((!strncmp ("GENERIC",t,strlen("GENERIC")))) do { Type = FXTRAN_GENERIC; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 if ((!strncmp ("GOTO(",t,strlen("GOTO("))))
          do { Type = FXTRAN_COMPUTEDGOTO; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

 if ((!strncmp ("GOTO",t,strlen("GOTO"))))
          {
            if (FXTRAN_str_at_level (t, ci, "(", 0))
              do { Type = FXTRAN_ASSIGNEDGOTO; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
     do { Type = FXTRAN_GOTO; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
          }

 break;

 case 'I':

        if ((!strncmp ("INTEGER",t,strlen("INTEGER"))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
        if ((!strncmp ("IF(",t,strlen("IF("))))
          {
            int k;
            if ((!strncmp (")THEN",&t[len-5],strlen(")THEN"))))
              do { Type = FXTRAN_IFTHEN; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
            k = FXTRAN_str_at_level (t, ci, ")", ci[0].parens);
     if (k == 0)
              do { Type = FXTRAN_NONE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
     if (((*__ctype_b_loc ())[(int) ((t[k]))] & (unsigned short int) _ISdigit))
              do { Type = FXTRAN_ARITHMETICIF; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
     do { Type = FXTRAN_IF; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
   }


 do { if ((!strcmp ("IMPLICITNONE",t))) do { Type = FXTRAN_IMPLICITNONE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("IMPLICIT",t,strlen("IMPLICIT")))) do { Type = FXTRAN_IMPLICIT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("IMPORT",t,strlen("IMPORT")))) do { Type = FXTRAN_IMPORT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("INCLUDE",t,strlen("INCLUDE")))) do { Type = FXTRAN_INCLUDE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
 do { if ((!strncmp ("INQUIRE",t,strlen("INQUIRE")))) do { Type = FXTRAN_INQUIRE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("INTENT",t,strlen("INTENT")))) do { Type = FXTRAN_INTENT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("INTERFACE",t,strlen("INTERFACE")))) do { Type = FXTRAN_INTERFACE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("INTRINSIC",t,strlen("INTRINSIC")))) do { Type = FXTRAN_INTRINSIC; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'L':

        if ((!strncmp ("LOGICAL",t,strlen("LOGICAL"))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);


 break;

 case 'N':

        do { if ((!strncmp ("NAMELIST",t,strlen("NAMELIST")))) do { Type = FXTRAN_NAMELIST; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("NULLIFY",t,strlen("NULLIFY")))) do { Type = FXTRAN_NULLIFY; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'O':

        do { if ((!strncmp ("OPEN",t,strlen("OPEN")))) do { Type = FXTRAN_OPEN; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("OPTIONAL",t,strlen("OPTIONAL")))) do { Type = FXTRAN_OPTIONAL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'P':

        if ((!strncmp ("PROCEDURE(",t,strlen("PROCEDURE("))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

        if ((!strncmp ("POINTER(",t,strlen("POINTER("))))
          do { Type = FXTRAN_CRAYPOINTER; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

        do { if ((!strncmp ("PAUSE",t,strlen("PAUSE")))) do { Type = FXTRAN_PAUSE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("PARAMETER",t,strlen("PARAMETER")))) do { Type = FXTRAN_PARAMETER; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("POINTER",t,strlen("POINTER")))) do { Type = FXTRAN_POINTER; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("PRINT",t,strlen("PRINT")))) do { Type = FXTRAN_PRINT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
 do { if ((!strncmp ("PRIVATE",t,strlen("PRIVATE")))) do { Type = FXTRAN_PRIVATE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("PROTECTED",t,strlen("PROTECTED")))) do { Type = FXTRAN_PROTECTED; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("PUBLIC",t,strlen("PUBLIC")))) do { Type = FXTRAN_PUBLIC; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'R':

        do { if ((!strncmp ("READ",t,strlen("READ")))) do { Type = FXTRAN_READ; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

        if ((!strncmp ("REAL",t,strlen("REAL"))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

 do { if ((!strncmp ("RETURN",t,strlen("RETURN")))) do { Type = FXTRAN_RETURN; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("REWIND",t,strlen("REWIND")))) do { Type = FXTRAN_REWIND; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

        break;

 case 'S':

        do { if ((!strncmp ("SAVE",t,strlen("SAVE")))) do { Type = FXTRAN_SAVE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("SELECTTYPE",t,strlen("SELECTTYPE")))) do { Type = FXTRAN_SELECTTYPE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("SELECTCASE",t,strlen("SELECTCASE")))) do { Type = FXTRAN_SELECTCASE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("SEQUENCE",t,strlen("SEQUENCE")))) do { Type = FXTRAN_SEQUENCE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);
 do { if ((!strncmp ("STOP",t,strlen("STOP")))) do { Type = FXTRAN_STOP; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

        break;

 case 'T':

        do { if ((!strncmp ("TARGET",t,strlen("TARGET")))) do { Type = FXTRAN_TARGET; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

        if ((!strncmp ("TYPE(",t,strlen("TYPE("))))
          do { Type = FXTRAN_TYPEDECL; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);


 if ((!strncmp ("TYPEIS(",t,strlen("TYPEIS("))))
          do { Type = FXTRAN_TYPEIS; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);

        do { if ((!strncmp ("TYPE",t,strlen("TYPE")))) do { Type = FXTRAN_TYPE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'U':

        do { if ((!strncmp ("USE",t,strlen("USE")))) do { Type = FXTRAN_USE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'V':

 do { if ((!strncmp ("VOLATILE",t,strlen("VOLATILE")))) do { Type = FXTRAN_VOLATILE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("VALUE",t,strlen("VALUE")))) do { Type = FXTRAN_VALUE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 break;

 case 'W':

 do { if ((!strncmp ("WAIT",t,strlen("WAIT")))) do { Type = FXTRAN_WAIT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0); do { if ((!strncmp ("WRITE",t,strlen("WRITE")))) do { Type = FXTRAN_WRITE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0); } while (0);

 if ((!strncmp ("WHERE",t,strlen("WHERE"))))
          {
     int k = FXTRAN_str_at_level (t, ci, ")", 0);
     int len = strlen (t);
     if (k != len)
              do { Type = FXTRAN_WHERE; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
     else
       do { Type = FXTRAN_WHERECONSTRUCT; if ((Type == FXTRAN_TYPEDECL) && (FXTRAN_stmt_in(stack,FXTRAN_TYPE) || FXTRAN_stmt_in(stack,FXTRAN_CLASS))) Type = FXTRAN_COMPONENTDECL; goto done; } while (0);
          }


 break;

    }



done:

  stack->seen_stmt = 1;

  return Type;







}

static void stmt_block_handle (const char * t, FXTRAN_stmt_type Type, int expect_pu, int label,
                 FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx, xml_tu * tu)
{
# 2986 "FXTRAN_STMT.c"
  switch (Type)
    {

case FXTRAN_BLOCKDATA: def_construct_opn_ (FXTRAN_BLOCKDATA,0,"program" "-" "unit",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDBLOCKDATA: def_construct_end_ (FXTRAN_BLOCKDATA,FXTRAN_ENDBLOCKDATA,0,stack,ctx,tu); break;

case FXTRAN_PROGRAM: def_construct_opn_ (FXTRAN_PROGRAM,0,"program" "-" "unit",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDPROGRAM: def_construct_end_ (FXTRAN_PROGRAM,FXTRAN_ENDPROGRAM,0,stack,ctx,tu); break;

case FXTRAN_SUBROUTINE: def_construct_opn_ (FXTRAN_SUBROUTINE,0,"program" "-" "unit",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDSUBROUTINE: def_construct_end_ (FXTRAN_SUBROUTINE,FXTRAN_ENDSUBROUTINE,0,stack,ctx,tu); break;

case FXTRAN_FUNCTION: def_construct_opn_ (FXTRAN_FUNCTION,0,"program" "-" "unit",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDFUNCTION: def_construct_end_ (FXTRAN_FUNCTION,FXTRAN_ENDFUNCTION,0,stack,ctx,tu); break;

case FXTRAN_MODULE: def_construct_opn_ (FXTRAN_MODULE,0,"program" "-" "unit",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDMODULE: def_construct_end_ (FXTRAN_MODULE,FXTRAN_ENDMODULE,0,stack,ctx,tu); break;

      case FXTRAN_CONTAINS:
        FXTRAN_stmt_stack_curr(stack)->seen_contains = 1;
      break;
      default:
        if ((!FXTRAN_stmt_stack_curr(stack)) && (FXTRAN_stmt_stack_ok(stack)))
          FXTRAN_stmt_stack_incr(stack, FXTRAN_PROGRAM);
 if (expect_pu)
          FXTRAN_xml_err ("Expected program unit statement", ctx);
      break;
    }


  {
    int k = 0;
    while (1)
      {
        FXTRAN_stmt_stack_state * sts = FXTRAN_stmt_stack_curr (stack);
        if (sts == ((void *)0))
          break;
        if ((sts->type == FXTRAN_DOLABEL) && (sts->do_label == label))
          {
            if (ctx->opts.construct_tag)
              tu->xml_ctu2++;
            FXTRAN_stmt_stack_decr (stack);
     k++;
          }
        else
          {
            break;
          }
      }
    if (k > 0)
      goto end;
  }


  switch (Type)
    {

case FXTRAN_IFTHEN: def_construct_opn_ (FXTRAN_IFTHEN,1,"if" "-" "construct","if" "-" "block",stack,ctx,tu); break;
case FXTRAN_ELSEIF: def_construct_alt_ (FXTRAN_IFTHEN,FXTRAN_ELSEIF,"if" "-" "block",stack,ctx,tu); break;
case FXTRAN_ELSE: def_construct_alt_ (FXTRAN_IFTHEN,FXTRAN_ELSE,"if" "-" "block",stack,ctx,tu); break;
case FXTRAN_ENDIF: def_construct_end_ (FXTRAN_IFTHEN,FXTRAN_ENDIF,1,stack,ctx,tu); break;

case FXTRAN_WHERECONSTRUCT: def_construct_opn_ (FXTRAN_WHERECONSTRUCT,1,"where" "-" "construct","where" "-" "block",stack,ctx,tu); break;
case FXTRAN_ELSEWHERE: def_construct_alt_ (FXTRAN_WHERECONSTRUCT,FXTRAN_ELSEWHERE,"where" "-" "block",stack,ctx,tu); break;
case FXTRAN_ENDWHERE: def_construct_end_ (FXTRAN_WHERECONSTRUCT,FXTRAN_ENDWHERE,1,stack,ctx,tu); break;

case FXTRAN_SELECTCASE: def_construct_opn_ (FXTRAN_SELECTCASE,1,"selectcase" "-" "construct","selectcase" "-" "block",stack,ctx,tu); break;
case FXTRAN_CASE: def_construct_alt_ (FXTRAN_SELECTCASE,FXTRAN_CASE,"selectcase" "-" "block",stack,ctx,tu); break;
case FXTRAN_ENDSELECTCASE: def_construct_end_ (FXTRAN_SELECTCASE,FXTRAN_ENDSELECTCASE,1,stack,ctx,tu); break;

case FXTRAN_SELECTTYPE: def_construct_opn_ (FXTRAN_SELECTTYPE,1,"selecttype" "-" "construct","selecttype" "-" "block",stack,ctx,tu); break;
case FXTRAN_TYPEIS: def_construct_alt_ (FXTRAN_SELECTTYPE,FXTRAN_TYPEIS,"selecttype" "-" "block",stack,ctx,tu); break;
case FXTRAN_ENDSELECTTYPE: def_construct_end_ (FXTRAN_SELECTTYPE,FXTRAN_ENDSELECTTYPE,1,stack,ctx,tu); break;

case FXTRAN_CLASS: def_construct_opn_ (FXTRAN_CLASS,0,"class" "-" "construct",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDCLASS: def_construct_end_ (FXTRAN_CLASS,FXTRAN_ENDCLASS,0,stack,ctx,tu); break;

case FXTRAN_ENUM: def_construct_opn_ (FXTRAN_ENUM,0,"enum" "-" "construct",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDENUM: def_construct_end_ (FXTRAN_ENUM,FXTRAN_ENDENUM,0,stack,ctx,tu); break;

case FXTRAN_TYPE: def_construct_opn_ (FXTRAN_TYPE,0,"T" "-" "construct",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDTYPE: def_construct_end_ (FXTRAN_TYPE,FXTRAN_ENDTYPE,0,stack,ctx,tu); break;

case FXTRAN_FORALLCONSTRUCT: def_construct_opn_ (FXTRAN_FORALLCONSTRUCT,0,"forall" "-" "construct",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDFORALL: def_construct_end_ (FXTRAN_FORALLCONSTRUCT,FXTRAN_ENDFORALL,0,stack,ctx,tu); break;

case FXTRAN_INTERFACE: def_construct_opn_ (FXTRAN_INTERFACE,0,"interface" "-" "construct",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDINTERFACE: def_construct_end_ (FXTRAN_INTERFACE,FXTRAN_ENDINTERFACE,0,stack,ctx,tu); break;

case FXTRAN_ASSOCIATE: def_construct_opn_ (FXTRAN_ASSOCIATE,0,"associate" "-" "construct",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDASSOCIATE: def_construct_end_ (FXTRAN_ASSOCIATE,FXTRAN_ENDASSOCIATE,0,stack,ctx,tu); break;

case FXTRAN_DOLABEL: def_construct_opn_ (FXTRAN_DOLABEL,0,"do" "-" "label" "-" "construct",((void *)0),stack,ctx,tu); break;

case FXTRAN_DO: def_construct_opn_ (FXTRAN_DO,0,"do" "-" "construct",((void *)0),stack,ctx,tu); break;
case FXTRAN_ENDDO: def_construct_end_ (FXTRAN_DO,FXTRAN_ENDDO,0,stack,ctx,tu); break;

      default:
      break;

    }


  if (Type == FXTRAN_DOLABEL)
    FXTRAN_stmt_stack_curr(stack)->do_label = get_do_label (t);

end:
  return;
# 3106 "FXTRAN_STMT.c"
}


static void stmt_simple_extra (const char * t, const FXTRAN_char_info * ci,
                 FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx,
          const char * expr_name)
{
  int k = FXTRAN_str_at_level (t, ci, "(", 0);

  do { int _n = (k); ci += _n; t += _n; } while (0);

  k = FXTRAN_str_at_level (t, ci, ")", 0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (expr_name, ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k-1, ctx);

  do { int _n = (k-1); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("action" "-" "stmt", ci->offset, ctx); } while (0);
  k = strlen (t);

  FXTRAN_stmt (t, ci, stack, ctx, 0, 0);

  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}
# 3144 "FXTRAN_STMT.c"
static void stmt_IF_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx) { return stmt_simple_extra (t, ci, stack, ctx, "condition" "-" "E"); }
static void stmt_WHERE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx) { return stmt_simple_extra (t, ci, stack, ctx, "mask" "-" "E"); }







static void stmt_IMPLICITNONE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { }
static void stmt_CONTINUE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { }
static void stmt_CONTAINS_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { }
static void stmt_SEQUENCE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { }
static void stmt_ENDENUM_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx) { }



static int arithmetic_if_label (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("label", ci->offset, ctx); } while (0);
  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}

static void stmt_ARITHMETICIF_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (3); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("numeric" "-" "E", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k-1, ctx);
  do { int _n = (k-1); ci += _n; t += _n; } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);

  k = strlen (t);
  FXTRAN_process_list (t, ci, ctx, ",",
                "label" "-" "LT",
         k, arithmetic_if_label, ((void *)0));

}

static void stmt_ASSIGN_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (6); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, "TO", 0);

  if (k == 0)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3197); fprintf (stderr, "Expected `TO'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3197); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("label", ci->offset, ctx); } while (0);

  do { int _n = (k-1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  do { int _n = (2); ci += _n; t += _n; } while (0);

  k = strlen (t);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(k)-1].offset+1, ctx, t, k); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("V", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

}

static int letter_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{

  FXTRAN_xml_word_tag ("letter" "-" "spec", ci->offset, ci[kmax-1].offset+1, ctx);

  return 1;
}

static int implicit_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  int i;
  int k;
  const char * T = t;


  for (i = 0; FXTRAN_types[i]; i++)
    if ((!strncmp (FXTRAN_types[i],t,strlen(FXTRAN_types[i]))))
      break;

  if (FXTRAN_types[i] == ((void *)0))
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3236); fprintf (stderr, "Unknown type"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3236); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("implicit" "-" "spec", ci->offset, ctx); } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("T" "-" "spec", ci->offset, ctx); } while (0);
  k = strlen (FXTRAN_types[i]);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  if (t[0] == '(')
    {
      k = FXTRAN_str_at_level (t, ci, ")", ci[0].parens);
      if (&t[k] - T >= kmax)
        goto letter_spec;
    }

  k = typespec_ext (t, ci, ctx, i);

  do { int _n = (k); ci += _n; t += _n; } while (0);


letter_spec:
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] != '(')
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3259); fprintf (stderr, "Expected `('"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3259); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);

  k = FXTRAN_str_at_level (t, ci, ")", ci[0].parens-1);
  FXTRAN_process_list (t, ci, ctx, ",",
                "letter" "-" "spec" "-" "LT",
         k-1, letter_spec, ((void *)0));

  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return 1;
}

static void stmt_IMPLICIT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (8); ci += _n; t += _n; } while (0);
  k = strlen (t);
  FXTRAN_process_list (t, ci, ctx, ",",
                "implicit" "-" "spec" "-" "LT",
         k, implicit_spec, ((void *)0));

}

static int module_procedure_name (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(kmax)-1].offset+1, ctx, t, kmax); } while (0);
  return 1;
}

static void stmt_PROCEDURE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;

  if ((!strncmp ("MODULEPROCEDURE",t,strlen("MODULEPROCEDURE"))))
    do { int _n = (15); ci += _n; t += _n; } while (0);
  else if ((!strncmp ("PROCEDURE",t,strlen("PROCEDURE"))))
    do { int _n = (9); ci += _n; t += _n; } while (0);
  else
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3300); fprintf (stderr, "Expected `MODULEPROCEDURE' or `PROCEDURE'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3300); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  k = strlen (t);
  FXTRAN_process_list (t, ci, ctx, ",",
                "module" "-" "procedure" "-" "N" "-" "LT",
         k, module_procedure_name, ((void *)0));

}

static void stmt_IFTHEN_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { int _n = (3); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("condition" "-" "E", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k-1, ctx);
  do { int _n = (k-1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}

static void stmt_WHERECONSTRUCT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { int _n = (6); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("mask" "-" "E", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k-1, ctx);
  do { int _n = (k-1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}

static int forall_triplet_spec (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  int k;
  const char * T = t;
  const char * tag;
  k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax);

  if (k == 0)
    return -1;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("forall" "-" "triplet" "-" "spec", ci->offset, ctx); } while (0);

  k = FXTRAN_eat_word (t);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("V", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax-(t-T));

  if (k == 0)
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3364); fprintf (stderr, "Expected `:'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3364); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("lower" "-" "bound", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k-1, ctx);
  do { int _n = (k-1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  do { int _n = (1); ci += _n; t += _n; } while (0);

  k = FXTRAN_str_at_level_ir (t, ci, ":", ci[0].parens, kmax-(t-T));

  if (k)
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("upper" "-" "bound", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k-1, ctx);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
      tag = "step";
    }
  else
    {
      tag = "upper" "-" "bound";
    }

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag (tag, ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, kmax-(t-T), ctx);

  do { int _n = (kmax-(t-T)); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  return 1;
}

static void stmt_forall_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack,
                 FXTRAN_xmlctx * ctx, int simple)
{
  int k;

  k = stmt_bos_named_label (t, ci, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  do { int _n = (7); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);

  k = FXTRAN_process_list (t, ci, ctx, ",",
               "forall" "-" "triplet" "-" "spec" "-" "LT",
      k-1, forall_triplet_spec, ((void *)0));

  do { int _n = (k); ci += _n; t += _n; } while (0);
  if (t[0] == ',')
    {
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = FXTRAN_str_at_level (t, ci, ")", 0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("mask" "-" "E", ci->offset, ctx); } while (0);
      FXTRAN_expr (t, ci, k-1, ctx);
      do { int _n = (k-1); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
    }

  if (simple)
    {
      do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("action" "-" "stmt", ci->offset, ctx); } while (0);
      k = strlen (t);

      FXTRAN_stmt (t, ci, stack, ctx, 0, 0);

      do { int _n = (k); ci += _n; t += _n; } while (0);
      do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
    }
}

static void stmt_FORALLCONSTRUCT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  return stmt_forall_extra (t, ci, stack, ctx, 0);

}

static void stmt_FORALL_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  return stmt_forall_extra (t, ci, stack, ctx, 1);
}

static void stmt_GOTO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (4); ci += _n; t += _n; } while (0);
  k = strlen (t);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("label", ci->offset, ctx); } while (0);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}

static int assigned_goto_label (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("label", ci->offset, ctx); } while (0);
  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}

static void stmt_ASSIGNEDGOTO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int kc, kp, k;
  do { int _n = (4); ci += _n; t += _n; } while (0);
  kp = FXTRAN_str_at_level (t, ci, "(", 0);
  kc = FXTRAN_str_at_level (t, ci, ",", 0);

  k = 0;
  if (kc > 0)
    k = kc;
  if ((kp > 0) && ((kp < k) || (k == 0)))
    k = kp;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("test" "-" "E", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k-1, ctx);
  do { int _n = (k-1); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0] == ',')
    do { int _n = (1); ci += _n; t += _n; } while (0);

  do { int _n = (1); ci += _n; t += _n; } while (0);

  k = strlen (t);

  FXTRAN_process_list (t, ci, ctx, ",",
                "label" "-" "LT",
         k, assigned_goto_label, ((void *)0));

}

static void stmt_COMPUTEDGOTO_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (5); ci += _n; t += _n; } while (0);
  k = FXTRAN_str_at_level (t, ci, ")", 0);
  FXTRAN_process_list (t, ci, ctx, ",",
                "label" "-" "LT",
         k, assigned_goto_label, ((void *)0));
  do { int _n = (k); ci += _n; t += _n; } while (0);

  if (t[0] == ',')
    do { int _n = (1); ci += _n; t += _n; } while (0);

  k = strlen (t);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("test" "-" "E", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, k, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
}

static void stmt_FORMAT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (6); ci += _n; t += _n; } while (0);
  k = strlen (t);

  FXTRAN_xml_word_tag ("format" "-" "spec",
         ci->offset, ci[k-1].offset+1, ctx);
}

static int import_name (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_word_tag_name ("N", ci->offset, ci[(kmax)-1].offset+1, ctx, t, kmax); } while (0);
  return 1;
}

static void stmt_IMPORT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (6); ci += _n; t += _n; } while (0);

  if (t[0] == 0)
    return;

  do { if (t[0] == ':') { if (t[1] == ':') { do { int _n = (2); ci += _n; t += _n; } while (0); } else { do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3542); fprintf (stderr, "Expected `::'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3542); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0); return; } } } while (0);

  k = strlen (t);
  FXTRAN_process_list (t, ci, ctx, ",",
                "import" "-" "N" "-" "LT",
         k, import_name, ((void *)0));

}

static int output_item (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("output" "-" "item", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, kmax, ctx);
  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}

static void stmt_WAIT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  do { int _n = (4); ci += _n; t += _n; } while (0);

  stmt_actual_args (t, ci, ctx, &saap_wait);

}

static void stmt_INQUIRE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (7); ci += _n; t += _n; } while (0);

  k = stmt_actual_args (t, ci, ctx, &saap_inquiry);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_process_list (t, ci, ctx, ",",
                        "output" "-" "item" "-" "LT",
      k, output_item, ((void *)0));
    }
}

static int input_item (const char * t, const FXTRAN_char_info * ci, FXTRAN_xmlctx * ctx, int kmax, void * data)
{
  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("input" "-" "item", ci->offset, ctx); } while (0);
  FXTRAN_expr (t, ci, kmax, ctx);
  do { int _n = (kmax); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);
  return 1;
}

static void stmt_READ_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (4); ci += _n; t += _n; } while (0);

  k = stmt_actual_args (t, ci, ctx, &saap_io);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_process_list (t, ci, ctx, ",",
                        "input" "-" "item" "-" "LT",
      k, input_item, ((void *)0));
    }
}

static void stmt_WRITE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (5); ci += _n; t += _n; } while (0);

  k = stmt_actual_args (t, ci, ctx, &saap_io);
  do { int _n = (k); ci += _n; t += _n; } while (0);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_process_list (t, ci, ctx, ",",
                        "output" "-" "item" "-" "LT",
      k, output_item, ((void *)0));
    }
}


static void stmt_PRINT_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (5); ci += _n; t += _n; } while (0);

  k = FXTRAN_str_at_level (t, ci, ",", 0);
  if (k == 0)
    k = strlen (t);
  else
    k = k - 1;

  do { if (FXTRAN_XML_dump) FXTRAN_xml_start_tag ("format", ci->offset, ctx); } while (0);
  if (t[0] != '*')
    FXTRAN_expr (t, ci, k, ctx);
  do { int _n = (k); ci += _n; t += _n; } while (0);
  do { if (FXTRAN_XML_dump) FXTRAN_xml_end_tag (ci[-1].offset+1, ctx); } while (0);

  if (t[0])
    {
      if (t[0] != ',')
        do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3649); fprintf (stderr, "Expected `,'"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3649); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
      do { int _n = (1); ci += _n; t += _n; } while (0);
      k = strlen (t);
      FXTRAN_process_list (t, ci, ctx, ",",
                        "output" "-" "item" "-" "LT",
      k, output_item, ((void *)0));
    }


}

static void stmt_INCLUDE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (7); ci += _n; t += _n; } while (0);
  k = strlen (t);
  FXTRAN_xml_word_tag ("filename",
         ci->offset, ci[k-1].offset+1, ctx);

}

static void stmt_RETURN_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (6); ci += _n; t += _n; } while (0);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_xml_word_tag ("return" "-" "code",
             ci->offset, ci[k-1].offset+1, ctx);
    }
}

static void stmt_STOP_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (4); ci += _n; t += _n; } while (0);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_xml_word_tag ("stop" "-" "code",
             ci->offset, ci[k-1].offset+1, ctx);
    }
}

static void stmt_PAUSE_extra (const char * t, const FXTRAN_char_info * ci, FXTRAN_stmt_stack * stack, FXTRAN_xmlctx *ctx)
{
  int k;
  do { int _n = (5); ci += _n; t += _n; } while (0);

  if (t[0])
    {
      k = strlen (t);
      FXTRAN_xml_word_tag ("stop" "-" "code",
             ci->offset, ci[k-1].offset+1, ctx);
    }
}

static void dump_ctu (int * ctu, int offset, FXTRAN_xmlctx * ctx)
{
  while ((*ctu) > 0)
    {
      FXTRAN_xml_end_tag_unsafe (offset, ctx);
      (*ctu)--;
    }
}

static void dump_otu (const char ** otu, int offset, FXTRAN_xmlctx * ctx)
{
  int i;
  for (i = 0; otu[i]; i++)
    {
      FXTRAN_xml_start_tag (otu[i], offset, ctx);
      otu[i] = ((void *)0);
    }
}

void FXTRAN_stmt (const char * text, const FXTRAN_char_info * ci,
    FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx,
    int omp, int label)
{
  int len;
  char * text1;
  FXTRAN_char_info * ci1;
  const int ncharmargin = 32;

  len = strlen (text);


  text1 = (char*)malloc (len+1+ncharmargin);
  do { FXTRAN_char_info * _ci; int i; _ci = (FXTRAN_char_info*)malloc (((len)+1) * sizeof (FXTRAN_char_info)); memset (_ci, '\0', ((len)+1) * sizeof (FXTRAN_char_info)); for (i = 0; i < (len); i++) _ci[i].mask = FXTRAN_SPC; *(&ci1) = _ci; } while (0);

  memset (&text1[len], '\0', ncharmargin);

  len = FXTRAN_restrict_tci (text1, ci1, text, ci, len);




  FXTRAN_set_char_info_dop (text1, ci1);



  if (FXTRAN_check_dpb (text1, ci1, len))
    do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3755); fprintf (stderr, "Unbalanced parens or dots in `%s'\n", text); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3755); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);

  if (omp == 2)
    {
      FXTRAN_dump_ompd (text1, ci1, ctx);
    }
  else
    {
      FXTRAN_stmt_type type;
      int expect_pu;
      const char * str;
      xml_tu tu;

      memset (&tu, '\0', sizeof (tu));

      type = get_FXTRAN_stmt_type (text1, ci1, stack, ctx, &expect_pu, &tu);

      stmt_block_handle (text1, type, expect_pu, label, stack, ctx, &tu);

      str = type == FXTRAN_NONE ? "broken" "-" "stmt" : stmt_as_str (type);

      if (tu.xml_ctu1)
        dump_ctu (&tu.xml_ctu1, ci1->offset, ctx);

      dump_otu (tu.xml_otu1, ci1->offset, ctx);

      FXTRAN_xml_start_tag (str, ci1->offset, ctx);

      switch (type)
        {



            case FXTRAN_ARITHMETICIF: stmt_ARITHMETICIF_extra(text1, ci1, stack, ctx); break; case FXTRAN_ASSIGNEDGOTO: stmt_ASSIGNEDGOTO_extra(text1, ci1, stack, ctx); break; case FXTRAN_COMPONENTDECL: stmt_COMPONENTDECL_extra(text1, ci1, stack, ctx); break; case FXTRAN_POINTERASSIGNMENT: stmt_POINTERASSIGNMENT_extra(text1, ci1, stack, ctx); break; case FXTRAN_ASSIGNMENT: stmt_ASSIGNMENT_extra(text1, ci1, stack, ctx); break; case FXTRAN_ASSOCIATE: stmt_ASSOCIATE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ASYNCHRONOUS: stmt_ASYNCHRONOUS_extra(text1, ci1, stack, ctx); break; case FXTRAN_IF: stmt_IF_extra(text1, ci1, stack, ctx); break; case FXTRAN_FORALL: stmt_FORALL_extra(text1, ci1, stack, ctx); break; case FXTRAN_ALLOCATABLE: stmt_ALLOCATABLE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ALLOCATE: stmt_ALLOCATE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ASSIGN: stmt_ASSIGN_extra(text1, ci1, stack, ctx); break; case FXTRAN_BACKSPACE: stmt_BACKSPACE_extra(text1, ci1, stack, ctx); break; case FXTRAN_BIND: stmt_BIND_extra(text1, ci1, stack, ctx); break; case FXTRAN_BLOCKDATA: stmt_BLOCKDATA_extra(text1, ci1, stack, ctx); break; case FXTRAN_CALL: stmt_CALL_extra(text1, ci1, stack, ctx); break; case FXTRAN_CASE: stmt_CASE_extra(text1, ci1, stack, ctx); break; case FXTRAN_CLASS: stmt_CLASS_extra(text1, ci1, stack, ctx); break; case FXTRAN_CLASSIS: stmt_CLASSIS_extra(text1, ci1, stack, ctx); break; case FXTRAN_CLOSE: stmt_CLOSE_extra(text1, ci1, stack, ctx); break; case FXTRAN_COMMON: stmt_COMMON_extra(text1, ci1, stack, ctx); break; case FXTRAN_COMPUTEDGOTO: stmt_COMPUTEDGOTO_extra(text1, ci1, stack, ctx); break; case FXTRAN_CONTAINS: stmt_CONTAINS_extra(text1, ci1, stack, ctx); break; case FXTRAN_CONTINUE: stmt_CONTINUE_extra(text1, ci1, stack, ctx); break; case FXTRAN_CYCLE: stmt_CYCLE_extra(text1, ci1, stack, ctx); break; case FXTRAN_TYPEDECL: stmt_TYPEDECL_extra(text1, ci1, stack, ctx); break; case FXTRAN_DATA: stmt_DATA_extra(text1, ci1, stack, ctx); break; case FXTRAN_DEALLOCATE: stmt_DEALLOCATE_extra(text1, ci1, stack, ctx); break; case FXTRAN_DIMENSION: stmt_DIMENSION_extra(text1, ci1, stack, ctx); break; case FXTRAN_DO: stmt_DO_extra(text1, ci1, stack, ctx); break; case FXTRAN_DOLABEL: stmt_DOLABEL_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDASSOCIATE: stmt_ENDASSOCIATE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDBLOCKDATA: stmt_ENDBLOCKDATA_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDCLASS: stmt_ENDCLASS_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDDO: stmt_ENDDO_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDFORALL: stmt_ENDFORALL_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDFUNCTION: stmt_ENDFUNCTION_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDINTERFACE: stmt_ENDINTERFACE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDMODULE: stmt_ENDMODULE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDPROGRAM: stmt_ENDPROGRAM_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDSELECTCASE: stmt_ENDSELECTCASE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDSELECTTYPE: stmt_ENDSELECTTYPE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDSUBROUTINE: stmt_ENDSUBROUTINE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDTYPE: stmt_ENDTYPE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDWHERE: stmt_ENDWHERE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDFILE: stmt_ENDFILE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ELSEIF: stmt_ELSEIF_extra(text1, ci1, stack, ctx); break; case FXTRAN_ELSE: stmt_ELSE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ELSEWHERE: stmt_ELSEWHERE_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDIF: stmt_ENDIF_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENTRY: stmt_ENTRY_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENDENUM: stmt_ENDENUM_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENUM: stmt_ENUM_extra(text1, ci1, stack, ctx); break; case FXTRAN_ENUMERATOR: stmt_ENUMERATOR_extra(text1, ci1, stack, ctx); break; case FXTRAN_EQUIVALENCE: stmt_EQUIVALENCE_extra(text1, ci1, stack, ctx); break; case FXTRAN_EXIT: stmt_EXIT_extra(text1, ci1, stack, ctx); break; case FXTRAN_EXTERNAL: stmt_EXTERNAL_extra(text1, ci1, stack, ctx); break; case FXTRAN_FINAL: stmt_FINAL_extra(text1, ci1, stack, ctx); break; case FXTRAN_FLUSH: stmt_FLUSH_extra(text1, ci1, stack, ctx); break; case FXTRAN_FORALLCONSTRUCT: stmt_FORALLCONSTRUCT_extra(text1, ci1, stack, ctx); break; case FXTRAN_FORMAT: stmt_FORMAT_extra(text1, ci1, stack, ctx); break; case FXTRAN_FUNCTION: stmt_FUNCTION_extra(text1, ci1, stack, ctx); break; case FXTRAN_GENERIC: stmt_GENERIC_extra(text1, ci1, stack, ctx); break; case FXTRAN_GOTO: stmt_GOTO_extra(text1, ci1, stack, ctx); break; case FXTRAN_IFTHEN: stmt_IFTHEN_extra(text1, ci1, stack, ctx); break; case FXTRAN_IMPLICITNONE: stmt_IMPLICITNONE_extra(text1, ci1, stack, ctx); break; case FXTRAN_IMPLICIT: stmt_IMPLICIT_extra(text1, ci1, stack, ctx); break; case FXTRAN_IMPORT: stmt_IMPORT_extra(text1, ci1, stack, ctx); break; case FXTRAN_INCLUDE: stmt_INCLUDE_extra(text1, ci1, stack, ctx); break; case FXTRAN_INQUIRE: stmt_INQUIRE_extra(text1, ci1, stack, ctx); break; case FXTRAN_INTENT: stmt_INTENT_extra(text1, ci1, stack, ctx); break; case FXTRAN_INTERFACE: stmt_INTERFACE_extra(text1, ci1, stack, ctx); break; case FXTRAN_INTRINSIC: stmt_INTRINSIC_extra(text1, ci1, stack, ctx); break; case FXTRAN_PROCEDURE: stmt_PROCEDURE_extra(text1, ci1, stack, ctx); break; case FXTRAN_MODULE: stmt_MODULE_extra(text1, ci1, stack, ctx); break; case FXTRAN_NAMELIST: stmt_NAMELIST_extra(text1, ci1, stack, ctx); break; case FXTRAN_NULLIFY: stmt_NULLIFY_extra(text1, ci1, stack, ctx); break; case FXTRAN_OPEN: stmt_OPEN_extra(text1, ci1, stack, ctx); break; case FXTRAN_OPTIONAL: stmt_OPTIONAL_extra(text1, ci1, stack, ctx); break; case FXTRAN_PAUSE: stmt_PAUSE_extra(text1, ci1, stack, ctx); break; case FXTRAN_PARAMETER: stmt_PARAMETER_extra(text1, ci1, stack, ctx); break; case FXTRAN_CRAYPOINTER: stmt_CRAYPOINTER_extra(text1, ci1, stack, ctx); break; case FXTRAN_POINTER: stmt_POINTER_extra(text1, ci1, stack, ctx); break; case FXTRAN_PROGRAM: stmt_PROGRAM_extra(text1, ci1, stack, ctx); break; case FXTRAN_PRINT: stmt_PRINT_extra(text1, ci1, stack, ctx); break; case FXTRAN_PRIVATE: stmt_PRIVATE_extra(text1, ci1, stack, ctx); break; case FXTRAN_PROTECTED: stmt_PROTECTED_extra(text1, ci1, stack, ctx); break; case FXTRAN_PUBLIC: stmt_PUBLIC_extra(text1, ci1, stack, ctx); break; case FXTRAN_READ: stmt_READ_extra(text1, ci1, stack, ctx); break; case FXTRAN_RETURN: stmt_RETURN_extra(text1, ci1, stack, ctx); break; case FXTRAN_REWIND: stmt_REWIND_extra(text1, ci1, stack, ctx); break; case FXTRAN_SAVE: stmt_SAVE_extra(text1, ci1, stack, ctx); break; case FXTRAN_SELECTCASE: stmt_SELECTCASE_extra(text1, ci1, stack, ctx); break; case FXTRAN_SELECTTYPE: stmt_SELECTTYPE_extra(text1, ci1, stack, ctx); break; case FXTRAN_SEQUENCE: stmt_SEQUENCE_extra(text1, ci1, stack, ctx); break; case FXTRAN_STOP: stmt_STOP_extra(text1, ci1, stack, ctx); break; case FXTRAN_SUBROUTINE: stmt_SUBROUTINE_extra(text1, ci1, stack, ctx); break; case FXTRAN_TARGET: stmt_TARGET_extra(text1, ci1, stack, ctx); break; case FXTRAN_TYPE: stmt_TYPE_extra(text1, ci1, stack, ctx); break; case FXTRAN_TYPEIS: stmt_TYPEIS_extra(text1, ci1, stack, ctx); break; case FXTRAN_USE: stmt_USE_extra(text1, ci1, stack, ctx); break; case FXTRAN_VALUE: stmt_VALUE_extra(text1, ci1, stack, ctx); break; case FXTRAN_VOLATILE: stmt_VOLATILE_extra(text1, ci1, stack, ctx); break; case FXTRAN_WAIT: stmt_WAIT_extra(text1, ci1, stack, ctx); break; case FXTRAN_WHERE: stmt_WHERE_extra(text1, ci1, stack, ctx); break; case FXTRAN_WHERECONSTRUCT: stmt_WHERECONSTRUCT_extra(text1, ci1, stack, ctx); break; case FXTRAN_WRITE: stmt_WRITE_extra(text1, ci1, stack, ctx); break;



          default:
          break;
        }

      FXTRAN_xml_end_tag (ci1[len-1].offset+1, ctx);

      if (tu.xml_ctu2)
        dump_ctu (&tu.xml_ctu2, ci1[len-1].offset+1, ctx);
      dump_otu (tu.xml_otu2, ci1[len-1].offset+1, ctx);

    }


  free (text1);
  do { free (*(&ci1)); *(&ci1) = ((void *)0); } while (0);

}

void FXTRAN_dump_fc_stmt (const char * text, const FXTRAN_char_info * ci, int i1, int i2,
            FXTRAN_xmlctx * ctx, FXTRAN_stmt_stack * stack, int label)
{
  char * t;
  FXTRAN_char_info * ci1;
  int i, j;
  int I1 = -1, I2 = -1;
  int omp;

  t = (char*)malloc (i2-i1+2);
  do { FXTRAN_char_info * _ci; int i; _ci = (FXTRAN_char_info*)malloc (((i2-i1+2)+1) * sizeof (FXTRAN_char_info)); memset (_ci, '\0', ((i2-i1+2)+1) * sizeof (FXTRAN_char_info)); for (i = 0; i < (i2-i1+2); i++) _ci[i].mask = FXTRAN_SPC; *(&ci1) = _ci; } while (0);


  for (i = i1, j = 0; i < i2+1; i++)
    if ((ci[i].mask == FXTRAN_COD) || (ci[i].mask == FXTRAN_STR))
      {
        if (I1 < 0)
          I1 = i;
 I2 = i;

        ci1[j] = ci[i];
        t[j] = text[i];
 j++;
      }

  t[j] = 0;

  omp = FXTRAN_check_omp (text, ci, I1, I2, ctx);

  FXTRAN_stmt (t, ci1, stack, ctx, omp, label);

  do { free (*(&ci1)); *(&ci1) = ((void *)0); } while (0);
  free (t);
}


void FXTRAN_stmt_stack_init (FXTRAN_stmt_stack * stack)
{
  memset (stack, 0, sizeof (*stack));
  stack->lev = -1;
}

FXTRAN_stmt_stack_state * FXTRAN_stmt_stack_curr (FXTRAN_stmt_stack * stack)
{
  return ((stack->lev >= 0) && FXTRAN_stmt_stack_ok(stack))
       ? &((stack)->state[(stack)->lev]) : ((void *)0);
}

void FXTRAN_stmt_stack_incr (FXTRAN_stmt_stack * stack, FXTRAN_stmt_type t)
{

  if (FXTRAN_stmt_stack_ok(stack))
    {
      ++(stack)->lev;
      memset (&((stack)->state[(stack)->lev]), '\0', sizeof (FXTRAN_stmt_stack_state));
      (stack)->state[(stack)->lev].type = t;
    }
}

void FXTRAN_stmt_stack_decr (FXTRAN_stmt_stack * stack)
{
  if (FXTRAN_stmt_stack_ok(stack))
    {
# 3883 "FXTRAN_STMT.c"
      (stack)->lev--;
    }
}

void FXTRAN_stmt_stack_break (FXTRAN_stmt_stack * stack, FXTRAN_xmlctx * ctx)
{
  (stack)->broken = 1;
  do { fprintf (stderr, "\n%s\n", ctx->fb.cur - ctx->fb.str > 100 ? ctx->fb.cur - 100 : ctx->fb.str); fprintf (stderr, "At ""FXTRAN_STMT.c"":%d\n", 3890); fprintf (stderr, "Unexpected statement"); fprintf (stderr, "\n"); if (ctx->opts.gdb) FXTRAN_save_where ("FXTRAN_STMT.c", 3890); FXTRAN_XML_print_section (ctx->text, ctx->ci, ctx->pos, 3); exit (1); } while (0);
}

int FXTRAN_stmt_stack_ok (FXTRAN_stmt_stack * stack)
{
  return stack->broken == 0;
}

int FXTRAN_stmt_in (FXTRAN_stmt_stack * stack, FXTRAN_stmt_type t)
{
  return FXTRAN_stmt_stack_curr (stack)
       ? FXTRAN_stmt_stack_curr (stack)->type == t : 0;
}
