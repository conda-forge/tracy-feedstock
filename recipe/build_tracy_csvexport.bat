cd csvexport

rm -rf build

mkdir build
cd build

cmake .. ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DDOWNLOAD_CAPSTONE=FALSE ^
    -DNO_ISA_EXTENSIONS=ON ^
    -GNinja ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%"

:: build
cmake --build .

:: install
cmake --build . --target install
