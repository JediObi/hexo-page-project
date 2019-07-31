---
title: linux service
copyright: true
date: 2019-07-31 12:26:55
categories:
    - shell
tags:
    - shell
    - linux service
---
linux service管理。

<!-- more -->

(1) create a 644 service 

/usr/lib/systemd/system/test.service
```conf
[Unit]
Description=this is test service
# after some service, such like network.target or sshd.service
After=network.target

[Install]
WantedBy=multi-user.target

[Service]
ExecStart=/home/user/test.sh

```

(2) create a 744 shell

/home/user/test.sh
```shell
#!/bin/bash
echo "hello" >> /home/user/test.log
```

(3) start/stop/restart/status

```
systemctl command test.service
```

(3) enable or disable

```
systemctl enable test.service
```
It will make test.service start at system boot. That means test.sh will run when system boot.