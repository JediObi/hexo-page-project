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

使用 docker 创建 mariadb 实例，挂载硬盘做数据持久化。

<!-- more -->

### (1) 拉取镜像

```
~:docker pull mariadb
```

### (2) 创建容器

一般创建 mariadb(或者 mysql)容器，需要映射 3306 端口，创建 root 账户的密码，同时挂载数据目录、日志目录和配置目录。
注意后台运行 -d

```
~:docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mariadb
    -v /usr/local/docker/mysql/conf:/etc/mysql \
    -v /usr/local/docker/mysql/logs:/var/log/mysql \
    -v /usr/local/docker/mysql/data:/var/lib/mysql \
```
