#!/bin/sh

rm -rf build

mkdir build && cd build

cmake ${CMAKE_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DTRACY_DELAYED_INIT=ON \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -GNinja

# build
cmake --build .

# install
cmake --build . --target install
