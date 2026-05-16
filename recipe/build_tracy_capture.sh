#!/bin/sh

cd capture

rm -rf build
mkdir build && cd build

if [[ "${target_platform}" == osx-* ]]; then
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DNO_ISA_EXTENSIONS=ON \
    -DDOWNLOAD_CAPSTONE=FALSE \
    -GNinja

cmake --build . --parallel ${CPU_COUNT}
cmake --build . --target install
