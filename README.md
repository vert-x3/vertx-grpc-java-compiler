[![Build Status](https://travis-ci.org/vert-x3/vertx-grpc-java-compiler.svg?branch=master)](https://travis-ci.org/vert-x3/vertx-grpc-java-compiler)

# vertx-grpc-java-compiler 1.1.1

This is a drop-in replacement gRPC compiler for java targetting the Vert.x programming model.

Besides the normal generation that the official compiler does it adds 2 extra classes to the generation:

* an abstract class <ServiceName>VertxImplBase
* a final class <ServiceName>VertxStub

These new classes follow the vert.x programming model closer than the generic ones so it will feel more
natural to the end user to choose these instead of the official ones. There is no difference between the
implementations since the new generated classes only wrap the vert.x types into the gRPC expected types.

## Build it

gRPC assumes you already have a couple of dependencies on your system:

* Docker
* A working Bash shell
* maven

Docker will be used to provide a set of cross compilers and the output of the build will end up on this directory.

Maven will then collect the binaries and archive into the local repository.

## Build the plugin

```
sudo ./build.sh
```

Note that sudo is used here since in Fedora docker requires it, if you don't need it for your case don't use sudo.

## Archive the maven artifacts

```
mvn install
```
