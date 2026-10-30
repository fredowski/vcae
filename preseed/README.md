# vcae Debian Installer ISO

This builds an automated Debian "trixie" (13) installer ISO for the vcae
virtual machine using a "preseed" configuration. The installation runs
without any questions and powers the machine off when it is finished.

**WARNING!** The installer takes the first disk which is not mounted
and erases it without asking. Only boot this ISO in a virtual machine or
on a machine whose disk you want to wipe.

## What the installation does

* German locale and keyboard, timezone Europe/Berlin, hostname `vcae`.
* Debian mirror `ftp.de.debian.org`.
* Partitioning: one ext4 root partition plus swap (`atomic` recipe, no LVM).
* No tasksel, no desktop. Only `openssh-server`, `build-essential`,
  `keyboard-configuration` and `python3` are installed in addition to the
  base system.
* Root login is disabled. Two users are created:
  * `caeuser` with password `caeuser`, sudo without password.
  * `vagrant` with password `vagrant`, sudo without password and the
    insecure vagrant public keys in `~/.ssh/authorized_keys`, so that the
    machine can be used as a vagrant box.
* Predictable network interface names are disabled and `eth0` is
  configured with DHCP. VMware Fusion and vagrant assign different pci
  slots, so a name like `ens33` would not survive (see `postinstall`).
* `go.sh` is copied to `/home/caeuser`.

## Files

* `preseed.cfg` the answers for the debian installer.
* `postinstall` runs at the end of the installation in the target system.
* `postinstall.d/` files used by `postinstall`, packed into the initrd.
* `isolinux.cfg` boot menu for amd64 BIOS boot. It starts the automated
  install after a 30 second timeout.
* `grub.cfg` is prepended to the grub menu of the arm64 ISO. The entry
  "Automated install (vcae)" starts after a 30 second timeout.
* `build` the script which builds the ISO.

## Building the ISO

Install the dependencies on Debian:

```
apt-get install -y --no-install-recommends xorriso cpio wget make
```

On macOS:

```
brew install cpio xorriso wget
```

Then run

```
make                  # vcae-amd64.iso
make vcae-arm64.iso   # vcae-arm64.iso, e.g. UTM or VMware Fusion on Apple Silicon
```

The Makefile downloads the Debian netinst ISO to `isos/` and calls
`build`. You can also call the script directly. It detects the
architecture from the ISO:

```
./build /path/to/debian-13.x.x-amd64-netinst.iso vcae-amd64.iso
```

`make clean` removes the downloaded and generated ISOs.

## Boot modes

* amd64, BIOS: the automated install starts after the timeout.
* amd64, UEFI: the ISO boots, but the grub menu is the unmodified Debian
  menu. There is no automated entry, so you have to select the install
  entry yourself.
* arm64, UEFI only: the automated install starts after the timeout.

## After the installation

Boot the installed system, log in as `caeuser` and run

```
./go.sh
```

It installs ansible and git, clones https://github.com/fredowski/vcae and
runs the ansible playbooks `init-from-shell.yaml` (LXQt desktop with
autologin) and `digitaltechnik.yaml`. For the other courses, run
`soc.yaml` or `vlsi.yaml` from `~/vcae/ansible` instead of
`digitaltechnik.yaml`.

## Writing the ISO to a USB disk

The ISO is a hybrid image and can be written directly to a USB disk.
**This erases the USB disk.**

macOS, where `diskXX` is your USB disk:

```
diskutil unmountDisk /dev/diskXX
sudo dd if=./vcae-amd64.iso of=/dev/rdiskXX bs=1m
```

Linux, use `lsblk` to find the device name of the USB disk:

```
sudo dd bs=4M if=vcae-amd64.iso of=/dev/XXX conv=fdatasync
```

## More Information

* [https://wiki.debian.org/DebianInstaller/Preseed](https://wiki.debian.org/DebianInstaller/Preseed)
* [https://wiki.debian.org/DebianInstaller/Preseed/EditIso](https://wiki.debian.org/DebianInstaller/Preseed/EditIso)
* [https://www.debian.org/releases/trixie/example-preseed.txt](https://www.debian.org/releases/trixie/example-preseed.txt)
* [https://github.com/pin/debian-vm-install](https://github.com/pin/debian-vm-install)
* [https://serverfault.com/questions/722021/preseeding-debian-install-efi](https://serverfault.com/questions/722021/preseeding-debian-install-efi)
