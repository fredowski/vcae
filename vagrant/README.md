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

## Create a simple debian machine


```
vagrant init debian/bookworm64
```

```
vagrant up --provider vmware_desktop
```

