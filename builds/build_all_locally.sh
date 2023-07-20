IMAGES=(debian-bullseye-gcc10 ubuntu-focal-clang10 ubuntu-focal-gcc9 ubuntu-jammy-clang14 ubuntu-jammy-gcc11 ubuntu-jammy-gcc11-batsched)


for toBuild in ${IMAGES[@]}; do
    cd $toBuild
    echo "***"
    echo "*** BUILDING $toBuild ***"
    echo "***"
    docker build --platform linux/386 -t wrenchproject/wrench-build:$toBuild . ; cd ..
done

