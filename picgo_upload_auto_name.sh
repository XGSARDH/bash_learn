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
echo "result = ${result}"

# 自动生成图片名字
image_name="image-${result}.png"
echo "image_name = ${image_name}"

# 该shell脚本所在目录获取
shell_file_path=$(cd $(dirname $0); pwd)
echo "shell_file_path = ${shell_file_path}"

# 所需要上传图片的路径获取
image_path="$(pwd)/$1"
echo "image_path = ${image_path}"

# image图片文件夹
image_folder_path="${shell_file_path}/image"
echo "image_folder_path = ${image_folder_path}"

# picgo所在路径, 默认所在目录与该shell脚本所在目录一致
picgo_path="${shell_file_path}/picgo"
echo "picgo_path = ${picgo_path}"

cp ${image_path} ${image_folder_path}/${image_name}

# picgo执行上传操作
${picgo_path} upload ${image_folder_path}/${image_name}