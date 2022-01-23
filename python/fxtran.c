#include <Python.h>
#include "FXTRAN_RUN.h"

PyObject * run (PyObject * self, PyObject * args)   
{
  Py_ssize_t items = PyTuple_Size (args);
  int argc = items + 1;
  char * argv[argc];
  char * Text, * Xml;
  PyObject * str[items], * ret;

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

  FXTRAN_RUN (argc, argv, Text, &Xml);

  for (Py_ssize_t i = 0; i < items; i++)
    Py_DECREF (str[i]);

  ret = Py_BuildValue ("s", Xml);

  free (Xml);

  return ret;
}

static PyMethodDef fxtranMethods[] =
{
  {"run", run,    METH_VARARGS, ""  },
  {NULL,  NULL,   0,            NULL}
};


PyMODINIT_FUNC
initfxtran ()
{
  Py_InitModule ("fxtran", &fxtranMethods[0]);
}


