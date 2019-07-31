---
title: fabric (5) change directory cd
copyright: true
date: 2019-07-31 11:20:48
categories:
    - python3
tags:
    - python3
    - python
    - fabric
    - ssh
---
fabric提供一些api可以替代常用的命令。
本文介绍`cd()`接口替代`cd`命令。

<!-- more -->

(1) command

```
c.cd(dir)
c.run('cd /home')
```

(2) keep path context
```
dir = '/home'
c.run('pwd') # /home/user
with c.cd(dir):
  c.run('pwd') # /home
```