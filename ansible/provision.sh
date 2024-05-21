#!/bin/bash -x

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
    if [ $cnt == 10 ]; then
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

ansible-playbook -i vcae.ini desktop.yaml 


