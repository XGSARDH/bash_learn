#!/bin/bash
# sure where cmake in
PROJECT_SOURCE_DIR=$PWD && \
echo "PROJECT_SOURCE_DIR="$PROJECT_SOURCE_DIR && \

CMAKELISTS_DIR=$PROJECT_SOURCE_DIR/CMakeLists.txt

if test -e $PROJECT_SOURCE_DIR/CMakeLists.txt
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
fi 

if [ ! -d "$PROJECT_SOURCE_DIR/src" ]; then
    mkdir $PROJECT_SOURCE_DIR/src
fi

if [ ! -d "$PROJECT_SOURCE_DIR/inc" ]; then
    mkdir $PROJECT_SOURCE_DIR/inc
fi

# sure project name and out in CMakeLists.txt
read -p "输入项目名称: " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-"default_name"}

echo \
'
# reinit by make_cmake.sh
# cmake最小要求版本
cmake_minimum_required(VERSION 3.25)

# 项目名称
project($PROJECT_NAM)

# 设置头文件目录
# PROJECT_SOURCE_DIR 是该项目最根的CMakeLists.txt所在目录(全路径字符创不包含CMakeLists.txt)
include_directories(${PROJECT_SOURCE_DIR}/inc)

# 设置可执行文件所在目录
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)

# 设置相关头文件库
# 要将x替换为对应的头文件名称
add_library(x ${PROJECT_SOURCE_DIR}/src/x)

# 配置可执行文件(相关连接库)
add_executable(main ${PROJECT_SOURCE_DIR}/src/main.c)
target_link_libraries(main x)
' >> $CMAKELISTS_DIR