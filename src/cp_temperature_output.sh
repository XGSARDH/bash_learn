#!/bin/bash

FILE_NAME="temperature"
FILE_PATH=$(cd "$(dirname "$0")"; pwd)/../temperature_log

cp "${FILE_PATH}/${FILE_NAME}" "${FILE_PATH}/${FILE_NAME}.old"