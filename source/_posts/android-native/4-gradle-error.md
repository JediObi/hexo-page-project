---
title: 4 - gradle error
copyright: true
date: 2019-07-26 16:40:58
categories:
    - Android native
tags:
    - Android
    - gradle
---
gradle常见错误和解决办法。

<!-- more -->

### **1. can't create parent lock**

gradle同步错误
无法创建文件锁，因为当前用户对本机gradle目录没有写权限，把gradle home目录配置到当前用户的写权限范围内。

### **2. Unsupported method:**

gradle同步错误
gradle 插件版本太高或者gradle版本太高。降低gradle一个大版本，并使用wapper的gradle。

### **2. cpu support (x86, armv7...)**

gradle 编译时使用了不同的指令集导致ndk应用兼容性错误。
build.gradle->productFlavors 配置了多个ndk可用的指令集环境， Build Variants -> Build Variant 对相应的模块选择不同指令集，这里的指令集就来自于productFlavors的配置。productFlavors类似于 maven->profile。
