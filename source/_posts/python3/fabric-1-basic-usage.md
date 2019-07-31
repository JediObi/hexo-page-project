---
title: fabric (1) basic usage
copyright: true
date: 2019-07-31 11:11:37
categories:
    - python3
tags:
    - python3
    - python
    - fabric
    - ssh
---
本文介绍了fabric基础用法。
fabric是一个python ssh操作的包。它比paramiko更方便和高级。

<!-- more -->

### (1) install python module and shell

```bash
~:sudo pip3 install fabric
~:sudo apt-get fabric
```

### (2) help and version

```bash
~:fab -h
~:fab -V
```

### (3) tasks

+ fabfile.py

    ```python
    from fabric import task

    @task
    def hello(c):
    print('hello')
    ```

+ intro

    `from fabric import task` is necessary for `@task`.
    `hello(c)` is a task, it must have a default initial argument here is `c`.

+ fab

    ```bash
    ~:fab -l
    hello
    ~:fab hello
    hello
    ```
