#!/bin/bash

set -x
set -e


cd python2

dir=python2-fxtran_1-0_amd64

make clean
make

mkdir -p $dir/usr/lib/python2.7/lib-dynload
cp fxtran.so $dir/usr/lib/python2.7/lib-dynload/fxtran.x86_64-linux-gnu.so

cd $dir

mkdir -p debian

cat -> debian/control << EOF
Package: python2-fxtran
Version: 1.0
Architecture: amd64
Source: fxtran
Maintainer: <pmarguinaud@hotmail.com>
Description: Parse FORTRAN source code into XML.
 More info at https://github.com/pmarguinaud/fxtran.
EOF

DEPENDS=$(dpkg-shlibdeps -O usr/lib/python2.7/lib-dynload/fxtran.x86_64-linux-gnu.so  | perl -pe 's/shlibs:Depends=/Depends: /o;')
DEPENDS="$DEPENDS, python2 (>= 2.7)"
echo "$DEPENDS" >> debian/control

mv debian DEBIAN

cd ..

dpkg-deb --build --root-owner-group $dir
\rm -rf $dir
mv $dir.deb ..

cd ..







