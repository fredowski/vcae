# Make a custom debian iso
#
#   make              amd64 iso: vcae-amd64.iso
#   make vcae-arm64.iso

dver=13.7.0
diso=debian-$(dver)-amd64-netinst.iso
diso_arm64=debian-$(dver)-arm64-netinst.iso

vcae-amd64.iso: isos/$(diso) postinstall postinstall.d/* preseed.cfg isolinux.cfg
	./build ./isos/$(diso) vcae-amd64.iso

vcae-arm64.iso: isos/$(diso_arm64) postinstall postinstall.d/* preseed.cfg grub.cfg
	./build ./isos/$(diso_arm64) vcae-arm64.iso

isos/debian-$(dver)-%-netinst.iso:
	cd isos; wget http://ftp.de.debian.org/debian-cd/$(dver)/$*/iso-cd/debian-$(dver)-$*-netinst.iso
	
clean:
	rm -rf ./isos/* isohdpfx.bin vcae-amd64.iso vcae-arm64.iso
