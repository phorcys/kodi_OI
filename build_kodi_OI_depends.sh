#!/bin/sh
sudo pkg set-publisher -O http://pkg.openindiana.org/hipster-encumbered hipster-encumbered 
sudo pkg install  build-essential  doxygen boost nasm  mariadb-55 fribidi libass libmpeg2 libdca microhttpd libpthread-stubs mesa glu glw libsmbclient video/ffmpeg gperf libdvdread libsmbclient system/header/header-audio

sudo cp depends_patch/smbclient.pc /usr/local/lib/pkgconfig/

#build depends
mkdir -p depends
cd depends
mkdir -p build
cd build

#wget -c https://github.com/nigels-com/glew/archive/glew-1.13.0.tar.gz -O ../glew-1.13.0.tar.gz
wget -c "http://downloads.sourceforge.net/project/glew/glew/1.13.0/glew-1.13.0.tgz?r=http%3A%2F%2Fglew.sourceforge.net%2F&ts=1452345500&use_mirror=nchc" -O ../glew-1.13.0.tar.gz
tar -zxvf ../glew-1.13.0.tar.gz
cd glew-1.13.0
CC=gcc CXX=g++ cmake build/cmake
CC=gcc CXX=g++ gmake
sudo gmake install INSTALL=ginstall
cd ..

wget -c  https://github.com/foo86/dcadec/archive/v0.2.0.tar.gz -O ../libdcadec-0.2.0.tar.gz
tar -zxvf ../libdcadec-0.2.0.tar.gz
cd dcadec-0.2.0
CC=gcc gmake
sudo gmake install INSTALL=ginstall
cd ..

#tinyxml
#wget -c https://github.com/leethomason/tinyxml2/archive/3.0.0.tar.gz -O ../tinyxml2-3.0.0.tar.gz
wget -c "http://downloads.sourceforge.net/project/tinyxml/tinyxml/2.6.2/tinyxml_2_6_2.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Ftinyxml%2Ffiles%2Ftinyxml%2F2.6.2%2F&ts=1452341056&use_mirror=nchc" -O ../tinyxml-2.6.2.tar.gz
tar -zxvf ../tinyxml-2.6.2.tar.gz
cd tinyxml
cp ../../../depends_patch/tinyxml_configure.ac configure.ac
cp ../../../depends_patch/tinyxml_Makefile.am Makefile.am
cp ../../../depends_patch/tinyxml.pc tinyxml.pc
patch -p1 <../../../depends_patch/tinyxml_use_stl.patch
touch INSTALL NEWS README AUTHORS ChangeLog COPYING
libtoolize;aclocal;autoconf;automake --add-missing 
CC=gcc CXX=g++ bash configure 
CC=gcc CXX=g++ gmake 
sudo gmake install INSTALL=ginstall
cd ..

#libuuid
wget -c "http://downloads.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Flibuuid%2F&ts=1452114135&use_mirror=ncu" -O ../libuuid-1.0.3.tar.gz
tar -zxvf ../libuuid-1.0.3.tar.gz
cd libuuid-1.0.3
bash configure
gmake
sudo gmake install INSTALL=ginstall
cd ..


#libyajl
wget -c "https://github.com/lloyd/yajl/archive/2.1.0.tar.gz"  -O ../libyajl-2.1.0.tar.gz
tar -zxvf ../libyajl-2.1.0.tar.gz
cd yajl-2.1.0
CC=gcc CXX=g++  bash configure
CC=gcc CXX=g++ gmake
sudo gmake install INSTALL=ginstall
cd ..


#taglib
wget -c "https://github.com/taglib/taglib/archive/v1.10.tar.gz"  -O ../taglib-1.10.tar.gz
tar -zxvf ../taglib-1.10.tar.gz
cd taglib-1.10
CC=gcc CXX=g++ cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release . 
CC=gcc CXX=g++ gmake
sudo gmake install INSTALL=ginstall
cd ..

#cddb

#cdio
wget -c "http://ftp.gnu.org/gnu/libcdio/libcdio-0.93.tar.bz2"  -O ../libcdio-0.93.tar.bz2
tar -jxvf ../libcdio-0.93.tar.bz2
cd libcdio-0.93
CC=gcc CXX=g++ bash configure
CC=gcc CXX=g++ gmake
sudo gmake install INSTALL=ginstall
cd ..


#crossguid
cd ..
cd xbmc
sudo gmake -C tools/depends/target/crossguid PREFIX=/usr/local
cd ..




