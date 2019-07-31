---
title: build ko for kernel
copyright: true
date: 2019-07-29 11:19:54
categories:
    - ubuntu
tags:
    - ubuntu
    - kernel
    - 内核
    - 驱动
---
为内核添加新的驱动。

<!-- more -->

之前使用linux kernel源码编译新的内核替换旧内核。
现在，为内核添加设备驱动。
驱动程序作为内核模块，被内核加载。编译驱动源码生成ko，然后加载到内核里。

有两种方式生成ko
(1) 编译驱动源码时，使用kernel源码

(2) 编译驱动源码时，使用当前系统的kernel。
make menuconfig等命令

最后安装驱动模块(xxx.ko)
