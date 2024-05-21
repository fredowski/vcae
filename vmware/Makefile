
VMDIR=./vcae.vmwarevm

all: $(VMDIR)/vcae.vmdk $(VMDIR)/vcae.vmx

start: $(VMDIR)/vcae.vmdk $(VMDIR)/vcae.vmx ../preseed/vcae.iso
	vmrun start $(VMDIR)/vcae.vmx

$(VMDIR)/vcae.vmdk:
	./create_vmware_vm.sh

$(VMDIR)/vcae.vmx: vcae.vmx.strip
	cp vcae.vmx.strip $(VMDIR)/vcae.vmx

clean:
	rm -rf $(VMDIR)