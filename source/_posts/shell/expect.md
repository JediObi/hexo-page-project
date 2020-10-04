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

## 1. set timeout n

一般都要设置超时时间，比如命令可能是git或ssh这种带有网络请求的，返回交互命令的时间比较长，如果超时时间太短，提前超时就会结束掉epxect。

## 2. expect eof and interact

这两个一般用在expect脚本末尾，只选一个即可。

如果是expect执行完后，不需要交互，用expect eof。

如果expect执行完，用户需要接管操作权，需要用interact，比如自动连接ssh。


## 3. ssh自动连接

自动连接之后，把控制权交给用户

```shell
#!/usr/bin/expect

set password "password"
set timeout 5
spawn ssh -l admin 192.168.0.1
expect {
    "yes/no" {
        send "yes\n";
        exp_continue
    }
    "password:" {
        send "${password}\n";
        exp_continue
    }
}
interact
```

## 4. 自动执行命令

```shell
#!/usr/bin/expect

set password "password"
set timeout 5
spawn 
expect eof
```