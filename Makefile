# Start and provision the vcae vmware machine without vagrant

all:
	cd preseed; make
	cd vmware; make
	cd ansible; make

clean:
	cd vmware; make clean
	cd preseed; make clean

	
