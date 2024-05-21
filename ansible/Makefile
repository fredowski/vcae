# Start and provision the vcae vmware machine without vagrant

VMDIR=../vmware/vcae.vmwarevm

all:
	./provision.sh

start: $(VMDIR)/vmware.log
	vmrun start $(VMDIR)/vcae.vmx
