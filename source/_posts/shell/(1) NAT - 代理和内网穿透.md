---
title: (1) NAT - 代理和内网穿透
copyright: true
date: 2019-07-25 17:49:49
categories:
    - shell
tags:
    - shell
    - NAT
    - SSH隧道
    - 内网穿透
---
本文使用iptables和ssh隧道两种方式实现反向代理。
其中iptables最为强大，可以替换数据包的来源或目标地址及端口，可以实现代理。
而ssh隧道则可以实现反向代理的内网穿透即内网端口暴露到公网。

<!-- more -->

## **代理 端口重定向 基于ssh的反向代理**

### **1. 域名代理**

+ #### 1.1 修改hosts

    ```
    修改 /etc/hosts 可以使用指定ip地址代替某个域名的真实地址
    那么访问该域名时就会访问该ip
    ```

### **2. ip和端口转发**

+ #### 2.1 使用iptables设置代理

    ```
    可以做ip转发，端口转发。可以操作符合要求的数据包。比如把数据包来源ip和端口替换。或者把数据包目标ip和端口替换。
    ```

+ ##### 2.1.1 开启转发功能

   echo 1 > /proc/sys/net/ipv4/ip_forward

+ ##### 2.1.2 定义转发规则
    ```
    iptables -t nat -A PREROUTING -p tcp -d 1.1.1.1 --dport 80 -j DNAT --to-destination 172.169.42.8:80
    ```
    ```
    -t nat                          使用nat表(网络地址转换表)，该表是独立于filter表(过滤表)的另一个规则表，filter表是默认表
    -A                              在指定表的末尾增加一条规则。-D CHAIN_NAME [num] 删除CHAIN_NAME链里的第num条规则, 此外还有 -I插入, -R替换;
    PREROUTING                      CHAIN_NAME之一，该链包含对数据包目标地址转换的规则.此外还有 POSTROUTING 源地址的转换规则, OUTPUT等;
    -j DNAT：目的地址转换             动作之一。此外还有 SNAT：源地址转换; REDIRECT：端口重定向;
    -p tcp                          指定协议，规则将约束指定协议类型的数据包
    -i eth0                         省略，入站接口，指定数据来源的网卡设备名称。专用PREROUTING
    -o eth1                         省略，出站接口，指定数据出站的网卡设备名称。POSTROUTING和OUTPUT
    -d 1.1.1.1                      数据包的来源地址，规则将约束该地址发来的数据包,1.1.1.1通配所有ip
    --dport 80                      指定来源的端口
    --to-destination 172.169.42.8:80        可简写为--to,指定替换的结果     
    ```

+ ##### 2.1.3 举例

    1. 更改所有来自192.168.1.0/24的数据包的源IP地址为123.4.5.100

        ```
        iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j SNAT --to 123.4.5.100
        ```
    2. 更改所有来自192.168.1.0/24的数据包的目的ip地址为123.4.5.100

    ```
    iptables -t nat -A PREROUTING -s 192.168.1.0/24 -i eth1 -j DNAT --to 123.4.5.100
    ```

+ #### 2.2 使用 ssh 隧道代理和反向代理

    ```
    ssh隧道必须要使用ssh
    ```

+ ##### 2.2.1 本地转发

    把本地8080端口的请求转发到 host1:host1_port 上
    不限定host1是本地还是远程
    ```
    ssh -gNf -L 8080:host1:host1_port host1User@host1
    ```
    ```
    -g 启用网关
    -N 不使用shell
    -f 后台
    ```

+ ##### 2.2.2 远程转发

    把远程host1上的8080端口转发到 本地某个端口上 上
    ```
    ssh -gNf -R 8080:localhost:localhost_port host1User@host1
    ```

+ ##### 2.2.3 内网穿透功能

    实现花生壳类似的内网穿透
    ```
    局域网内的服务器A，没有单独的公网IP，公网无法直接访问 http://hostA:8080
    公网服务器B，具有独立的IP hostB， ssh用户名 userB，端口无限制
    ```

    1. 在A上远程转发B的一个端口 28080 到A本地的8080

        ```
        ssh -gNf -R 28080:localhost:8080 userB@hostB
        ```
        此时，可以在B服务器上通过 http://localhost:28080访问 到A的服务，但是公网无法访问 hostB:28080

    2. 在B服务器上本地转发一个端口 28081 到B服务器本地的28080

        ```
        ssh -gNf -L 28081:localhost:28080 userB@hostB
        ```

    3. 在任意公网上的浏览器里访问 B服务器daili的 28081端口

        ```
        curl http://hostB:28081
        ```
        此时，A的服务就被B代理到了公网上。