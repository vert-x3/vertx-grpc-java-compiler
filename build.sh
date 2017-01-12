#!/bin/sh
set -e

make clean
make

make -f Makefile.win32 clean
make -f Makefile.win32

make -f Makefile.win64 clean
make -f Makefile.win64

mvn install
