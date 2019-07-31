---
title: java ee - eclipse
copyright: true
date: 2019-07-31 11:00:32
categories:
    - java
tags:
    - java
    - eclipse
---
eclipse 开发环境的配置

<!-- more -->

### (1) install

国内镜像比如清华
[https://mirrors.tuna.tsinghua.edu.cn/eclipse/technology/epp/downloads/release/](https://mirrors.tuna.tsinghua.edu.cn/eclipse/technology/epp/downloads/release/)

### (2) 设置

+ 更新地址和插件地址
  
    ```
    windows->preferences
    (1) 当前版本号的更新地址 2018-12，清华大学镜像，2018-12版本
        https://mirrors.tuna.tsinghua.edu.cn/eclipse/mpc/2018-12/

    (2) 插件商店 EPP Marketplace Client
        https://mirrors.tuna.tsinghua.edu.cn/eclipse/mpc/2018-12/

    (3) The Eclipse Project Updates
        https://mirrors.tuna.tsinghua.edu.cn/eclipse/eclipse/updates/4.10
    ```

### (3) 快捷方式
```
[Desktop Entry]
Version=1.0
Type=Application
Name=Eclipse
Icon=/usr/local/bin/eclipse/icon.xpm
Exec="/usr/local/bin/eclipse/eclipse" %f
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
```

### (4) 终端字体

### (5) maven配置

### (6) jdk和jre配置

+ window->preferences->java->installed JREs

    ```
    使用java_home即可
    ```

+ eclipse_home/eclipse.ini

    ```
    在-vmargs上边添加
    -vm
    /usr/local/lib/jdk1.8.0_201/bin
    ```

### (7) 插件

+ darkest theme

    ```
    全黑主题
    新的icon
    ```

+ spring tools

    ```
    spring dashboard
    ```

+ EasyShell

    ```
    可以把teminal跳转到工程目录
    ```

+ ANSI Escape in Console

    ```
    run/debug可以显示颜色(eclipse本身只有白色)
    并可以正常显示空格和制表符等符号
    ```

### (8) 导入git maven多模块spring项目

import from git -> 导入到某个eclipse工作空间外的位置
import existing maven -> 把maven项目导入到eclipse工作空间
