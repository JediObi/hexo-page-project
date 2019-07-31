---
title: rabbitMQ
copyright: true
date: 2019-07-29 11:17:28
categories:
    - ubuntu
tags:
    - ubuntu
    - rabbitMQ
---
rabiitMQ在ubuntu上的安装和配置

<!-- more -->

### **1. install**

+ #### 1.1 install

    ```
    ~:sudo dpkg -i rabbitMQ.deb
    ```

+ #### 2.2 enable management plugin

    ```
    ~:sudo rabbitmq-plugins enable rabbitmq_management
    ```

+ #### 2.3 list users

    ```
    ~:sudo rabbitmqctl list_users
    ```

+ #### 2.4 add user

    ```
    # username admin, password admin123
    ~:sudo rabbitmqctl add_user admin admin123 
    # set admin as administrator
    ~:sudo rabbitmqctl set_user_tags admin administrator
    ```

+ #### 2.5 html gui

    http://localhost:15672
    guest/guest
