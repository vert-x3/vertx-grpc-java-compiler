# vertx-grpc-java-compiler

This is a custom protobuf compiled for java targetting the Vert.x programming model.

Not much to see for now...

## Build it

gRPC assumes you already have a couple of dependencies on your system:

* Java >=1.7
* `libprotoc` and `libprotobuf`
* a (not to old) Working C++ compiler toolchain

## Fedora build machine dependencies

* gcc
* gcc-c++
* mingw32-gcc
* mingw32-gcc-c++
* mingw64-gcc
* mingw64-gcc-c++

## Build the protobuf dependency

```
cd build
./build-linux.sh
./build-win32.sh
./build-linux.sh
```

You should have now the dependencies to build the plugin.

## Build the plugin

```
make clean
make

make -f Makefile.win32 clean
make -f Makefile.win32

make -f Makefile.win64 clean
make -f Makefile.win64
```

## Archive the maven artifacts

```
mvn install
```

