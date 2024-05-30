

VERSION:=$(shell dpkg-parsechangelog -S Version | sed -rne 's,([^-\+]+)+(\+dfsg)*.*,\1,p'i)
UPSTREAMPACKAGE:=quartus23_${VERSION}.orig.tar.gz

help:
	echo "Install quartus software on debian"
	echo "make dpkg: create source tar.gz file and build .deb"

dpkg:
	tar --exclude=debian --exclude=.git -czf ../${UPSTREAMPACKAGE} .
	debuild

install:
	./install-quartus.sh ${DESTDIR}/opt/altera/23.1

