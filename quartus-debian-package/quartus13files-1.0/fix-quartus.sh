#!/bin/bash

# Provide some old or fixed libraries which were provided ages ago
# on the host system. 


# exit on error
set -e

# This should be something like ROOTDIR/opt/altera/13.0sp1
QUARTUSDIR=$1

TMPDIR=/tmp/quartus13build
mkdir -p $TMPDIR
pushd $TMPDIR

# Update the libtbb to fix "freezes" of quartus
# See: https://zkre.xyz/posts/quartus/
if [ ! -f ./libtbb2_4.2~20140122-5_amd64.deb ]; then
  wget http://archive.debian.org/debian/pool/main/t/tbb/libtbb2_4.2~20140122-5_amd64.deb
fi
dpkg -x libtbb2_4.2~20140122-5_amd64.deb tmp
cp -a ./tmp/usr/lib/* $QUARTUSDIR/quartus/linux64
rm -rf ./tmp

# Provide libpng12 which is not available on newer distributions
if [ ! -f libpng12-0_1.2.44-1+squeeze6_amd64.deb ]; then
  wget http://archive.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.44-1+squeeze6_amd64.deb
fi
dpkg -x libpng12-0_1.2.44-1+squeeze6_amd64.deb tmp
cp -a ./tmp/lib/* $QUARTUSDIR/quartus/linux64
rm -rf ./tmp

popd

# Fix the qenv.sh script to run on aarch64 also
cp $QUARTUSDIR/quartus/adm/qenv.sh $QUARTUSDIR/quartus/adm/qenv.sh.orig
patch $QUARTUSDIR/quartus/adm/qenv.sh < ./qenv.patch

