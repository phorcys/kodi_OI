# kodi_OI
Patches and build script  for building  kodi  on  OpenIndiana.

1.   update to latest  OI version  hipster-2015
     do a   sudo pkg update

2.   run  build_kodi_OI_depends.sh
     you may want to run the pkg update command by yourself
          sudo pkg set-publisher -O http://pkg.openindiana.org/hipster-encumbered hipster-encumbered 
          sudo pkg install  build-essential  doxygen boost nasm  mariadb-55 fribidi libass libmpeg2 libdca microhttpd libpthread-stubs mesa glu glw libsmbclient video/ffmpeg gperf libdvdread libsmbclient system/header/header-audio
3.   wait for depends install finished, (you may need compile mesa(only EGL part) if you are in a vm)
     run  build_kodi_OI.sh

4.   run  run_kodi_OI.sh

