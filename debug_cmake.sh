CMAKE_BINARY_DIR=$PWD && \
CMAKELISTS_NAME=CMakeLists.txt && \
CMAKELISTS_DIR=$CMAKE_BINARY_DIR/$CMAKELISTS_NAME && \
BUILD_DIR=$CMAKE_BINARY_DIR/build && \

if [ ! -d "/$BUILD_DIR/" ];then
    mkdir $BUILD_DIR 
else
    rm -r $BUILD_DIR/*
fi

cd $BUILD_DIR
cmake .. -D CMAKE_BUILD_TYPE=debug  && \
make