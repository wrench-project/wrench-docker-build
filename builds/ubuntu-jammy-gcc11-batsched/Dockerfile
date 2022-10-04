FROM wrenchproject/wrench-build:ubuntu-jammy-gcc11

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

# add repositories
RUN apt-get update

# set timezone
RUN echo "America/Los_Angeles" > /etc/timezone && export DEBIAN_FRONTEND=noninteractive && apt-get install -y tzdata

# build environment
RUN apt-get -y install pkg-config git cmake cmake-data graphviz libboost-all-dev wget sudo curl lcov default-jre flex bison doxygen

# install compiler
RUN apt-get -y install g++ gcc

#################################################
# BatSched Dependencies
#################################################

USER root
ENV CXX="g++-7" CC="gcc-7"
WORKDIR /tmp

#install ASCIIDOC
RUN wget https://newcontinuum.dl.sourceforge.net/project/asciidoc/asciidoc/8.6.9/asciidoc-8.6.9.tar.gz && tar -xzf asciidoc-8.6.9.tar.gz && cd asciidoc-8.6.9 && ./configure && sudo make install && cd .. && rm -rf asciidoc*

# install AUTOCONF
RUN apt-get install -y m4

# install AUTOMAKE
RUN apt-get install -y automake

# install LIBTOOL
RUN apt-get install -y libtool libtool-bin

# install LIBSODIUM
RUN apt-get install -y libsodium-dev

# install GMPLIB
RUN wget https://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.xz && tar -xf gmp-6.1.2.tar.xz && cd gmp-6.1.2/ && ./configure && make -j12 && sudo make install && cd .. && rm -rf gmp*

# install RAPIDJSON
RUN wget https://github.com/Tencent/rapidjson/archive/v1.1.0.tar.gz && gunzip v1.1.0.tar.gz && tar -xf v1.1.0.tar && cd rapidjson-1* && find ./ -type f -exec sed -i -e 's/-Werror//g' {} \; && mkdir build && cd build && cmake .. && make -j12 && sudo make install && cd ../../ && rm -rf rapidjson-1* v1.1.0.tar.gz

# install HIREDIS
RUN wget https://github.com/redis/hiredis/archive/v0.14.0.tar.gz  && gunzip v0.14.0.tar.gz && tar -xvf v0.14.0.tar && cd hiredis* && make -j12 && sudo make install && cd .. && rm -rf hiredis*

# install LIBEV
RUN apt-get install -y libev4 libev-dev

# install REDOX
RUN git clone https://github.com/hmartiro/redox.git && cd redox && mkdir build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/ && make -j12 && sudo make install && cd ../../ && rm -rf redox

# install BOOST
RUN apt-get install -y libboost-all-dev

# install CPPZMQ
RUN wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz && tar xvzf zeromq-4.2.2.tar.gz && cd zeromq-4.2.2 && ./configure && make && sudo make install && cd .. && rm -rf zeromq-4.2.2
RUN wget https://github.com/zeromq/cppzmq/archive/v4.2.2.tar.gz && tar xf v4.2.2.tar.gz && cd cppzmq-4.2.2/ && mkdir build && cd build/ && cmake .. && sudo make -j4 install && cd ../../ && rm -rf v4.2.2.tar.gz cppzmq*

#################################################
# BatSched
#################################################

# Intervalset
RUN apt-get install -y python3-pip ninja-build && pip3 install --user meson && mv /root/.local/bin/meson /usr/local/bin
RUN wget https://framagit.org/batsim/intervalset/-/archive/master/intervalset-master.tar.gz && tar -xzf intervalset-master.tar.gz && cd intervalset-master && meson build && cd build && ninja && sudo meson install && cd ../.. && rm -rf intervalset*

# Loguru
RUN wget https://github.com/emilk/loguru/archive/v2.0.0.tar.gz && tar -xf v2.0.0.tar.gz && cd loguru-* &&  sudo cp ./loguru.hpp /usr/local/include/ && $CXX -std=c++11 -o libloguru.so -shared -pthread -fPIC loguru.cpp && sudo cp ./libloguru.so /usr/local/lib/ &&  cd .. && rm -rf loguru-* v2.0.0.tar.gz


# Batsched
RUN wget https://gitlab.inria.fr/batsim/batsched/-/archive/v1.4.0/batsched-v1.4.0.tar.gz && tar -xzf batsched-v1.4.0.tar.gz && cd batsched-v1.4.0 && mkdir build && cd build && cmake .. -DREDOX_LIBRARY:FILEPATH=/usr/local/lib64/libredox.so && make -j12 && sudo make install && cd ../../ && rm -rf batsched*


#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench


