#include <Python.h>
#include <stdlib.h>
#include "FXTRAN/RUN.h"

/*
 * Only the stable ABI of Python 3.6 is used (Py_LIMITED_API is set by
 * setup.py), so that one wheel works with all the versions of Python 3.
 */

static PyObject * fxtran_Error = NULL;

/*
 * The C strings of the items of the sequence seq, encoded in UTF-8, in
 * argv[first], ..., argv[first+n-1] (n is the length of seq). The bytes
 * objects that hold them are put in *pbytes, to be released with free_args.
 * Return -1 with an exception set on failure.
 */
static int get_args (PyObject * seq, char ** argv, Py_ssize_t first, PyObject *** pbytes, Py_ssize_t * pn)
{
  Py_ssize_t n = PySequence_Size (seq), i;
  PyObject ** bytes;

  *pbytes = NULL;
  *pn = 0;

  if (n < 0)
    return -1;

  bytes = PyMem_New (PyObject *, n > 0 ? n : 1);
  if (bytes == NULL)
    {
      PyErr_NoMemory ();
      return -1;
    }
  *pbytes = bytes;

  for (i = 0; i < n; i++)
    {
      PyObject * item, * str;

      item = PySequence_GetItem (seq, i);
      if (item == NULL)
        return -1;
      str = PyObject_Str (item);
      Py_DECREF (item);
      if (str == NULL)
        return -1;
      bytes[i] = PyUnicode_AsUTF8String (str);
      Py_DECREF (str);
      if (bytes[i] == NULL)
        return -1;
      (*pn)++;

      argv[first+i] = PyBytes_AsString (bytes[i]);
      if (argv[first+i] == NULL)
        return -1;
    }

  return 0;
}

static void free_args (PyObject ** bytes, Py_ssize_t n)
{
  Py_ssize_t i;
  for (i = 0; i < n; i++)
    Py_DECREF (bytes[i]);
  PyMem_Free (bytes);
}

/*
 * run (option, ..., text): parse the Fortran source text with fxtran and the
 * given command line options, and return the XML as a str. Errors of fxtran
 * raise _fxtran.error.
 *
 * The GIL is kept while fxtran runs: FXTRAN_RUN changes the stack limit of the
 * process and the embedded preprocessor has global state, so two parses must
 * not run at the same time.
 */
static PyObject * run (PyObject * self, PyObject * args)
{
  Py_ssize_t items = PyTuple_Size (args);
  Py_ssize_t nbytes = 0;
  int argc;
  char ** argv = NULL;
  char * Text = NULL, * Xml = NULL, * Err = NULL;
  PyObject ** bytes = NULL, * ret = NULL;

  if (items < 1)
    {
      PyErr_SetString (PyExc_TypeError, "run() takes the source text as last argument");
      return NULL;
    }

  if (items > INT_MAX - 2)
    {
      PyErr_SetString (PyExc_OverflowError, "too many arguments");
      return NULL;
    }

  /* argv: program name, options, text, then a file name that sets the free form;
     the text is taken out of argv below */
  argc = (int)items + 1;
  argv = PyMem_New (char *, argc + 1);
  if (argv == NULL)
    {
      PyErr_NoMemory ();
      goto done;
    }

  argv[0] = "";
  if (get_args (args, argv, 1, &bytes, &nbytes) < 0)
    goto done;
  Text = argv[items];
  argv[argc-1] = "_.F90";
  argv[argc] = NULL;

  FXTRAN_RUN (argc, argv, Text, &Xml, &Err);

  if (Err)
    {
      PyObject * err = PyUnicode_DecodeUTF8 (Err, strlen (Err), "replace");
      if (err != NULL)
        {
          PyErr_SetObject (fxtran_Error, err);
          Py_DECREF (err);
        }
    }
  else if (Xml)
    {
      ret = PyUnicode_DecodeUTF8 (Xml, strlen (Xml), "strict");
    }
  else
    {
      PyErr_SetString (fxtran_Error, "fxtran returned no output");
    }

done:
  free (Xml);
  free (Err);
  free_args (bytes, nbytes);
  PyMem_Free (argv);

  return ret;
}

/*
 * main (argv): run fxtran as the fxtran command, with the arguments of the
 * sequence argv (argv[0] is the program name): files are read and written,
 * errors are printed on stderr. Return the exit status.
 */
static PyObject * main_ (PyObject * self, PyObject * args)
{
  PyObject * seq = NULL, ** bytes = NULL, * ret = NULL;
  Py_ssize_t items, nbytes = 0;
  char ** argv = NULL;
  int status;

  if (! PyArg_ParseTuple (args, "O", &seq))
    return NULL;

  items = PySequence_Size (seq);
  if (items < 0)
    return NULL;

  if ((items < 1) || (items > INT_MAX - 1))
    {
      PyErr_SetString (PyExc_ValueError, "main() takes the program name and the arguments");
      return NULL;
    }

  argv = PyMem_New (char *, items + 1);
  if (argv == NULL)
    {
      PyErr_NoMemory ();
      goto done;
    }

  if (get_args (seq, argv, 0, &bytes, &nbytes) < 0)
    goto done;
  argv[items] = NULL;

  status = FXTRAN_RUN ((int)items, argv, NULL, NULL, NULL);

  /* fxtran writes with the stdio of C, not with sys.stdout */
  fflush (stdout);
  fflush (stderr);

  ret = PyLong_FromLong (status ? 1 : 0);

done:
  free_args (bytes, nbytes);
  PyMem_Free (argv);

  return ret;
}

static PyMethodDef fxtran_Methods[] =
{
  {"run", run, METH_VARARGS,
   "run(option, ..., text): parse Fortran source text and return the XML"},
  {"main", main_, METH_VARARGS,
   "main(argv): run fxtran as the fxtran command; return the exit status"},
  {NULL,  NULL, 0, NULL}
};

static struct PyModuleDef fxtran_Module =
{
  PyModuleDef_HEAD_INIT,
  "_fxtran",
  "Low level interface to the fxtran Fortran parser",
  -1,
  fxtran_Methods
};

PyMODINIT_FUNC
PyInit__fxtran (void)
{
  PyObject * m = PyModule_Create (&fxtran_Module);

  if (m == NULL)
    return NULL;

  fxtran_Error = PyErr_NewException ("_fxtran.error", NULL, NULL);
  if (fxtran_Error == NULL)
    {
      Py_DECREF (m);
      return NULL;
    }

  /* One reference for the module (stolen), one for fxtran_Error */
  Py_INCREF (fxtran_Error);
  if (PyModule_AddObject (m, "error", fxtran_Error) < 0)
    {
      Py_DECREF (fxtran_Error);
      Py_CLEAR (fxtran_Error);
      Py_DECREF (m);
      return NULL;
    }

  return m;
}
