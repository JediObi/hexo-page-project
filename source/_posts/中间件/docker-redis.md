---
title: docker-redis
copyright: true
mathjax: false
date: 2020-09-12 22:09:57
categories:
    - 中间件
tags:
    - 中间件
    - redis
    - docker
---
本文使用基于alpine的redis镜像。简单的配置一个redis集群。

<!-- more -->

## 1. 安装

### 1.1 镜像下载

可以去dockerhub上搜索redis镜像的各种tag，文章发布时使用的版本`redis:alpine3.12`

```
~:docker pull redis:alpine3.12
```

### 1.2 运行单实例

```
~:docker run --name redis-test -p 6379:6379 -v /etc/localtime:/etc/localtime:ro -itd redis:alpine3.12
```

带密码
```
docker run -d --name redis-test -p 6379:6379 -v /etc/localtime:/etc/localtime:ro redis:alpine3.12 --requirepass "123456"
```


### 1.3 运行集群

#### 1.3.1 创建redis管理的集群

#### 1.3.2 创建k8s管理的集群
