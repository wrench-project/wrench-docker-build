IMAGES=(debian-bullseye-gcc10 debian-buster-gcc8 ubuntu-focal-clang10 ubuntu-focal-gcc9 ubuntu-jammy-clang14 ubuntu-jammy-gcc11 ubuntu-jammy-gcc11-batsched)


for toBuild in ${IMAGES[@]}; do
    cd $toBuild; docker build -t wrenchproject/wrench-build:$toBuild . ; cd ..
done

