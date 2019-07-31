---
title: shell of orations on zip like war
copyright: true
date: 2019-07-31 14:08:25
categories:
    - shell
tags:
    - shell
    - archives
---
操作压缩包里的文件。提取和增加文件。修改压缩包里件的内容。

<!-- more -->

(1) zip 命令参数

```
以下参数只根据时间戳来更新文件，所以可以删除压缩包内的旧文件，然后把新文件添加进去做到更新的目的。
-f :更新压缩包内的指定文件
-m :更新指定文件到压缩包内，然后删除外边的这个文件
-u :更新已有文件或者添加新文件
-d :删除压缩包内的指定文件
```

(2) 更新旧文件--替换

```
zip -d test.war abc.txt
zip -u test.war abc.txt
```
```
# 删除旧文件
zip -d test.war WEB-INF/classes/dbconfig.properties
# 添加新文件
zip -u test.war WEB-INF/classes/dbconfig.properties
```
