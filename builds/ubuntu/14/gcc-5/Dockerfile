FROM ubuntu:trusty

MAINTAINER Rafael Ferreira da Silva <rafsilva@isi.edu>

# add repositories
RUN apt-get update
RUN apt-get -y install software-properties-common python-software-properties
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
#RUN add-apt-repository ppa:george-edison55/cmake-3.x
RUN add-apt-repository ppa:nschloe/cmake-nightly

RUN apt-get update

# add wrench user
RUN useradd --gid 100 --uid 550 --create-home --password wrench wrench

# install compiler
RUN apt-get -y install g++-5 gcc-5

#RUN apt-get -y install pkg-config git make cmake cmake-data doxygen doxygen-doc doxygen-latex doxygen-gui graphviz libboost-all-dev wget
RUN apt-get -y install pkg-config git make doxygen doxygen-doc doxygen-latex doxygen-gui graphviz libboost-all-dev wget

# build environment

# configure coveralls
RUN apt-get -y install lcov
RUN gem install coveralls-lcov

#################################################
# WRENCH's dependencies
#################################################

# set root's environment variable
ENV CXX="g++-5" CC="gcc-5"

# Install a recent CMAKE, which is overkill but necessary for the 
# Batsched-enabled image
RUN wget https://cmake.org/files/v3.12/cmake-3.12.2.tar.gz && gunzip cmake-3.12.2.tar.gz && tar -xf cmake-3.12.2.tar && cd cmake-3.12.2 && ./bootstrap && make && sudo make install && cd .. && rm -rf cmake-3.12.2*

WORKDIR /tmp

# install SimGrid
RUN wget https://framagit.org/simgrid/simgrid/uploads/0365f13697fb26eae8c20fc234c5af0e/SimGrid-3.25.tar.gz && tar -xf SimGrid-3.25.tar.gz && cd SimGrid-3.25 && cmake . && make && sudo make install && cd .. && rm -rf SimGrid-3.25*

# install Lemon
RUN wget http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz && tar -xf lemon-1.3.1.tar.gz && cd lemon-1.3.1 && cmake . && make && sudo make install && cd .. && rm -rf lemon-1.3.1*

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
ENV CXX="g++-5" CC="gcc-5"
