---
title: fabric (2) local connection
copyright: true
date: 2019-07-31 11:14:21
categories:
    - python3
tags:
    - python3
    - python
    - fabric
    - ssh
---
fabric connection。
connection是建立ssh的基础。
本文介绍如何使用connection操作本地（类似于本地的terminal）。

<!-- more -->

(1) connection

`def hello(c):` is a task. `c` is the default argument. In fact, `c` means a connection. This connection locate at localhost if you don't config with any host information.

(2) local connection

+ fabfile.py

    ```python
    from fabric import task

    @task
    def runLocal(c):
    c.run('pwd')
    ```

+ fab
  
    ```bash
    ~:fab runLocal
    /home/user01
    ```

+ sudo pass from putty
  
    ```python
    c.run('sudo ls -a', pty=True)
    ```

+ sudo pass from config

    ```
    from invoke import Responder
    ...
    passconf = Responder(
    pattern=r'\[sudo]\ password .*:',
    response='password\n',
    )
    c.run('sudo ls -a', pty=True, watchers=[passconf])
    ```
