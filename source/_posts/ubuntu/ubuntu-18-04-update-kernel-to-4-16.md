---
title: ubuntu 18.04 update kernel to 4.16
copyright: true
date: 2019-07-29 10:56:09
categories:
    - ubuntu
tags:
    - ubuntu
    - kernel
    - 内核
---
本文介绍了ubuntu内核更新过程以及一些依赖的包，不过使用的是内核源码。需要参照内核源码编译安装过程。当然后续还会有文章直接安装编译好的内核。

<!-- more -->

**Note:** nvidia driver 390 didn't work on kernel 4.16.
If you want to keep fans silent, use kernel 4.15.

### **1. dependencies**

```
GNU C                  3.2              gcc --version
GNU make               3.81             make --version
binutils               2.20             ld -v
flex                   2.5.35           flex --version
bison                  2.0              bison --version
util-linux             2.10o            fdformat --version
module-init-tools      0.9.10           depmod -V
e2fsprogs              1.41.4           e2fsck -V
not require ==> jfsutils               1.1.3            fsck.jfs -V
not require ==> reiserfsprogs          3.6.3            reiserfsck -V
not require ==> xfsprogs               2.6.0            xfs_db -V
squashfs-tools         4.0              mksquashfs -version
not require ==> btrfs-progs            0.18             btrfsck
pcmciautils            004              pccardctl -V
not require ==> quota-tools            3.09             quota -V
PPP                    2.4.0            pppd --version
miss ==> isdn4k-utils           3.1pre1          isdnctrl 2>&1|grep version
miss ==> nfs-utils              1.0.5            showmount --version
procps                 3.2.0            ps --version
not require ==> oprofile               0.9              oprofiled --version
udev                   081              udevd --version
grub                   0.93             grub --version || grub-install --version
miss ==> mcelog                 0.6              mcelog --version
iptables               1.4.2            iptables -V
openssl & libcrypto    1.0.0            openssl version
bc                     1.06.95          bc --version
not require ==> Sphinx\ [#f1]_         1.3              sphinx-build --version
```

+ #### install sphinx

    ```
    ~:sudo pip3 install sphinx
    ```

### **2. compile and install kernel**

```
~:cd /usr/src/linux-4.x
```

+ #### 2.1 clean old config

    ```
    ~:sudo make mrproper
    ```

+ #### 2.2 generate new config

    ```
    ~:sudo make menuconfig
    ```
    Save and Exit.

+ #### 2.3 compile

    ```
    ~:sudo make -j4
    ```
    Use 4 threads. (About 40 minutes on i5-7400 4 cores 4 threads.)

+ #### 2.4 install

    ```
    ~:sudo make modules_install
    ~:sudo make install
    ```

+ #### 2.5 reboot system