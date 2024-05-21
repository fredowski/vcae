#!/bin/bash

# Wait until the VMWare install from .iso is done.
# This is for the first boot which installs the system
# on the virtual vmware drive

# Debug on
set -e

VMDIR=vcae.vmwarevm
echo -n "Waiting for install:"
sleep 5
while vmrun list | grep vcae.vmx > /dev/null ;
do
  sleep 3
  echo -n "."
done
echo "vcae.vmx machine finished"
