protoc-gen-grpc-java-linux-x86_64.exe: java_generator.o java_plugin.o
	g++ -o protoc-gen-grpc-java-linux-x86_64.exe java_plugin.o java_generator.o -lpthread lib/linux/libprotoc.a lib/linux/libprotobuf.a -m64 -s
	mkdir -p bin
	cp protoc-gen-grpc-java-linux-x86_64.exe bin

java_generator.o: java_generator.cpp java_generator.h
	g++ -Ibuild/protobuf-3.1.0/src -x c++ -c -DGRPC_VERSION=1.0.3 --std=c++0x -m64 java_generator.cpp

java_plugin.o: java_plugin.cpp
	g++ -Ibuild/protobuf-3.1.0/src -x c++ -c -DGRPC_VERSION=1.0.3 --std=c++0x -m64 java_plugin.cpp

clean: 
	rm -f *.exe *.o
