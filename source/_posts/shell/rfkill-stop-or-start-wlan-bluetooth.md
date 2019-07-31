---
title: rfkill-stop or start wlan/bluetooth
copyright: true
date: 2019-07-31 14:16:07
categories: 
    - shell
tags:
    - shell
    - wifi
    - rfkill
---
rfkill命令可以管理wlan和bluetooth等射频设备的启动和关闭。

<!-- more -->

(1) list rf devices

`~:rfkill list`
1: wlan0 xxx
2: bluetooth xx

(2) block or unblock
`:rfkill block 1`
`:rfkill unblock 1`