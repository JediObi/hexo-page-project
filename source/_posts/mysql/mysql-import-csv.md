---
title: mysql import csv
copyright: true
date: 2019-07-26 18:12:39
categories:
    - mysql
tags:
    - mysql
    - csv
---
连接mysql之后导入csv数据

<!-- more -->

```
LOAD DATA LOCAL INFILE '/home/fwdadmin/test.csv' 
INTO TABLE bankinfo 
FIELDS 
ESCAPED BY    '\\' 
TERMINATED BY     ',' 
ENCLOSED BY   '"' 
LINES TERMINATED BY   '\r\n' 
(`bankcode`,`bankname`); --fileds area that you want.
```