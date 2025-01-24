#!/bin/bash

# 获取当前时间，精确到纳秒
current_time=$(date +%s%N)

# 分离秒和纳秒部分
seconds=${current_time:0:10}  # 前10位是秒
nanoseconds=${current_time:10:15}  # 剩余的部分是纳秒
nanoseconds=${nanoseconds:0:5}

# 将秒部分转换为人类可读的日期时间格式
human_readable_time=$(date -d @$seconds +"%Y-%m-%d %H:%M:%S")

# 输出最终格式化时间
result="$human_readable_time $nanoseconds"
result=$(echo "${result}" | sed 's/[^0-9]//g')
echo ${result}

image_name="image-${result}.png"
echo ${image_name}
