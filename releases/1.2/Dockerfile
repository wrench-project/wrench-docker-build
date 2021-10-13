FROM wrenchproject/wrench-build:ubuntu-bionic-gcc7

MAINTAINER Rafael Ferreira da Silva <silvarf@ornl.gov>

ENV WRENCH_VERSION="1.2"

#################################################
# INSTALL WRENCH
#################################################

USER root
WORKDIR /tmp

# install WRENCH
RUN wget https://github.com/wrench-project/wrench/archive/v${WRENCH_VERSION}.tar.gz && tar -zxf v${WRENCH_VERSION}.tar.gz && cd wrench-${WRENCH_VERSION} && cmake . && make && sudo make install

# copy examples
RUN cd wrench-${WRENCH_VERSION} && mkdir -p /home/wrench/examples && cp -R examples/simple-example/platform_files /home/wrench/examples/ && cp -R examples/simple-example/workflow_files /home/wrench/examples/
RUN chown -R wrench /home/wrench/examples

# remove installation folder
RUN rm -rf wrench-${WRENCH_VERSION}

#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-7" CC="gcc-7"
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
