#!/bin/bash
# sure where cmake in
CMAKE_BINARY_DIR=$PWD && \
CMAKELISTS_NAME=CMakeLists.txt && \
echo "CMAKE_BINARY_DIR="$CMAKE_BINARY_DIR && \

CMAKELISTS_DIR=$CMAKE_BINARY_DIR/$CMAKELISTS_NAME

if test -e $CMAKELISTS_DIR
then
    echo "CMakeLists存在"
    DEFAULT_READ_CHANCE=y
    read -p "是否需要重新生成CMakeLists.txt(y/n): " READ_CHANCE
    READ_CHANCE=${READ_CHANCE:-"n"}
    if [ $READ_CHANCE != $DEFAULT_READ_CHANCE ]
    then
        echo "不重新生成CMakeLists.txt"
        exit
    else
        cp $CMAKELISTS_DIR $CMAKELISTS_DIR.old
        echo "# reinit by make_cmake.sh" > $CMAKELISTS_DIR
    fi
else
    touch $CMAKELISTS_DIR
    echo "创建CMakeLists文件成功" 
fi 

# sure the cmake version
echo "cmake_minimum_required(VERSION 3.25)" >> $CMAKELISTS_DIR

# sure project name and out in CMakeLists.txt
read -p "输入项目名称: " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-"default_name"}
# echo "PROJECT_NAME="$PROJECT_NAME
echo "project($PROJECT_NAME VERSION 1.0)" >> $CMAKELISTS_DIR

# sure headers position for default
echo "include_directories("'${PROJECT_SOURCE_DIR}'"/inc)" >> $CMAKELISTS_DIR
# echo "aux_source_directory("'${PROJECT_SOURCE_DIR}'"/src SRC_LIST)"  >> $CMAKELISTS_DIR

# add lib purpose
echo "# add lib purpose" >> $CMAKELISTS_DIR
echo "" >> $CMAKELISTS_DIR

# sure executable file name and out in CMakeLists.txt
read -p "输入可执行文件名称: " EXECUTABLE_NAME
EXECUTABLE_NAME=${EXECUTABLE_NAME:-"default_name"}
echo "add_executable($EXECUTABLE_NAME  "'${SRC_LIST}'")" >> $CMAKELISTS_DIR

# sure executable file position for default
echo "set(HOME "$CMAKE_BINARY_DIR")" >> $CMAKELISTS_DIR
echo "set(EXECUTABLE_OUTPUT_PATH "'${HOME}'"/bin)" >> $CMAKELISTS_DIR

# link lib with executable file
echo "# link lib with executable file" >> $CMAKELISTS_DIR
echo "" >> $CMAKELISTS_DIR