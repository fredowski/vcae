#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Run as root with: sudo ./install-quartus.sh"
  exit
fi

# Install the dependencies for Quartus
dpkg --add-architecture i386
apt update
apt install -y libc6:i386 libpng16-16:i386 libfreetype6:i386 libsm6:i386 \
            libxrender1:i386 libfontconfig1:i386 libxext6:i386 \
            libxft2:i386 libncurses5:i386

# Build and install the libpng12 library
if [[ -f /usr/lib/i386-linux-gnu/libpng12.so && -f /usr/lib/x86_64-linux-gnu/libpng12.so ]]; then
  echo "libpng12 ist schon installiert"
else
  apt install -y build-essential gcc-multilib zlib1g-dev zlib1g-dev:i386
  mkdir -p build
  pushd build
  if [ ! -f libpng-1.2.59.tar.gz ]; then
    wget https://www.hs-augsburg.de/homes/beckmanf/public/libpng-1.2.59.tar.gz
  fi
  tar -xzf libpng-1.2.59.tar.gz
  cd libpng-1.2.59
  CFLAGS='-m32' ./configure --libdir=/usr/lib/i386-linux-gnu
  make
  make install
  cd ..
  rm -rf libpng-1.2.59
  tar -xzf libpng-1.2.59.tar.gz
  cd libpng-1.2.59
  ./configure --libdir=/usr/lib/x86_64-linux-gnu
  make
  make install
  popd
  rm -rf build
fi

if [ -d /opt/altera/13.0sp1 ]; then
  echo "Quartus ist schon installiert"
else
  mkdir -p cae
  pushd cae
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

  #cd components
  chmod a+x ./QuartusSetupWeb-13.0.1.232.run
  ./QuartusSetupWeb-13.0.1.232.run --mode unattended \
     --unattendedmodeui none \
     --installdir /opt/altera/13.0sp1 \
     --disable-components quartus_help,arria_web,cyclonev,max_web,modelsim_ase,modelsim_ae
  popd
  #rm -rf cae
fi

if grep /opt/altera/13.0sp1/quartus/bin /home/caeuser/.bashrc; then
  echo "Quartus PATH is already set in .bashrc"
else
  echo 'export PATH=$PATH:/opt/altera/13.0sp1/quartus/bin' >> /home/caeuser/.bashrc
fi

if [ -f /etc/udev/rules.d/51-usbblaster.rules ]; then
  echo "51-usblaster.rules are already there"
else
cat << EOF > /etc/udev/rules.d/51-usbblaster.rules
# Altera USB-Blaster for Quartus FPGA Software
SUBSYSTEMS=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
SUBSYSTEMS=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
SUBSYSTEMS=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"
# USB-Blaster II
SUBSYSTEMS=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
SUBSYSTEMS=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
EOF
fi

