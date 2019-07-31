---
title: Manage Kernels not in dpkg list
copyright: true
date: 2019-07-29 11:11:10
categories:
    - ubuntu
tags:
    - ubuntu
    - kernel
    - 内核
---
管理不在dpkg列表里的内核。
通过源码安装的内核并不在dpkg管理范围内，管理的方式也不同。
另一篇里介绍过dpkg管理内核。

<!-- more -->

### **1. delete manully**

```
~:sudo rm /boot/abi-4.x-generic
~:sudo rm /boot/config-4.x-generic
~:sudo rm /boot/initrd.img-4.x-generic
~:sudo rm /boot/System.map-4.x-generic
~:sudo rm /boot/vmlinuz-4.x-generic
~:sudo rm -rf /lib/modules/4.x-generic
```
You need to remove image( /boot/ ) and modules(/lib/modules/).
Because we install image and modules in Updating;

### **2. update grub**

```
~:sudo update-grub2
```
