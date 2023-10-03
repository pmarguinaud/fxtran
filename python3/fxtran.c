#include <Python.h>
#include "FXTRAN/RUN.h"

static PyObject * fxtran_Error = NULL;

static PyObject * run (PyObject * self, PyObject * args, PyObject * kwargs)
{
  if(!kwargs)
	{
    PyErr_SetString(PyExc_RuntimeError, "Need to specify either 'code=' or 'file=' argument");
    return NULL;
  }

  Py_ssize_t items = PyTuple_Size (args);
  int argc = items + 2;
  char * argv[argc];
  char * Text = NULL, * Xml = NULL, * Err = NULL;
  PyObject * str[items], * ret = NULL;

  argv[0] = "";
  for(Py_ssize_t i=0;i<items;i++)
	{
    PyObject * arg = PyTuple_GetItem (args, i);
    str[i] = PyObject_Str (arg);
    argv[i+1] = (char*)PyUnicode_AsUTF8 (str[i]);
  }

  PyObject *file_item = Py_BuildValue("s", "file");
  PyObject *file = PyDict_GetItem(kwargs, file_item);
  if(file)
	{
    PyObject *file_str = PyObject_Str(file);
    argv[argc-1] = (char*)PyUnicode_AsUTF8(file_str);
  }

  PyObject *code_item = Py_BuildValue("s", "code");
  PyObject *code = PyDict_GetItem(kwargs, code_item);
  if(code)
	{
    PyObject *code_str = PyObject_Str(code);
    Text = (char*)PyUnicode_AsUTF8(code_str);
    argv[argc-1] = "_.F90";
  }

  if(Text)
	{
    FXTRAN_RUN (argc, argv, Text, &Xml, &Err);
  }
	else
	{
    FXTRAN_RUN (argc, argv, NULL, &Xml, &Err);
  }

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
  {
    "run",
    (PyCFunctionWithKeywords)run,
    METH_VARARGS|METH_KEYWORDS,
    "Generate XML with fxtran from a string or a file\n"\
    "fxtran.run('-canonic', code=\"PROGRAM MAIN\\nEND\")\n"\
    "fxtran.run('-canonic', file=\"main.F90\")"\
  },
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

