FROM wrenchproject/wrench-build:ubuntu-focal-gcc9

MAINTAINER Rafael Ferreira da Silva <rafsilva@isi.edu>

USER root
WORKDIR /tmp

RUN echo "wrench ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN apt-get install -y vim nano

#################################################
# INSTALL WRENCH
#################################################

RUN git clone https://github.com/wrench-project/wrench && cd wrench && mkdir build && cd build && cmake .. && make && make install

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
ENV CXX="g++-9" CC="gcc-9"
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
