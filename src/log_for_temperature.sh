#!/bin/bash

COMMAND="sudo vcgencmd measure_temp"

# 定义间隔时间（秒）
INTERVAL=60  # 每隔60秒运行一次

FILE_NAME="temperature"
FILE_PATH=$(cd "$(dirname "$0")"; pwd)/../temperature_log
FILE_NUM=0
OUTPUT_FILE=${FILE_PATH}/${FILE_NAME}
if [ ! -d $FILE_PATH ]; then 
    mkdir $FILE_PATH
fi
cd $FILE_PATH
if [ ! -f $FILE_NAME ]; then 
    touch $FILE_NAME
elif [ ! -f "${FILE_NAME}_${FILE_NUM}" ]; then
    mv $FILE_NAME "${FILE_NAME}_${FILE_NUM}"
else
    while [ -f "${FILE_NAME}_${FILE_NUM}" ]; do
        FILE_NUM=$((FILE_NUM + 1))
    done
    mv $FILE_NAME "${FILE_NAME}_${FILE_NUM}"
fi

echo "The temperature log starts at $(date "+%Y-%m-%d-%H:%M:%S")" >> $OUTPUT_FILE

SECOND=$(date "+%S")
while [ $SECOND -ne 0 ]; do
    echo "waiting" for  $SECOND
    sleep 1
    SECOND=$(date "+%S")
done

echo "temperature start loging."

while true; do
    # 获取当前时间
    CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
    
    # 执行命令并获取其返回值
    COMMAND_OUTPUT=$($COMMAND)
    
    # 将时间和命令返回值追加到输出文件
    echo "$CURRENT_TIME - $COMMAND_OUTPUT" >> $OUTPUT_FILE
    
    # 计算距离下一个记录点的时间差
    NEXT_INTERVAL=$((INTERVAL - $(date "+%S") % INTERVAL))
    
    # 动态等待
    sleep $NEXT_INTERVAL

    # # 等待指定的间隔时间
    # sleep $INTERVAL
done
