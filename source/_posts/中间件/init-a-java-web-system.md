---
title: init a java web system
copyright: true
date: 2019-07-31 12:10:03
categories:
    - 中间件
tags:
    - 中间件
    - tomcat
    - zookeeper
---
在linux上配置一个java web开发环境。
包括为tomcat和zookeeper指定jdk环境。
这些中间件可能并不使用全局配置中的jdk。

<!-- more -->

(1) install mysql

(2) install jdk => jdk.tar.gz

(3) tomcat

tomcat_home/bin/catalina.sh
```
JAVA_HOME=/home/username/jdk1.8.x_x
...
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
```

(4) zookeeper

1) config
   
    cd zookeeper_home
    cp conf/zoo_sample.cfg conf/zoo.cfg
    vim conf/zoo.cfg
    ```
    dataDir=zookeeper_home/data
    dataLogDir=zookeeper_home/logs
    ```
    mkdir data
    mkdir logs

2) environment
   
    vim bin/zkEnv.sh
    ```
    JAVA_HOME=/home/username/jdk1.8.x_x
    ```

3) command
   
    ./bin/zkServer.sh start/stop/status
