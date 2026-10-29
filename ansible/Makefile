# Start and provision the vcae vmware machine without vagrant

VMDIR=../vmware/vcae.vmwarevm
# digitaltechnik, soc or vlsi, e.g. make COURSE=vlsi
COURSE ?= digitaltechnik

all:
	./provision.sh $(COURSE)

start: $(VMDIR)/vmware.log
	vmrun start $(VMDIR)/vcae.vmx
