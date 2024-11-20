#!/bin/bash

FILE_NAME="temperature"
FILE_PATH=$(cd "$(dirname "$0")"; pwd)/temperature_log
FILE_NUM=0

cp ${FILE_PATH}/${FILE_NAME} ${FILE_PATH}/${FILE_NAME}.old