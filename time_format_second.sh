#!/bin/bash

# 输入时间字符串
input_time="Fri Jan 24 09:15:01 PM CST 2025"

# 使用 date 命令转换时间格式
output_time=$(date -d "$input_time" +"%Y%m%d%H%M%S")

# 输出结果
echo "$output_time"
