#!/bin/bash

# Build libpng12 for quartus and copy the .so files to the quartus/linux and
# quartus/linux64 directory.
# libpng12 is required by quartus but not available on current distributions
# Friedrich Beckmann

QUARTUSDIR=$1

TMPDIR=`mktemp -d`

pushd $TMPDIR
wget https://www.hs-augsburg.de/homes/beckmanf/public/libpng-1.2.59.tar.gz
tar -xzf libpng-1.2.59.tar.gz
# Build the i386 32 Bit Version
cd libpng-1.2.59
CFLAGS='-m32' ./configure --libdir=/usr/lib/i386-linux-gnu
make
mkdir -p $QUARTUSDIR/linux
cp .libs/libpng12.so.0 $QUARTUSDIR/quartus/linux
cd ..
# Build the x86_64 64 Bit version
rm -rf libpng-1.2.59
tar -xzf libpng-1.2.59.tar.gz
cd libpng-1.2.59
./configure --libdir=/usr/lib/x86_64-linux-gnu
make
mkdir -p $QUARTUSDIR/linux64
cp .libs/libpng12.so.0 $QUARTUSDIR/quartus/linux64
popd
rm -rf $TMPDIR
