---
title: quick start
copyright: true
date: 2019-07-31 11:10:19
categories:
    - python3
tags:
    - python3
    - python
    - ssh
---
paramiko的使用。python ssh操作的基础组件。

<!-- more -->

install pip3
```~:sudo apt-get install python3-pip```

install a module
```~:pip3 install paramiko```

use a module
Test.py
```
import paramiko
import os

try:
      ssh = paramiko.SSHClient()
      ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
      ...
except Exception as e:
      ...
      os._exit(0)
```

run the code
```
~:python3 Test.py
```