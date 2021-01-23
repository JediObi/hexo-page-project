---
title: docker-使用问题归档
copyright: true
mathjax: false
date: 2021-01-23 19:14:48
categories:
    - docker
tags:
    - docker
    - linux
    - manjaro
    - ubuntu
---
本文将会记录docker使用中的各种问题和解决方法

<!-- more -->

### 1. linux 系统无法启动或者无法操作docker

linux环境的docker有`独立的docker用户组`，所以由于权限问题，其他用户组无法操作docker相关资源，比如docker的进程文件(默认路径 /var/run/docker.sock)。

只要把普通用户加入到docker用户组即可。

- 命令：添加到 docker 用户组

```
~:sudo gpasswd -a user_name docker
```

- 权限生效，命令或重启电脑

```
# 刷新用户组，只对当前会话有效
~:newgrp docker
```

- 命令：从 docker 用户组删除用户

```
~:sudo gpasswd -d user_name docker
```

ps: 

+ linux系统上 docker 守护进程默认只开启了 unix socket 监听，对应的进程文件为 /var/run/docker.sock，当然你也可以在 service 文件里修改这个路径。这个文件归属于 docker 用户组和超级用户，普通用户组没有权限操作这个文件，所以普通用户需要添加到 docker 组。

+ docker默认开机不启动，安装了 k8s 之后开机启动非常慢，所以可能需要手动开启 docker 进程。

+ tcp监听，前边说了linux只开了unix sodket监听，docker 也支持 tcp 监听，本地测试不需要开启。在 service 里配置，一般开启远程就是指开启 tcp 监听，如果需要在远程服务器上上传镜像，一般是需要开启这个的。


### 2. 图形界面cockpit

manajro 安装cockpit，然后在启动`systemctl start cockpit`。

然后打开浏览器`https://localhost:9090`，用户名与密码就是当前系统的用户名和密码，可以方便的管理容器。