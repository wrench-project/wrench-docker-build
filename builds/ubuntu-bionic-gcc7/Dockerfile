FROM ubuntu:bionic

MAINTAINER Rafael Ferreira da Silva <silvarf@ornl.gov>

# add repositories
RUN apt-get update

# add wrench user
RUN useradd --gid 100 --uid 550 --create-home --password wrench wrench

# install compiler
RUN apt-get -y install g++ gcc

# set timezone
RUN echo "America/Los_Angeles" > /etc/timezone && export DEBIAN_FRONTEND=noninteractive && apt-get install -y tzdata

# build environment
RUN apt-get -y install pkg-config git cmake cmake-data doxygen doxygen-doc doxygen-latex doxygen-gui graphviz libboost-all-dev wget sudo curl lcov default-jre

#################################################
# WRENCH's dependencies
#################################################

# set root's environment variable
ENV CXX="g++-7" CC="gcc-7"
WORKDIR /tmp

# install SimGrid
RUN wget https://framagit.org/simgrid/simgrid/-/archive/v3.30/simgrid-v3.30.tar.gz && tar -xf simgrid-v3.30.tar.gz && cd simgrid-v3.30 && cmake . && make -j12 && sudo make install && cd .. && rm -rf simgrid-v3.30*

# install pugixml
RUN wget https://github.com/zeux/pugixml/releases/download/v1.8.1/pugixml-1.8.1.tar.gz && tar -xf pugixml-1.8.1.tar.gz && cd pugixml-1.8 && cmake . && make && sudo make install && cd .. && rm -rf pugixml-1.8*

# install json for modern c++
RUN wget https://github.com/nlohmann/json/archive/v3.7.0.tar.gz && tar -xf v3.7.0.tar.gz && cd json-3.7.0 && cmake . && make && $SUDO make install && cd .. && rm -rf v3.7.0* json-3.7.0

# install googletest
RUN wget https://github.com/google/googletest/archive/release-1.8.0.tar.gz && tar xf release-1.8.0.tar.gz && cd googletest-release-1.8.0/googletest && cmake . && make && sudo make install && cd ../.. && rm -rf release-1.8.0.tar.gz googletest-release-1.8.0

#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-7" CC="gcc-7"
