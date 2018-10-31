FROM wrenchproject/wrench-build:ubuntu-trusty-gcc5

MAINTAINER Rafael Ferreira da Silva <rafsilva@isi.edu>

#################################################
# BatSched Dependencies
#################################################


USER root
ENV CXX="g++-5" CC="gcc-5"
WORKDIR /tmp

#install a RECENT CMAKE
RUN wget https://cmake.org/files/v3.12/cmake-3.12.2.tar.gz && gunzip cmake-3.12.2.tar.gz && tar -xf cmake-3.12.2.tar && cd cmake-3.12.2 && ./bootstrap && make && sudo make install && cd .. && rm -rf cmake-3.12.2*

#install ASCIIDOC
RUN wget https://newcontinuum.dl.sourceforge.net/project/asciidoc/asciidoc/8.6.9/asciidoc-8.6.9.tar.gz && tar -xzf asciidoc-8.6.9.tar.gz && cd asciidoc-8.6.9 && ./configure && sudo make install && cd .. && rm -rf asciidoc*

# install AUTOCONF
RUN apt-get install -y m4
RUN wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz && tar xf autoconf* && cd autoconf-2.69 && sh configure --prefix /usr/local && sudo make install && cd .. && rm -rf autoconf*

# install AUTOMAKE
RUN wget http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz && tar xf automake* && cd automake-1.15 && sh configure --prefix /usr/local && make && sudo make install && cd .. && rm -rf automake*

# install LIBTOOL
RUN wget http://mirror.jre655.com/GNU/libtool/libtool-2.4.6.tar.gz && tar xf libtool* && cd libtool-2.4.6 && sh configure --prefix /usr/local && make && sudo make install && cd .. && rm -rf libtool*

# install LIBSODIUM
RUN wget https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz && tar xf libsodium* && cd libsodium-1.0.16 && ./configure && make check && sudo make install && cd .. && rm -rf libsodium*

# install GMPLIB
RUN wget https://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.xz && tar -xf gmp-6.1.2.tar.xz && cd gmp-6.1.2/ && ./configure && make && sudo make install && cd .. && rm -rf gmp*

# install RAPIDJSON
RUN wget https://github.com/Tencent/rapidjson/archive/v1.1.0.tar.gz && gunzip v1.1.0.tar.gz && tar -xf v1.1.0.tar && cd rapidjson-1* && mkdir build && cd build && cmake .. && make && sudo make install && cd ../../ && rm -rf rapidjson-1* v1.1.0.tar.gz

# install HIREDIS
RUN git clone https://github.com/redis/hiredis.git && cd hiredis && make && sudo make install && cd .. && rm -rf hiredis

# install LIBEV
RUN wget https://launchpad.net/ubuntu/+archive/primary/+files/libev_4.22.orig.tar.gz && tar -xf libev_4.22.orig.tar.gz && cd libev-4.22/ && ./configure && make && sudo make install && cd .. && rm -rf libev-4.22*

# install REDOX
RUN git clone https://github.com/hmartiro/redox.git && cd redox && mkdir build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/ && make && sudo make install && cd ../../ && rm -rf redox

# install BOOST
RUN ln -s /usr/bin/g++-5 /usr/bin/g++
RUN wget https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.gz && tar -xf boost_1_65_1.tar.gz && cd boost_1_65_1/ && ./bootstrap.sh && sudo ./b2 install --prefix=/usr/local && cd .. && rm -rf boost_1_65_1*

# install CPPZMQ
RUN wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz && tar xvzf zeromq-4.2.2.tar.gz && cd zeromq-4.2.2 && ./configure && make  && sudo make install && cd .. && rm -rf zeromq-4.2.2
RUN wget https://github.com/zeromq/cppzmq/archive/v4.3.0.tar.gz && tar xf v4.3.0.tar.gz && cd cppzmq-4.3.0/ && mkdir build && cd build/ && cmake .. && make -j4 &&  sudo make install && cd ../../ && rm -rf v4.3.0.tar.gz cppzmq*


#################################################
# BatSched
#################################################

# Intervalset
RUN wget https://framagit.org/batsim/intervalset/repository/master/archive.tar.gz && tar -xf archive.tar.gz && cd intervalset-master-* && mkdir build && cd build && cmake  -DCMAKE_CXX_FLAGS="-std=c++14" -DCMAKE_INSTALL_PREFIX=/usr/local .. && make && sudo make install && cd ../../ && rm -rf intervalset-master-* archive.tar.gz

# Loguru
#RUN wget https://raw.githubusercontent.com/emilk/loguru/master/loguru.hpp && sudo cp ./loguru.hpp /usr/local/include/ && rm loguru.hpp
RUN wget https://github.com/emilk/loguru/archive/v2.0.0.tar.gz && tar -xf v2.0.0.tar.gz && cd loguru-* &&  sudo cp ./loguru.hpp /usr/local/include/ && $CXX -std=c++11 -o libloguru.so -shared -pthread -fPIC loguru.cpp && sudo cp ./libloguru.so /usr/local/lib/ &&  cd .. && rm -rf loguru-* v2.0.0.tar.gz 

# Batsched
RUN wget https://gitlab.inria.fr/batsim/batsched/repository/master/archive.tar.gz && tar -xf archive.tar.gz && cd batsched-master* && mkdir build && cd build && cmake .. -DREDOX_LIBRARY:FILEPATH=/usr/local/lib64/libredox.so && make && sudo make install && cd ../../ && rm -rf batsched-master* archive.tar.gz


#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-5" CC="gcc-5"
