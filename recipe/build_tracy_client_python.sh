#!/bin/sh

rm -rf build
cd python

export CMAKE_GENERATOR=Ninja
${PYTHON} -m pip install --no-deps --no-build-isolation -vv .
