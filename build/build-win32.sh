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
mingw32-configure
make -j4 || true # build should fail on running exe... ignore

mkdir -p ${BASE}/../lib/win32
cp src/.libs/libprotoc.a ${BASE}/../lib/win32
cp src/libprotoc.la ${BASE}/../lib/win32

cp src/.libs/libprotobuf.a ${BASE}/../lib/win32
cp src/libprotobuf.la ${BASE}/../lib/win32
