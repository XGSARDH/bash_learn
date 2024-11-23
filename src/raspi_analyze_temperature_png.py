# /home/sardh/miniconda3/envs/auto_temperature/bin/python
import sys
import math
import os
import re
import time
from configparser import ConfigParser
import numpy as np
import matplotlib.pyplot as plt

# 定义读取文件的函数
def read_file(file_path):
    times = []
    temperatures = []
    
    # 打开文件并读取每一行
    skip_line = 1
    with open(file_path, 'r') as file:
        for i in range(skip_line):
            next(file)
        for line in file:
            time, curr, temperature, curr = re.split(" - |=|\'" ,line.strip())
            times.append(time)
            temperatures.append(float(temperature))
    return times, temperatures

# 画折线图的函数
def plot_data(times, temperatures, output_file_path):
    plt.figure(figsize=(len(times)/300 + 10, max(4, (abs(max(temperatures)) - abs(min(temperatures)))/2)))
    if(len(times) < 60):
        # 添加数据线
        plt.plot(times, temperatures, label="temperature", linewidth=0.5, marker='o')  
    else:
        # 添加数据线
        plt.plot(times, temperatures, label="temperature", linewidth=0.5)  
    plt.xticks(
        # 每隔一定步长设置一个刻度
        ticks = np.arange(0, len(times), min(60, max(1, len(times) - 1))),  
        # 使用对应的时间作为刻度标签
        labels = np.array(times)[::min(60, max(1, len(times) - 1))],       
        # 旋转x轴标签以防重叠
        rotation = 90                                           
    )
    plt.yticks(
        ticks = np.arange(math.ceil(math.floor(min(temperatures))), math.ceil(max(temperatures)) + 1, 1),  
        rotation = 0                                           
    )
    # 设置网格线样式
    plt.grid(lw=1, axis="both", linestyle="--", alpha=0.5)  
    plt.xlabel('Time')
    plt.ylabel('Temperature')
    plt.title('Temperature over Time')
    plt.tight_layout()
    plt.legend()
    plt.savefig(output_file_path + "/output.png", dpi=100,format="png")

# 主程序开始
# 读取配置文件
default_temperature_file_path="../temperature_log/temperature.old"
print("temperature_png.py is starting to work.")
time_start_all = time.time()
# 文件路径（你可以修改为你文件的路径）
if(len(sys.argv) > 1):
    temperature_file_path = os.getcwd() + "/" + sys.argv[1]
else:
    os.chdir(sys.path[0])
    shell_return_code = os.system('bash ./cp_temperature_output.sh')
    temperature_file_path = default_temperature_file_path
    if shell_return_code != 0:
        print("copy is error")
        exit(shell_return_code)       
print("temperature_file_path = " + temperature_file_path)
if not os.path.exists(temperature_file_path):
    print(f"File not found: {temperature_file_path}")
    sys.exit(1)
# 读取数据
times, temperatures = read_file(temperature_file_path)
if(len(times) == 0):
    print("No log data available")
    with open(temperature_file_path, 'r') as file:
        for line in file:
            print(line)
    exit(0)
# 绘制折线图
time_end_read_data = time.time()
output_file_path = sys.path[0] + "/pictures"
if not(os.path.exists(output_file_path)):
    os.mkdir(output_file_path)
plot_data(times, temperatures, output_file_path)
time_end_all = time.time()
print("time_to_read_data is " + str((time_end_read_data - time_start_all))+" s")
print("time_to_deal_data is " + str((time_end_all - time_end_read_data))+" s")
print("time_to_all is " + str((time_end_all - time_start_all))+" s")
print("temperature_png.py is ending to work.")
