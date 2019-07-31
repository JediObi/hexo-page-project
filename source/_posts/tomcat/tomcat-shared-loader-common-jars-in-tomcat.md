---
title: tomcat shared.loader common jars in tomcat
copyright: true
date: 2019-07-31 18:17:40
categories:
    - tomcat
tags:
    - tomcat
---
tomcat项目jar包共享目录设置。

<!-- more -->

You can put your jars in a specified directory. Instead of packaging them into wars.

We set a jar scope as provided in a maven web project. This jar will not be packaged in to the war during install. And we specify a dir for shared.loader in catalina.properties.

```

shared.loader=/home/admin/testlib,/home/admin/testlib/*.jar

```