#!/usr/bin/env bash

set +x
set -e # Abort on error

[[ -d build ]] || mkdir build
cd build

if [[ $target_platform =~ linux.* ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

CC=${BUILD_PREFIX}/bin/${HOST}-gcc CXX=$BUILD_PREFIX/bin/${HOST}-g++ \
    cmake -G "Ninja" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS:BOOL=ON ..
ninja install

