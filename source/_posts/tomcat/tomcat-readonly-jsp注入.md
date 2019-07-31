---
title: tomcat readonly jsp注入
copyright: true
date: 2019-07-31 17:21:28
categories:
    - tomcat
tags:
    - tomcat
    - 注入
---
tomcat readonly bug导致put和delete注入攻击。

<!-- more -->

在tomcat的conf/web.xml中
```xml
<servlet>
        <servlet-name>default</servlet-name>
        <servlet-class>org.apache.catalina.servlets.DefaultServlet</servlet-class>
        ...
</servlet>
```
这个节点下可以配置readonly(该参数默认true，可能是拒绝put和delete请求)
true即防止注入。现在改为false。
```
<init-param>
        <param-name>readonly</param-name>
        <param-value>false</param-value>
</init-param>
```
这样就可以配置put/delete请求，具体可以通过chrome或者firefox的调试工具或者插件模拟，也可以用curl或者nc等命令行工具模拟。
使用chrome restlet配置一个注入：
```
//以下在webapps/ROOT/目录下创建test.txt，填入body指定的内容
//可以指定其他工程的某个目录，上传一个jsp，之后就能直接访问
METHOD: PUT
http://localhost:8080/test.txt  
Content-Length:  11
Accept-Language: en-US
BODY:  hello world
```
使用chrome restlet配置一次删除:
```
//删除指定工程下某个html
METHOD: DELETE
http://localhost:8080/testproject/test.html
Content-Length:  11
Accept-Language: en-US
```