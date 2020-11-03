---
title: sentinel-docker安装
copyright: true
mathjax: false
date: 2020-11-03 22:06:13
categories:
tags:
---
使用docker运行一个sentinel(包含dashboard)实例。

<!-- more -->


## 1. 镜像

```
docker pull bladex/sentinel-dashboard
```

## 2. 创建容器

```
docker run -d --name sentinel-test -p 8858:8858 bladex/sentinel-dashboard
```