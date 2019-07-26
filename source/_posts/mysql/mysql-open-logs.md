---
title: mysql open logs
copyright: true
date: 2019-07-26 18:47:25
categories:
    - mysql
tags:
    - mysql
    - windows
    - mysql 5.6
---
windows mysql开启慢查询日志和二进制日志。
需要注意路径里的斜杠要使用unix风格。

<!-- more -->

**Notice:** All path use "/" instead of "\\".
mysql 5.6 mariadb
windows10 

**my.ini**

```ini
...
# error log
log_error="D:/mysql_logs/error.log"

# open it to save all slow query logs into files
general_log=on
general_log_file="D:/mysql_logs/query.log"

# slow query log
slow_query_log=on
slow_query_log_file="D:/mysql_logs/slow_query.log"
long_query_time=1

# binary log
# update, insert and delete operation will be convert into binary and saved into these file. You can use these files to roll back your databases.
server-id=1
# Notice: if you  want to use binary log, you have to specify your functions' type with one of (DETERMINISTIC,NO SQL,READS SQL DATA)
# CREATE DEFINER=`username`@`%` READS SQL DATA FUNCTION `fn_getitemclock`(i_itemid bigint,i_clock int,i_pos int) RETURNS int(11)...begin...end
# Or set log_bin_trust_function_creators=1 in my.ini, it is less safe for master-slave system.
# log_bin="D:/mysql_logs/log_bin/binlog-bin"
# lob_bin_index="D:/mysql_logs/log_bin/binlog"  

...
```