#!/bin/sh
set -e
PB_VERSION=3.3.0

# init
mkdir -p target/${CROSS_TRIPLE}/protobuf-${PB_VERSION}
cd target

if [ ! -d protobuf-${PB_VERSION} ]; then
  tar xvf ../protobuf-java-${PB_VERSION}.tar.gz
  cd protobuf-${PB_VERSION}
  ./autogen.sh
  cd ..
fi

# quick escape if libs are cached
if [ ! -f ${CROSS_TRIPLE}/protobuf-${PB_VERSION}/libprotoc.a ] || [ ! -f ${CROSS_TRIPLE}/protobuf-${PB_VERSION}/libprotobuf.a ]; then
  
  cd ${CROSS_TRIPLE}/protobuf-${PB_VERSION}

  if [ ! "${CROSS_TRIPLE}" = "x86_64-linux-gnu" ]; then
    mkdir -p src
    cp ../../host/* src
  fi

  if [ "${CROSS_TRIPLE}" = "x86_64-apple-darwin14" ]; then
    $(/usr/x86_64-apple-darwin14/bin/osxcross-env)
    $(/usr/x86_64-apple-darwin14/bin/osxcross-conf)
  fi

  if [ "${CROSS_TRIPLE}" = "x86_64-apple-darwin14" ]; then
    ../../protobuf-${PB_VERSION}/configure --host=${CROSS_TRIPLE} --enable-shared=no --with-protoc=../../host/protoc ${CONFIGURE_EXTRAS} CC=o64-clang CXX=o64-clang++ CXXFLAGS='-std=c++11 -stdlib=libc++' LDFLAGS='-stdlib=libc++' LIBS="-lc++ -lc++abi"
  else
    if [ ! "${CROSS_TRIPLE}" = "x86_64-linux-gnu" ]; then
      ../../protobuf-${PB_VERSION}/configure --host=${CROSS_TRIPLE} --enable-shared=no --with-protoc=../../host/protoc ${CONFIGURE_EXTRAS}
    else
      ../../protobuf-${PB_VERSION}/configure --host=${CROSS_TRIPLE} --enable-shared=no ${CONFIGURE_EXTRAS}
    fi
  fi

  make -j4

  cp src/.libs/libprotoc.a .
  cp src/libprotoc.la .

  cp src/.libs/libprotobuf.a .
  cp src/libprotobuf.la .

  if [ "${CROSS_TRIPLE}" = "x86_64-linux-gnu" ]; then
    # save the host js_embed and protoc
    mkdir -p ../../host
    cp src/js_embed ../../host/js_embed
    cp src/js_embed ../../host/js_embed.exe
    cp src/protoc ../../host/protoc
  fi

  # clean so we save some space on the cache
  make clean || true
fi
