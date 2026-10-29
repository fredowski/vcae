#!/bin/bash -xe
# Build yosys from the release tarball, install is done by ansible
# usage: build_yosys.sh <prefix> <builddir>

# versions are based on IIC-OSIC-TOOLS 2026.02
# https://github.com/iic-jku/IIC-OSIC-TOOLS/blob/2026.02/_build/tool_metadata.yml
VERSION=0.62

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

# a new version gets a fresh source tree
if [ ! -e yosys-${VERSION}.tar.gz ]; then
  wget -O yosys-${VERSION}.tar.gz \
    https://github.com/YosysHQ/yosys/releases/download/v${VERSION}/yosys.tar.gz
  rm -rf yosys
fi
# the tarball has no top level directory
if [ ! -d yosys ]; then
  mkdir yosys
  tar -C yosys -xzf yosys-${VERSION}.tar.gz
fi

cd yosys
make PREFIX=${PREFIX} -j $(nproc)
