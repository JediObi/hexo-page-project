---
title: my.cnf standard
copyright: true
date: 2019-07-26 18:39:39
categories:
    - mysql
tags:
    - mysql
---
mysql 开启了慢查询日志和二进制日志的配置文件。

<!-- more -->

```properties
[client]
default-character-set=utf8
[mysqld]
character_set_server=utf8
max_connections=800
# O_DIRECT for local, and fsync for san
innodb_flush_method=O_DIRECT
lower_case_table_names=1

# mysqld log
log_error=/var/log/mysql/mysqld.log
# slow query log
slow_query_log=on
slow_query_log_file=/var/log/mysql/mysql_slow_query.log
long_query_time=2
# bin log
server_id=1
log_bin=/var/log/mysql/mysql-bin
log_bin_index=/var/log/mysql/mysql-bin.index
# default is 0, for master and slaves, creating functions is unsafe if the functions will change the data.
# and slaves want copy unsafe functions from master unless log_bin_trust_function_creators=1 on slaves.
# so you can set log_bin_trust_function_creators=1.
# Or you specify the types of the functions in [DETERMINISTIC,NO SQL,READS SQL DATA]
log_bin_trust_function_creators=1
```
