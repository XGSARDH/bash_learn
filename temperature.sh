#!/bin/bash

FILE_NAME="temperature"
FILE_PATH=$(cd "$(dirname "$0")"; pwd)/temperature_log
FILE_NUM=0

COMMAND="cat /sys/class/thermal/thermal_zone0/temp"
OUTPUT_FILE=${FILE_PATH}/${FILE_NAME}

echo "temperature start loging."

# 定义间隔时间（秒）
INTERVAL=60  # 每隔60秒运行一次

if [ ! -d $FILE_PATH ]; then 
    mkdir $FILE_PATH
fi

cd $FILE_PATH
if [ ! -f $FILE_NAME ]; then 
    touch $FILE_NAME
elif [ ! -f "${FILE_NAME}-${FILE_NUM}" ]; then
    mv $FILE_NAME "${FILE_NAME}-${FILE_NUM}"
else
    while [ -f "${FILE_NAME}-${FILE_NUM}" ]; do
        FILE_NUM=$((FILE_NUM + 1))
    done
    mv $FILE_NAME "${FILE_NAME}-${FILE_NUM}"
fi

while true; do
    # 获取当前时间
    CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
    
    # 执行命令并获取其返回值
    COMMAND_OUTPUT=$($COMMAND)
    
    # 将时间和命令返回值追加到输出文件
    echo "$CURRENT_TIME - $COMMAND_OUTPUT" >> $OUTPUT_FILE
    
    # 等待指定的间隔时间
    sleep $INTERVAL
done
