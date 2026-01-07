#!/bin/sh

cd profiler

# Tracy build a tool (embed) that is used to generate source files.
# When cross building, embed is run by build architecture and must be build
# for it.
# The following code configure the compiler and compilation flags to build embed
# in build architecture.
# This code is heavily inspired from this one:
# https://github.com/conda-forge/pyside2-feedstock/blob/37d071b008afab69ef6a221e31446c1f46a3a754/recipe/build.sh#L9-L34
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == 1 && "${CMAKE_CROSSCOMPILING_EMULATOR:-}" == "" ]]; then
(
    cd helpers
    rm -rf build
    mkdir build && cd build

    export CC=$CC_FOR_BUILD
    export CXX=$CXX_FOR_BUILD
    export LDFLAGS=${LDFLAGS//$PREFIX/$BUILD_PREFIX}
    export CFLAGS=${CFLAGS//$PREFIX/$BUILD_PREFIX}
    export CXXFLAGS=${CXXFLAGS//$PREFIX/$BUILD_PREFIX}

    # hide host libs
    mkdir -p $BUILD_PREFIX/${HOST}
    mv $BUILD_PREFIX/${HOST} _hidden

    cmake ${CMAKE_ARGS} .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${BUILD_PREFIX}/bin \
        -GNinja

    # build
    cmake --build . --parallel ${CPU_COUNT}

    # install
    cmake --build . --target install

    mv _hidden $BUILD_PREFIX/${HOST}
)
fi


rm -rf build

mkdir build && cd build

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

    # pugixml use CXX 20 module and need clang-scan-deps.
    # It's installed by the clang-tools package, but it doesn't have the right CMAKE_TOOLCHAIN_PREFIX.
    CMAKE_CUSTOM_ARGS="-DCMAKE_CXX_COMPILER_CLANG_SCAN_DEPS="clang-scan-deps""
fi

cmake ${CMAKE_ARGS} ${CMAKE_CUSTOM_ARGS} .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DLEGACY=TRUE \
    -DDOWNLOAD_CAPSTONE=FALSE \
    -GNinja

# build
cmake --build . --parallel ${CPU_COUNT}

# install
cmake --build . --target install

