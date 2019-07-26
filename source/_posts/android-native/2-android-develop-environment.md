---
title: (2) android develop environment
copyright: true
date: 2019-07-26 15:52:43
categories:
    - Android native
tags:
    - Android
    - native
    - adb shell
---
配置android开发环境。   
sdk和adb命令行操作命令。

<!-- more -->

### **1. jdk**

global jdk environment

### **2. sdk**

android sdk tools   
android sdk platform-tools  
android sdk platform    
android sdk build-tools 
intel images    
android sdk sources 

### **3. sdk manager**

```
~:cd sdk/tools
~:./android
~:./emulator -avd Nexus_5 -qemu -m 2047 -enable-kvm
```

### **4. adb**

```
~:cd sdk/platform-tools
~:sudo ./adb devices
~:sudo ./adb kill-server
~:sudo ./adb start-server
```

### **5. connect to emulator**

```
~:./adb -s emulator-5554 shell
```
