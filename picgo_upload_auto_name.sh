#!/bin/bash

# 该shell脚本所在目录获取
shell_file_path=$(cd $(dirname $0); pwd)

# image图片文件夹
upload_image_folder_path="${shell_file_path}/image"
if [ ! -d "${upload_image_folder_path}" ]; then
    mkdir ${upload_image_folder_path}
fi

# picgo所在路径, 默认所在目录与该shell脚本所在目录一致
picgo_path="${shell_file_path}/picgo"
# 所需要上传图片的路径获取, 要判断传入参数
if [[ "$1" == /* ]]; then
    origin_image_path="$1"
else
    origin_image_path="$(pwd)/$1"
fi

# 获取当前时间，精确到纳秒
current_time=$(date +%s%N)
# 分离秒和纳秒部分
# 前10位是秒
seconds=${current_time:0:10}
# 剩余的部分是纳秒, 这里后面保留前5位是为了和typora的默认上传格式保持一致
nanoseconds=${current_time:10:15}
nanoseconds=${nanoseconds:0:5}
# 将秒部分转换为人类可读的日期时间格式
human_readable_time=$(date -d @$seconds +"%Y-%m-%d %H:%M:%S")
# 输出最终格式化时间, 并且删除除去数字以外的字符
upload_time="$human_readable_time $nanoseconds"
upload_time=$(echo "${upload_time}" | sed 's/[^0-9]//g')
# 生成上传图片名字
upload_image_name="image-${upload_time}.png"

# 进行图片备份
cp ${origin_image_path} ${upload_image_folder_path}/${upload_image_name}

# picgo执行上传操作
log_folder_path=${shell_file_path}/log
log_path=${log_folder_path}/shell.log
if [ ! -d "${log_folder_path}" ]; then
    mkdir ${log_folder_path}
fi
if [ ! -e "${log_path}" ]; then
    touch ${log_path}
fi
${picgo_path} u ${upload_image_folder_path}/${upload_image_name} >| ${log_path}

# 处理URL
output=$(cat ${log_path} | grep "http")
URL=${output}

# 集中输出
echo ""
echo "upload_time = ${upload_time}"
echo "origin_image_path = ${origin_image_path}"
echo "upload_image_name = ${upload_image_name}"
echo "picgo_path = ${picgo_path}"
echo "shell_file_path = ${shell_file_path}"
echo "upload_image_folder_path = ${upload_image_folder_path}"
echo "log_path = ${log_path}"
echo ""

if [ -n "$URL" ]; then
    echo "URL = "
    echo "${URL}"
else
    echo "ERROR"
fi
