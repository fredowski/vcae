

VERSION:=$(shell dpkg-parsechangelog -S Version | sed -rne 's,([^-\+]+)+(\+dfsg)*.*,\1,p'i)
UPSTREAMPACKAGE:=quartus_${VERSION}.orig.tar.gz

help:
	echo "Install quartus software on debian"
	echo "make dpkg: create source tar.gz file and build .deb"

dpkg:
	tar --exclude=debian --exclude=.git -czf ../${UPSTREAMPACKAGE} .
	debuild --host-arch i386

install:
	./install-quartus.sh ${DESTDIR}/opt/altera/13.0sp1
	./install-libpng.sh ${DESTDIR}/opt/altera/13.0sp1
	mkdir -p ${DESTDIR}/etc/udev/rules.d/
	cp ./51-usbblaster.rules ${DESTDIR}/etc/udev/rules.d/
