#include <Python.h>
#include "FXTRAN_RUN.h"

static PyObject * fxtran_Error = NULL;

static PyObject * run (PyObject * self, PyObject * args)   
{
  Py_ssize_t items = PyTuple_Size (args);
  int argc = items + 1;
  char * argv[argc];
  char * Text, * Xml = NULL, * Err = NULL;
  PyObject * str[items], * ret = NULL;

  argv[0] = "";
  for (Py_ssize_t i = 0; i < items; i++) 
    {   
      PyObject * arg = PyTuple_GetItem (args, i); 

      if (arg == NULL) 
        return 0;

      str[i] = PyObject_Str (arg);

      if (i < argc-2)
        argv[i+1] = PyString_AsString (str[i]);
      else
        Text = PyString_AsString (str[i]);
    }
  argv[argc-1] = "_.F90";

  FXTRAN_RUN (argc, argv, Text, &Xml, &Err);

  for (Py_ssize_t i = 0; i < items; i++)
    Py_DECREF (str[i]);

  if (Err)
    {
      PyObject * err = Py_BuildValue ("s", Err);
      free (Err);
      PyErr_SetObject (fxtran_Error, err);
    }
  else
    {
      ret = Py_BuildValue ("s", Xml);
      free (Xml);
    }

  return ret;

}

static PyMethodDef fxtran_Methods[] =
{
  {"run", run,    METH_VARARGS,   ""},
  {NULL,  NULL,   0,            NULL}
};

PyMODINIT_FUNC 
initfxtran ()
{
  PyObject * m = Py_InitModule ("fxtran", &fxtran_Methods[0]);

  fxtran_Error = PyErr_NewException ("fxtran.error", NULL, NULL);
  Py_XINCREF (fxtran_Error);

  PyModule_AddObject (m, "error", fxtran_Error);
}

