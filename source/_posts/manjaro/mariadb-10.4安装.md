---
title: Mariadb 安装
copyright: true
date: 2019-07-29 11:31:43
categories:
    - manjaro
tags:
    - manjaro
    - mysql
    - mariadb
---
Manjaro 18.1.2安装 Mariadb 10过程中并未设置用户名和密码。
用户需要手动配置, 可能会遇到默认的数据库没有安装导致无法启动，并且启动之后还要设置用户密码等等。
类似于mysql 5.7的配置过程。

<!-- more -->

### **1. 安装后无法启动服务**

使用 `journalctl -xe` 查看服务启动日志，mariadb相关错误中，主要是一些系统表无法加载或打开之类的错误，如下：     
`Could not open mysql.plugin table. Some plugins may be not loaded`     
这是因为安装过程中没有安装系统表，需要使用 `mysql_install_db` 来安装。注意 root 权限。          
命令如下:
```
~:sudo systemctl stop mariadb
~:sudo rm -R /var/lib/mysql/*
~:sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
~:sudo systemctl start mariadb
```

### **2. 配置root用户密码**

最初只有两个用户    
root@localhost: 没有密码但只能使用 sudo 权限登录 ; 
mysql@localhost: 没有密码但只能使用 系统的mysql用户 权限登录(由于系统不开放mysql的登录权限，所以不用)。

mariadb 对很多旧的函数仍然支持，可以在登录 root@localhost 之后，修改密码:
```
~:set password=password("root");
```
相比 mysql 5.7 要简单很多。

