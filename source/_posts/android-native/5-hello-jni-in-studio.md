---
title: 5 - hello-jni in studio
copyright: true
date: 2019-07-26 16:42:58
categories:
    - Android native
tags:
    - Android
    - Android Studio
    - jni
---
Android studio 运行 hello-jni官方demo

<!-- more -->

### **1. 下载 ndk 示例代码**

github 地址: https://github.com/googlesamples/android-ndk

### **2. 打开第一项目 注意配置 配置项目的环境 jdk， sdk， ndk，以及cmake和ndk-build环境变量**

cmake和ndk-build位于sdk目录

### **3. 配置虚拟机( avd )**

正常运行

### **4. 配置build.gradle的阿里云仓库，gradle插件改为3.2.1**

### **5. android studio-->build variants 选择cpu指令集为x86**

### **6. 同步gradle**

Sync project with gradle files

### **7. 运行项目选择创建的虚拟机**