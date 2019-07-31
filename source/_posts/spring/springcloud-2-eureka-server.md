---
title: springcloud(2)-eureka server
copyright: true
date: 2019-07-31 14:43:32
categories:
    - spring
tags:
    - spring
    - spring cloud
    - eureka
---
spring cloud 项目 eureka server。
eureka是netflix子项目的服务治理框架，是spring cloud微服务治理框架的一种实现。
eureka提供了服务发现，断路器，智能路由，客户端负载均衡等功能。


<!-- more -->

微服务的高可用需要微服务治理框架（服务发现，断路器【服务降级，线程隔离，熔断】，只能路由，客户端负载均衡），配置中心，服务跟踪，消息中间件等
熔断依赖服务降级的配置，目前使用的feign已经集成了客户端负载均衡和断路器功能，当然一般可能没有服务降级的处理。
智能路由，提供服务网管的功能，可以同意管理微服务网络里的所有请求，执行同意的鉴权，校验等操作，免去了各个微服务校验的拦截器过滤器逻辑，免掉了重复的校验逻辑。

### (1) pom.xml starter

```xml
<dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka-server</artifactId>
</dependency>
```

### (2) application.yml

```yml
server:
  port: 8761
eureka:
  instance:
    hostname: localhost
  client:
    register-with-eureka: false
    fetchRegistry: false
    service-url:
      default-zone: http://admin:admin@localhost:8761/eureka/
  server:
    enable-self-preservation: false
    registry-sync-retry-wait-ms: 10000
spring:
  application:
    name: server
security:
  basic:
    enabled: true
  user:
    name: admin
    password: admin
```
register-with-eureka: false  -->  don't register server itself as a service provider
fetchRegistry: false --> don't get server info as a service consumer
enable-self-preservation: false --> close self preservation, Just for test.

### (3) Main Application

```java
package com.example.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@EnableEurekaServer
@SpringBootApplication
public class MyServer {
    public static void main(String[] args) {
        SpringApplication.run(MyServer.class, args);
    }
}
```
`@EnableEurekaServer` -> start as an eureka server