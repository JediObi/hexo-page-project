---
title: 6 - hello-jni in termial
copyright: true
date: 2019-07-26 16:46:00
categories:
    - Android native
tags:
    - Android
    - jni
---
shell编译hello-jni官方demo

<!-- more -->

### **1. c/c++代码的编译可以使用make或cmake**

基于make的ndk-build+Android.mk是一种较原始的方式
而cmake就是当前版本支持的跨平台方式
gradle通过配置集成其中一个，使gradle可以编译c/c++代码

### **2. build.gradle配置**

gradle集成cmake配置免去了直接用cmake命令编译的过程

模块的gradle配置

+ #### 2.1 default配置 可以指定cmake的指令集和其他参数

    ```
    defaultConfig {
            ...
            externalNativeBuild {
                cmake {
                    abiFiters 'x86'
                    cppFlags ''
                }
            }
        }
    ```
+ #### 2.2 nativeBuild配置 指定cmake 的配置文件位置 CMakeLists.txt

    ```
    externalNativeBuild {
    cmake {
                version '3.10.2'
                path "src/main/cpp/CMakeLists.txt"
            }
    }
    ```

### **3. 使用cmake命令编译**
