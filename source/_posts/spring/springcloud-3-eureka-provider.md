---
title: springcloud(3)-eureka provider
copyright: true
date: 2019-07-31 14:44:51
categories:
    - spring
tags:
    - spring
    - spring cloud
---
微服务提供者的demo

<!-- more -->

### (1) pom.xml starter

```xml
<dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka</artifactId>
</dependency>
```

### (2) application.yml

```yml
server:
  port: 8082
eureka:
  client:
    service-url:
      default-zone: http://admin:admin@localhost:8761/eureka/
spring:
  application:
    name: user
```

### (3) Main Application

```java
package com.example.user;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.web.bind.annotation.*;

@EnableEurekaClient
@SpringBootApplication
@RestController
public class MyClient {

    public static void main(String[] args) {
        SpringApplication.run(MyClient.class, args);
    }

    @GetMapping("/client/user")
    public String revertName(String targetName){
        return "hello 11 "+targetName;
    }
}
```
`@EnableEurekaClient` -> enable eureka server to find this provider.
`@EnableDiscoveryClient` -> enable server to find this provider. (eureka, zookeeper)