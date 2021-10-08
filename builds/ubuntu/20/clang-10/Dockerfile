FROM ubuntu:focal

MAINTAINER Rafael Ferreira da Silva <silvarf@ornl.gov>

# add repositories
RUN apt-get update

# add wrench user
RUN useradd --gid 100 --uid 550 --create-home --password wrench wrench

# install compiler
RUN apt-get -y install clang-10

# set timezone
RUN echo "America/Los_Angeles" > /etc/timezone && export DEBIAN_FRONTEND=noninteractive && apt-get install -y tzdata

# build environment
RUN apt-get -y install pkg-config git cmake cmake-data doxygen doxygen-doc doxygen-latex doxygen-gui graphviz libboost-all-dev wget sudo curl lcov

#################################################
# WRENCH's dependencies
#################################################

# set root's environment variable
ENV CXX="clang++-10" CC="clang-10"
WORKDIR /tmp

# install SimGrid
RUN wget https://framagit.org/simgrid/simgrid/-/archive/v3.29/simgrid-v3.29.tar.gz && tar -xf simgrid-v3.29.tar.gz && cd simgrid-v3.29 && cmake . && make -j12 && sudo make install && cd .. && rm -rf simgrid-v3.29*

# install pugixml
RUN wget http://github.com/zeux/pugixml/releases/download/v1.11/pugixml-1.11.tar.gz && tar -xf pugixml-1.11.tar.gz && cd pugixml-1.11 && cmake . && make -j12 && sudo make install && cd .. && rm -rf pugixml-1.11*

# install json for modern c++
RUN wget https://github.com/nlohmann/json/archive/v3.9.1.tar.gz && tar -xf v3.9.1.tar.gz && cd json-3.9.1 && cmake . && make -j12 && $SUDO make install && cd .. && rm -rf v3.9.1* json-3.9.1

# install googletest
RUN wget https://github.com/google/googletest/archive/release-1.10.0.tar.gz && tar xf release-1.10.0.tar.gz && cd googletest-release-1.10.0 && cmake . && make -j12 && sudo make install && cd .. && rm -rf release-1.10.0.tar.gz googletest-release-1.10.0

#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="clang++-10" CC="clang-10"
