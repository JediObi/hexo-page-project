---
title: fabric (7) other
copyright: true
date: 2019-07-31 11:24:14
categories:
      - python3
tags:
      - python3
      - python
      - fabric
      - ssh
---
一些常见的问题。
fabric连接可能不支持某些命令。
远端命令执行上下文问题。
远端的环境变量需要在脚本代码里配置等问题。

<!-- more -->

(1) 

`lsof` don't use it if not necessary

(2) cotext manage

use  `with` for context

(3) environment var

```python
with c.prefix("export TEST_ENV_VAR='this is test'"):
      c.run("echo ${TEST_ENV_VAR}")

with c.prefix("export PATH=${PATH}:"+server["/home/user/bin/node/bin"]):
        cmd = "node -v"
        print(cmd)
        c.run(cmd)
```