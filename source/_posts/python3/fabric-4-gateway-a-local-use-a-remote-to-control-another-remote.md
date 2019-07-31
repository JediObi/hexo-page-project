---
title: fabric (4) gateway-a local use a remote to control another remote
copyright: true
date: 2019-07-31 11:18:48
categories:
    - python3
tags:
    - python3
    - python
    - fabric
    - ssh
---
fabric也支持跳板机。可以连接远程跳板机A并操作远程机器B，实际相当于连接上A，A ssh 连接B。

<!-- more -->

```python
from fabric import Connection
...
gateway = Connection(host='remote_pub_host',user='root',port="22",connect_kwargs={'password':'password'})
c = Connection(host='remote_pub_or_private_host',user='root',port="22",connect_kwargs={'password':'password'},gateway=gateway)
with c.cd('/home/user'):
  c.run('echo a>>a.txt')
```