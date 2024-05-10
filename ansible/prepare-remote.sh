#!/bin/bash

# https://github.com/opencollab/qemu-debian-install-pxe-preseed/blob/master/build_qemu_debian_image.sh

HOSTNAME=192.168.212.131

# Install ssh key for access without password
TMP="$(mktemp -d build.XXXXX)"
mkdir -p $TMP/.ssh
cp ~/.ssh/id_rsa.pub $TMP/.ssh/authorized_keys
scp -r $TMP/.ssh caeuser@${HOSTNAME}:~
rm -rf $TMP







 

