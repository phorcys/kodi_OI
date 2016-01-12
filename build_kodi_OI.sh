#!/bin/sh

if [[ ! -d xbmc ]];then
	git clone http://github.com/xbmc/xbmc.git xbmc
	cd xbmc
	git fetch origin Jarvis
	git checkout Jarvis

patch -p1 < ../patch/001-kodi-solaris-platform-support.patch
patch -p1 < ../patch/002-lock_level-macro-fix.patch
patch -p1 < ../patch/003-alloca-fix.patch
patch -p1 < ../patch/004-oss-support-fix.patch
patch -p1 < ../patch/005-osrelated-stuff.patch
patch -p1 < ../patch/006-network-related.patch
patch -p1 < ../patch/007-third-party-library.patch
patch -p1 < ../patch/008-libupnp-temp-fix.patch
patch -p1 < ../patch/009-fix-solaris-FILE-no__file.patch
patch -p1 < ../patch/099-need-fix-disabled.patch
patch -p1 < ../patch/010-fix-charset-iconv.patch
else

	cd xbmc
fi

CC=gcc CXX=g++ bash bootstrap
CC=gcc CXX=g++ LD=/usr/gnu/bin/ld PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH PATH=/usr/mariadb/5.5/bin:$PATH bash configure --prefix=${HOME}/kodi/build/ --disable-ssh LDFLAGS="-L/usr/lib -L/usr/local/lib -L/usr/sfw/lib"
CC=gcc CXX=g++ gmake -j4
CC=gcc CXX=g++ gmake install

