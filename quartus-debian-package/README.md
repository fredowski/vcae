# Quartus Debian source package

This contains the source files and scripts to build the

  * quartus13
  * quartus23
  * quartususb

debian .deb install packages, ready for a repository or direct
install. The qartususb package contains the common usb setup.

## Build the .deb files, create repository and upload to web

```
make upload
```

To just create the repository directory structure and the .deb files run

```
make repo
```

## Package dependencies for building the package

```
sudo dpkg --add-architecture i386
sudo apt install devscripts \
  build-essential \
  lintian \
  zlib1g-dev:i386
```

## Build the quartus13 .deb install file from source

```
cd quartus13-13.0.1
make dpkg
```

This will produce the quartus13_13.0.1-1_i386.deb file.

## Build the quartus23 .deb package

```
cd quartus23-23.1
make dpgk
```

## Install Quartus via the .deb file

```
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install ./quartus13_13.0.1-1_i386.deb
```

This will install the quartus 13 package in /opt/altera/13.0sp1. You need
to add /opt/altera/13.0sp1/quartus/bin to your PATH.

```
sudo apt install ./quartus23_23.1-1_amd64.deb
```

This will install quartus 23 package in /opt/altera/23.1. You need to
add /opt/altera/23.1/quartus/bin to your PATH

## Install quartus by adding the repository to /etc/apt/sources.list.d

```
sudo dpkg --add-architecture i386
sudo cp quartus.list /etc/apt/sources.list.d
sudo apt update
sudo apt install quartus
```

This works if the quartus13 and quartus23 packages are installed on
the tha webserver.


