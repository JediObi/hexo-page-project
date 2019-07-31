---
title: shell of mysql
copyright: true
date: 2019-07-31 12:23:35
categories:
    - shell
tags:
    - shell
    - mysql
---
mysql常用shell脚本。
登录，导入导出等。

<!-- more -->

(1)login mysql

```shell
#!/bin/bash

mysql -uxxx -pxxxx -A
```

(2)mysqldump [tables, data, functions and procedures]

```shell
#!/bin/bash
echo "export tables and data"
mysqldump -hxxx -Pxxx -uxxx -pxxx --default-character-set=utf8 db_name | gzip > /home/username/db_name_utf8.sql.gz

echo "export functions and procedures"
mysqldump -hxxx -Pxxx -uxxx -pxxx --default-character-set=utf8 -ndt -R db_name | gzip > /home/username/db_name_func_utf8.sql.gz
```

(3)mysqldump [tables, data, functions and procedures] with drop db and create db

```shell
#!/bin/bash
echo "export tables and data"
#--add-drop-database means "drop database if exists xx"
#-B means "create database xx"
mysqldump -hxxx -Pxxx -uxxx -pxxx --default-character-set=utf8 --add-drop-database -B db_name | gzip > /home/username/db_name_utf8.sql.gz

echo "export functions and procedures"
mysqldump -hxxx -Pxxx -uxxx -pxxx --default-character-set=utf8 -ndt -R db_name | gzip > /home/username/db_name_func_utf8.sql.gz
```

(4)-1 mysqldump [create table only]

```shell
~:mysqldump -u xxx -p"xxx" -default-character-set=utf8 -d db_name | gzip > /home/username/db_name_tables_utf8.sql.gz
```

(4)-2 mysqldump [data insert only]

```shell
~:mysqldump -u xxx -p"xxx" -default-character-set=utf8 -t db_name | gzip > /home/username/db_name_data_utf8.sql.gz
```

(5)import

```shell
#!/bin/bash

#make sure the target databse exists
mysql -hxxx -Pxxx -uxxx -pxxx -A -e "
drop database if exists db_name;
create database db_name default character set utf8 collate utf8_bin;
"
#import tables and data
#if there already exists create db in sql.gz, you don't have to figure out the db_name of this step
gunzip < /home/username/db_name_utf8.sql.gz | mysql -hxxx -Pxxx -uxxx -pxxx db_name

#import functions and procedures
gunzip < /home/username/db_name_func_utf8.sql.gz | mysql -hxxx -Pxxx -uxxx -pxxx db_name

#select capacity of the db
mysql -hxxx -Pxxx -uxxx -pxxx -A -e "
select (sum(data_length)+sum(index_length))/1024/1024 from information_schema.tables where table_schema='lis';
"
```