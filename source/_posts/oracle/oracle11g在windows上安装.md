---
title: oracle11g在windows上安装
copyright: true
date: 2019-07-29 11:49:37
categories:
    - ubuntu
tags:
    - ubuntu
    - oracle
    - navicat
---
oracle11g 在 windows上的安装。
用户表空间，权限查看。
navicat oci(oracle client instant)配置。

<!-- more -->

## **windows**

#### **1. 服务器搭建**

安装相对简单
此处记录下安装之后的操作

+ ##### 1.1 使用net configuration assistant配置远程监听，这样远程客户端就能连接这台服务器，具体可以看其他教程

+ ##### 1.2 开启OMF功能，创建表空间时会自动指定文件位置和大小。如何开启可以参考create tablespace的缺少子句的问题，因为不开omf直接创建表空间会不指定位置与大小会报错。

    ```
    查看是否开启：show parameter db_create_file_dest;
    开启：alter system set db_create_file_dest='/oracle/oradata';
    注意指定的目录要存在，可以是基目录的oradata，或者数据库目录。
    创建表空间：create tablespace myts;
    查看表空间：select TABLESPACE_NAME from dba_tablespaces;
    ```

+ ##### 1.3 创建用户赋权限，并指定表空间

    CREATE USER NEWUSER IDENTIFIED BY BD123  DEFAULT TABLESPACE DB_DATA;
    修改用户默认表空间：alter user wy2014 default tablespace mytds01;
    grant connect, resource to user;
    grant dba to user;
    查看用户和默认表空间：select   username,default_tablespace   from   dba_users;
    查看当前用户的表：select table_name from user_tables;
    查看所有用户的表：select table_name  from all_tables;

  + ###### 1.3.1 查看所有用户：

        select * from dba_user;
        select * from all_users;
        select * from user_users;

  + ###### 1.3.2 查看用户系统权限：

        select * from dba_sys_privs;
        select * from all_sys_privs;
        select * from user_sys_privs;

  + ###### 1.3.3 查看用户对象权限：

        select * from dba_tab_privs;
        select * from all_tab_privs;
        select * from user_tab_privs;

  + ###### 1.3.4 查看所有角色：

        select * from dba_roles;

  + ###### 1.3.5 查看用户所拥有的角色：

        select * from dba_role_privs;
        select * from user_role_privs;

  + ###### 1.3.6 查看角色所拥有的权限:

        select * from role_sys_privs;

        select * from role_tab_privs;

  + ###### 1.3.7 查看所有系统权限

        select * from system_privilege_map;

  + ###### 1.3.8 查看所有对象权限

        select * from table_privilege_map;

+ ##### **1.4 导入数据**

    建好所需的表空间和用户，因为脚本可能对表空间有要求。
    imp username/password@127.0.0.1:1521/orcl file=C:\xx\data.dmp full=y
    出现 IMP-00041: 警告: 创建的对象带有编译警告
    加上ignore=y
    imp username/password@127.0.0.1:1521/orcl file=C:\xx\data.dmp full=y ignore=y
    导入完成后，在pl/sql developer里右键出错的视图recompiled。
    如果是一个复杂视图或者触发器，问题就大了。如存在其他用户名下的相关调用，可以在导出时简化并重建视图或触发器，或者在新机器上新建相同的用户和表。

#### **2. 客户端navicat配置**

navicat需要借助instant client连接oracle数据库。navicat自带的有一个instant，但是可能不兼容服务器端的oracle版本。
所以首先要确定navicat的位数32还是64，然后要确定服务器上的oracle版本，然后选择合适的instant client下载，然后在navicat的preference里配置下oci就行了。
