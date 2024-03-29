FROM ubuntu:xenial

MAINTAINER Rafael Ferreira da Silva <silvarf@ornl.gov>

# add repositories
RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update

# add wrench user
RUN useradd --gid 100 --uid 550 --create-home --password wrench wrench

# install compiler
RUN apt-get -y install g++-6 gcc-6

# build environment
RUN apt-get -y install pkg-config git cmake cmake-data doxygen doxygen-doc doxygen-latex doxygen-gui graphviz libboost-all-dev wget sudo curl lcov python-software-properties

#################################################
# WRENCH's dependencies
#################################################

# set root's environment variable
ENV CXX="g++-6" CC="gcc-6"
WORKDIR /tmp

# install SimGrid
RUN wget https://framagit.org/simgrid/simgrid/uploads/0365f13697fb26eae8c20fc234c5af0e/SimGrid-3.25.tar.gz && tar -xf SimGrid-3.25.tar.gz && cd SimGrid-3.25 && cmake . && make && sudo make install && cd .. && rm -rf SimGrid-3.25*

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
ENV CXX="g++-6" CC="gcc-6"
