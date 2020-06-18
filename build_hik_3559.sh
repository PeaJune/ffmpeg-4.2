#!/bin/sh

workspace=$(cd `dirname $0`; pwd)
#echo "$workspace"
cd $workspace
if [ -e config.h ];then
	arch=`cat config.h | grep ARCH_AARCH64 | awk '{print $3}' | xargs`
	if [ $arch -eq 0 ];then
		make clean
	fi
fi

##cross compile toolchain env
export PATH=/opt/hisi-linux/x86-arm/aarch64-himix100-linux/bin/:$PATH

./configure --prefix=${workspace}/install/arm64  --disable-zlib --disable-sdl2 --disable-ffmpeg --disable-ffprobe --disable-ffplay --disable-avdevice --enable-shared  --enable-cross-compile --cross-prefix=aarch64-himix100-linux-  --arch=arm64 --target-os=linux --extra-cflags=" -fPIC " --disable-neon

make -j20 && make install
