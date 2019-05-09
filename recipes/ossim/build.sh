#!/usr/bin/env bash

set +x
set -e # Abort on error

[[ -d build ]] || mkdir build
cd build

#Force C++14 compilation
export CXXFLAGS=${CXXFLAGS//c++17/c++14}

if [[ $target_platform =~ linux.* ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

CC=${BUILD_PREFIX}/bin/${HOST}-gcc CXX=$BUILD_PREFIX/bin/${HOST}-g++ \
    cmake -G "Ninja" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DProject_WC_REVISION:STRING=23665 \
    -DBUILD_OSSIM_MPI_SUPPORT:BOOL=OFF \
    -DBUILD_OSSIM_FREETYPE_SUPPORT:BOOL=ON \
    -DBUILD_OSSIM_APPS:BOOL=OFF \
    -DBUILD_OSSIM_TEST_APPS:BOOL=OFF \
    -DBUILD_OSSIM_FRAMEWORKS:BOOL=OFF \
    -DINSTALL_ARCHIVE_DIR:STRING=lib \
    -DINSTALL_LIBRARY_DIR:STRING=lib \
    ..

ninja install -j 4

