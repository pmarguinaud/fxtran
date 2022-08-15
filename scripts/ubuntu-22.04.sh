#!/bin/bash

set -x
set -e

make clean
make

dir=fxtran_1-0_amd64


mkdir -p $dir/usr/bin
cp bin/fxtran $dir/usr/bin/fxtran

mkdir $dir/debian

cd $dir

cat -> debian/control << EOF
Package: fxtran
Version: 1.0
Architecture: amd64
Source: fxtran
Maintainer: <pmarguinaud@hotmail.com>
Description: Parse FORTRAN source code into XML.
 More info at https://github.com/pmarguinaud/fxtran.
EOF

dpkg-shlibdeps -O usr/bin/*  | perl -pe 's/shlibs:Depends=/Depends: /o;'  > depends.txt

cat depends.txt >> debian/control
\rm depends.txt

mv debian DEBIAN

cd ..

dpkg-deb --build --root-owner-group $dir
\rm -rf $dir

