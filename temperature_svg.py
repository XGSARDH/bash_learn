# /home/sardh/miniconda3/envs/auto_temperature/bin/python
import sys
import math
import os
import time
import numpy as np
import matplotlib.pyplot as plt


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
        ticks = np.arange(math.ceil(min(values)), math.ceil(max(values)), 1) + 1,  
        # labels = np.array(times)[::min(60, len(times))], 
        rotation = 0                                           
    )
    plt.grid(lw=1, axis="both", linestyle="--", alpha=0.5)  # 设置网格线样式
    plt.xlabel('Time')
    plt.ylabel('Value')
    plt.title('Value over Time')
    plt.tight_layout()
    plt.legend()
    plt.savefig(output_file_path, dpi=300,format="svg")

print("temperature_svg.py is starting to work.")
time_start_all = time.time()

# 文件路径（你可以修改为你文件的路径）
if(len(sys.argv) > 1):
    print('os.getcwd() = ' + os.getcwd())
    print('sys.argv[1] = ' + sys.argv[1])
    temperature_file_path = os.getcwd() + "/" + sys.argv[1]
else:
    os.chdir(sys.path[0])
    shell_return_code = os.system('bash ./cp_temperature_output.sh')
    temperature_file_path =  sys.path[0] + "/temperature_log/temperature.old"
   
if not os.path.exists(temperature_file_path):
    print(f"File not found: {temperature_file_path}")
    sys.exit(1)

# 读取数据conda create -n myenv numpy
times, values = read_file(temperature_file_path)

# 绘制折线图
time_end_read_data = time.time()
output_file_path = sys.path[0] + "/output.svg"
plot_data(times, values, output_file_path)
time_end_all = time.time()
print("time_to_read_data is " + str((time_end_read_data - time_start_all))+" s")
print("time_to_deal_data is " + str((time_end_all - time_end_read_data))+" s")
print("time_to_all is " + str((time_end_all - time_start_all))+" s")
print("temperature_svg.py is ending to work.")
