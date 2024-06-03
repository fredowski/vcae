#!/bin/bash

# exit on error
set -e

QUARTUSDIR=$1

QUARTUSINSTALLER=QuartusLiteSetup-23.1std.0.991-linux.run

TMPDIR=/tmp/quartusbuild
mkdir -p $TMPDIR
pushd $TMPDIR

if [ ! -f $QUARTUSINSTALLER ]; then
  wget http://downloads.intel.com/akdlm/software/acdsinst/23.1std/991/ib_installers/$QUARTUSINSTALLER
  wget http://downloads.intel.com/akdlm/software/acdsinst/23.1std/991/ib_installers/cyclonev-23.1std.0.991.qdz
fi

chmod a+x ./$QUARTUSINSTALLER
./$QUARTUSINSTALLER --mode unattended \
  --unattendedmodeui none \
  --installdir $QUARTUSDIR \
  --accept_eula 1 \
  --disable-components quartus_help,devinfo,arria_lite,\
cyclone,cyclone10lp,max,max10,\
quartus_update,riscfree,\
questa_fse,questa_fe
# Install the CycloneV device info
unzip -d $QUARTUSDIR cyclonev-23.1std.0.991.qdz
# remove uninstall directories
# nios is required for hps generation with system builder
#rm -rf $QUARTUSDIR/nios2eds
rm -rf $QUARTUSDIR/nios2eds/bin/gnu
rm -rf $QUARTUSDIR/uninstall
rm -rf $QUARTUSDIR/logs
popd


