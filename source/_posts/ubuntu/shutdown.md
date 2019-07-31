---
title: shutdown
copyright: true
date: 2019-07-29 11:40:57
categories:
    - ubuntu
tags:
    - ubuntu
    - 关机
    - 守护进程
    - 无法关机
---
ubuntu经常会有无法关机的情况。
因为关机时无法关掉一些守护进程，比如mysql。

<!-- more -->

### **1. 由于某些进程无法结束,导致无法关机**

比如 mysql, 需要关掉mariadb和mysql服务
```
sudo systemctl stop mariadb
sudo systemctl sotp mysql
```

### **2. 禁止服务开机启动**

+ #### 2.1 对于mariadb这类native服务

    ```
    sudo systemctl disable mariadb
    ```

+ #### 2.2 对于mariadb的mysql这种非navtive服务

    ```
    sudo /lib/systemd/systemd-sysv-install disable mysql
    ```
