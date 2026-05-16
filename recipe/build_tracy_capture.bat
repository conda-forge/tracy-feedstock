cd capture

rm -rf build
mkdir build
cd build

cmake .. ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DNO_ISA_EXTENSIONS=ON ^
    -GNinja ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%"

cmake --build . --parallel %CPU_COUNT%
cmake --build . --target install
