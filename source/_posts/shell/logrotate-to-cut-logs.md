---
title: logrotate to cut logs
copyright: true
date: 2019-07-31 12:34:36
categories:
    - shell
tags:
    - shell
    - logrotate
---
使用logrotate切割大日志。
通常tomcat可以关掉catalina输出，通过log4j的组件，直接分割日志。
但是我们可以用logrotate工具的提取某些时间段的日志。

<!-- more -->

```
# -v display operation
~:logrotate /home/admin/rule_tomcat -v
```


rule_tomcat
```
/home/admin/admin_fc/testlog/catalina.out{
daily
dateext
rotate 30
missingok
size 15M
copytruncate
}
```
`daily` cut logs once a day, if date doesn't change, don't need cut.
`dateext` append date "YYmmdd" to file name
`rotate 30` keep the last 30 files , delete the earlier.
`missingok` ignore the warning of log doesn't exist.
`size 15M` if the log file is bigger than the size, cut it.
`copytruncate` create new file after cut.