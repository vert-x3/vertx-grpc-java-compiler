[![Build Status](https://travis-ci.org/vert-x3/vertx-grpc-java-compiler.svg?branch=master)](https://travis-ci.org/vert-x3/vertx-grpc-java-compiler)

# vertx-grpc-java-compiler 1.13.2

This is a drop-in replacement gRPC compiler for java targeting the Vert.x programming model.

Besides the normal generation that the official compiler does it adds 2 extra classes to the generation:

* an abstract class <ServiceName>VertxImplBase
* a final class <ServiceName>VertxStub

These new classes follow the vert.x programming model closer than the generic ones so it will feel more
natural to the end user to choose these instead of the official ones. There is no difference between the
implementations since the new generated classes only wrap the vert.x types into the gRPC expected types.

## Build it

**IMPORTANT**: Read the additional modification made to the code section (below)

gRPC assumes you already have a couple of dependencies on your system:

* Docker
* A working Bash shell
* maven

Docker will be used to provide a set of cross compilers and the output of the build will end up on this directory.

Maven will then collect the binaries and archive into the local repository.

## Build the plugin

```
sudo ./scripts/build.sh
```

Note that sudo is used here since in Fedora docker requires it, if you don't need it for your case don't use sudo.

## Archive the maven artifacts

```
mvn install
```
## Update the code

The process is quite manual.

1. Run a diff between the gRPC tags, replace the versions in the [link](https://github.com/grpc/grpc-java/compare/v1.13.2...v1.13.x)
2. If there are changes in the CPP code try to apply the diff/manual merge
3. Bump the versions on `pom.xml` and `Makefile` to match the new one.
4. Build

When bumping the `protobuf` dependency the following steps are required:

1. Download the `tar.gz` file to the root of the project.
2. Update travis to cache the new version.
3. Update the `Makefile` to use the new version.

**IMPORTANT** A few changes are applied in the code:

1. Stub constructors are made `public` instead of `private`. It improves Java 9 support where reflective calls should not use `setAccessible`. Changes are made in `java_generator.cpp` (such as: https://github.com/vert-x3/vertx-grpc-java-compiler/pull/9/commits/69d8a4fcc2b4d37a265a3f1ae8d4ac203df420dd)
