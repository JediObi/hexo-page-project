---
title: nginx 反向代理
copyright: true
date: 2019-07-25 17:40:47
categories:
    - nginx
tags:
    - nginx
    - hosts
    - 跨域
    - 反向代理
---
nginx不能直接把请求代理到公共域名，也不能把公共域名的请求代理到本地或其他公共域名。     
通过hosts文件的配置，把公共域名解析为指定IP，即可实现两种代理方式，但要注意跨域问题。

<!-- more -->

### **1. nginx和系统hosts文件先后关系**

http://url:port -> hosts解析 ip -> 请求报文 -> nginx获取报文信息 host ip信息，如果匹配就重定向，否则放过。

### **2. 由以上先后关系可以看出**

nginx代理 listen(或者server_name)可以是ip地址，或者是hosts列表里映射过的域名。nginx直接listen ip很好理解， listen域名则需要在hosts列表里配置过(手动配置或自动解析过)。比如域名还没申请到，但是又不想改数据库配置，就可以修改hosts和nginx配置达到使用域名的效果。

### **3. 跨域支持**

+ #### 3.1 hosts
  
    ```
    127.0.0.1  www.abc.com
    ```

+ #### 3.2 nginx.conf
    
    ```
    server {
                    listen          80;
                    server_name     www.abc.com;

                    location / {
                            proxy_pass http://localhost:8080;
                    }
            }
    ```
    这个配置没有使用负载均衡的upstream配置。
    访问www.abc.com解析为127.0.0.1:80 将被转到localhost:8080

### **4. 请求失败**

+ #### 4.1 主要是跨域导致的失败        
    
    ```
    localhost:8080这个服务器的页面包含多个对静态资源的请求。但是我们没有修改数据库配置，导致服务器上静态资源的url仍然是www.abc.com。
    直接访问localhost:8080后，当页面上请求 www.abc.com时，就会导致跨域，chrome会在console里报错跨域，虽然可以在nginx里配置跨域，但是只是不再报错，请求仍然失败。
    ```

+ #### 4.2 解决方法是 
  
    ```
    客户端/浏览器只访问代理地址 www.abc.com
    ```

### **5. 基于实践经验的得到的最终结果**

服务端，在部署服务的机器上使用局域网或者localhost地址，在nginx里用新的地址代理实际地址。
而客户端 只访问服务端代理地址，不访问实际部署的地址。
