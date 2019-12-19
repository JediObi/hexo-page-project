---
title: log4j2配置解析
copyright: true
date: 2019-12-19 11:22:06
categories:
  - spring
tags:
  - java
  - spring
  - log4j
  - sleuth
---

log4j2 xml 配置解析
springboot,gradle 集成 log4j2

<!-- more -->

### (1) log4j2 xml 解析

- 配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <!--日志文件名前缀-->
    <Properties>
        <!--日志格式-->
        <property name="log.pattern"
                  value="%d{yyyy-MM-dd HH:mm:ss.SSS} %-5p %c{2} : - %m%n"/>
    </Properties>
    <!--控制台appender-->
    <appenders>
        <console name="Console" target="SYSTEM_OUT">
            <PatternLayout>
                <pattern>${log.pattern}</pattern>
            </PatternLayout>
        </console>
    </appenders>

    <loggers>
        <!--根策略-->
        <root level="DEBUG">
            <appender-ref ref="Console"/>
            <!--        <appender-ref ref="fileInfoLog"/>-->
        </root>
        <!--    其他策略，默认会包含根策略-->
        <!--    <logger name="org.springframework.boot" level="INFO"/>-->
        <!--    <logger name="com.fc.test" level="debug"/>-->
    </loggers>
</configuration>
```

- 日志格式 Layout

```xml
<PatternLayout>
    <pattern>"%d{yyyy-MM-dd HH:mm:ss.SSS} %-5p %c{2} : - %m%n"</pattern>
</PatternLayout>
```
`%d`    打印日期，后边的中括号限定了日期格式
`%p`    打印日志级别，-5 表示最多5个字符，左对齐不足5个字符补空格
`%c`    打印日志的类的路径，中括号表示路径级别取舍。默认全路径，比如 com.fc.test.TestController, {2} 表示 test.TestController
`%m`    日志内容
`%n`    当前系统平台的换行符

其他常用 
`%T`    调用log的线程id
`$X{xxx}`   打印用户指定的内容

### (2) springboot gradle 集成 log4j2

+ 全面替换，应该把每个模块的logback 禁用，并引入log4j2
```conf
configurations {
    all*.exclude group: 'org.springframework.boot', module: 'spring-boot-starter-logging'
}
dependencies {
    compile 'org.springframework.boot:spring-boot-starter-log4j2'
}
```

+ lombok使用
```java
@Slf4j
```

### (3) 集成 sleuth

+ 入口模块的 gradle配置，比如web模块
```conf
ext {
    set('springCloudVersion', "Hoxton.RELEASE")
}

dependencyManagement {
    imports {
        mavenBom "org.springframework.cloud:spring-cloud-dependencies:${springCloudVersion}"
    }
}

dependencies {
    compile 'org.springframework.cloud:spring-cloud-starter-sleuth'
}

```

+ log4j2 配置文件，日志格式制定trace相关
```xml
<PatternLayout>
    <pattern>"%d{yyyy-MM-dd HH:mm:ss.SSS} [%T,%X{X-B3-TraceId},%X{X-B3-SpanId},%X{X-B3-ParentSpanId},%X{X-Span-Export}] %-5p %c{2} : - %m%n"</pattern>
</PatternLayout>
```
`X-B3-TraceId` 即 traceId，表示当前链路的id，同一条链路，traceId相同。
`X-B3-SpanId`   即 spanId，表示当前系统的任务id。
`X-B3-ParentSpanId`  当前任务的 父id，
`X-Span-Export` 是否输出到日志收集系统比如zipkin
