#!/usr/bin/python3

import fxtran
from fxtran import error

print (fxtran.run ("REAL :: X (10)\nEND\n"));

try:
  fxtran.run ("X = ..\nEND\n")
except fxtran.error as e:
  print (e);


