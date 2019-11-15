---
title: high1-总览
copyright: true
date: 2019-11-15 11:22:22
categories:
    - java
tags:
    - java
    - cache
    - 高性能
    - 缓存
---
web项目的缓存架构介绍

<!-- more -->

为项目加上多层缓存，可以有效提高性能。

### (1) `深入分布式缓存` 大概是京东的缓存架构， 结构如下:       
<a id="li_1"></a>

nginx 缓存 -> redis 缓存集群 -> tomcat 集群，jvm缓存

请求到达nginx层， nginx 从本地取缓存，如果没取到，则取 redis 缓存，如果还没取到，则走 tomcat， tomcat 会尝试从jvm缓存读取，如果jvm缓存没有就去数据库，读完会写到 redis，也会返回给nginx， nginx会做缓存然后返回结果。



### (2) 自已yy的缓存架构

redis 缓存集群 -> tomcat 集群, jvm缓存

与 [(1)](#li_1) 的架构相比，缺少了 nginx 缓存。