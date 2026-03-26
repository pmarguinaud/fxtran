#!/usr/bin/python3

import fxtran
from _fxtran import error

print(fxtran.run("REAL :: X (10)\nEND\n"))

try:
    fxtran.run("X = ..\nEND\n")
except error as e:
    print(e)
