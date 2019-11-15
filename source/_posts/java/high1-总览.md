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


mysql 调优

(1) 使用查询 缓存 query cache

query cache 使用 hash表缓存 select 语句的执行结果集 resultSet， select语句的hash值就是key。

1. query_cache 有两个关键参数 

    query_cache_size    缓存的大小
    query_cache_type    off(完全不用查询缓存)/on(除显示写明不用外，默认都用)/demand(除显式写明用外，默认都不用)

2. query_cache 合理性评价指标

通过一下命令之一，查看 query_cache 状态
```
~:show variables like "%query_cache%"
~:show status like "Qcache%"
```
会显示以下参数
```
Qcache inserts          缓存更新次数， 缓存未命中时往缓存中插入数据的次数

Qcache hits             缓存命中率，数值很小说明命中率低，可以考虑不用缓存  

Qcache lowmem prunes    缓存淘汰次数，数值非常大，说明缓存设置过小经常不够用导致经常刷新和淘汰数据

Qcache free blocks      缓存区的存储空间碎片数量，如果数值过大，说明内存碎片太多，应该清理了
```
以上数据中 hits 和 inserts 是最重要的指标，二者之和就是使用缓存的次数，因此缓存命中率 = hist/(hits+inserts)

3. innodb 缓存池

`innodb_buffer_pool_size `       innodb 缓存池大小

innodb 在内存中开辟一个缓存池，用于缓存 所有的数据索引和被操作的数据。读取和写入都先经过缓存池，读取时，先从缓存池读，读不到则从磁盘读然后写到缓存然后返回结果。写入时，也是先在缓存中完成再同步到磁盘上（同步频率大于每秒若干条）;     
缓存池大小，在独立的mysql服务器上一般80%物理内存。      
缓存池命中率: (innodb_buffer_pool_read_requests - innodb_buffer_pool_reads) / innodb_buffer_pool_read_requests

`table_cache`       表的高速缓存数量， mysql 会缓存一定数量的表到缓存区，一般来说每个connection至少会访问一张表，如果connection需要的表不在缓存区就会加载该表到缓存区（如果，缓存数量不够，就会淘汰某个旧的缓存）。

java 缓存

1. 平台级缓存 

`深入分布式缓存`中的介绍平台缓存是专门用于缓存的一些库，比如java的 ehcache。区别于 redis,mongodb,memcached 这种应用级缓存。

一般作为一级缓存使用。

在我看来就是提供 `jvm 缓存`， ehcache 虽然工作早jvm里，但是也支持集群和扩展。

2. 应用级缓存

像 redis, mongodb, memcached 这种，一个独立的应用中间件，可以独立部署运行。

多级缓存架构

1. nginx 本地缓存 第三层

多种实现方式 Lua Shared Dict/Nginx Proxy Cache/或者本地redis


2. redis 集群 第二层

3. jvm 缓存  第一层

4. 数据库缓存 第0层



