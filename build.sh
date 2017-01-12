#!/bin/sh
rm -Rf bin

make clean
make

make -f Makefile.win32 clean
make -f Makefile.win32

make -f Makefile.win64 clean
make -f Makefile.win64

make -f Makefile.mac clean
make -f Makefile.mac

mvn install
