FROM wrenchproject/wrench-build:ubuntu-bionic-gcc7

MAINTAINER Rafael Ferreira da Silva <rafsilva@isi.edu>

#################################################
# INSTALL WRENCH
#################################################

USER root
WORKDIR /tmp

# install WRENCH
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
ENV CXX="g++-7" CC="gcc-7"
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
