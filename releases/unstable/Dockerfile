FROM wrenchproject/wrench-build:ubuntu-noble-gcc13

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"


#################################################
# INSTALL WRENCH
#################################################

USER root
WORKDIR /tmp

RUN echo "wrench ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# install libasio-dev
RUN apt-get update
RUN apt-get install libasio-dev

# Install jsonref
RUN pip install --break-system-packages jsonref

# install WRENCH
RUN git config --global http.postBuffer 524288000
RUN git clone https://github.com/wrench-project/wrench && cd wrench && mkdir build && cd build && cmake .. && make -j12 wrench-daemon examples && make install && cp -r ./examples /home/wrench/ && chown -R wrench /home/wrench && cd ../.. && /bin/rm -rf wrench

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
