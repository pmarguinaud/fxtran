#!/bin/bash

set -x
set -e

make clean
make

dir=fxtran_1-0_amd64

mkdir -p $dir/usr/bin
cp bin/fxtran $dir/usr/bin/fxtran

mkdir $dir/DEBIAN

cat -> $dir/DEBIAN/control << EOF
Package: fxtran
Version: 1.0
Architecture: amd64
Maintainer: <pmarguinaud@hotmail.com>
Description: Parse FORTRAN source code into XML.
 More info at https://github.com/pmarguinaud/fxtran.
EOF

