---
title: ansible (2) simple usage
copyright: true
date: 2019-07-31 11:32:28
categories:
      - python3
tags:
      - python3
      - python
      - ansible
      - ssh
---
ansible的简单示例

<!-- more -->

(1) hosts group

服务器配置

+ /etc/ansible/hosts

    ```
    [group_name1]
    host_ip1 [ansible_ssh_user=] [ansible_ssh_pass=]
    host_ip2

    [group_name1]
    ansible_ssh_user=
    ansible_ssh_pass=
    ```
    以上配置 指定了一组服务器, 默认ssh用户信息可在组名下另行配置,单独的host用户信息则在同行配置

(2) command format

命令格式
`ansible ip/group -m module_name -a arg`
其中ip可以是某个具体的ip, group则是组名,使用group将会对组内所有服务器执行相同操作
-m 指定要运行的功能模块, module_name就是功能模块的名字
-a 为要运行的功能模块传入参数

(3) specify ip collection

以ping为例
-i 表示自行制定host文件,而不用默认的/etc/ansible/hosts
`ansible all -i ./hosts -m ping`
