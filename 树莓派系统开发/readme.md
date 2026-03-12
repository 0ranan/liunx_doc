# 树莓派系统开发

## 树莓派等嵌入式产品的启动过程

```txt

c51，stm32(裸机)：C直接操作寄存器

liunx
嵌入式产品：树莓派，mi2440 mini6410,海思，瑞芯微
启动过程：电源-> Bootloader-> Linux 内核 ->文件系统（根据功能来组织文件）->KTV 点歌机，自动售货机

android
启动过程：电源-> fastboot/bootloader -> Linux 内核 （kernel） -> 文件系统 -> 虚拟机->home 程序

Bootloader： 一阶段 让CPU 和内存、Flash 、串口、IIc、数据段、打交道
             二阶段 引导 Liunx 内核启动（纯C）

```

## 源码目录树

大约1.3W 个C文件
    内核编译出来就几M
    因为支持多平台，所以编译前需要配置成适合的目标平台来用

目录树结构

```txt
arch :包含硬件体系结构的相关代码，每个平台占用一个相应的目录(如：arm, x86, mips, riscv,powerpc)
    kernel : 包含内核代码，每个平台占用一个相应的目录
    mm : 包含内存管理代码
    math-emu : 浮点单元仿真
    lib : 包含库函数代码
    boot : 包含引导代码
    pci : 包含PCI 设备驱动代码
    power : CPU相关状态
block : 部分块设备驱动程序
crypto : 常用的加密和散列算法（哈希算法）
Documentation : 内核各部分的通用解释和注释
drivers : 设备驱动程序(重要)
ipc:进程间通信(次重要)
mm:内存管理(次重要)
net:网络协议栈(次重要)

init : 包含初始化代码
kernel : 包含内核代码

```

## 内核源码配置

驱动代码的编写
    驱动代码的编译需要一个提编译好的内核
        编译内核就必须配置
    方式：
        配置的最终目标会生成.config 文件,该文件指导makefile去把有用的东西去组织成内核。
    第一种方式：
        厂家去配置Liunx内核源码，比如说买树莓派，厂家会给树莓派Liunx内核源码
        cp  厂家._defconfig ._defconfig
    第二种方式：make menuconfig，根据厂家的配置去修改
    第三种方式：完全自己来配置
        
## 编译内核

相关文档

```txt
# 获取源码
https://github.com/raspberrypi/linux

# 官方参考文档
https://www.raspberrypi.com/documentation/computers/linux_kernel.h
```


1. 配置环境
```bash
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
```

2. 配置内核

```bash
# 64位树莓派4b
cd linux
KERNEL=kernel8
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
```

3. 编译内核

```
# 64位构建
# make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
```


5. 挂载树莓派系统卡

```
mkdir mnt
mkdir /mnt/boot
mkdir /mnt/root
sudo mount /dev/sdb1 /mnt/boot
sudo mount /dev/sdb2 /mnt/root
```

6. 安装 modules

```bash 
sudo env PATH=$PATH make -j12 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=/mnt/root modules_install
```

7. 备份并 覆盖 kernel

```bash
sudo cp /mnt/boot/kernel8.img /mnt/boot/kernel8-backup.img
sudo cp arch/arm64/boot/Image /mnt/boot/kernel8.img
sudo cp arch/arm64/boot/dts/broadcom/*.dtb /mnt/boot/
sudo cp arch/arm64/boot/dts/overlays/*.dtb* /mnt/boot/overlays/
sudo cp arch/arm64/boot/dts/overlays/README /mnt/boot/overlays/
sudo umount /mnt/boot
sudo umount /mnt/root
```
