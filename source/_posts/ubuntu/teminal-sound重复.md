---
title: teminal sound重复
copyright: true
date: 2019-07-29 11:31:43
categories:
    - ubuntu
tags:
    - ubuntu
---
ubuntu18安装之后可能有terminal提示音多个音效重复的问题。
经过测试，是主题文件里某些引用出了问题（默认音效无法取消和可选新增的音效重叠）。
删除默认音效即可。

<!-- more -->

### **1. gnome alert和Ubuntu streo bell重复**

`mv /usr/share/sounds/ubuntu/streo/bell.ogg /usr/share/sounds/ubuntu/streo/bell.ogg.bak`
