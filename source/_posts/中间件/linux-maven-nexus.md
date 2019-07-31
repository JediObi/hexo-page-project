---
title: linux maven nexus
copyright: true
date: 2019-07-31 12:16:07
categories:
    - 中间件
tags:
    - 中间件
    - maven
    - nexus
---
集团内部的jar包可能需要架设私有maven仓库。

<!-- more -->

(1) install

tar nexus.tar.gz -C ~/app/

(2) config port 

cd nexus_home/
vim etc/nexus-default.properties

(3) config java home

vim nexus/home/bin/nexus
```
INSTALL4J_JAVA_HOME_OVERRIDE="/home/admin/lib/jdk"
```

(4) start nexus

cd nexus_home/bin
nexus start

(5) login

http://localhost:8081
admin/admin123

(6) upload jar
1) config maven setting.xml
add nexus user
```xml
<servers>
<server>
<id>3rdParty</id>
<username>admin</username>
<password>admin123</password>
</server>

</servers>
```

2) use mvn command to up
   
```
mvn deploy:deploy-file -DgroupId=xxx.xxx -DartifactId=xxx -Dversion=0.0.2 -Dpackaging=jar -Dfile=D:\xxx.jar -Durl=http://xxx.xxx.xxx.xxx:8081/repository/3rdParty/ -DrepositoryId=3rdParty
```

(7) clean task

clean old versions of jar
==> tasks ==> create task ==> maven delete snapshot task


