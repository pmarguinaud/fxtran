/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_OPTS_H
#define _FXTRAN_OPTS_H


typedef struct FXTRAN_opts
{
  int namelist;
  int namelist_diff;
  int openmp;
  int openacc;
  char * directive;
  char * directive_st;
  char * directive_ct;
  int directive_ln;
  int flat_expr;
  int flat_op_expr;
  int show_lines;
  char * xml_stylesheet;
  int code_tag;
  int name_attr;
  int construct_tag;
  int cray_pointer;
  int help;
  int help_xml;
  int help_pod;
  int strip_exec;
  int strip;
  int strip_comments;
  int strip_linefeed;
  int strip_continue;
  int strip_spaces;
  int canonic;
  int uppercase;
  int dump_mask;
  int dump_stmt_list;

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


#endif
