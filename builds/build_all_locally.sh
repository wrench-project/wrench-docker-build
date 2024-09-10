#!/bin/bash
#

set -e

IMAGES=$(ls . | grep "-")

for toBuild in ${IMAGES[@]}; do
    cd $toBuild
    echo "***"
    echo "*** BUILDING $toBuild ***"
    echo "***"
    docker build --platform linux/amd64 -t wrenchproject/wrench-build:$toBuild . ; cd ..
done

