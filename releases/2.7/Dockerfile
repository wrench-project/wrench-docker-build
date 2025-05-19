FROM wrenchproject/wrench-build:ubuntu-noble-gcc13

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

ENV WRENCH_VERSION="2.7"

#################################################
# INSTALL WRENCH
#################################################

USER root
WORKDIR /tmp

RUN echo "wrench ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# install libasio-dev
RUN apt-get update
RUN apt-get install libasio-dev

# Install Python and jsonref
RUN pip3 install --break-system-packages jsonref

# install WRENCH
RUN wget https://github.com/wrench-project/wrench/archive/v${WRENCH_VERSION}.tar.gz && tar -zxf v${WRENCH_VERSION}.tar.gz && cd wrench-${WRENCH_VERSION} && mkdir build && cd build && cmake .. && make -j12 wrench-daemon examples && sudo make install && cp -r ./examples /home/wrench/ && chown -R wrench /home/wrench && cd ../.. && /bin/rm -rf wrench-${WRENCH_VERSION}

# fix the run_all_examples.sh script
RUN sed -i "s/INSTALL_DIR=.*/INSTALL_DIR=\/home\/wrench\/examples/" /home/wrench/examples/run_all_examples.sh


#################################################
# WRENCH's user
#################################################
USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-13" CC="gcc-13"
ENV LD_LIBRARY_PATH=/usr/local/lib
