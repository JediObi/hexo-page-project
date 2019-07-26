---
title: respository install mysql
copyright: true
date: 2019-07-26 18:25:03
categories:
    - mysql
tags:
    - centos
    - mysql
    - mysql repository
    - mysql 5.6
    - mysql 5.7
---
项目可能需要指定版本的mysql，因为不同版本兼容性问题。
mysql官方提供了仓库安装的方式，可以选择不同的版本安装。
由于发行版自带的包管理器可能只能安装最新版，所以需要以上方式。
本文介绍了 centos7 上的安装方式。

<!-- more -->

## CentOS7 install mysql by repository

### **1. remove installed mysql**

+ #### 1.1 to see if theres mysql installed

    ```
    ~:rpm -qa | grep mysql
    ```
    or
    ```
    ~:yum list installed | grep mysql
    ```

+ #### 1.2 uninstall

    ```
    ~:yum -y remove mysql-libs*
    ```


### **2. get the repository rpm for your system platform**

+ #### 2.1 download the repository.rpm

    ```
    ~:wget http://...
    ```

+ #### 2.2 install this repository

    ```
    ~:rpm -Uvh repo.rpm
    ```

### **3. install mysql**

+ #### 3.1 to see repolist of mysql that can be installed

    ```
    ~:yum repolist all | grep mysql
    ```
    or this command to see the enabled version only
    ```
    ~:yum repolist enabled|grep mysql
    ```

+ #### 3.2 choose the version you need

    now mysql 5.7 is enabled and if you use command to install mysql you will get mysql 5.7 installed.

+ ##### 3.3 vim /etc/yum.repos.d/mysql-community.repo

    here we choose 5.6
    ```
    # mysql 5.6
    ...
    enabled=0
    ...

    # mysql 5.7
    ...
    enabled=1
    ```
    than you can see the status of each version.
    ```
    ~:yum repolist all | grep mysql
    ```

+ #### 3.4 install mysql

    ```
    ~:yum install mysql-community-server
    ```
    this command will  install the enabled verison.

### **4. dependecies error**

`~:yum install mysql-community-server` will install the dependencies automatically, but if you don't have a repository to download these dependencies, it will fail to install mysql.

+ #### 4.1 add repository to system
+ #### 4.2 down load repository to `/etc/yum.repos.d/`

    ```
    ~:wget http://mirrors.163.com/.help/CentOS7-Base-163.repo
    ```

+ #### 4.3 use the repository

    ```
    ~:yum clean all
    ~:yum makecache
    ```

+ #### 4.4 then you can try to install mysql again

    ```
    ~:yum install mysql-community-server
    ```

### **5. mysql service**

+ #### 5.1 service

    ```
    ~:service mysqld status
    ~:service mysqld start
    ```

+ #### 5.2 or systemctl

    ```
    ~:systemctl status mysqld.service
    ~:systemctl start mysqld.service
    ```

### **6. than you should change mysql config**

vim /etc/my.cnf
you can see a standard config [a standard my.cnf](https://www.jianshu.com/p/db43e8c7f977).

### **7. than you may import a sql file**

you can see how to import a file by following this article
[mysql import a sql file](https://www.jianshu.com/p/50288f95296f).