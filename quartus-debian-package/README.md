# Quartus Debian source package

This contains the source files and scripts to build the quartus .deb install package.

## Build the .deb install file from source

```
sudo apt install devscripts \
  build-essential \
  lintian \
  zlib1g-dev 
cd quartus-13.0.1
make dpkg
```

This will produce the quartus_13.0.1-1_i386.deb file

## Install Quartus via the .deb file

```
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install ./quartus_13.0.1-1_i386.deb
```

This will install the quartus package in /opt/altera/13.0sp1. You need
to add /opt/altera/13.0sp1/quartus/bin to your PATH.
