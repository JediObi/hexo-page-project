---
title: Mariadb 安装
copyright: true
date: 2019-07-29 11:31:43
categories:
    - manjaro
tags:
    - manjaro
    - fcitx
---
`搜狗拼音`需要`fcitx`的支持。
需要配置 中文镜像源 以获取搜狗拼音的包。

<!-- more -->

### **1. fcitx 安装**

截止 2019-11-01 Manjaro 18.1.2， 使用 fcitx 5 即可。        
但是有多种不同的实现，此处使用 qt的实现
```
~:sudo pacman -S fcitx-qt4 fcitx-qt5 fcitx-configtool fcitx-sogoupinyin
```
** `fcitx-configtool` 是 fcitx 的配置界面

### **2. 应用输入法**

`~/.xprofile`
```
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"%
```
在 fcitx 的配置界面添加 搜狗输入法 

