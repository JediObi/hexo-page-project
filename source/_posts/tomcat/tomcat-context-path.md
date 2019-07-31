---
title: tomcat context path
copyright: true
date: 2019-07-31 18:21:09
categories:
    - tomcat
tags:
    - tomcat
---
tomcat容器结构简介。
通过配置context(工程)的相对地址，在浏览器可以免去输入工程名访问。

<!-- more -->

This config lead you to visit your web site without figuring out project name.
before: http://localhost:8080/project_name
now: http://localhost:8080

### **1. tomcat容器结构 **

tomcat容器组成在server.xml里可以看到。
一个tomcat实例只有一个server。
server可以包含多个service。
一个service可以包含多个connector，多个executor，一个engine container。

connector是连接器，可以根据监听不同的接口，并把请求转发到engine。所以不同的协议可以使用不同的connector。

engine，是container的子类，engine可以包含其他多个host container。
host，host是engine的子类，可以包含多个context。host可以配置访问域名估计是。
context是host的子类，可以包含多个wrapper。
wrapper是 context的子类，一个wrapper代表了一个servlet。context管理多个wrapper，一个context对应了一个web工程。

+ tomcat_home/config/server.xml
```xml
<Host autoDeploy="false" ... >
      ...
      <Context path="" docBase="project_name" reloadable="true"/>
      ...
</Host>
```
`autoDeploy=false`: A context cotext could be effective only once. An update including deleting the project in docBase will make it lose effect.

`docBase`: It can be absolute or relative path. A relative path is to `tomcat_home/webapps/`.