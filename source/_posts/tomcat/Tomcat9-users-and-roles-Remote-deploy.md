---
title: 'Tomcat9 users and roles, Remote deploy'
copyright: true
date: 2019-07-31 15:42:34
categories:
    - tomcat
tags:
    - tomcat
    - tomcat9
---
tomcat9的管理账户和角色相比tomcat7有变化。角色权限区分更细。

<!-- more -->

Since tomcat7, roles come with different permission.
admin-gui, admin-script, manager-gui, manager-script, manager-jmx and manager-status are in place of admin and manager.
Manager is for deploy. 
```
**Host Manager**
    admin-gui - allows access to the HTML GUI
    admin-script - allows access to the text interface

**html manager gui for project**
    manager-gui - allows access to the HTML GUI and the status pages
****
**manager for remote deploy**
    manager-script - allows access to the text interface and the status pages
    (manager-script will be used in Jenkins and tomcat-maven plugin. 
    For security, script shouldn't be used with gui together.)
****
    manager-jmx - allows access to the JMX proxy and the status pages
    manager-status - allows access to the status pages only

```

