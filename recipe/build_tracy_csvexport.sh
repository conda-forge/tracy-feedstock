#!/bin/sh

cd csvexport

rm -rf build

mkdir build && cd build

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DDOWNLOAD_CAPSTONE=FALSE \
    -DNO_ISA_EXTENSIONS=ON \
    -GNinja

# build
cmake --build .

# install
cmake --build . --target install
