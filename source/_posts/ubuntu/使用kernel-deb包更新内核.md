---
title: 使用kernel deb包更新内核
copyright: true
date: 2019-07-29 11:28:19
categories:
    - ubuntu
tags:
    - ubuntu
    - kernel
    - 内核
---
安装官方编译好的deb格式内核。安装后可以使用dpkg管理。
更新内核可以降低风扇噪音等问题。
其他几篇内核相关文章介绍了使用源码编译和安装内核。

<!-- more -->

### **1. 下载**

[https://kernel.ubuntu.com/~kernel-ppa/mainline/](https://kernel.ubuntu.com/~kernel-ppa/mainline/)
在这个网址选择内核版本
下载以下文件
```
linux-headers-4.xx_all.deb
linux-headers-4.xx-generic_xx_amd64.deb
linux-image-unsigned-4.xx-generic_xx_amd64.deb
linux-modules-4.xx-generic_xx_amd64.deb
```

### **2. 按照以上列表第一个开始安装**
