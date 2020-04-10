---
title: manjaro-gnome-18.1.5-安装
copyright: true
date: 2020-02-03 04:19:12
categories:
    - manjaro
tags:
    - manjaro
---
manjaro gnome 18.1.5 u盘安装单系统，或与win10构成双系统

<!-- more -->

### 1. 系统版本介绍

manjaro-gnome 18.0 直接使用 `pacman -Syu` 升级到 18.1.5 会导致桌面组件缺失，无法进入桌面。

pacman 安装pip的命令有变化，python3-pip 变成了 python-pip，并且截止当前时间 2020-02-03，pacman安装的python-pip是相对于 python 3.8.1 版本，如果系统当前的 python 环境是 3.7，也会导致 pip 出现问题

### 2. u盘启动盘制作

#### (1) 格式化
使用 ultraliso 制作，如果 ultraliso 能识别到u盘，则在 ultraliso 界面中格式化整个u盘空间为fat32，如果不识别，请使用其他工具格式化。

#### (2) 写入方式 

raw，其他格式导致 uefi 下无法从u盘启动。

然后执行写入，等待完成。

#### (3) 成功后的u盘分区

成功后，u盘空间被分为三个区
```
第一个区是隐藏分区，是 manjaro 系统文件，不要动这个分区，也不要变成可见。
第二个是一个可见分区， 很小的空间，几乎无法使用，无需理会。
第三个区是一个隐藏分区，占了u盘大部分空间，该区域可以重新格式化产生一个可用分区，用来存东西。
```

### 3. 单系统分区

120G 硬盘为例

系统盘可以整个覆盖，所以可以用默认的安装方案。

手动分区

1G, primary, file-system: fat32, mount point: boot-efi, flag: boot, esp

8G, primary, file-system: linux-swap, mount point: , flag: swap

50G, primary, file-system: ext4, mount point: /, flag: 

70G(剩下的空间),primary, file-system: ext4, mount point: /home, flag

### 4. win10双系统分区

安装到独立的120硬盘，分区和 单系统分区相同。

