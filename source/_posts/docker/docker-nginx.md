---
title: docker -nginx
copyright: true
mathjax: false
date: 2021-01-16 21:42:12
categories:
tags:
---
文章简介

<!-- more -->

正文
```sh
~:docker run -itd --name nginx-test -p 8080:8080 -v /etc/localtime:/etc/localtime:ro nginx:latest
```

1. react项目包配置
```conf
upstream apiServer {   
      server 192.168.0.2:8080; # api接口服务器的地址
    }
server {
        listen       8080;
        server_name  localhost;

        location / {
            root   html;
            index  index.html index.htm;
        }
        location /api{
            proxy_paas http://apiServer;
        }
    }

```

2. websocket配置
