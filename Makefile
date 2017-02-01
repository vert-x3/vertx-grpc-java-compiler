OBJS = $(CROSS_TRIPLE)/java_generator.o $(CROSS_TRIPLE)/java_plugin.o

ifneq ($(CROSS_TRIPLE), x86_64-w64-mingw32)
ifneq ($(CROSS_TRIPLE), i686-w64-mingw32)
    LDEXTRA := -Wl,-Bdynamic -lpthread
endif
endif

$(CROSS_TRIPLE)/protoc-gen-grpc-java.exe: $(OBJS) 
	$(CXX) -o $(CROSS_TRIPLE)/protoc-gen-grpc-java.exe $(OBJS) -static-libgcc -static-libstdc++ -Wl,-Bstatic -L$(CROSS_TRIPLE) -lprotoc -lprotobuf $(LDEXTRA) -s

$(CROSS_TRIPLE)/%.o: ./%.cpp
	$(CXX) -Iprotobuf-3.1.0/src -x c++ -c -DGRPC_VERSION=1.1.1 --std=c++0x -o $@ $< $(CFLAGS) 

.PHONY: clean

clean:
	@rm -f $(CROSS_TRIPLE)/*.o $(CROSS_TRIPLE)/protoc-gen-grpc-java.exe
