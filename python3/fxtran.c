#include <Python.h>
#include <stdlib.h>
#include "FXTRAN/RUN.h"

static PyObject * fxtran_Error = NULL;

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
  Py_ssize_t i, nstr = 0;
  int argc;
  char ** argv = NULL;
  char * Text = NULL, * Xml = NULL, * Err = NULL;
  PyObject ** str = NULL, * ret = NULL;

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

  /* argv: program name, options, then a file name that sets the free form */
  argc = (int)items + 1;
  argv = PyMem_New (char *, argc);
  str  = PyMem_New (PyObject *, items);
  if ((argv == NULL) || (str == NULL))
    {
      PyErr_NoMemory ();
      goto done;
    }

  argv[0] = "";
  for (i = 0; i < items; i++)
    {
      const char * s;

      str[i] = PyObject_Str (PyTuple_GET_ITEM (args, i));
      if (str[i] == NULL)
        goto done;
      nstr++;

      s = PyUnicode_AsUTF8 (str[i]);
      if (s == NULL)
        goto done;

      if (i < items - 1)
        argv[i+1] = (char *)s;
      else
        Text = (char *)s;
    }
  argv[argc-1] = "_.F90";

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
  for (i = 0; i < nstr; i++)
    Py_DECREF (str[i]);
  PyMem_Free (str);
  PyMem_Free (argv);

  return ret;
}

static PyMethodDef fxtran_Methods[] =
{
  {"run", run, METH_VARARGS,
   "run(option, ..., text): parse Fortran source text and return the XML"},
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
