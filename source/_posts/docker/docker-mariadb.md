---
title: docker-mariadb
copyright: true
date: 2020-06-29 06:51:30
categories:
    - docker
tags:
    - docker
    - mysql
    - mariadb
---
使用docker创建mariadb实例，挂载硬盘做数据持久化。

<!-- more -->

### (1) 拉取镜像

```
~:docker pull mariadb
```

### (2) 创建容器

一般创建mariadb(或者mysql)容器，需要映射3306端口，创建root账户的密码，同时挂载数据目录、日志目录和配置目录。
注意后台运行 -d

```
~:docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mariadb 
    -v /usr/local/docker/mysql/conf:/etc/mysql \
    -v /usr/local/docker/mysql/logs:/var/log/mysql \
    -v /usr/local/docker/mysql/data:/var/lib/mysql \
```
