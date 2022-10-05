FROM wrenchproject/wrench-build:ubuntu-jammy-gcc11

LABEL org.opencontainers.image.authors="silvarf@ornl.gov,henric@hawaii.edu"

USER root 

# add repositories
RUN apt-get update

#################################################
# BATSCHED
#################################################


RUN apt-get install -y nix-bin
RUN echo "filter-syscalls = false" >> /etc/nix/nix.conf
RUN nix-env -iA batsched -f 'https://github.com/oar-team/nur-kapack/archive/master.tar.gz'


USER wrench
WORKDIR /home/wrench

# set user's environment variable
ENV CXX="g++" CC="gcc"
