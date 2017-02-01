# vertx-grpc-java-compiler 1.1.1

This is a custom protobuf compiled for java targetting the Vert.x programming model.

Not much to see for now...

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

