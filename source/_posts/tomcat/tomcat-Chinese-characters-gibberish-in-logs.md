---
title: tomcat Chinese characters gibberish in logs
copyright: true
date: 2019-07-31 18:19:16
categories:
    - tomcat
tags:
    - tomcat
    - 中文乱码
---
tomcat设置utf8编码解决日志乱码。

<!-- more -->

+ tomcat_home/bin/catalina.sh
inject one line
```
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
```