# Hochschule Augsburg - Virtual CAE

The Virtual CAE repository contains installation scripts to install

  * Intel Altera Quartus 13.0sp1 for synthesis
  * ghdl for simulation
  * VSCodium

for the synthesis and simulation of VHDL Code for Intel Altera Cyclone II FPGAs on Debian linux.

## Ansible

The Virtual CAE machine is configured via ansible scripts. You need to have ansible on your machine. There must be a user "caeuser" on your machine.

```
sudo apt install ansible
```

Then you find several .yaml files for the different install targets in the ansible directory. To install for example ghdl, run

```
cd ansible
ansible-playbook ghdl.yaml
```

For ghdl, quartus and vscodium, run

```
cd ansible
ansible-playbook vcae.yaml
```


## Intel Altera Quartus Package

The quartus-debian-package directory contains the source files to create
a quartus .deb package. To create the .deb file run

```
cd quartus-debian-package
make deb
```

To create a repository directory structure, run

```
cd quartus-debian-package
make repo
```

To upload the repository directory structure to beckmann, run

```
cd quartus-debian-package
make upload
```
