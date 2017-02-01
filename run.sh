#!/bin/sh
mkdir -p out
protoc --plugin=protoc-gen-grpc-java=./x86_64-linux-gnu/protoc-gen-grpc-java.exe --grpc-java_out="out" --proto_path="." "helloworld.proto"
protoc --plugin=protoc-gen-grpc-java=./x86_64-linux-gnu/protoc-gen-grpc-java.exe --grpc-java_out="out" --proto_path="." "streaming.proto"