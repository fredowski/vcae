# VCAE vagrant

Create scripted virtual machines

## Setup on MacOS

```
brew install vagrant
```

If you have vmware virtualization, then

```
brew install vagrant-vmware-utility
vagrant plugin install vagrant-vmware-desktop
```

## Install and run a debian machine from the cloud

```
vagrant init generic/debian12
vagrant up
vagrant ssh
```

## Install and run the vcae vmware box

```
vagrant box add --name vcae ../vmware/vcae.box
vagrant up --provider vmware_desktop
```

## Provisioning and gui

Look at the file Vagrantfile-vcae and add the entries to
the created Vagrantfile. The part for the ansible provisioning
will create the full vcae machine. Start provisioning via

```
vagrant provision
```

The final vmware disk compaction step takes longer than the normal
ansible timeout, but it will finish. 

## Clean up

```
vagrant destroy
vagrant box list
vagrant box remove generica/debian12
vagrant box remove vcae
```



