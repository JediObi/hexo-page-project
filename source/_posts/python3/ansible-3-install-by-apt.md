---
title: ansible (3) install by apt
copyright: true
date: 2019-07-31 11:33:59
categories:
      - python3
tags:
      - python3
      - python
      - ansible
      - ssh
---
使用apt安装ansible。

<!-- more -->

(1) install
```
~:sudo apt-get install ansible
```

(2) use ssh passwords
缺少模块导致不支持ssh登录需要安装sshpass模块
```
~:sudo apt-get install sshpass
```

(3) skip host checking 跳过首次连接检查
+ /etc/ansible/ansible.cfg
```
host_key_checking = False  
```