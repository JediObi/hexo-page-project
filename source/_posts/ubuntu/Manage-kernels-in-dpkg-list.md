---
title: Manage kernels in dpkg list
copyright: true
date: 2019-07-29 11:01:28
categories:
    - ubuntu
tags:
    - ubuntu
    - kernel
    - 内核
    - grub
---
系统可以安装多内核，但开机只会加载默认的那个。
开机grub界面可以选择内核，不过单系统需要设置grub开机可见。
通过grub设置可以设置默认内核。通过dpkg删除多余的内核（通过dpkg安装的内核才可以使用dpkg管理）

<!-- more -->

### **1. select boot kernel**

+ #### 1.1 select in grub

    When boot-up choose in grub `Advance Option`.
    **Note:** In sigle system,  grub will skipped when boot-up.
    The following steps will make it visiable.
    ```
    ~:sudo vim /etc/default/grub
    ```
    ```
    #GRUB_HIDDEN_TIMEOUT=0
    ```
    This will make grub visible.

### **2. select grub boot selection**

+ #### 2.1 show kernels

+ #### 2.2 change grub

    ```
    ~:sudo vim /etc/default/grub
    ```
    /etc/default/grub
    ```
    GRUB_DEFAULT=0
    ```
    change the number to which you want.

+ #### 2.3 update grub

    ```
    ~:sudo update-grub2
    ```

+ #### 2.3 reboot system

### **3. delete old kernel**

+ #### 3.1 list images

    ```
    ~:dpkg -l|grep linux
    ```

+ #### 3.2 remove

    ```
    ~:sudo dpkg --purge linux-image-4.x-generic
    ```

+ #### 3.3 update grub

    ```
    ~:sudo update-grub2
    ```
