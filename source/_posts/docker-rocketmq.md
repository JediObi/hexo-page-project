---
title: docker-rocketmq
copyright: true
mathjax: false
date: 2020-09-12 22:10:09
categories:
tags:
---
rocketmq自带高可用的集群配置组件，本文将介绍单机和集群的配置

<!-- more -->

## 1. rocketmq 简介

rocketmq 是一款高性能高可用的mq中间件。支持分布式集群。发布/订阅的核心叫做broker，高可用依赖nameserver（类似于注册中心），rocketmq自带这两个部分。

在直接安装或docker配置时，要分别配置nameserver和broker。

## 2. 配置

### 2.1 下载镜像

```
~:docker pull rocketmqinc/rocketmq
```

### 2.2 运行单实例

#### 2.2.1 运行nameserver

rocketmq-nameserver默认9876端口

测试环境不需要配置日志

```
~:docker run -p 9876:9876 --name rmqserver -v /etc/localtime:/etc/localtime:ro -d rocketmqinc/rocketmq sh mqnamesrv
```

这里在docker环境启动了一个叫做 rmqserver 的实例

#### 2.2.2 运行broker

rocketmq-broker默认10911端口，集群环境下默认的主从复制端口10912，vip借口10909一般不需要

user.home指定到物理机目录下

测试环境使用默认配置，不需要额外配置日志，数据目录，也不需要配置文件

nameserver直接使用局域网实例名 

```
~:docker run --name rmqbroker --link rmqserver:namesrv \
 -p 10911:10911 -p 10909:10909 \
 -v /etc/localtime:/etc/localtime:ro \
 -e "NAMESRV_ADDR=namesrv:9876" -e "JAVA_OPTS=-Duser.home=/opt" \
 -e "JAVA_OPT_EXT=-server -Xms128m -Xmx128m" \
 -d rocketmqinc/rocketmq \
 sh mqbroker
```

#### 2.2.3 控制台


```
~:docker pull styletang/rocketmq-console-ng
~:docker run --name rmqconsole -p 8080:8080 -v /etc/localtime:/etc/localtime:ro -e "JAVA_OPTS=-Drocketmq.config.namesrvAddr=192.168.0.106:9876 -Drocketmq.config.isVIPChannel=false" -itd styletang/rocketmq-console-ng
```

### 2.3 运行集群

#### 2.3.1 创建rocketmq管理的集群

#### 2.3.2 创建k8s管理的集群
