---
title: ubuntu 18.04 install mariadb 10.3
copyright: true
date: 2019-07-26 18:08:05
categories:
    - mysql
tags:
    - mysql
    - mariadb
---
安装mariadb指定版本。
mariadb的配置和界面比mysql更加友好。兼容性也更强。
此处只是一些安装后的错误和解决办法。

<!-- more -->

You can see the steps in my article. (11)
[steps](https://www.jianshu.com/p/30c720becad8)

Here are some error dealing.

### **1. `Plugin 'unix_socket' is not loaded.`**

```
~:systemctl stop mysql
~:sudo mysqld_safe --skip-grant-tables &
~:mysql -u root
~:select host,user,plugin from mysql.user where user='root';
~:update mysql.user set plugin='mysql_native_password' where user='root';
~:set password =password('new_password');
~:systemctl restart mysql
```

### **2. my.cnf**

```
~:mysql --help|grep my.cnf
```
```
~:cp /etc/mysql/mariadb.cnf my.cnf
```