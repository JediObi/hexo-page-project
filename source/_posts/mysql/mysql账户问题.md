---
title: mysql账户问题
copyright: true
date: 2019-09-12 22:28:02
categories:
    - mysql
tags:
    - mysql
---
mysql 5.7 安装之后设置密码无效。普通用户无法登录的情况

<!-- more -->

root用户可以直接登录。或者按照/etc/mysql/debian.cnf里的用户名密码登录后

更新mysql.user里的密码和插件。

```
update mysql.user set authentication_string=password('123'), plugin='mysql_native_password' where user='root';
```

restart mysql.service