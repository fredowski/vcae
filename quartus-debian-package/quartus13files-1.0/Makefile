

VERSION:=$(shell dpkg-parsechangelog -S Version | sed -rne 's,([^-\+]+)+(\+dfsg)*.*,\1,p'i)
UPSTREAMPACKAGE:=quartus13files_${VERSION}.orig.tar.gz

help:
	echo "Install quartus 13 software on debian"
	echo "make dpkg: create source tar.gz file and build .deb"

dpkg:
	tar --exclude=debian --exclude=.git -czf ../${UPSTREAMPACKAGE} .
	debuild --no-lintian

install:
	./install-quartus.sh ${DESTDIR}/opt/altera/13.0sp1
	./fix-quartus.sh ${DESTDIR}/opt/altera/13.0sp1
