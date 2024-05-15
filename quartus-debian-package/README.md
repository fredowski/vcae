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

This will produce the .deb file

## Install the .deb file

```
sudo apt install ../quartus...deb
```

This will install the quartus package in /opt/altera/13.0sp1. You need
to add /opt/altera/13.0sp1/quartus/bin to your PATH.
