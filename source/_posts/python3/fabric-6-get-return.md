---
title: fabric (6) get return
copyright: true
date: 2019-07-31 11:22:10
categories:
    - python3
tags:
    - python3
    - python
    - fabric
    - ssh
---
fabric可以获取远程命令执行结果作为返回值。
这些返回值可以用做成功判断和回滚操作。

<!-- more -->

c.run('ls') will return a result

```python
Result(stdout='', stderr='', encoding=None, command='', shell='', env=None, exited=0, pty=False, hide=())
```

get return like this

```python
result = c.run('echo hello')
print('stdout is %s'%result.stdout)
```