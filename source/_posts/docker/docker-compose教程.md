---
title: docker-compose教程
copyright: true
mathjax: false
date: 2021-08-15 21:06:25
categories:
  - docker
tags:
  - docker
  - docker-compose
---
docker-compose是一个本地docker容器管理工具，通过yml脚本实现容器的批量管理,可以理解为k8s的简化版

<!-- more -->

## 1. 简介

docker-compose 通过脚本来批量管理容器，这些容器可以从既有镜像创建，也可以从Dockerfile开始创建。

此外还可以管理网卡，挂载卷等

## 2. 从既有镜像开始-基本使用

### 2.1 脚本demo

```yml
version: '3'

services:
    nginx1:
        container_name: "nginx-test"
        image: nginx
        ports:
            - "8080:8080"
            - "8081:8081"

    mariadb1:
        container_name: "mysql-test"
        image: mariadb
        ports: 
            - "3306:3306"
        environment:
            MYSQL_ROOT_PASSWORD: "123456"
        volumes:
            - "/etc/localtime:/etc/localtime:ro"
        command: [
            "--character-set-server=utf8",
            "--collation-server=utf8_bin"
        ]

```

脚本解释
`version` 固定格式，必须要写，版本号看你的docker-compose
`services` 容器列表， 每个容器节点有自己的名称比如demo里的 nginx1, mariadb1
然后是`容器节点`, 基本和 `docker run` 命令差不多， 这里对比下 `mariadb1` 这个节点的run命令

```
docker run -it --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD="123456" -v /etc/localtime:/etc/localtime:ro mariadb --character-set-server=utf8 --collation-server=utf8_bin
```

### 2.2 docker-compose 命令

docker-compose 默认使用当前目录下的 docker-compose.yml, 如果要指定其他配置文件，请用 `-f <yml路径>`

#### 2.2.1 创建并启动容器

会创建容器并启动，如果容器依赖的镜像有改变，则会重新创建容器，也就是容器的更新功能

```
docker-compose up 
```

如果需要在后台启动

```
docker-compose up -d
```

#### 2.2.2 停止服务

会停止当前配置文件管理的所有容器, 不会删除容器

```
docker-compose stop
```

#### 2.2.3 删除停止的容器

会删除已经停止的容器和网络，但不会删除卷和镜像

```
docker-compose rm
```

#### 2.2.4 重启应用

仅仅是重启容器，不会更新容器

```
docker-compose restart
```

#### 2.2.5 进程查看

输出当前管理的容器的状态

```
docker-compose ps
```

#### 2.2.5 删除所有容器

删除所有管理的容器和网络，但不会删除卷和镜像

```
docker-compose down
```

## 3. 从 Dockerfile 创建

```yml
# yaml 配置实例
version: '3'
services:
  web:
    build: .
    ports:
        - "5000:5000"
    volumes:
        - .:/code
        - logvolume01:/var/log
  redis:
    image: redis
volumes:
  logvolume01: {}
```

`build` 容器节点中的 build 用于指定 Dockerfile, 此处就是使用 当前目录下的 Dockerfile, 如果想要细化可以如下
```yml
build:
    context: .
    dockerfile: Dockerfile-prod
```
`context` 指定Dockerfile路径
`dockerfile` 指定 Dockerfile文件名

## 4. 网络配置

这里主讲 services 中为各个容器指定网络并分配固定ip。

用途：一般各个服务通过ip访问，docker需要配置独立的自定义网络才能指定ip。
`注意：虽然 docker-compose 的 links 提供了按服务名称访问忽略ip变动的快捷方式，但这里主要讲ip直接访问的形式，感兴趣可以自行查找links资料。`


### 4.1 脚本

```yml
# yaml 配置实例
version: '3'
services:
  app1:
    networks:
      network1:
          ipv4_address: 172.0.0.3
          ipv6_address: 2001:3984:3989::10
networks:
  network1:
    driver: bridge/host/none/container 四种驱动之一
    ipam:
        config:
            - subnet: 172.16.0.0/16
              gateway: 172.16.0.1
            - subnet: "2001:3984:3989::/64"
```

容器节点中的 `networks` 可以指定网络配置节点的名称来使用网络配置，可以配置多网络这里不多说了。
然后配置网络地址就是 `app_net` 里那样，一般都是 ipv4 和 ipv6 的地址

网络配置节点，每个节点自定义一个名称，ipam就是网络的具体配置，subnet 可以配置多个
