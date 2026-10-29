#!/bin/bash -xe
# Build the ghdl plugin for yosys, install is done by ansible
# usage: build_ghdl_yosys_plugin.sh <prefix> <builddir>
# ghdl and yosys must already be installed in <prefix>

# versions are based on IIC-OSIC-TOOLS 2026.02
# https://github.com/iic-jku/IIC-OSIC-TOOLS/blob/2026.02/_build/tool_metadata.yml
GHDLYOSYSPLUGINCOMMIT=07a30ed39fb6a078f1bf7e9e88ce9ed712380ec2

if [ $# -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
  echo "usage: $0 <prefix> <builddir>" >&2
  exit 1
fi

PREFIX=$1
BUILDDIR=$2

if [[ ! $GHDLYOSYSPLUGINCOMMIT =~ ^[0-9a-f]{40}$ ]]; then
  echo "commit must be a full 40 character git hash: $GHDLYOSYSPLUGINCOMMIT" >&2
  exit 1
fi
if [[ $PREFIX != /* ]] || [[ $BUILDDIR != /* ]]; then
  echo "prefix and builddir must be absolute paths" >&2
  exit 1
fi
for tool in ghdl yosys-config; do
  if [ ! -x $PREFIX/bin/$tool ]; then
    echo "$PREFIX/bin/$tool not found" >&2
    exit 1
  fi
done

mkdir -p $BUILDDIR
cd $BUILDDIR

if [ ! -d ghdl-yosys-plugin ]; then
  git clone https://github.com/ghdl/ghdl-yosys-plugin.git
fi
cd ghdl-yosys-plugin
git checkout ${GHDLYOSYSPLUGINCOMMIT}

make GHDL=$PREFIX/bin/ghdl YOSYS_CONFIG=$PREFIX/bin/yosys-config -j $(nproc)
