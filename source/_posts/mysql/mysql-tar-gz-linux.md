---
title: mysql tar.gz linux
copyright: true
date: 2019-07-26 18:36:08
categories:
    - mysql
tags:
    - mysql
---
mysql bin包解压安装和配置

<!-- more -->

### **1. decompress**

### **2. create group and user for mysql**

groupadd -g mysql
useradd -g mysql mysql

### **3. init mysql**

cd mysql_home

+ #### 3.1 use scripts to create mysql system database

    ```
    ~:./scripts/mysql_install_db --user=mysql
    ```

+ #### 3.2 start myql

    `~:./bin/mysql_safe --user=mysql`

### **4. login mysql and set password**

```
~:mysql -u root
~:set password =password('admin123');
```

### **5. register mysql as system service**

```
~:cp support-files/mysql.server /etc/init.d/mysql
~:chconfig --add mysql
~:chconfig mysql on
```

### **6. reboot system**

### **7. /etc/my.cnf**

```
[mysqld]
character_set_server=utf8
lower_case_table_names=1
```

### **8. restart mysql**

```
~:systemctl restart mysql
```