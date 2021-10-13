FROM wrenchproject/wrench-build:ubuntu-xenial-gcc5

MAINTAINER Rafael Ferreira da Silva <silvarf@ornl.gov>

ENV WRENCH_VERSION="1.0.0-alpha"

#################################################
# INSTALL WRENCH
#################################################

USER root
WORKDIR /tmp

# install WRENCH
RUN wget https://github.com/wrench-project/wrench/archive/${WRENCH_VERSION}.tar.gz && tar -zxf ${WRENCH_VERSION}.tar.gz && cd wrench-${WRENCH_VERSION} && cmake . && make && sudo make install

# copy examples
RUN cd wrench-${WRENCH_VERSION} && mkdir -p /home/wrench/examples && cp examples/*.xml /home/wrench/examples && cp examples/*.dax /home/wrench/examples && cp examples/*.json /home/wrench/examples
RUN chown -R wrench /home/wrench/examples

# remove installation folder
RUN rm -rf wrench-${WRENCH_VERSION}

#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-5" CC="gcc-5"
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
