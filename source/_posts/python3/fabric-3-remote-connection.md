---
title: fabric (3) remote connection
copyright: true
date: 2019-07-31 11:17:21
categories:
    - python3
tags:
    - python3 
    - python
    - fabric
    - ssh
---
介绍使用connection连接远程服务器并执行简单的命令。

<!-- more -->

(1) config connection

```python
from fabric import Connection
...
c = Connection(host='web1', user='deploy', port=2202)
# [user@]host[:port] 
# c = Connection('deploy@web1:2202')
```

(2) connection with password

```python
c = Connection(host='web1', user='deploy', port=2202, connect_kwargs={'password':'pass_word'})
c.run('pwd')
```