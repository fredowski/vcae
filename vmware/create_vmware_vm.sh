#!/bin/bash

# Create a VMware virtual machine from an iso file

# Debug on
set -e

if [ `uname` != "Darwin" ]; then
  echo "This only works on MacOS"
  exit
fi

if [ ! -f "/Applications/VMware Fusion.app/Contents/Public/vmrun" ]; then
  echo "I could not find vmrun in VMWare installed in /Applications/"
  exit
fi

export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"

VMDIR=vcae.vmwarevm
mkdir $VMDIR

# Create a selfgrowing disk with maximum 120G
vmware-vdiskmanager -c -t 0 -s 120G -a lsilogic $VMDIR/vcae.vmdk

