---
title: expect
copyright: true
date: 2019-07-31 12:28:41
categories:
    - shell
tags:
    - shell
    - expect
---
expect关键字可以用于shell脚本交互并自动填充内容，比如脚本执行调用了mysql登录，需要输入密码，可以用expect。

<!-- more -->

### (1) set timeout n

```
this will send an stop sign to expect after n seconds, such like EOF
```

### (2) expect eof and interact

```
interact: keep the spawn command process alive and open an treminal tunnel, then you can interact with the target over the spawn command.
expect eof: keep the spawn command process alive without terminal. It will 
need a sign like EOF to do that. set timeout can send that sign.
```
