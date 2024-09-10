FROM wrenchproject/wrench-build:ubuntu-jammy-gcc11

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

ENV WRENCH_VERSION="2.3"

#################################################
# INSTALL WRENCH
#################################################

USER root
WORKDIR /tmp

# install WRENCH
RUN wget https://github.com/wrench-project/wrench/archive/v${WRENCH_VERSION}.tar.gz && tar -zxf v${WRENCH_VERSION}.tar.gz && cd wrench-${WRENCH_VERSION} && cmake . && make -j12 && sudo make install

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
ENV CXX="g++-11" CC="gcc-11"
#ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
