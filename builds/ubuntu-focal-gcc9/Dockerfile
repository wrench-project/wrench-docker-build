FROM i386/ubuntu:focal

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

# add repositories
RUN apt-get clean
RUN apt-get update

# set timezone
RUN echo "America/Los_Angeles" > /etc/timezone && export DEBIAN_FRONTEND=noninteractive && apt-get install -y tzdata

# build environment
RUN apt-get -y install pkg-config
RUN apt-get -y install graphviz
RUN apt-get -y install libboost-all-dev
RUN apt-get -y install wget sudo curl make git
RUN apt-get -y install lcov
#RUN apt-get -y install default-jre
RUN apt-get -y install flex
RUN apt-get -y install bison

# install compiler
RUN apt-get -y install g++ gcc

#################################################
# WRENCH's dependencies
#################################################

# set root's environment variable
ENV CXX="g++-9" CC="gcc-9"
WORKDIR /tmp

# install cmake 3.24
RUN wget --no-check-certificate https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz && tar -xf cmake-3.24.2.tar.gz && cd cmake-3.24.2 && ./bootstrap -- -DCMAKE_USE_OPENSSL=OFF && make -j2 && sudo make install

# install SimGrid
RUN wget --no-check-certificate https://framagit.org/simgrid/simgrid/-/archive/v3.34/simgrid-v3.34.tar.gz && tar -xf simgrid-v3.34.tar.gz && cd simgrid-v3.34 && cmake . && make -j12 && sudo make install && cd .. && rm -rf simgrid-v3.34*


# install json for modern c++
RUN wget --no-check-certificate https://github.com/nlohmann/json/archive/refs/tags/v3.10.4.tar.gz && tar -xf v3.10.4.tar.gz && cd json-3.10.4 && cmake . && make -j4 && $SUDO make install && cd .. && rm -rf v3.10.4* json-3.10.4

# install googletest
RUN wget --no-check-certificate https://github.com/google/googletest/archive/refs/tags/release-1.11.0.tar.gz && tar xf release-1.11.0.tar.gz && cd googletest-release-1.11.0 && cmake . && make -j4 && sudo make install && cd .. && rm -rf release-1.11.0.tar.gz googletest-release-1.11.0

# install sphinx docs
RUN apt-get install -y python3-pip
RUN pip3 install Sphinx sphinx-rtd-theme breathe recommonmark

#################################################
# WRENCH's user
#################################################
RUN useradd -ms /bin/bash wrench
RUN adduser wrench sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-9" CC="gcc-9"
