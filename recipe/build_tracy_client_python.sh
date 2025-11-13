#!/bin/sh

rm -rf build
cd python

if [[ "${target_platform}" == osx-* ]]; then
    # Binding setup CXX 20 and need clang-scan-deps.
    # It's installed by the clang-tools package, but it doesn't have the right CMAKE_TOOLCHAIN_PREFIX.
    export SKBUILD_CMAKE_DEFINE=CMAKE_CXX_COMPILER_CLANG_SCAN_DEPS=clang-scan-deps
fi
export CMAKE_GENERATOR=Ninja
${PYTHON} -m pip install --no-deps --no-build-isolation -vv .
