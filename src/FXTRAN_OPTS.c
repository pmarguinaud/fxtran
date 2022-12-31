/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#include "FXTRAN_OPTS.h"
#include "FXTRAN_GDB.h"
#include "FXTRAN_ERROR.h"
#include "FXTRAN_XML.h"
#include "FXTRAN_FBUFFER.h"

#include <string.h>


#define FXTRAN_handle_flag(opt, var, doc) \
  if (help)                                                         \
    FXTRAN_FBUFFER_printf (&ctx->fb, " -%-40s : F : %s\n",          \
                           #opt, #doc);                             \
  else if (help_xml)                                                \
    FXTRAN_FBUFFER_printf (&ctx->fb,                                \
    "<option><name>%s</name><type>%s</type>"                        \
    "<help>%s</help></option>\n", #opt, "FLAG", #doc);              \
  else if (help_pod)                                                \
    FXTRAN_FBUFFER_printf (&ctx->fb,                                \
    "=item C<-%s>\n\n\nType : %s\n\n%s\n\n", #opt, "FLAG", #doc);   \
  else if (strcmp (argv[i], "-"#opt) == 0)                          \
    {                                                               \
      opts->var++;                                                  \
      i++;                                                          \
      continue;                                                     \
    }  

#define FXTRAN_handle_charopt(opt, var, doc) \
  if (help)                                                         \
    FXTRAN_FBUFFER_printf (&ctx->fb, " -%-40s : S : %s\n",          \
                           #opt, #doc);                             \
  else if (help_xml)                                                \
    FXTRAN_FBUFFER_printf (&ctx->fb,                                \
    "<option><name>%s</name><type>%s</type>"                        \
    "<help>%s</help></option>\n", #opt, "STRING", #doc);            \
  else if (help_pod)                                                \
    FXTRAN_FBUFFER_printf (&ctx->fb,                                \
    "=item C<-%s>\n\n\nType : %s\n\n%s\n\n", #opt, "STRING", #doc); \
  else if (strcmp (argv[i], "-"#opt) == 0)                          \
    {                                                               \
      if (i+1 < argc)                                               \
        {                                                           \
          opts->var = strdup (argv[i+1]);                           \
          i += 2;                                                   \
          continue;                                                 \
        }                                                           \
      else                                                          \
        FXTRAN_THROW ("Option `%s' "                                \
       "requires an argument", argv[i]);                            \
    }

#define FXTRAN_handle_intopt(opt, var, doc) \
  if (help)                                                         \
    FXTRAN_FBUFFER_printf (&ctx->fb, " -%-40s : I : %s\n",          \
                           #opt, #doc);                             \
  else if (help_xml)                                                \
    FXTRAN_FBUFFER_printf (&ctx->fb,                                \
    "<option><name>%s</name><type>%s</type>"                        \
    "<help>%s</help></option>\n", #opt, "INTEGER", #doc);           \
  else if (help_pod)                                                \
    FXTRAN_FBUFFER_printf (&ctx->fb,                                \
    "=item C<-%s>\n\n\nType : %s\n\n%s\n\n", #opt, "INTEGER", #doc);\
  else if (strcmp (argv[i], "-"#opt) == 0)                          \
    {                                                               \
      if (i+1 < argc)                                               \
        {                                                           \
          opts->var = atoi (argv[i+1]);                             \
          i += 2;                                                   \
          continue;                                                 \
        }                                                           \
      else                                                          \
        FXTRAN_THROW ("Option `%s' "                                \
       "requires an argument", argv[i]);                            \
    }

static char ** push (char ** list, char * s)
{
  int len;
  for (len = 0; list[len]; len++);
  list = (char**)realloc (list, sizeof (char*) * (len + 2));
  list[len] = strdup (s);
  list[len+1] = NULL;
  return list;
}

static int FXTRAN_parse_opts0 (FXTRAN_xmlctx * ctx, FXTRAN_opts * opts, 
		               int argc, char * argv[], int help, int help_xml, int help_pod)
{
  int len;
  int i;

  if (help_xml)
    FXTRAN_FBUFFER_printf (&ctx->fb, "<?xml version=\"1.0\"?><fxtran-options>");

  if (help_pod)
    FXTRAN_FBUFFER_printf (&ctx->fb, "%s",
"=head1 NAME\n"
"\n"
"fxtran - Parse FORTRAN source code into XML documents\n"
"\n"
"=head1 SYNOPSYS\n"
"\n"
"  fxtran [OPTION].. file.F90\n"
"\n"
"=head1 DESCRIPTION\n"
"\n"
"Parse Fortran source code. Decorate source code with XML tags. The result is  \n"
"an XML file which you can search with XPath, modify with the DOM API. \n"
"Round tripping is supported : get back your original or modified source code \n"
"just by stripping XML tags.  Provided under the terms of the GNU GPL license.\n"
"\n"
"=head1 OPTIONS\n"
"\n"
"=over 4\n"
"\n"
  );



  memset (opts, '\0', sizeof (FXTRAN_opts));

  opts->includes = (char**)calloc (1, sizeof (char*));
  opts->defines  = (char**)calloc (1, sizeof (char*));
  opts->line_length = -1;
  opts->argc = argc;
  opts->argv = argv;


  for (i = 1; i < argc; )
    {

      FXTRAN_handle_flag (namelist, namelist, Parse Fortran namelist);
      FXTRAN_handle_flag (namelist-diff, namelist_diff, Allow diff namelist);
      FXTRAN_handle_flag (openmp, openmp, Handle OpenMP directives);
      FXTRAN_handle_flag (openacc, openacc, Handle OpenACC directives);
      FXTRAN_handle_flag (cpp, cpp, Preprocess source code);
      FXTRAN_handle_flag (no-cpp, nocpp, Do not preprocess source code);
      FXTRAN_handle_flag (no-include, noinclude, Do not handle include lines);
      FXTRAN_handle_flag (gdb, gdb, Start gdb if program fails);
      FXTRAN_handle_flag (debugL, debugL, );
      FXTRAN_handle_flag (flat-op-expr, flat_op_expr, Flatten op exprs);
      FXTRAN_handle_flag (flat-expr, flat_expr, Flatten all expr);
      FXTRAN_handle_flag (show-lines, show_lines, Show beginning of lines tags);
      FXTRAN_handle_flag (strip-executable-statements, strip_exec, Strip executable statements);
      FXTRAN_handle_flag (strip, strip, Strip comments + multiple linefeeds + spaces);
      FXTRAN_handle_flag (strip-comments, strip_comments, Strip comments);
      FXTRAN_handle_flag (strip-linefeed, strip_linefeed, Strip multiple linefeeds);
      FXTRAN_handle_flag (strip-continue, strip_continue, Strip continuation lines);
      FXTRAN_handle_flag (strip-spaces, strip_spaces, Strip spaces);
      FXTRAN_handle_flag (canonic, canonic, Canonic form : uppercase + no spaces)
      FXTRAN_handle_flag (uppercase, uppercase, Turn all language and identifiers into uppercase);
      FXTRAN_handle_flag (code-tag, code_tag, Add a tag for source code);
      FXTRAN_handle_flag (name-attr, name_attr, Add an attribute for N tags);
      FXTRAN_handle_flag (construct-tag, construct_tag, Display program units and constructs);
      FXTRAN_handle_flag (cray-pointer, cray_pointer, Allow Cray pointers);
      FXTRAN_handle_flag (dump-mask, dump_mask, Print character mask and exit);
      FXTRAN_handle_flag (dump-stmt-list, dump_stmt_list, Dump statement list);
      FXTRAN_handle_flag (help, help, Print help message);
      FXTRAN_handle_flag (help-xml, help_xml, Print help message in XML format);
      FXTRAN_handle_flag (help-pod, help_pod, Print help message in POD format);

      if (opts->canonic)
        {
          opts->strip = 1;
          opts->uppercase = 1;
        }

      opts->strip_comments = opts->strip_comments || opts->strip;
      opts->strip_linefeed = opts->strip_linefeed || opts->strip;
      opts->strip_continue = opts->strip_continue || opts->strip;
      opts->strip_spaces   = opts->strip_spaces   || opts->strip;

      FXTRAN_handle_charopt (xml-stylesheet, xml_stylesheet, Path to XML stylesheet);
      FXTRAN_handle_charopt (directive, directive, Directive name);
      FXTRAN_handle_charopt (o, xfile, Output file);
      FXTRAN_handle_intopt (line-length, line_length, Set source code line length);

      if (opts->directive)
        {
          opts->directive_ln = strlen (opts->directive) + 2;
          opts->directive_st = (char *)malloc (opts->directive_ln + 1); 
          strcpy (opts->directive_st, "$");
          strcat (opts->directive_st, opts->directive); 
          strcat (opts->directive_st, " ");
          opts->directive_ct = (char *)malloc (opts->directive_ln + 1); 
          strcpy (opts->directive_ct, "$");
          strcat (opts->directive_ct, opts->directive); 
          strcat (opts->directive_ct, "&");
        }

      if (help_xml)
        FXTRAN_FBUFFER_printf (&ctx->fb, "</fxtran-options>");

      if (help_pod)
        FXTRAN_FBUFFER_printf (&ctx->fb, "%s",
"\n"
"=back\n"
"\n"
"=head1 AUTHOR\n"
"\n"
"Philippe Marguinaud pmarguinaud@hotmail.com\n"
"\n"
"=head1 SEE ALSO\n"
"\n"
"https://github.com/pmarguinaud/fxtran\n"
"\n"
"https://www.iso.org/standard/72320.html\n"
"\n"
"=cut\n"
        );

      if (help || help_xml || help_pod)
        return 0;

      if ((strcmp (argv[i], "-I") == 0) && (i+1 < argc))
        {
	  opts->includes = push (opts->includes, argv[i+1]);
          i += 2;                        
          continue;                      
        }

      if (strncmp (argv[i], "-I", 2) == 0)
        {
	  opts->includes = push (opts->includes, argv[i]+2);
          i++;
          continue;                      
        }

      if ((strncmp (argv[i], "-D", 2) == 0) || (strncmp (argv[i], "-U", 2) == 0))
        {
	  opts->defines = push (opts->defines, argv[i]);
          i++;
          continue;                      
        }

      if (opts->ffile == NULL)
        {
          opts->ffile = strdup (argv[i]);
          i++;
          continue;
        }

      if (opts->xfile == NULL)
        {
          opts->xfile = strdup (argv[i]);
          i++;
          continue;
	}

      FXTRAN_THROW ("Unknown parameter `%s'", argv[i]);

    }

  if (opts->namelist_diff)
    opts->namelist = 1;

  if (opts->dump_stmt_list)
    return 0;

  if (help || help_xml || help_pod)
    return 0;

  if (opts->help || opts->help_xml || opts->help_pod)
    return 0;

  if (opts->gdb)
    FXTRAN_save_args (argc, argv);

/* Check arguments */

  if (opts->ffile == NULL)
    FXTRAN_THROW ("No input file");
    
  if (opts->nocpp && opts->cpp)
    FXTRAN_THROW ("Cannot handle both -cpp and -noccp");
    


  len = strlen (opts->ffile);
  if (opts->xfile == NULL)
    {
      opts->xfile = (char*) malloc (len+5);
      strcpy (opts->xfile, opts->ffile);
      strcat (opts->xfile, ".xml");
    }

/* Guess form, text width and cpp */
  if ((opts->form == FXTRAN_FORM_NONE) && (! opts->namelist))
    {
      struct 
      {
        const char * ext;
        int form;
	int cpp;
      } ext2form[] = 
      {
        { ".f90", FXTRAN_FORM_FREE,  0 },
        { ".F90", FXTRAN_FORM_FREE,  1 },
        { ".f95", FXTRAN_FORM_FREE,  0 },
        { ".F95", FXTRAN_FORM_FREE,  1 },
        { ".f03", FXTRAN_FORM_FREE,  0 },
        { ".F03", FXTRAN_FORM_FREE,  1 },
        { ".f08", FXTRAN_FORM_FREE,  0 },
        { ".F08", FXTRAN_FORM_FREE,  1 },
        { ".f",   FXTRAN_FORM_FIXED, 0 },
        { ".F",   FXTRAN_FORM_FIXED, 1 },
        { ".FOR", FXTRAN_FORM_FIXED, 1 },
        { ".FTN", FXTRAN_FORM_FIXED, 1 },
        { NULL,   FXTRAN_FORM_NONE,  0 }
      };


      int i;

      for (i = 0; ext2form[i].ext; i++)
        {
          int k = strlen (ext2form[i].ext);
          if (strcmp (ext2form[i].ext, &opts->ffile[len-k]) == 0)
            {
              opts->form = ext2form[i].form;
              opts->cpp  = ext2form[i].cpp;
	      if (opts->line_length < 0)
                opts->line_length = ext2form[i].form == FXTRAN_FORM_FREE ? 132 : 72;
              goto form_found;
            }
	}

      FXTRAN_THROW ("Unknown source form");
    }

form_found:

  if (opts->nocpp)
    opts->cpp = 0;

  if (opts->namelist)
    opts->cpp = 0;

  if (opts->noinclude)
    {
      free (opts->includes);
      opts->includes = (char**)calloc (1, sizeof (char*));
      opts->includes = push (opts->includes, "");
    }

  return 0;

}

int FXTRAN_parse_opts (FXTRAN_xmlctx * ctx, int argc, char * argv[])
{
  return FXTRAN_parse_opts0 (ctx, &ctx->opts, argc, argv, 0, 0, 0);
}

void FXTRAN_free_opts0 (FXTRAN_xmlctx * ctx, FXTRAN_opts * opts)
{
  if (opts->xml_stylesheet)
    free (opts->xml_stylesheet);

  if (opts->ffile)
    free (opts->ffile);

  if (opts->xfile)
    free (opts->xfile);

  if (opts->includes)
    {
      int i;
      for (i = 0; opts->includes[i]; i++)
        free (opts->includes[i]);
      free (opts->includes);
    }

  if (opts->defines)
    {
      int i;
      for (i = 0; opts->defines[i]; i++)
        free (opts->defines[i]);
      free (opts->defines);
    }
}

void FXTRAN_free_opts (FXTRAN_xmlctx * ctx)
{
  FXTRAN_free_opts0 (ctx, &ctx->opts);
}

void FXTRAN_help_opts (FXTRAN_xmlctx * ctx)
{
  FXTRAN_opts opts;
  FXTRAN_parse_opts0 (ctx, &opts, 2, NULL, ctx->opts.help, ctx->opts.help_xml, ctx->opts.help_pod);
  FXTRAN_free_opts0 (ctx, &opts);
}


