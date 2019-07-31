---
title: compile and install kernel
copyright: true
date: 2019-07-29 10:51:27
categories:
    - ubuntu
tags:
    - ubuntu
    - kernel
    - 内核
---
linux内核源码编译和安装。
该过程可以向linux内核添加驱动，以及修改默认的内核配置。比如某些特殊网卡需要的内核配置。

<!-- more -->

### **1. dependencies**

```
~:sudo apt-get insall build-essential
# install make-kpkg
~:sudo apt-get install kernel-package
~:sudo apt-get install libncurses5-dev
~:sudo apt-get install bison flex libssl-dev
```

### **2. download source code**

```
~:sudo tar zJvf linux-kernel.tar.xz -C /usr/src
~:cd /usr/src
~:sudo ln -s linux-kernel/ linux
```

### **3. clean scripts and .config**

You need do this when you compile failed.
```
~:cd linux
~:sudo make mrproper
```

### **4. menuconfig**

```
~:sudo make menuconfig
```
just save

### **5. compile**

```
~:sudo make-kpkg clean
~:sudo make-kpkg --initrd --append-to-version=pcname kernel-image kernel-headers
```
**Note:** pcname must be characters in a-z and 0-9
**Note:** Waiting for finishing.

### **6. install kernel**

```
~:cd /usr/src
~:sudo dpkg -i linux-image-xxx
~:sudo dpkg -i linux-headers-xxx
``` 
After install kernel, reboot system.
