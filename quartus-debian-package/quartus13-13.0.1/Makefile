

VERSION:=$(shell dpkg-parsechangelog -S Version | sed -rne 's,([^-\+]+)+(\+dfsg)*.*,\1,p'i)
UPSTREAMPACKAGE:=quartus13_${VERSION}.orig.tar.gz

help:
	echo "Install quartus 13 software on debian"
	echo "make dpkg: create source tar.gz file and build .deb"

dpkg:
	tar --exclude=debian --exclude=.git -czf ../${UPSTREAMPACKAGE} .
	dpkg-buildpackage --host-arch=i386

install:
	./install-quartus.sh ${DESTDIR}/opt/altera/13.0sp1
	./install-libpng.sh ${DESTDIR}/opt/altera/13.0sp1

