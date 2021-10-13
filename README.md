# WRENCH Docker Releases and Builds

This repository contains `Dockerfiles` for WRENCH releases, as well as configuration
files to build containers that are used to build and test WRENCH on variety of platforms.

Docker Hub for WRENCH Releases: https://hub.docker.com/r/wrenchproject/wrench/

Docker Hub for WRENCH Builds: https://hub.docker.com/r/wrenchproject/wrench-build/

---

### Building containers

The following example shows the steps to build a `ubuntu-focal-gcc9` container and push to DockerHub:

```
$ git clone https://github.com/wrench-project/wrench-docker-build
$ cd builds
$ cd ubuntu-focal-gcc9
$ docker build --no-cache -t ubuntu-focal-gcc9 .
$ docker push ubuntu-focal-gcc9
```
