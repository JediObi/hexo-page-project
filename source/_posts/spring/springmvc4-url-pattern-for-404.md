---
title: springmvc4 url pattern for 404
copyright: true
date: 2019-07-31 14:35:08
categories:
    - spring
tags:
    - spring
---
配置springmvc拦截所有请求，不会放行静态资源的url请求。

<!-- more -->

springmvc 4.3.8 + html

We configure dispatcherservlet url-pattern in web.xml. 
We hope to intercept all requests by this config. 

(1) put all static resources into WEB-INF –> reject all request for static resource by url. 

(2) web.xml
```xml
<servlet>
    <servlet-name>springMVC</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
      <param-name>contextConfigLocation</param-name>
      <param-value>classpath:spring-*.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
  </servlet>
  <servlet-mapping>
    <servlet-name>springMVC</servlet-name>
    <!-- "/" or "/*" intercept all requests-->
    <url-pattern>/</url-pattern>
  </servlet-mapping>
```

(3) config spring-mvc.xml
```
<!-- scan all controllers in base-package -->
<context:component-scan base-package="com.fc.test.controller"/>

<!-- tell spring to deal annotations in controllers -->
<mvc:annotation-driven/>

<!-- allow controllers visit static resources in WEB-INF -->
<mvc:default-servlet-handler/>
```