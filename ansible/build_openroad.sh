#!/bin/bash -xe
# Build OpenROAD with GUI using bazel, install is done by ansible
# usage: build_openroad.sh <builddir>
# The result is <builddir>/OpenROAD/bazel-bin/packaging/openroad.tar with
# the openroad binary and the openroad.runfiles directory.
# see: docs/user/Build.md in the OpenROAD repository

# The IIC-OSIC-TOOLS 2026.02 version was updated 
# because first the timing path colours were not shown and then
# the power density map did not update

OPENROADCOMMIT=bc26e2ef4b6cafe03f7e033a27236078b075a49a

if [ $# -ne 1 ] || [ -z "$1" ]; then
  echo "usage: $0 <builddir>" >&2
  exit 1
fi

BUILDDIR=$1

if [[ ! $OPENROADCOMMIT =~ ^[0-9a-f]{40}$ ]]; then
  echo "commit must be a full 40 character git hash: $OPENROADCOMMIT" >&2
  exit 1
fi
if [[ $BUILDDIR != /* ]]; then
  echo "builddir must be an absolute path" >&2
  exit 1
fi

mkdir -p $BUILDDIR
cd $BUILDDIR

if [ ! -d OpenROAD ]; then
  git clone --recurse-submodules https://github.com/The-OpenROAD-Project/OpenROAD.git
fi
cd OpenROAD
git checkout ${OPENROADCOMMIT}
git submodule update --init --recursive

# --config=release embeds the git version string
bazelisk build --config=release --//:platform=gui //:tarfile
