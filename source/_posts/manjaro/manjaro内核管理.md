---
title: manjaro内核管理
copyright: true
date: 2020-03-31 12:15:18
categories:
    - manjaro
tags:
    - manjaro
    - linux kernel
---
两种方式管理内核
通过命令行查询内核/安装新内核/删除旧内核，也适用于其他发行版;
通过manjaro自带的内核管理gui工具管理内核。

<!-- more -->

### 1. 命令行管理内核

命令行可以通过三种方式获取编译好的内核：发行版软件仓库获取，内核源码编译获取

`uname -r` 可以查看内核版本

manjaro 查看正在使用的内核 `mhwd-kernel -li`

5.x lts 是 5.4.28，非lts的在软件仓库中可能是找不到相关包的。

可以在linux网站和manjaro内核管理gui上看到 lts版本;

linux内核网站 kernel.org

manjaro内核管理gui入口: manjaro settings -> kernel

#### 1.1 软件仓库

(1) 查询可用的kernel

比如 linux-kernel 5.4.28
```
~:pacman -Ss linux54
```

(2) 安装
```
~:sudo pacman -S linux54 linux54-headers linux54-ndiswrapper
```
其中 `ndiswrapper` 是网卡驱动。如果是在虚拟机上，还要安装虚拟机模块，`linux54-virtualbox-host-modules`。
如果需要安装更多驱动，比如nvidia显卡, sudo pacman -S linux54-extramodules 会提示选择

(3) 切换内核到新版本

```
~:sudo mhwd-kernel -i linux54
```

(4) 删除旧版本内核
```
~:sudo pacman -R linux53
```

#### 1.2 使用编译好的内核

manjaro目前不提供类似于ubuntu那样的 内核deb文件下载，所以只能下载内核源码自行编译。直接编译源码可能要花掉好几个小时。


