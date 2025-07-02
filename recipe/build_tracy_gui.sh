#!/bin/sh

cd profiler

rm -rf build

mkdir build && cd build

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DLEGACY=TRUE \
    -DDOWNLOAD_CAPSTONE=FALSE \
    -GNinja

# build
cmake --build . --parallel ${CPU_COUNT}

# install
cmake --build . --target install

