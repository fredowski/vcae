#!/bin/bash -xe
# Build klayout with Qt6, ruby and python, install is done by ansible
# usage: build_klayout.sh <prefix> <builddir>
# The binaries go to <builddir>/klayout-bin, linked with the rpath
# <prefix>/lib/klayout where ansible copies them to.

# versions are based on IIC-OSIC-TOOLS 2026.02
# https://github.com/iic-jku/IIC-OSIC-TOOLS/blob/2026.02/_build/tool_metadata.yml
KLAYOUTVERSION=v0.30.6-3

if [ $# -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
  echo "usage: $0 <prefix> <builddir>" >&2
  exit 1
fi

PREFIX=$1
BUILDDIR=$2

if [[ $PREFIX != /* ]] || [[ $BUILDDIR != /* ]]; then
  echo "prefix and builddir must be absolute paths" >&2
  exit 1
fi

mkdir -p $BUILDDIR
cd $BUILDDIR

if [ ! -d klayout ]; then
  git clone --filter=blob:none https://github.com/KLayout/klayout.git
fi
cd klayout
git checkout ${KLAYOUTVERSION}

# ruby is required for the DRC/LVS scripts (.lydrc/.lylvs) of the
# OpenROAD flow scripts, build.sh finds ruby and python by itself
./build.sh -qmake qmake6 -j $(nproc) \
  -build $BUILDDIR/klayout-build \
  -bin $BUILDDIR/klayout-bin \
  -rpath $PREFIX/lib/klayout
