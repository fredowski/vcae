#!/bin/bash

QUARTUSDIR=$1

TMPDIR=/tmp/quartusbuild
mkdir -p $TMPDIR
pushd $TMPDIR
#if [ ! -f Quartus-web-13.0.1.232-linux.tar ]; then
#  wget http://www.hs-augsburg.de/~beckmanf/public/Quartus-web-13.0.1.232-linux.tar
#  wget http://downloads.intel.com/akdlm/software/acdsinst/13.0sp1/232/ib_tar/Quartus-web-13.0.1.232-linux.tar
#fi
#if [ ! -d components ]; then
#  tar -xf Quartus-web-13.0.1.232-linux.tar
#fi
if [ ! -f QuartusSetupWeb-13.0.1.232.run ]; then
  wget http://downloads.intel.com/akdlm/software/acdsinst/13.0sp1/232/ib_installers/QuartusSetupWeb-13.0.1.232.run
  wget http://downloads.intel.com/akdlm/software/acdsinst/13.0sp1/232/ib_installers/cyclone_web-13.0.1.232.qdz
fi

chmod a+x ./QuartusSetupWeb-13.0.1.232.run
./QuartusSetupWeb-13.0.1.232.run --mode unattended \
  --unattendedmodeui none \
  --installdir $QUARTUSDIR \
  --disable-components quartus_help,arria_web,cyclonev,max_web,modelsim_ase,modelsim_ae
popd


