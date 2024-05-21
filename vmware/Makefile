
VMDIR=./vcae.vmwarevm

all: $(VMDIR)/vcae.vmdk $(VMDIR)/vcae.vmx

start: $(VMDIR)/vcae.vmdk $(VMDIR)/vcae.vmx ../preseed/vcae.iso
	vmrun start $(VMDIR)/vcae.vmx

$(VMDIR)/vcae.vmdk:
	./create_vmware_vm.sh

$(VMDIR)/vcae.vmx: vcae.vmx.strip
	cp vcae.vmx.strip $(VMDIR)/vcae.vmx

$(VMDIR)/vmware.log:
	echo "Please run make start and watch the install" 

vcae.box: $(VMDIR)/vcae.vmdk $(VMDIR)/vcae.vmx info.json metadata.json Vagrantfile $(VMDIR)/vmware.log 
	tar -cf vcae.box --directory $(VMDIR) .
	tar --append -f vcae.box info.json metadata.json Vagrantfile

clean:
	rm -rf $(VMDIR) vcae.box