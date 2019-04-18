#!/usr/bin/env bash

#!/usr/bin/env bash

set +x
set -e # Abort on error

[[ -d build ]] || mkdir build
cd build

echo "Current work directory: $(pwd)"
echo "BUILD_PREFIX: ${BUILD_PREFIX}"
echo "PREFIX: ${PREFIX}"

export CMAKE_LIBRARY_PATH=${BUILD_PREFIX}/lib:${CMAKE_LIBRARY_PATH}
export CMAKE_INCLUDE_PATH=${BUILD_PREFIX}/include:${CMAKE_INCLUDE_PATH}
export CMAKE_LIBRARY_PATH=${BUILD_PREFIX}/${HOST}/sysroot/usr/lib:${CMAKE_LIBRARY_PATH}

if [[ $target_platform =~ linux.* ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

CC=${BUILD_PREFIX}/bin/${HOST}-gcc CXX=$BUILD_PREFIX/bin/${HOST}-g++ \
    cmake -D CMAKE_INSTALL_PREFIX=$PREFIX -DBUILD_SHARED_LIBS:BOOL=ON ..
ninja install

