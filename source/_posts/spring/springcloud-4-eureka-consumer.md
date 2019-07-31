---
title: springcloud(4)-eureka consumer
copyright: true
date: 2019-07-31 15:31:52
categories:
    - spring
tags:
    - spring
    - spring cloud
    - feign
---
服务消费者demo。
feign集成了hystrix，可以在feign接口上写falllback逻辑，fallback指向的实现类就是降级的逻辑。

<!-- more -->

### (1) pom.xml starter
```xml
<dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka</artifactId>
            <!--<artifactId>spring-cloud-starter-feign</artifactId>-->
</dependency>
<dependency>
            <groupId>org.springframework.cloud</groupId>
            <!--<artifactId>spring-cloud-starter-eureka</artifactId>-->
            <artifactId>spring-cloud-starter-feign</artifactId>
</dependency>
```

### (2) application.yml
```yml
server:
  port: 8083

eureka:
  client:
    service-url:
      default-zone: http://localhost:8761/eureka/
```

### (3) Main Application
```java
package com.example.consumer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;

@SpringBootApplication
//@EnableDiscoveryClient
@EnableEurekaClient
@EnableFeignClients
public class MyConsumer {

    public static void main(String[] args) {
        SpringApplication.run(MyConsumer.class, args);
    }
}
```
```@EnableEurekaClient``` -> enable to find service
```@EnableFeignClients``` -> enable to use service by feign

### (4) controller
```java
package com.example.consumer.controller;

import com.example.consumer.service.IEurekaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/consumer")
public class CosumerController {

    @Autowired
    private IEurekaService iEurekaService;

    @GetMapping("/test")
    public String testConsumer5(String targetName) {
        return iEurekaService.getUser(targetName);
    }
 }
```

### (5) service

```java
package com.example.consumer.service;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient("user")
public interface IEurekaService {
    @RequestMapping(value = "/client/user", method = RequestMethod.GET)
    String getUser(@RequestParam("targetName") String targetName);
}
```
```
Notice: 
Must use @RequestMapping.
@GetMapping and other @{Method}Mapping are not supported in Feign service.
```