# Build the quartus repository

help:
	echo "Create a repository for the quartus .deb file"
	echo "make deb: build quartus .deb package"
	echo "make repo: build the repository"
	echo "make upload: upload the repository to web"

deb: quartus_13.0.1-1_i386.deb

quartus_13.0.1-1_i386.deb:
	cd quartus-13.0.1; make dpkg

repo: repository/Packages.xz

repository/Packages.xz: quartus_13.0.1-1_i386.deb
	mkdir -p repository
	cd repository; ln -s ../quartus_13.0.1-1_i386.deb .
	cd repository; dpkg-scanpackages . | xz -c > Packages.xz

upload: repository/Packages.xz
	scp repository/* beckmanf@login.rz.hs-augsburg.de:/www/beckmanf/public/repository