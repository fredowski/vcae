#!/bin/bash -x
# Start and provision the vcae vmware machine built from the preseed image
# usage: provision.sh <course>
#   course: digitaltechnik, soc or vlsi

COURSE=$1

case "$COURSE" in
    digitaltechnik|soc|vlsi)
        ;;
    *)
        echo "usage: $0 digitaltechnik|soc|vlsi" >&2
        exit 1
        ;;
esac

VCAEVM=../vmware/vcae.vmwarevm/vcae.vmx

if [ ! -f $VCAEVM ]; then
    echo "$VCAEVM does not exist"
    exit 1
fi


if vmrun list | grep vcae.vmx; then
    echo "vcae is running"
else
    echo "vcae is not running. Trying to start"
    vmrun start $VCAEVM
    echo -n "Waiting for startup: "
    cnt=0
    while [ $cnt != 5 ] && ! vmrun list | grep vcae.vmx ; do
        sleep 2
        echo -n "."
        cnt=$((cnt+1))
    done
    if [ $cnt == 5 ]; then
        echo "Could not start machine"
        exit 1
    else
        echo "Machine started"
    fi
fi

cnt=0
echo -n "Waiting IP of machine: "
while [ $cnt != 60 ] && ! VCAEIP=`vmrun getGuestIPAddress $VCAEVM`; do
    sleep 3
    echo -n "."
    cnt=$((cnt+1))
done

if [ $cnt == 60 ]; then
    echo "Could not get an IP address."
    exit 1
fi

echo "[default]" > vcae.ini
echo "$VCAEIP ansible_user=vagrant ansible_ssh_private_key_file=./vagrant-sec.key" >> vcae.ini

set -e

# Desktop and system setup as user vagrant
ansible-playbook -i vcae.ini init-from-shell.yaml

# The course installs and the cleanup write to $HOME, so they must run as
# caeuser. Only vagrant has an ssh key, give caeuser the same key for now.
ansible -i vcae.ini default -b -m ansible.builtin.file \
    -a "path=/home/caeuser/.ssh state=directory owner=caeuser group=caeuser mode=0700"
ansible -i vcae.ini default -b -m ansible.builtin.copy \
    -a "src=/home/vagrant/.ssh/authorized_keys dest=/home/caeuser/.ssh/authorized_keys remote_src=true owner=caeuser group=caeuser mode=0600"

ansible-playbook -i vcae.ini -e ansible_user=caeuser $COURSE.yaml
ansible-playbook -i vcae.ini -e ansible_user=caeuser --skip-tags reboot finalize-image.yaml

# Remove the vagrant key from caeuser again and reboot
ansible -i vcae.ini default -b -m ansible.builtin.file \
    -a "path=/home/caeuser/.ssh/authorized_keys state=absent"
ansible -i vcae.ini default -b -m ansible.builtin.reboot
