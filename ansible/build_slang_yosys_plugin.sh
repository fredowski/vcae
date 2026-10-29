#!/bin/bash -xe
# Build the slang (SystemVerilog) plugin for yosys, install is done by ansible
# usage: build_slang_yosys_plugin.sh <prefix> <builddir>
# yosys must already be installed in <prefix>

# versions are based on IIC-OSIC-TOOLS 2026.02
# https://github.com/iic-jku/IIC-OSIC-TOOLS/blob/2026.02/_build/tool_metadata.yml
SLANGYOSYSPLUGINCOMMIT=446240c31e2b4aa33334d3c568c5729a9e3ff9e7

if [ $# -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
  echo "usage: $0 <prefix> <builddir>" >&2
  exit 1
fi

PREFIX=$1
BUILDDIR=$2

if [[ ! $SLANGYOSYSPLUGINCOMMIT =~ ^[0-9a-f]{40}$ ]]; then
  echo "commit must be a full 40 character git hash: $SLANGYOSYSPLUGINCOMMIT" >&2
  exit 1
fi
if [[ $PREFIX != /* ]] || [[ $BUILDDIR != /* ]]; then
  echo "prefix and builddir must be absolute paths" >&2
  exit 1
fi
if [ ! -x $PREFIX/bin/yosys-config ]; then
  echo "$PREFIX/bin/yosys-config not found" >&2
  exit 1
fi

mkdir -p $BUILDDIR
cd $BUILDDIR

if [ ! -d yosys-slang ]; then
  git clone --recursive https://github.com/povik/yosys-slang.git
fi
cd yosys-slang
git checkout ${SLANGYOSYSPLUGINCOMMIT}
git submodule update --init --recursive

# YOSYS_PREFIX is prepended to yosys-config
CMAKE_BUILD_PARALLEL_LEVEL=$(nproc) make YOSYS_PREFIX=$PREFIX/bin/
