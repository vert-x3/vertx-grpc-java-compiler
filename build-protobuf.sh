#!/bin/sh
set -e
PB_VERSION=3.1.0

if [ "${CROSS_TRIPLE}" = "x86_64-apple-darwin14" ]
then
    $(/usr/x86_64-apple-darwin14/bin/osxcross-env)
    $(/usr/x86_64-apple-darwin14/bin/osxcross-conf)
fi

if [ -d protobuf-${PB_VERSION} ]
then
    rm -rf protobuf-${PB_VERSION}
fi
    
tar xvf protobuf-${PB_VERSION}.tar.gz

cd protobuf-${PB_VERSION}
./autogen.sh
if [ "${CROSS_TRIPLE}" = "x86_64-apple-darwin14" ]
then
    ./configure --host=${CROSS_TRIPLE} --enable-shared=no ${CONFIGURE_EXTRAS} CC=o64-clang CXX=o64-clang++ CXXFLAGS='-std=c++11 -stdlib=libc++' LDFLAGS='-stdlib=libc++' LIBS="-lc++ -lc++abi"
else
    ./configure --host=${CROSS_TRIPLE} --enable-shared=no ${CONFIGURE_EXTRAS}
fi

make -j4 || true # build will fail to run tests

mkdir -p ../${CROSS_TRIPLE}
cp src/.libs/libprotoc.a ../${CROSS_TRIPLE}
cp src/libprotoc.la ../${CROSS_TRIPLE}

cp src/.libs/libprotobuf.a ../${CROSS_TRIPLE}
cp src/libprotobuf.la ../${CROSS_TRIPLE}
