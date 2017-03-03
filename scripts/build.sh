#!/bin/sh
set -e
mkdir -p target

# Linux64
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-linux-gnu -it multiarch/crossbuild ./scripts/build-protobuf.sh
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-linux-gnu -it multiarch/crossbuild make

# Win32
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=i686-w64-mingw32 -it multiarch/crossbuild ./scripts/build-protobuf.sh
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=i686-w64-mingw32 -it multiarch/crossbuild make

# Win64
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-w64-mingw32 -it multiarch/crossbuild ./scripts/build-protobuf.sh
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-w64-mingw32 -it multiarch/crossbuild make

# OSX
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-apple-darwin -it multiarch/crossbuild ./scripts/build-protobuf.sh
docker run --rm -v $(pwd):/workdir:Z -e CROSS_TRIPLE=x86_64-apple-darwin -it multiarch/crossbuild make
