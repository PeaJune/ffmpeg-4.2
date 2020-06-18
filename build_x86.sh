#!/bin/sh

workspace=$(cd `dirname $0`; pwd)
#echo "$workspace"
cd $workspace
if [ -e config.h ];then
	arch=`cat config.h | grep -w "ARCH_X86" | awk '{print $3}' | xargs`
	if [ $arch -eq 0 ];then
		make clean
	fi
fi

##x86 compile

./configure --prefix=${workspace}/install/x86  --disable-lzma --disable-zlib --disable-sdl2 --disable-ffmpeg --disable-ffprobe --disable-ffplay --disable-avdevice --enable-shared --extra-cflags=" -fPIC "

make -j20 && make install
