#!/usr/bin/env bash

set +x
set -e # Abort on error

[[ -d build ]] || mkdir build
cd build

if [[ $target_platform =~ linux.* ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

CC=${BUILD_PREFIX}/bin/${HOST}-gcc CXX=$BUILD_PREFIX/bin/${HOST}-g++ \
    cmake -G "Ninja"\
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DCMAKE_CXX_FLAGS:STRING="-std=c++14" \
    -DCMAKE_INSTALL_PREFIX:STRING=$PREFIX \
    -DBUILD_TESTING:BOOL=OFF \
    -DOTB_USE_6S:BOOL= ON \
    -DOTB_USE_CURL:BOOL=ON \
    -DOTB_USE_GLEW:BOOL=OFF \
    -DOTB_USE_GLFW:BOOL=OFF \
    -DOTB_USE_GLUT:BOOL=OFF \
    -DOTB_USE_GSL:BOOL=ON \
    -DOTB_USE_LIBKML:BOOL=ON \
    -DOTB_USE_LIBSVM:BOOL=ON \
    -DOTB_USE_MAPNIK:BOOL=OFF \
    -DOTB_USE_MPI:BOOL=OFF \
    -DOTB_USE_MUPARSER:BOOL=ON \
    -DOTB_USE_MUPARSERX:BOOL=ON \
    -DOTB_USE_OPENCV:BOOL=ON \
    -DOTB_USE_OPENGL:BOOL=OFF \
    -DOTB_USE_QT:BOOL=OFF \
    -DOTB_USE_QWT:BOOL=OFF \
    -DOTB_USE_SHARK:BOOL=ON \
    -DOTB_USE_SIFTFAST:BOOL=ON \
    -DOTB_USE_SPTW:BOOL=OFF \
    -DOTB_WRAP_PYTHON:BOOL=ON \
    -DOTB_USE_OPENMP:BOOL=ON \
    -DOTB_USE_SSE_FLAGS:BOOL=ON \
    ..

ninja install -j 4

ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/otb-activate.sh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/otb-deactivate.sh
