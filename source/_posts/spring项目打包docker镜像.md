---
title: spring项目打包docker镜像
copyright: true
date: 2020-05-10 06:47:42
categories:
tags:
---
使用dockerfile maven插件把spring项目打包成docker镜像。
本文除了打包，还包含加载镜像创建容器，把镜像上传到nexus私服。

<!-- more -->

### (1) pom配置

spring项目一般会配置 spring maven插件。
本文打包需要 dockerfile maven插件

```xml

```

docker 守护进程默认只开启了 unix socket 监听，对应的进程文件为 /var/run/docker.sock，当然你也可以在service文件里修改。默认的这个文件归属于docker用户组和超级用户，所以普通用户需要添加到docker组。

sudo gpasswd -a user_name docker
刷新用户组，只对当前会话有效
newgrp docker
删除用户
sudo gpasswd -d user_name docker



docker方式也支持tcp监听，本地测试不需要开启。在service里配置，一般开启远程就是指开启tcp监听，如果需要在远程服务器上上传镜像，一般是需要开启这个的。




