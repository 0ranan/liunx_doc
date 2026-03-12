
准备环境

官方参考文档
https://www.raspberrypi.com/documentation/computers/linux_kernel.html


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
