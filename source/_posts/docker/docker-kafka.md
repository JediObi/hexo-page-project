---
title: docker-kafka
copyright: true
mathjax: false
date: 2020-09-12 22:10:26
categories:
    - docker
tags:
    - docker
    - docker-compose
    - kafka
    - zookeeper
---
通过docker-compose部署kafka的开发环境

<!-- more -->

## 1. 配置

开发环境需要安装 `docker-compose`，它是个管理本地容器的工具，类似于k8s的单机版，它的配置文件是`docker-compose.yml`。
kafka默认端口9092，它用zookeeper管理集群。

### 1.1 下载镜像
```
wurstmeister/zookeeper
wurstmeister/kafka
```

### 1.2 运行一个broker
```yml
version: '2'

services:
  zoo1:
    image: wurstmeister/zookeeper
    #restart: unless-stopped
    hostname: zoo1
    ports:
      - "2181:2181"
    container_name: zookeeper

  kafka1:
    image: wurstmeister/kafka
    ports:
      - "9092:9092"
    environment:
      KAFKA_ADVERTISED_HOST_NAME: localhost
      KAFKA_ZOOKEEPER_CONNECT: "zoo1:2181"
      KAFKA_BROKER_ID: 1
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_CREATE_TOPICS: "stream-in:1:1, stream-out:1:1"
    depends_on:
      - zoo1
    container_name: kafka
```

### 1.3 运行多broker

```yml
version: '2'

services:
  zoo1:
    image: wurstmeister/zookeeper
    #restart: unless-stopped
    hostname: zoo1
    ports:
      - "2181:2181"
    container_name: zookeeper

  kafka1:
    image: wurstmeister/kafka
    ports:
      - "9092:9092"
    environment:
      KAFKA_ADVERTISED_HOST_NAME: localhost
      KAFKA_ZOOKEEPER_CONNECT: "zoo1:2181"
      KAFKA_BROKER_ID: 1
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_CREATE_TOPICS: "stream-in:1:1, stream-out:1:1"
    depends_on:
      - zoo1
    container_name: kafka1

  kafka2:
    image: wurstmeister/kafka
    ports:
      - "9093:9092"
    environment:
      KAFKA_ADVERTISED_HOST_NAME: {ipconfig getifaddr en0指令的结果}
      KAFKA_ADVERTISED_PORT: 9093
      KAFKA_ZOOKEEPER_CONNECT: "zoo1:2181"
      KAFKA_BROKER_ID: 2
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
    depends_on:
      - zoo1
    container_name: kafka2
```

### 1.4 docker-compose 用法

### 1.5 kafka 命令行交互

### 1.6 kafka springboot

### 1.4 使用k8s管理集群