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
./configure
make -j4

mkdir -p ${BASE}/../lib/osx
cp src/.libs/libprotoc.a ${BASE}/../lib/osx
cp src/libprotoc.la ${BASE}/../lib/osx

cp src/.libs/libprotobuf.a ${BASE}/../lib/osx
cp src/libprotobuf.la ${BASE}/../lib/osx
