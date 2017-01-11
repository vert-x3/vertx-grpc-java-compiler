#!/bin/sh
mkdir -p out
protoc --plugin=protoc-gen-grpc-java=./grpc --grpc-java_out="out" --proto_path="." "helloworld.proto"