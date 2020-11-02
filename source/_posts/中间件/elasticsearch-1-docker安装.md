---
title: elasticsearch-1-docker安装
copyright: true
mathjax: false
date: 2020-11-02 22:08:15
categories:
    - elasticsearch
tags:
    - elasticsearch
    - 中间件
    - elk
    - docker
---
使用elasticsearch的docker镜像搭建测试环境

<!-- more -->

## 1. 选择镜像

```
elasticsearch
```

## 2. 创建容器

```
docker run -d --name es-test -p 9200:9200 -p 9300:9300 -v /etc/localtime:/etc/localtime -e dicovery.type=single-node -e ES_JAVA_OPTS="-Xms256m -Xmx512m" elasticsearch
```
其中两个env参数，主要是启动单节点，限制jvm内存，内存过大容器容易死机，9200是restapi使用的http端口，9300是集群通信的tcp端口。
