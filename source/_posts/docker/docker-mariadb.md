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

### 1. 拉取镜像

```
~:docker pull mariadb
```

### 2. 创建容器

一般创建 mariadb(或者 mysql)容器，需要映射 3306 端口，创建 root 账户的密码，同时挂载数据目录、日志目录和配置目录。
注意后台运行 -d
中文编码 --character-set-server=utf8 --collation-server=utf8_bin
日志挂载到物理机

```
~:docker run --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 \
    -v /usr/local/docker/mysql/conf:/etc/mysql \
    -v /usr/local/docker/mysql/logs:/var/log/mysql \
    -v /usr/local/docker/mysql/data:/var/lib/mysql \
    -v /etc/localtime:/etc/localtime:ro \
    -itd mariadb \
    --character-set-server=utf8 --collation-server=utf8_bin
```

### 3. 创建读写分离的主备集群

#### 3.1 读写分离

#### 3.2 主备

### 4. 创建代理 - mycat

#### 5. k8s管理 mycat 集群


#### 6. canal同步