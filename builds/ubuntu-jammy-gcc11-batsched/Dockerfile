FROM amd64/ubuntu:jammy

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

# add repositories
RUN apt-get update --fix-missing

# set timezone
RUN echo "America/Los_Angeles" > /etc/timezone && export DEBIAN_FRONTEND=noninteractive && apt-get install -y tzdata

# build environment
RUN apt-get -y install pkg-config git cmake cmake-data libboost-all-dev wget sudo curl

# install compiler
RUN apt-get -y install gcc g++

#################################################
# WRENCH's dependencies
#################################################

# set root's environment variable
ENV CXX="g++" CC="gcc"
WORKDIR /tmp

# install SimGrid
RUN wget --no-check-certificate https://framagit.org/simgrid/simgrid/-/archive/v3.36/simgrid-v3.36.tar.gz && tar -xf simgrid-v3.36.tar.gz && cd simgrid-v3.36 && cmake . && make && sudo make install && cd .. && rm -rf simgrid-v3.36*
#RUN git clone https://framagit.org/simgrid/simgrid.git && cd simgrid && git checkout 1f1b85861ea71dd27d362b70f268b580c1f8c7c4 && mkdir build && cd build && cmake .. && make && sudo make install

# install json for modern c++
RUN wget https://github.com/nlohmann/json/archive/refs/tags/v3.10.5.tar.gz && tar -xf v3.10.5.tar.gz && cd json-3.10.5 && cmake . && make && make install && cd .. && rm -rf v3.10.5* json-3.10.5

# install googletest
RUN wget https://github.com/google/googletest/archive/refs/tags/release-1.11.0.tar.gz && tar xf release-1.11.0.tar.gz && cd googletest-release-1.11.0 && cmake . && make && sudo make install && cd .. && rm -rf release-1.11.0.tar.gz googletest-release-1.11.0

#################################################
# Batsched, ZMQ
#################################################

RUN apt-get install -y nix-bin
RUN echo "filter-syscalls = false" >> /etc/nix/nix.conf
RUN nix-env -iA batsched -f 'https://github.com/oar-team/nur-kapack/archive/master.tar.gz'

# install CPPZMQ
#RUN wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz && tar xvzf zeromq-4.2.2.tar.gz && cd zeromq-4.2.2 && ./configure && make && sudo make install && cd .. && rm -rf zeromq-4.2.2

RUN apt-get install -y libczmq-dev
#RUN wget https://github.com/zeromq/cppzmq/archive/v4.2.2.tar.gz && tar xf v4.2.2.tar.gz && cd cppzmq-4.2.2/ && mkdir build && cd build/ && cmake .. && sudo make -j4 install && cd ../../ && rm -rf v4.2.2.tar.gz cppzmq*



#################################################
# WRENCH's user
#################################################
RUN useradd -ms /bin/bash wrench
RUN adduser wrench sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++" CC="gcc"

# add the nix-installed batsched to the path
ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"
