---
title: springboot(1)-basic usage
copyright: true
date: 2019-07-31 14:39:28
categories:
    - spring
tags:
    - spring
    - spring boot
---
springboot应用，框架搭建。

<!-- more -->

### (1) tree

```
.
├── pom.xml
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com.example.demo
│   │   │       ├── DemoApplication.java
│   │   │       └── ServletInitializer.java
│   │   └── resources
              ├── application.yml
              ├── static
              └── templates

```

### (2) pom.xml

  + parent -> spring-boot-starter-parent

  + starter -> spring-boot-starter-web

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>demo</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>war</packaging>

    <name>demo</name>
    <description>Demo project for Spring Boot</description>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.0.4.RELEASE</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-tomcat</artifactId>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

### (2) run demo

run DemoApplication.java
Spring Boot will start from a Main Application.
Main Application will load project configurations. You don't have to configure them. (In springmvc, These configurations are  in xml(s).)

### (3) controller

Here we create controller at Main Application for test. You can code controller as usual.

+ DemoApplication.java

    ```java
    package com.example.demo;

    import org.springframework.boot.SpringApplication;
    import org.springframework.boot.autoconfigure.SpringBootApplication;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.ResponseBody;
    import org.springframework.web.bind.annotation.RestController;

    @RestController
    @SpringBootApplication
    public class DemoApplication {

        public static void main(String[] args)
        {
            SpringApplication.run(DemoApplication.class, args);
        }

        @GetMapping("/test")
        @ResponseBody
        public String test1(String userName){
            return "hello "+userName;
        }
    }
    ```
    `@SpringBootApplication` -> @Configuration + @EnableAutoConfiguration + @ComponentScan
    `@Configuration` -> @Configuration is a class-level annotation indicating that an object is a source of bean definitions. @Configuration classes declare beans via public @Bean annotated methods.
    `@EnableAutoConfiguration`-> Enable auto-configuration of the spring Application Context, attempting to guess and configure beans that you are likely to need. Auto-configuration classes are usually applied based on your classpath and what beans you have defined. It will use config files(xml or yml or properties) and beans in current directory.
    `@ComponentScan` -> Configures component scanning directives for use with @Configuration classes. Provides support parallel with Spring XML’s element. It will scan all @Component (@Service, @Controller) and register these component as beans.
    `@RestController` -> class-level, @Controller + @Responsebody, just return string.
    `@Controller` -> class-level
    `@Responsebody` -> method-level, return string instead of model.
    `GetMapping(xx)` -> @RequestMapping(xx, method=get).

