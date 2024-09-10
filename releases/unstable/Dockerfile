FROM wrenchproject/wrench-build:ubuntu-jammy-gcc11

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

USER root
WORKDIR /tmp

RUN echo "wrench ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN apt-get update
RUN apt-get install -y vim nano

#################################################
# INSTALL WRENCH
#################################################

RUN git clone https://github.com/wrench-project/wrench && cd wrench && mkdir build && cd build && cmake .. && make -j12 && make install

# copy examples
RUN ln -s /usr/local/wrench/examples /home/wrench/examples
RUN chown -R wrench /home/wrench

# remove installation folder
RUN rm -rf wrench

#################################################
# WRENCH's user
#################################################

USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++-11" CC="gcc-11"
#ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
