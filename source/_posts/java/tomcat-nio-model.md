---
title: tomcat nio model
copyright: true
date: 2019-07-31 10:50:26
categories:
    - java
tags:
    - java
    - tomcat
    - nio
---
tomcat nio简介

<!-- more -->

首先B/S架构和C/S架构一样基于Socket(TCP)通信
Tomcat作为web服务器，
接收client的Socket,解析其中的HttPServletRequest然后传递给后台的java web，由java web解析。
接收后台java web的HttpServletResponse封装到Socket中传给client.


而Tomcat在从Socket中获取HttpServletRequest的过程中完成了高性能的nio过程。
过程如下
```
(1)就像所有的socket通信，tomcat最外层有一个阻塞线程，用于侦听socket，侦听到socket之后，由Acceptor线程池为每个socket连接建立一个连接线程

(2)buffer-channel-selector是nio的一般过程
tomcat模型，从连接线程中获取socketchannel,封装成niochannel,
再把niochannel封装到PollerEvent对象，
再把PollerEvent对象压到event queue队列

(3)Poller线程是单一线程，维护一个Selector，
该线程轮询event queue中的channel，获取需要执行I/O的Socket，

(4)Worker线程池用于为耗时操作创建线程，
poller轮询到执行I/O的socket把它传递到worker线程，
worker线程从socket中获取request解析为HttpServletRequest，
然后传递到后台Servlet中处理，然后把response通过该socket发送到client.
```
![f570bf7c-4f06-3ba9-8be2-8581d167a0de.jpg](https://upload-images.jianshu.io/upload_images/5420342-711ada810597742e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
