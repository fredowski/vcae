

UPSTREAMPACKAGE:=quartususb_1.0.orig.tar.gz

help:
	echo "Install quartus usb udev rules"
	echo "make dpkg: create source tar.gz file and build .deb"

dpkg:
	tar --exclude=debian --exclude=.git -czf ../${UPSTREAMPACKAGE} .
	debuild

install:
	install -D --mode=644 -t ${DESTDIR}/lib/udev/rules.d ./51-usbblaster.rules 
