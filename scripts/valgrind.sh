#!/bin/bash

valgrind -s --leak-check=full ./bin/fxtran -no-include -no-cpp $*
