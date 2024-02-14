#include <Python.h>
#include "FXTRAN/RUN.h"

static PyObject * fxtran_Error = NULL;

static PyObject * run (PyObject * self, PyObject * args)   
{
  Py_ssize_t items = PyTuple_Size (args);
  int argc = items + 1;
  char * argv[argc];
  char * Text = NULL, * Xml = NULL, * Err = NULL;
  PyObject * str[items], * ret = NULL;
  Py_ssize_t i;

  argv[0] = "";
  for (i = 0; i < items; i++) 
    {   
      PyObject * arg = PyTuple_GetItem (args, i); 

      if (arg == NULL) 
        return 0;

      str[i] = PyObject_Str (arg);

      if (i < argc-2)
        argv[i+1] = (char*)PyUnicode_AsUTF8 (str[i]);
      else
        Text = (char*)PyUnicode_AsUTF8 (str[i]);
    }
  argv[argc-1] = "_.F90";

  FXTRAN_RUN (argc, argv, Text, &Xml, &Err);

  for (i = 0; i < items; i++)
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

static struct PyModuleDef fxtran_Module =
{
  PyModuleDef_HEAD_INIT,
  "fxtran", 
  "",          
  -1,          
  fxtran_Methods
};

PyMODINIT_FUNC 
PyInit_fxtran ()
{
  PyObject * m = PyModule_Create (&fxtran_Module);

  fxtran_Error = PyErr_NewException ("fxtran.error", NULL, NULL);
  Py_XINCREF (fxtran_Error);

  PyModule_AddObject (m, "error", fxtran_Error);

  return m;
}

