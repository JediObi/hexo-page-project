---
title: zookeeper specify jre
copyright: true
date: 2019-07-31 12:15:25
categories:
    - 中间件
tags:
    - 中间件
    - zookeeper
---
zookeeper也可以修改运行需要的jdk或jre环境

<!-- more -->

vim bin/zkEnv.sh
```
JAVA_HOME=/home/username/jdk1.8.x_x
```
