---
title: k8s使用minikube安装单机集群
copyright: true
date: 2020-04-25 22:30:37
categories:
    - k8s
    - docker
tags:
    - k8s
    - docker
---
k8s能够管理docker集群，自动扩缩容，简化了运维工作量。使用k8s加docker部署本地测试环境也很方便，免去了很多软件安装配置，随时用随时启动。
这里介绍minikube+本机docker的方式，在本地搭建docker集群。

<!-- more -->

(1) minikube介绍

k8s本身的集群组件会以docker容器的形式运行，所以minikube实际做的工作就是在物理机或虚拟机上安装docker，然后下载k8s组件的镜像，并提供参数启动容器。
minikube可以使用虚拟机或者物理机，这个参数是可以通过命令控制的，这里仅介绍物理机的方式，即minikube直接操作本机安装的docker。简单介绍下虚拟机的方式，minikube首先创建虚拟机，然后在虚拟机上安装docker并配置k8s的镜像和实例，用户要手动管理虚拟机上的docker时需要ssh连接到虚拟机上。
由于minikube默认使用的k8s镜像源都在国外，会很满，所以使用国内镜像，然后重命名或者通过minikube参数的形式使用国内镜像创建k8s容器集群。
