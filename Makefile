OBJS = $(CROSS_TRIPLE)/java_generator.o $(CROSS_TRIPLE)/java_plugin.o

LDFLAGS := -static-libgcc -static-libstdc++ -Wl,-Bstatic
LDEXTRA := -s

ifneq ($(CROSS_TRIPLE), x86_64-w64-mingw32)
ifneq ($(CROSS_TRIPLE), i686-w64-mingw32)
    LDEXTRA := -Wl,-Bdynamic -lpthread -s
endif
endif

ifeq ($(CROSS_TRIPLE), x86_64-apple-darwin14)
    PATH := /usr/x86_64-apple-darwin14/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/osxcross/bin
    CC := o64-clang
    CXX := o64-clang++
    CXXFLAGS := -std=c++11 -stdlib=libc++
    LDFLAGS := -stdlib=libc++
    LDEXTRA := -lc++ -lc++abi
endif

$(CROSS_TRIPLE)/protoc-gen-grpc-java.exe: $(OBJS)
	$(CXX) -o $(CROSS_TRIPLE)/protoc-gen-grpc-java.exe $(OBJS) $(LDFLAGS) -L$(CROSS_TRIPLE) -lprotoc -lprotobuf $(LDEXTRA)

$(CROSS_TRIPLE)/%.o: ./%.cpp
	$(CXX) -Iprotobuf-3.1.0/src -x c++ -c -DGRPC_VERSION=1.1.1 --std=c++0x -o $@ $< $(CXXFLAGS) 

.PHONY: clean

clean:
	@rm -f $(CROSS_TRIPLE)/*.o $(CROSS_TRIPLE)/protoc-gen-grpc-java.exe
