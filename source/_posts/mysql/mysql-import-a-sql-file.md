---
title: mysql import a sql file
copyright: true
date: 2019-07-26 18:16:02
categories:
    - mysql
tags:
    - mysql
    - mysqldump
    - mysql import
    - mysql导入
---
mysql导入sql脚本时存在的一些错误和解决办法。
比如函数指定了创建者，可能会导致权限问题。
导入导出也会设计到sql，一般也需要关掉bin log。

<!-- more -->

### **1. review the dump and import commands**

#### 1.1 dump

+ ##### 1.1.1 dump tables, data（include indexes） and triggers

    ```
    ~:mysqldump -h 192.168.0.100 -P 3306 -u root -p"root" -default-character-set=utf8 db_name | gzip > db_name_utf8.sql.gz
    ```

+ ##### 1.1.2 dump procedures and functions

    ```
    ~:mysqldump -h 192.168.0.100 -P 3306 -u root -p"root" -default-character-set=utf8 -ndt -R db_name | gzip > db_name_func_utf8.sql.gz
    ```

#### 1.2 import

```
~:gunzip < db_name_utf8.sql.gz | mysql -h 192.168.0.100 -P 3306 -u root -p"root" db_name
```

### **2. errors**

#### 2.1 function.sql

+ ##### 2.1.1 remove definer

    It will need you specify definer if theres definer in your sql 
    **==>** vim
    **==>** find all `DEFINER`
    **==>** remove them
    ```
    :%s/CREATE DEFINER=`user`@`host`/CREATE/g
    ```

+ #### 2.1.2 data.sql

    **remove definer**
    **==>** vim
    **==>** find all `DEFINER`
    you will find sql like this
    ```
    /*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
    ```
    **==>** remove them
    ```
    :%s/\/\*.* DEFINER=`root`@`%` .* \*\// /g
    ```

+ #### 2.1.3 remove sql_log_bin

    **==>** vim
    remove all like this
    ```
    SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
    SET @@SESSION.SQL_LOG_BIN= 0;
    SET @@GLOBAL.GTID_PURGED='2f42730f-f678-11e7-9f60-0017fa0116c4:1-91374';
    SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
    ```

+ #### 2.1.4 remove database specify sql

    ```
    :%s/ALTER DATABASE `db`/-- ALTER DATABASE `db`/g
    :%s/USE `db`/-- USE `db`/g
    ```