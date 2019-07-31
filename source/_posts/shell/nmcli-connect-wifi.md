---
title: nmcli connect wifi
copyright: true
date: 2019-07-31 14:14:00
categories:
    - shell
tags:
    - shell
    - wifi
    - nmcli
---
nmcli是ubuntu系统提供的网络管理模块的命令行工具。
实际上，一般可能使用iw居多。

<!-- more -->

(0) install network-manager
(1) scan the latest wifi spot
get essid
```
# use root permission to scan the latest
~:sudo iwlist wlan0 scanning
```
or
`~:nmcli dev wifi`

(2) nmcli connect

1. connection
   
+ use an existed connection

    ```
    # activate an connection
    ~:nmcli connection up "connection_name"
    # add a wifi connection
    ~:nmcli connection add con-name "connection_name" connection.autoconnect yes type wifi ssid "wifi_ssid" ifname "device_interface_name"
    # modify wifi password
    ~:nmcli connection modify "connection_name" wifi-sec.key-mgmt wpa-psk
    ~:nmcli connection modify "connection_name" wifi-sec.psk "password"
    ```

+ this will create a new connection for network-manager

    ```
    ~:sudo nmcli device wifi connect "ssid" [password "123456"]
    ```

(3) iwconfig interface
