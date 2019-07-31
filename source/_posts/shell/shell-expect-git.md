---
title: shell expect git
copyright: true
date: 2019-07-31 14:24:18
categories:
    - shell
tags:
    - shell
    - expect
    - git
---
使用ecpect为git填充密码

<!-- more -->

```shell
#!/bin/bash

USERNAME="username"
PASSWORD="password"
cd /home/username/work
echo "hello">>test.txt
git add -A
git commit -m "update"
/usr/bin/expect <<-EOF
set timeout 30
spawn git push origin master
expect "Username *:"
send "${USERNAME}\r"
expect "Password *:"
send "${PASSWORD}\r"
expect eof
EOF
```