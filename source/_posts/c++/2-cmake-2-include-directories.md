---
title: (2) cmake-2 include_directories()
copyright: true
date: 2019-07-25 22:27:11
categories:
    - c++
tags:
    - c++
    - cmake
---
源码中的include如果未指明路径，在编译时会出错。
在`CMakeLists.txt`中`include_directories(路径)`，将会给make添加搜索路径。
注意，这样使用会使源码可读性变差。所以源码的结构最好别依赖构建工具。

<!-- more -->

源码中的include如果未指明路径，在编译时会出错。
在`CMakeLists.txt`中`include_directories(路径)`，将会给make添加搜索路径。
注意，这样使用会使源码可读性变差。所以源码的结构最好别依赖构建工具。
