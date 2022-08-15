#!/bin/bash

set -x
set -e


V=$(perl -e ' my $V = $^V; $V =~ s/^.//o; $V =~ s/\.\d+$//o; print $V')

cd perl 
perl Makefile.PL
make
make test

dir=libfxtran-perl_1-0_amd64

mkdir -p $dir/usr/lib/x86_64-linux-gnu/perl5/$V/auto/fxtran
mkdir -p $dir/usr/share/man/man3

cp blib/lib/fxtran.pm $dir/usr/lib/x86_64-linux-gnu/perl5/$V/fxtran.pm
cp blib/arch/auto/fxtran/fxtran.so $dir/usr/lib/x86_64-linux-gnu/perl5/$V/auto/fxtran/fxtran.so
cp blib/man3/fxtran.3pm $dir/usr/share/man/man3/fxtran.3pm
gzip $dir/usr/share/man/man3/fxtran.3pm

mkdir -p $dir/debian

cd $dir

cat -> debian/control << EOF
Package: fxtran-perl
Version: 1.0
Architecture: amd64
Source: fxtran
Maintainer: <pmarguinaud@hotmail.com>
Description: Parse FORTRAN source code into XML.
 More info at https://github.com/pmarguinaud/fxtran.
EOF

DEPENDS=$(dpkg-shlibdeps -O usr/lib/x86_64-linux-gnu/perl5/$V/auto/fxtran/*  | perl -pe 's/shlibs:Depends=/Depends: /o;')
DEPENDS="$DEPENDS, perl (>= $V)"
echo "$DEPENDS" >> debian/control

mv debian DEBIAN

cd ..

dpkg-deb --build --root-owner-group $dir
\rm -rf $dir
mv $dir.deb ..

cd ..

