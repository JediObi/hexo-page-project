---
title: redis
copyright: true
date: 2019-07-29 11:14:18
categories:
    - ubuntu
tags:
    - ubuntu
    - redis
---
redis的安装。单机和集群的配置。

<!-- more -->

### **1. install**

+ #### 1.1 install

    ```
    ~:sudo apt-get install redis-server
    ```

### **2. single node**

+ #### 2.1 config

    **/etc/redis/redis.conf**
    ```
    requirepass root
    ```

+ #### 2.2 start && restart && stop

    ```
    ~:sudo systemctl restart redis-server
    ```

+ #### 2.3 connect

    ```
    ~:redis-cli
    ~:ping
    ~:auth root
    ~:set test_key test_value
    ~:get test_key
    ```

+ #### 2.4 change db

    ```
    ~:select 4
    ```

### **3. cluster**

**3 main**
**3 slaves**

+ #### 3.1 install redis-trib.rb

    this module is in redis source.
    Download redis sorce package and install redis-trib.
