---
title: iw 设置wifi连接
copyright: true
date: 2019-07-31 14:11:13
categories:
    - shell
tags:
    - shell
    - wifi
    - ip iw
---
使用ip命令提供的iw命令管理wifi。
这是推荐的方式设置无线连接，但是首先要借助rfkill相关命令查看无线设备是否开启。

<!-- more -->

(1) 查看无线网卡名称

```
~:ip a
```

(2) 扫描无线网络

使用(1)中的无线网卡名称
```
~:iwlist card_name scanning
```

(3) 根据ESSID连接

+ 设置网络连接类型

    ```
    ~:iwpriv card_name set NetworkType=Infra 
    ```

+ 设置无线网安全模式

    ```
    ~:iwpriv card_name set AuthMode=WPA2PSK  
    ```
    
+ 设置加密方式

    TKIP
    CCMP => AES
    ```
    ~:iwpriv card_name set EncrypType=TKIP
    ```

+ 设置连接密码

    ```
    ~:iwpriv card_name set WPAPSK=******* 
    ```

+ 连接到网络 ESSID

    方式1
    ```
    ~:iwpriv card_name set SSID=<ESSID>  
    ```
    方式2
    ```
    ~:iwconfig card_name essid <ESSID> 
    ```

(3) 查看连接状态

    ```
    ~:iwpriv card_name connStatus
    ```
