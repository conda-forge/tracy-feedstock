#!/bin/sh

cd csvexport

rm -rf build
mkdir build && cd build

if [[ "${target_platform}" == osx-* ]]; then
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

    # pugixml use CXX 20 module and need clang-scan-deps.
    # It's installed by the clang-tools package, but it doesn't have the right CMAKE_TOOLCHAIN_PREFIX.
    CLANG_SCAN_DEPS=$(which clang-scan-deps)
    CMAKE_CUSTOM_ARGS="-DCMAKE_CXX_COMPILER_CLANG_SCAN_DEPS=${CLANG_SCAN_DEPS}"
fi

cmake ${CMAKE_ARGS} ${CMAKE_CUSTOM_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DNO_ISA_EXTENSIONS=ON \
    -DDOWNLOAD_CAPSTONE=FALSE \
    -GNinja

cmake --build . --parallel ${CPU_COUNT}
cmake --build . --target install
