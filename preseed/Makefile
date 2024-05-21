
# Make a custom debian iso

diso=debian-12.5.0-amd64-netinst.iso



vcae.iso: isos/$(diso)
	./build ./isos/$(diso) vcae.iso

isos/$(diso):
	cd isos; wget http://ftp.de.debian.org/debian-cd/12.5.0/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso
	
clean:
	rm -rf ./isos/* isohdpfx.bin vcae.iso
