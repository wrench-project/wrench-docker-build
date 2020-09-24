FROM ubuntu:focal

MAINTAINER Rafael Ferreira da Silva <rafsilva@isi.edu>

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
ENV CXX="g++-9" CC="gcc-9"
WORKDIR /tmp

# install SimGrid
RUN wget https://framagit.org/simgrid/simgrid/uploads/0365f13697fb26eae8c20fc234c5af0e/SimGrid-3.25.tar.gz && tar -xf SimGrid-3.25.tar.gz && cd SimGrid-3.25 && cmake . && make && sudo make install && cd .. && rm -rf SimGrid-3.25*

# install pugixml
RUN wget https://github.com/zeux/pugixml/archive/v1.10.tar.gz && tar -xf v1.10.tar.gz && cd pugixml-1.10 && cmake . && make && sudo make install && cd .. && rm -rf v1.10* pugixml-1.10*

# install json for modern c++
RUN wget https://github.com/nlohmann/json/archive/v3.9.0.tar.gz && tar -xf v3.9.0.tar.gz && cd json-3.9.0 && cmake . && make && $SUDO make install && cd .. && rm -rf v3.9.0* json-3.9.0

# install googletest
RUN wget https://github.com/google/googletest/archive/release-1.10.0.tar.gz && tar xf release-1.10.0.tar.gz && cd googletest-release-1.10.0 && cmake . && make && sudo make install && cd .. && rm -rf release-1.10.0.tar.gz googletest-release-1.10.0

#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-9" CC="gcc-9"
