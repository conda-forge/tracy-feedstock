#!/bin/sh

cd profiler

rm -rf build

mkdir build && cd build

cmake ${CMAKE_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DLEGACY=TRUE \
    -DDOWNLOAD_CAPSTONE=FALSE \
    -GNinja

# build
cmake --build . --parallel ${CPU_COUNT}

# install
cmake --build . --target install

