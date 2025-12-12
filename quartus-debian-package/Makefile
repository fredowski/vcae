# Build the quartus repository

help:
	echo "Create a repository for the quartus .deb file"
	echo "make deb13: build quartus13 and quartususb .deb packages"
	echo "make deb23: build quartus23 and quatususb .deb packages"
	echo "make repo: build the repository with quartus13 and quartus23"
	echo "make upload: upload the repository to web"

q13dpkg=quartus13_13.0.1-2_amd64.deb
q13dpkgarm=quartus13_13.0.1-2_arm64.deb
q13files=quartus13files_1.0-1_all.deb
q23dpkg=quartus23_23.1-1_amd64.deb
qusbdpkg=quartususb_1.0-1_all.deb

alldpkgs=$(q13dpkg) $(q23dpkg) $(qusbdpkg) $(q13files)

deb13: $(q13dpkg) $(qusbdpkg) $(q13files)

deb23: $(q23dpkg) $(qusbdpkg)

$(qusbdpkg):
	cd quartususb-1.0; make dpkg

$(q13dpkg):
	cd quartus13-13.0.1; make dpkg

$(q13files):
	cd quartus13files-1.0; make dpkg

$(q23dpkg):
	cd quartus23-23.1; make dpkg

repo: repository/Packages.xz

repository/Packages.xz: $(alldpkgs)
	rm -rf repository
	mkdir -p repository
	cd repository; ln -s ../$(q13dpkg) .
	cd repository; ln -s ../$(q23dpkg) .
	cd repository; ln -s ../$(qusbdpkg) .
	cd repository; ln -s ../$(q13dpkgarm) .
	cd repository; ln -s ../$(q13files) .
	cd repository; dpkg-scanpackages --multiversion . | xz -c > Packages.xz

upload: repository/Packages.xz
	scp repository/* beckmanf@login.rz.hs-augsburg.de:/www/beckmanf/public/repository
