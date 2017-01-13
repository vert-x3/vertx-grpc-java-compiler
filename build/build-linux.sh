#!/bin/sh
set -e
BASE=$(pwd)
PB_VERSION=3.1.0

if [ -d ${BASE}/protobuf-${PB_VERSION} ]
then
    rm -rf ${BASE}/protobuf-${PB_VERSION}
fi
    
tar xvf ${BASE}/protobuf-${PB_VERSION}.tar.gz

cd ${BASE}/protobuf-${PB_VERSION}
./autogen.sh
./configure --target=${CROSS_TRIPLE}
make -j4

mkdir -p ${BASE}/../${CROSS_TRIPLE}
cp src/.libs/libprotoc.a ${BASE}/../${CROSS_TRIPLE}
cp src/libprotoc.la ${BASE}/../${CROSS_TRIPLE}

cp src/.libs/libprotobuf.a ${BASE}/../${CROSS_TRIPLE}
cp src/libprotobuf.la ${BASE}/../${CROSS_TRIPLE}
