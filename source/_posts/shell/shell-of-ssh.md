---
title: shell of ssh
copyright: true
date: 2019-07-31 14:06:54
categories:
    - shell
tags:
    - shell
    - ssh
    - expect
---
ssh脚本，使用expect填充密码

<!-- more -->

(1) login ssh

```shell
#!/usr/bin/expect

set timeout 30
spawn ssh -l username -pxxx 123.123.123.123
expect "password:"
# xxx is your password
send "xxx\r"
interact
```

(2) scp files to server

```shell
#!/usr/bin/expect

set timeout 30
spawn scp -Pxxx -r ${LOCAL_FILE_PATH} ${LOGIN_USER}@${SERVER_HOST}:${REMOTE_FILE_PATH}/
expect "password:"
send "xxx\r"
interact
```

(3) scp files from server

```shell
#!/usr/bin/expect

set timeout 30
spawn scp -Pxxx -r ${LOGIN_USER}@${SERVER_HOST}:${REMOTE_FILE_PATH}/ ${LOCAL_FILE_PATH}
expect "password:"
send "xxx\r"
interact
```
