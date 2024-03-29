#!/bin/bash
#
IMAGES=$(ls . | grep "-")

for toBuild in ${IMAGES[@]}; do
    cd $toBuild
    echo "***"
    echo "*** BUILDING $toBuild ***"
    echo "***"
    docker build --platform linux/386 -t wrenchproject/wrench-build:$toBuild . ; cd ..
done

