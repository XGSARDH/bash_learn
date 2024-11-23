#!/bin/bash

FILE_NAME="temperature_png.py"
FILE_PATH=$(cd "$(dirname "$0")"; pwd)
FILE_NUM=0

if [ $# -eq 0 ];then
    /home/sardh/miniconda3/envs/auto_temperature/bin/python ${FILE_PATH}/${FILE_NAME}
else
    /home/sardh/miniconda3/envs/auto_temperature/bin/python ${FILE_PATH}/${FILE_NAME} $1
fi
