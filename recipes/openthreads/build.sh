#!/usr/bin/env bash

set +x
set -e # Abort on error

[[ -d build ]] || mkdir build
cd build

#export CMAKE_LIBRARY_PATH=${BUILD_PREFIX}/lib:${CMAKE_LIBRARY_PATH}
#export CMAKE_LIBRARY_PATH=${BUILD_PREFIX}/${HOST}/sysroot/usr/lib:${CMAKE_LIBRARY_PATH}
#export CMAKE_INCLUDE_PATH=${BUILD_PREFIX}/${HOST}/sysroot/usr/include:${CMAKE_INCLUDE_PATH}
#export CMAKE_INCLUDE_PATH=${BUILD_PREFIX}/${HOST}/include:${CMAKE_INCLUDE_PATH}
#export CMAKE_INCLUDE_PATH=${BUILD_PREFIX}/include:${CMAKE_INCLUDE_PATH}


#export CXXFLAGS="-I${BUILD_PREFIX}/include -I${BUILD_PREFIX}/${HOST}/include/ -I${BUILD_PREFIX}/${HOST}/sysroot/usr/include"

if [[ $target_platform =~ linux.* ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

CC=${BUILD_PREFIX}/bin/${HOST}-gcc CXX=$BUILD_PREFIX/bin/${HOST}-g++ \
    cmake -G "Ninja" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS:BOOL=ON ..
ninja install

