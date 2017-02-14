#!/bin/sh
set -e
mkdir -p target
# create the base cross compiler image
# docker build . -t vertx-grpc

# Linux64
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-linux-gnu -it vertx-grpc ./scripts/build-protobuf.sh
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-linux-gnu -it vertx-grpc make

# Win32
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=i686-w64-mingw32 -it vertx-grpc ./scripts/build-protobuf.sh
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=i686-w64-mingw32 -it vertx-grpc make

# Win64
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-w64-mingw32 -it vertx-grpc ./scripts/build-protobuf.sh
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-w64-mingw32 -it vertx-grpc make

# OSX
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-apple-darwin -it vertx-grpc ./scripts/build-protobuf.sh
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-apple-darwin -it vertx-grpc make
