FROM amd64/ubuntu:jammy

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

# add repositories
RUN apt-get update

# set timezone
RUN echo "America/Los_Angeles" > /etc/timezone && export DEBIAN_FRONTEND=noninteractive && apt-get install -y tzdata

# build environment
RUN apt-get -y install pkg-config git cmake cmake-data libboost-all-dev wget sudo curl

# install doxygen and sphinx
RUN apt-get install -y doxygen
RUN apt-get install -y python3 
RUN apt-get install -y python3-pip
RUN pip3 install  --upgrade pip
RUN pip3 install Sphinx sphinx-rtd-theme breathe recommonmark

# install swagger-codegen
RUN pip3 install jsonref
RUN apt-get install -y libasio-dev
RUN apt-get install -y openjdk-11-jdk
RUN cd /tmp/ && wget https://repo1.maven.org/maven2/io/swagger/codegen/v3/swagger-codegen-cli/3.0.41/swagger-codegen-cli-3.0.41.jar -O swagger-codegen-cli.jar
RUN echo "#!/bin/bash" > /usr/local/bin/swagger-codegen
RUN echo "java -jar /tmp/swagger-codegen-cli.jar \$@" >> /usr/local/bin/swagger-codegen
RUN chmod 777 /usr/local/bin/swagger-codegen

# install compiler
RUN apt-get -y install gcc g++

# install lvoc
RUN apt-get -y install lcov

#################################################
# WRENCH's dependencies
#################################################

# set root's environment variable
ENV CXX="g++" CC="gcc"
WORKDIR /tmp

RUN ulimit -n 10000

RUN wget --no-check-certificate https://framagit.org/simgrid/simgrid/-/archive/v4.0/simgrid-v4.0.tar.gz && tar -xf simgrid-v4.0.tar.gz && cd simgrid-v4.0 && cmake . && make  && sudo make install && cd .. && rm -rf simgrid-v4.0*
#RUN git clone https://framagit.org/simgrid/simgrid.git && cd simgrid && git checkout 1f1b85861ea71dd27d362b70f268b580c1f8c7c4 && mkdir build && cd build && cmake .. && make && sudo make install

# install SimGrid's FSMod
RUN wget https://github.com/simgrid/file-system-module/archive/refs/tags/v0.3.tar.gz && tar -xf v0.3.tar.gz && cd file-system-module-0.3 && mkdir build && cd build && cmake .. && make  && sudo make install && cd ../.. && rm -rf v0.3.tar.gz file-system-module-v*

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
ENV CXX="g++" CC="gcc"
