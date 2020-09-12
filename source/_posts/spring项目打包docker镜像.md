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

## 1. pom配置

spring项目一般会配置 spring maven插件。
本文打包需要 dockerfile maven插件

```xml

```

## 2. linux docker配置

docker 守护进程默认只开启了 unix socket 监听，对应的进程文件为 /var/run/docker.sock，当然你也可以在service文件里修改。默认的这个文件归属于docker用户组和超级用户，普通用户组没有权限操作这个文件，所以普通用户需要添加到docker组。

可能系统默认不开启docker，开启之后会影响性能尤其是安装了k8s之后，所以可能需要手动开启docker进程。

+ 命令：添加到docker用户组
```
~:sudo gpasswd -a user_name docker
```

+ 权限生效，命令或重启电脑
```
# 刷新用户组，只对当前会话有效
~:newgrp docker
```

+ 命令：从docker用户组删除用户
```
~:sudo gpasswd -d user_name docker
```

docker也支持tcp监听，本地测试不需要开启。在service里配置，一般开启远程就是指开启tcp监听，如果需要在远程服务器上上传镜像，一般是需要开启这个的。




