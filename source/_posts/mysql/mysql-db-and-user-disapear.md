---
title: mysql db and user disapear
copyright: true
date: 2019-07-26 18:41:07
categories:
    - mysql
tags:
    - mysql
    - windows
    - mysql service
---
mysql 创建的数据库和用户消失的问题。
win10上能重复安装mysql service，但每次只能启动一个。
每个service的库是不一样的，会导致库和用户消失的问题。

<!-- more -->

mysql 5.6
windows10

### **1. Theory**

A service is an instance of mysql. 
We can use ```mysqld --install [service_name_not_necessary]``` to install a mysql service.
But things isn't like oracle. Though there can be more than one mysql instance in windows. But only one of them can be start and keep runing.

### **2. Problem**

If you create somthing in a mysql instance. And at next time, if windows starts a different instance, after logining into mysql you won't see any issues you created before.


### **3. Deal**

Most convenient way.
Change the service to the right instance.

If you want only one instance, you should delete extra instances. 

install an instance
`mysqld --install [service_name]` service name is not necessary

delete an instance
`mysqld --remove [service_name]` service name is not necessary

delete an service with windows command
`sc delete mysql_service_name` service_name is necessary but don't need the service really exists.

### **4. net start & stop mysql**

`net start service_name` it can start a service, use this command to start a msyql instance, the service must exits (you can use `mysqld --install [service_name]` to install a mysql service). If the service doesn't exist,  error 2185 will occure.