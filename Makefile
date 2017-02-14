OBJS = target/$(CROSS_TRIPLE)/java_generator.o target/$(CROSS_TRIPLE)/java_plugin.o

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

target/$(CROSS_TRIPLE)/protoc-gen-grpc-java.exe: init $(OBJS)
	$(CXX) -W -o target/$(CROSS_TRIPLE)/protoc-gen-grpc-java.exe $(OBJS) $(LDFLAGS) -Ltarget/$(CROSS_TRIPLE)/protobuf-3.1.0 -lprotoc -lprotobuf $(LDEXTRA)

target/$(CROSS_TRIPLE)/%.o: src/main/cpp/%.cpp
	$(CXX) -W -Itarget/protobuf-3.1.0/src -x c++ -c -DGRPC_VERSION=1.1.1 --std=c++0x -o $@ $< $(CXXFLAGS) 

.PHONY: clean

init:
	@mkdir -p target

clean:
	@rm -f target
