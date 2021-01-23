---
title: docker-nas-samba
copyright: true
mathjax: false
date: 2020-09-20 22:45:25
categories:
    - nas
tags:
    - nas
    - samba
    - linux
    - docker
---
使用docker搭建samba nas

<!-- more -->

## 1. 镜像

```
docker pull dperson/samba
```

## 2. 创建容器

```
docker run -it --name samba_docker -p 139:139 -p 445:445 -v /home/user_name/nas_data:/home/shares/shareA -d dperson/samba -w "WORKGROUP" -u "userA;123456789" -s "shareA;/home/shares/shareA;yes;no;no;userA;userA;userA"

docker run -it --name samba_docker -p 139:139 -p 445:445 -p 137:137/udp -p 138:138/udp -v /run/media/nomq/linux_work/work/mi-camera:/home/shares/shareA -d dperson/samba -w "WORKGROUP" -u "userA;123456789" -s "shareA;/home/shares/shareA;yes;no;no;userA;userA;userA" -n
```

参数说明
139/445端口 samba默认使用的两个端口
-n  开启nmbd广播进程，samba使用nmbd做局域网广播，一些iot设备只支持扫描发现nas，不支持手动输入ip，所以要开启nmbd服务
137-138/udb nmbd默认使用这两个端口做udp广播
-w 工作组
-u 用户名和密码
-s samba配置文件新增配置节点
```
shareA;/home/shares/shareA;yes;no;no;userA;userA;userA
shareA 节点shareA
/home/shares/shareA 共享目录/home/shares/shareA
yes 共享名称对所有工作组用户可见
no 不是只读（也就是说可写）
no 不允许guest用户
userA 指定共享的所有权用户
userA 指定共享的超级用户
userA 指定具有写权限的用户
```

## 3. 其他配置

上边创建的容器没有挂载samba的配置文件smb.cnf， samba配置文件默认位于 /etc/samba/smb.conf。
我们可以通过docker cp执行覆盖

```
# 从容器里复制出来
~:docker cp samba_docker:/etc/samba/smb.conf ./smb.conf

# 复制到容器里
~:docker cp ./smb.conf samba_docker:/etc/samba/smb.conf
```

一般要修改的可能是降低samba的协议版本，以兼容某些旧的客户端（比如app或者iot设备），协议版本位于 global节点
这里把协议降低到smbv1 -> NT1
```
server min protocol = NT1
```
