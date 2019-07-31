---
title: iwconfig connect to wep wifi
copyright: true
date: 2019-07-31 14:20:00
categories:
    - shell
tags:
    - shell
    - iwconfig
    - wifi
---
iwconfig命令连接wep加密的wifi

<!-- more -->

(1) scan

`~:sudo iwlist wlan0 scan`

(2) connect

`~:sudo iwconfig wlan0 essid 1234-1234-abcd`
