---
title: tomcat specify jre
copyright: true
date: 2019-07-31 12:13:02
categories:
    - 中间件
tags:
    - 中间件
    - tomcat
---
为tomcat指定jdk。比如测试机全局配置jdk1.8，并且已经有多个tomcat实例。要部署一个jdk1.6的tomcat6。
可以按本文配置修改tomcat的jdk。

<!-- more -->

tomcat_home/bin/catalina.sh
```
# top line
JAVA_HOME=/home/username/jdk1.8.x_x
...
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
```
