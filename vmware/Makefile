# Create VMware virtual machine and the derived Vagrant box

VMDIR=./vcae.vmwarevm

vcae.box: $(VMDIR)/vcae.vmdk $(VMDIR)/vcae.vmx info.json metadata.json Vagrantfile $(VMDIR)/vmware.log
	tar -cf vcae.box --directory $(VMDIR) .
	tar --append -f vcae.box info.json metadata.json Vagrantfile

start: $(VMDIR)/vcae.vmdk $(VMDIR)/vcae.vmx ../preseed/vcae.iso
	vmrun start $(VMDIR)/vcae.vmx

$(VMDIR)/vcae.vmdk: ../preseed/vcae.iso
	./create_vmware_vm.sh

$(VMDIR)/vcae.vmx: vcae.vmx.strip ../preseed/vcae.iso
	cp vcae.vmx.strip $(VMDIR)/vcae.vmx

$(VMDIR)/vmware.log: ../preseed/vcae.iso
	vmrun start $(VMDIR)/vcae.vmx
	./wait_until_install_is_done.sh

clean:
	rm -rf $(VMDIR) vcae.box
