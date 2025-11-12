FROM amd64/ubuntu:noble

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
RUN wget --no-check-certificate https://github.com/simgrid/simgrid/releases/download/v4.1/simgrid-4.1.tar.gz && tar -xf simgrid-4.1.tar.gz && cd simgrid-4.1 && cmake . && make  && sudo make install && cd .. && rm -rf simgrid-4.1*
#RUN git clone https://framagit.org/simgrid/simgrid.git && cd simgrid && git checkout 1f1b85861ea71dd27d362b70f268b580c1f8c7c4 && mkdir build && cd build && cmake .. && make && sudo make install

# install SimGrid's FSMod
RUN wget https://github.com/simgrid/file-system-module/archive/refs/tags/v0.4.tar.gz && tar -xf v0.4.tar.gz && cd file-system-module-0.4 && mkdir build && cd build && cmake .. && make  && sudo make install && cd ../.. && rm -rf v0.4.tar.gz file-system-module-v*

# install json for modern c++
RUN wget https://github.com/nlohmann/json/archive/refs/tags/v3.11.3.tar.gz && tar -xf v3.11.3.tar.gz && cd json-3.11.3 && cmake . && make && $SUDO make install && cd .. && rm -rf v3.11.3* json-3.11.3

# install googletest
RUN wget https://github.com/google/googletest/archive/refs/tags/release-1.11.0.tar.gz && tar xf release-1.11.0.tar.gz && cd googletest-release-1.11.0 && cmake . && make && sudo make install && cd .. && rm -rf release-1.11.0.tar.gz googletest-release-1.11.0

# install libasio-dev
RUN apt-get -y install libasio-dev

# install python and jsonref package to build wrench-daemon
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN pip install --break-system-packages jsonref

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
