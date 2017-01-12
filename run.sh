#!/bin/sh
mkdir -p out
protoc --plugin=protoc-gen-grpc-java=./protoc-gen-grpc-java-linux-x86_64.exe --grpc-java_out="out" --proto_path="." "helloworld.proto"
protoc --plugin=protoc-gen-grpc-java=./protoc-gen-grpc-java-linux-x86_64.exe --grpc-java_out="out" --proto_path="." "streaming.proto"