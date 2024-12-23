# 自动监测树莓派温度脚本

## 目录结构

```bash
.
├── cp_temperature_output.sh
├── make_svg_temperature.sh
├── output.svg
├── README.md
├── temperature_log
│   ├── temperature
│   ├── temperature-0
│   └── temperature.old
├── temperature.py
└── temperature.sh
```

## 文件说明

### temperature.sh

加入开机自启中, 每隔一分钟记录一次温度

### cp_temperature_output.sh

防止覆写 **temperature_log** 文件夹中的当前记录日志 *temperature*

### temperature.py

将日志可视化作为 *output.svg* 输出

不加参数时, 默认行为是: 调用 *cp_temperature_output.sh*

### make_svg_temperature.sh

通过这个脚本统一访问*temperature.py*

需要python环境安装numpy, matplotlib

### output.svg

可视化的温度变化曲线
