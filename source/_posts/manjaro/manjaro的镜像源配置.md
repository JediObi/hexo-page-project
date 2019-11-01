---
title: Mariadb 安装
copyright: true
date: 2019-07-29 11:31:43
categories:
    - manjaro
tags:
    - manjaro
    - pacman
---
Manjaro 的软件源配置比 Ubuntu 稍微复杂一些，因为 archlinux 的软件源配置使用 conf 格式的节点式配置，支持 $ 变量。并且 Manjaro 没有国内的企业镜像源支持，院校提供有稳定版本但速度稍慢，企业站提供 arch 的源，但提供的软件不稳定会导致系统崩溃。

<!-- more -->

### **1. archlinux 镜像源配置文件**

+ #### /etc/pacman.conf

arch 把软件按照类型分别存放在四个仓库

core: 系统核心部分，基础组件，决定系统能否启动。这部分应该使用 manjaro stable 的镜像。
extra: 应用层功能基础组件，比如 shell,de 等等，系统的基本功能，也应该使用 manjaro stable 的镜像。
mutilib: 一些额外的东西，用户基本不接触，最好使用 manjaro stable 镜像。
community: 社区软件，应用层的软件都可以从这个仓库获取，可以使用 arch 的源，以保持软件最新。

此外还可以添加额外的仓库，以获取独有的软件支持: 其他的源，比如 archlinuxcn， 包含一些中文相关的特有软件比如 sogoupinyin。

节点网址中必须包含仓库名，且会教研返回值中的仓库名是否与节点名相同。

配置格式有两种，以中文仓库 archlinuxcn 为例     
1. 仓库名变量配置
```
[archlinuxcn]
SigLevel = Optional TrusAll
Server = https://mirrors.tuna.tsinghua.edu.cn/$repo/$arch
```
节点名 `archlinuxcn` 就是仓库名, 变量 `$repo` 取的就是节点名

2. 仓库名直接配置
```
[archlinuxcn]
SigLevel = Optional TrusAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```
网址中直接写仓库地址

+ #### /etc/pacman.d/mirrorlist

pacman.conf 支持包含文件，四个仓库默认包含该文件，所以可以把国内的镜像地址直接写在 mirrorlist 里
```
Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch
```
但是，像 community 仓库 可能要使用最新版，以阿里云镜像为例
```
[community]
SigLevel = PackageRequired
Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch
```
要注意镜像源路径中的其他路径，不能漏掉。

### **2. 具体配置过程**

+ #### 修改 /etc/pacman.d/mirrorlist， 使用国内源

    使用 stable 的高校 manjaro 源， 比如清华大学，其他的 Server 可以删掉

    `Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch`

+ #### 修改 community 为 阿里云的arch源，以保持应用软件更新

    /etc/pacman.conf
    ```
    [community]
    SigLevel = PackageRequired
    Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch
    ```

+ #### 添加 archlinuxcn 以获取 搜狗输入法

    /etc/pacman.conf
    ```
    [archlinuxcn]
    SigLevel = Optional TrustAll
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
    ```
+ #### 同步本地仓库信息，更新缓存

    ```
    ~:sudo pacman -Syy
    ```
