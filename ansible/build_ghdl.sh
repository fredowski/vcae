#!/bin/bash -xe
# Build ghdl (llvm backend) from source, install is done by ansible
# usage: build_ghdl.sh <prefix> <builddir>
# see: https://github.com/iic-jku/IIC-OSIC-TOOLS/blob/main/_build/images/ghdl/Dockerfile

# versions are based on IIC-OSIC-TOOLS 2026.02
# https://github.com/iic-jku/IIC-OSIC-TOOLS/blob/2026.02/_build/tool_metadata.yml
GHDLCOMMIT=b65faa8b232d88244428ac4806b3470ac87e1578

if [ $# -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
  echo "usage: $0 <prefix> <builddir>" >&2
  exit 1
fi

PREFIX=$1
BUILDDIR=$2

if [[ ! $GHDLCOMMIT =~ ^[0-9a-f]{40}$ ]]; then
  echo "commit must be a full 40 character git hash: $GHDLCOMMIT" >&2
  exit 1
fi
if [[ $PREFIX != /* ]] || [[ $BUILDDIR != /* ]]; then
  echo "prefix and builddir must be absolute paths" >&2
  exit 1
fi

mkdir -p $BUILDDIR
cd $BUILDDIR

if [ ! -d ghdl ]; then
  git clone https://github.com/ghdl/ghdl.git
fi
cd ghdl
git checkout ${GHDLCOMMIT}

./configure --prefix=$PREFIX --with-llvm-config
make -j $(nproc)
