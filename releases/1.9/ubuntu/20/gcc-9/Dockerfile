FROM wrenchproject/wrench-build:ubuntu-focal-gcc9

MAINTAINER Rafael Ferreira da Silva <rafsilva@isi.edu>

ENV WRENCH_VERSION="1.9"

#################################################
# INSTALL WRENCH
#################################################

USER root
WORKDIR /tmp

# install WRENCH
RUN wget https://github.com/wrench-project/wrench/archive/v${WRENCH_VERSION}.tar.gz && tar -zxf v${WRENCH_VERSION}.tar.gz && cd wrench-${WRENCH_VERSION} && cmake . && make && sudo make install

# copy examples
RUN ln -s /usr/local/wrench/examples /home/wrench/examples
RUN chown -R wrench /home/wrench

# remove installation folder
RUN rm -rf wrench-${WRENCH_VERSION}

#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-9" CC="gcc-9"
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
