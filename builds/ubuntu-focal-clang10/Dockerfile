FROM i386/ubuntu:focal

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

ENV CXX="clang++-10" CC="clang-10"
WORKDIR /tmp

# add repositories
RUN apt-get update

# install compiler
RUN apt-get -y install clang-10

# set timezone
RUN echo "America/Los_Angeles" > /etc/timezone && export DEBIAN_FRONTEND=noninteractive && apt-get install -y tzdata

# build environment
RUN apt-get -y install wget sudo curl lcov make git
RUN apt-get -y install pkg-config libboost-all-dev 

# Install cmake 24.2 by hand to build SimGrid 3.32
RUN wget --no-check-certificate https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz && tar -xf cmake-3.24.2.tar.gz && cd cmake-3.24.2 && ./bootstrap -- -DCMAKE_USE_OPENSSL=OFF && make -j2 && sudo make install

#################################################
# WRENCH's dependencies
#################################################

# install SimGrid
RUN wget --no-check-certificate https://framagit.org/simgrid/simgrid/-/archive/v3.34/simgrid-v3.34.tar.gz && tar -xf simgrid-v3.34.tar.gz && cd simgrid-v3.34 && cmake . && make -j12 && sudo make install && cd .. && rm -rf simgrid-v3.34*


# install json for modern c++
RUN wget --no-check-certificate https://github.com/nlohmann/json/archive/refs/tags/v3.10.5.tar.gz && tar -xf v3.10.5.tar.gz && cd json-3.10.5 && cmake . && make -j4 && $SUDO make install && cd .. && rm -rf v3.10.5* json-3.10.5

# install googletest
RUN wget --no-check-certificate https://github.com/google/googletest/archive/refs/tags/release-1.11.0.tar.gz && tar xf release-1.11.0.tar.gz && cd googletest-release-1.11.0 && cmake . && make -j4 && sudo make install && cd .. && rm -rf release-1.11.0.tar.gz googletest-release-1.11.0

#################################################
# WRENCH's user
#################################################
RUN useradd -ms /bin/bash wrench
RUN adduser wrench sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="clang++-10" CC="clang-10"
