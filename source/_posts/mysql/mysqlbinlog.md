---
title: mysqlbinlog
copyright: true
date: 2019-07-26 17:26:56
categories:
    - mysql
tags:
    - mysql
    - mysql log
---
导出并转码mysql二进制日志。
mysql bin log里包含了数据库操作日志，可用于数据回滚。

<!-- more -->

### **1. 选择数据库**

提取指定的数据库的日志
```
~:mysqlbinlog -d db_name mysql-bin.000001 > test.log
```

### **2. base64转码为可读的sql**

-v 把sql语句转码为可读
```
~:mysqlbinlog --base64-output=decode-rows -v mysql-bin.000001 > test.log
```
