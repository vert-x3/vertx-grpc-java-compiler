grpc: java_generator.o java_plugin.o
	g++ -o grpc java_plugin.o java_generator.o -lpthread -lprotoc -lprotobuf -m64

java_generator.o: java_generator.cpp java_generator.h
	g++ -x c++ -c -DGRPC_VERSION=1.1.0-SNAPSHOT --std=c++0x -I/home/plopes/Projects/grpc-java/compiler/src/java_plugin/headers -m64 java_generator.cpp

java_plugin.o: java_plugin.cpp
	g++ -x c++ -c -DGRPC_VERSION=1.1.0-SNAPSHOT --std=c++0x -I/home/plopes/Projects/grpc-java/compiler/src/java_plugin/headers -m64 java_plugin.cpp
