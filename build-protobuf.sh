#!/bin/sh
set -e
PB_VERSION=3.1.0

if [ -d protobuf-${PB_VERSION} ]
then
    rm -rf protobuf-${PB_VERSION}
fi
    
tar xvf protobuf-${PB_VERSION}.tar.gz

cd protobuf-${PB_VERSION}
./autogen.sh
./configure --host=${CROSS_TRIPLE}
make -j4 || true # build will fail to run tests

mkdir -p ${CROSS_TRIPLE}
cp src/.libs/libprotoc.a ${CROSS_TRIPLE}
cp src/libprotoc.la ${CROSS_TRIPLE}

cp src/.libs/libprotobuf.a ${CROSS_TRIPLE}
cp src/libprotobuf.la ${CROSS_TRIPLE}
