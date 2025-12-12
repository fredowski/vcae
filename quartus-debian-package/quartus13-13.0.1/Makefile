

VERSION:=$(shell dpkg-parsechangelog -S Version | sed -rne 's,([^-\+]+)+(\+dfsg)*.*,\1,p'i)
UPSTREAMPACKAGE:=quartus13_${VERSION}.orig.tar.gz

help:
	echo "Install quartus 13 software on debian"
	echo "make dpkg: create source tar.gz file and build .deb"

dpkg:
	tar --exclude=debian --exclude=.git -czf ../${UPSTREAMPACKAGE} .
	debuild --no-lintian -a arm64
	debuild --no-lintian -a amd64

install:
	# Nothing to be done...
