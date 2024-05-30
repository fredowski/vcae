# Build the quartus repository

help:
	echo "Create a repository for the quartus .deb file"
	echo "make deb13: build quartus13 and quartususb .deb packages"
	echo "make deb23: build quartus23 and quatususb .deb packages"
	echo "make repo: build the repository with quartus13 and quartus23"
	echo "make upload: upload the repository to web"

q13dpkg=quartus13_13.0.1-1_i386.deb
q23dpkg=quartus23_23.1-1_amd64.deb
qusbdpkg=quartususb_1.0-1_all.deb

alldpkgs=$(q13dpkg) $(q23dpkg) $(qusbdpkg)

deb13: $(q13dpkg) $(qusbdpkg)

deb23: $(q23dpkg) $(qusbdpkg)

$(qusbdpkg):
	cd quartususb-1.0; make dpkg

$(q13dpkg):
	cd quartus13-13.0.1; make dpkg

$(q23dpkg):
	cd quartus23-23.1; make dpkg

repo: repository/Packages.xz

repository/Packages.xz: $(alldpkgs) 
	mkdir -p repository
	cd repository; ln -s ../$(q13dpkg) .
	cd repository; ln -s ../$(q23dpkg) .
	cd repository; ln -s ../$(qusbdpkg) .
	cd repository; dpkg-scanpackages . | xz -c > Packages.xz

upload: repository/Packages.xz
	scp repository/* beckmanf@login.rz.hs-augsburg.de:/www/beckmanf/public/repository