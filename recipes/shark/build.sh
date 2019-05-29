#!/usr/bin/env bash

set +x
set -e # Abort on error

[[ -d build ]] || mkdir build
cd build

export CMAKE_LIBRARY_PATH=${BUILD_PREFIX}/lib:${CMAKE_LIBRARY_PATH}
export CMAKE_INCLUDE_PATH=${BUILD_PREFIX}/include:${CMAKE_INCLUDE_PATH}

if [[ $target_platform =~ linux.* ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

CC=${BUILD_PREFIX}/bin/${HOST}-gcc CXX=$BUILD_PREFIX/bin/${HOST}-g++ \
    cmake -G "Ninja" \
    -D CMAKE_INSTALL_PREFIX=$PREFIX \
    -D BUILD_SHARED_LIBS:BOOL=ON \
    -D BUILD_DOCS:BOOL=OFF \
    -D BUILD_EXAMPLES:BOOL=OFF \
    -D BUILD_TESTING:BOOL=OFF \
    -D ENABLE_HDF5:BOOL=OFF \
    -D ENABLE_CBLAS:BOOL=ON \
    -D ENABLE_OPENMP:BOOL=ON \
    ..

ninja install

