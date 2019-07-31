---
title: wpa_supplicant connect to wpa wifi
copyright: true
date: 2019-07-31 14:21:27
categories:
    - shell
tags:
    - shell
    - wifi
---
wpa_sypplicant连接wap加密的wifi

<!-- more -->

### interface wlan0

(1) install wpa_supplicant

`~:sudo apt-get install wapsupplicant`
you will get `wpa_supplicant` and   `wpa_passphrase`;

(2) config your connection info of (ssid, password)

1) generate info config by wpa_passphrase
```
~:wpa_passphrase wifi_essid wifi_password > test.cnf
~:cat test.cnf
network={
	ssid="wifi_essid"
	#psk="wifi_password"
        # wpa_passphrase will encrypt your password
	psk=a5af8bb4558f42f5cd5a238da77bbac7b89e624449cc4a94b6b056ac6c15c3d1
}
```

2) config by edit config file

test.cnf
```
network={
	ssid="wifi_essid"
	psk="wifi_password"
}
```

(3) connect to wireless

```
~:wpa_supplicant -B -c ./test.cnf -i wlan0
```
-B -> keep connection in background
-c -> specify config file
-i -> specify interface

(4) obtain an IP from the wireless

```
~:dbclient wlan0
```
