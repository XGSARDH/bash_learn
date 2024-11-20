# /home/sardh/miniconda3/envs/auto_temperature/bin/python
import sys
import math
import os
import numpy as np
import matplotlib.pyplot as plt

print("temperature.py is doing.")

# 定义读取文件的函数
def read_file(file_path):
    times = []
    values = []
    
    # 打开文件并读取每一行
    with open(file_path, 'r') as file:
        for line in file:
            # 将行按照 ' - ' 分割为时间和数值部分
            time, value = line.strip().split(' - ')
            times.append(time)
            values.append(float(value) / 1000)
    
    return times, values

# 画折线图的函数
def plot_data(times, values, output_file_path):
    plt.figure(figsize=(len(times)/300 + 10, max(4, (abs(max(values)) - abs(min(values)))/2)))
    if(len(times) < 60):
        plt.plot(times, values, label="Value", linewidth=0.5, marker='o')  # 添加数据线
    else:
        plt.plot(times, values, label="Value", linewidth=0.5)  # 添加数据线
    plt.xticks(
        ticks = np.arange(0, len(times), min(60, len(times) - 1)),  # 每隔一定步长设置一个刻度
        labels = np.array(times)[::min(60, len(times) - 1)],       # 使用对应的时间作为刻度标签
        rotation = 90                                           # 旋转x轴标签以防重叠
    )
    plt.yticks(
        ticks = np.arange(math.ceil(min(values)), math.ceil(max(values)), 1),  
        # labels = np.array(times)[::min(60, len(times))], 
        rotation = 0                                           
    )
    plt.grid(lw=1, axis="both", linestyle="--", alpha=0.5)  # 设置网格线样式
    plt.xlabel('Time')
    plt.ylabel('Value')
    plt.title('Value over Time')
    plt.tight_layout()
    plt.legend()
    plt.savefig(output_file_path, dpi=1000,format="svg")

# 文件路径（你可以修改为你文件的路径）
if(len(sys.argv) > 1):
    temperature_file_name = sys.argv[1]
    temperature_log_path = sys.path[0]
    output_file_path = temperature_log_path + "/output.svg"
else:
    os.chdir(sys.path[0])
    shell_return_code = os.system('bash ./cp_temperature_output.sh')
    temperature_file_name = "temperature.old"
    temperature_log_path = sys.path[0] + "/temperature_log"
    output_file_path = temperature_log_path + "/../output.svg"
if not os.path.exists(temperature_log_path):
    print(f"File not found: {temperature_log_path}")
    sys.exit(1)
if not os.path.exists(temperature_log_path + "/" + temperature_file_name):
    print(f"File not found: {temperature_log_path + "/" + temperature_file_name}")
    sys.exit(1)

# 读取数据conda create -n myenv numpy
times, values = read_file(temperature_log_path + "/" + temperature_file_name)
# 绘制折线图
plot_data(times, values, output_file_path)