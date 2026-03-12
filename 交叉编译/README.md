# 交叉编译

## 简介

交叉编译就是在别的电脑架构上编译出可执行文件

通常来讲都是在x86架构的电脑上编译出其他架构的可执行文件，因为x86架构的电脑性能要高很多，而且最为常见

## 以树莓派交叉编译工具链为例

[树莓派交叉编译工具链](https://github.com/raspberrypi)

### 安装armv7l 交叉编译工具链

```bash
sudo apt-get install gcc-arm-linux-gnueabihf
```

### 使用

```bash
arm-linux-gnueabihf-gcc -o test.out test.c
```

### 配置环境变量

```bash
# 配置环境变量
vim ~/.bashrc
#末尾添加
alias armgcc='arm-linux-gnueabihf-gcc'
alias armcpp='arm-linux-gnueabihf-cpp'
# 使配置生效
source ~/.bashrc
# 测试
$ armgcc --version
arm-linux-gnueabihf-gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ armcpp --version
arm-linux-gnueabihf-cpp (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

```

### 使树莓派支持 armv7l 架构

```bash
sudo dpkg --add-architecture armhf
sudo apt update
sudo apt install libc6:armhf
# 如果后面还缺库，继续装对应的 :armhf 包
```

## 安装 aarch64 交叉编译工具链
