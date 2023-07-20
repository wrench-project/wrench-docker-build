FROM amd64/ubuntu:jammy

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

# add repositories
RUN apt-get update --fix-missing

# set timezone
RUN echo "America/Los_Angeles" > /etc/timezone && export DEBIAN_FRONTEND=noninteractive && apt-get install -y tzdata

# build environment
RUN apt-get -y install pkg-config git cmake cmake-data libboost-all-dev wget sudo curl

# install compiler
RUN apt-get -y install clang

#################################################
# WRENCH's dependencies
#################################################

# set root's environment variable
ENV CXX="clang++" CC="clang"
WORKDIR /tmp

# install SimGrid
RUN wget --no-check-certificate https://framagit.org/simgrid/simgrid/-/archive/v3.34/simgrid-v3.34.tar.gz && tar -xf simgrid-v3.34.tar.gz && cd simgrid-v3.34 && cmake . && make -j12 && sudo make install && cd .. && rm -rf simgrid-v3.34*


# install json for modern c++
RUN wget https://github.com/nlohmann/json/archive/refs/tags/v3.10.5.tar.gz && tar -xf v3.10.5.tar.gz && cd json-3.10.5 && cmake . && make -j4 && make install && cd .. && rm -rf v3.10.5* json-3.10.5

# install googletest
RUN wget https://github.com/google/googletest/archive/refs/tags/release-1.11.0.tar.gz && tar xf release-1.11.0.tar.gz && cd googletest-release-1.11.0 && cmake . && make -j4 && sudo make install && cd .. && rm -rf release-1.11.0.tar.gz googletest-release-1.11.0

#################################################
# WRENCH's user
#################################################
RUN useradd -ms /bin/bash wrench
RUN adduser wrench sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="clang++" CC="clang"
