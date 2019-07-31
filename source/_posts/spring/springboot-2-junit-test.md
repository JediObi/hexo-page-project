---
title: springboot(2)-junit-test
copyright: true
date: 2019-07-31 15:39:54
categories:
    - spring
tags:
    - spring
    - junit
---
spring集成junit测试的配置。

<!-- more -->

通过以下步骤实现junit测试, 为测试环境注入applicationContext

(1) pom
```xml
<dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
</dependency>
```

(2) Test.class

```java
package com.test.provider;

import com.test.provider.web.user.TestService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest(classes =MyApplication.class)
@RunWith(SpringRunner.class)
public class TestMain {

    @Autowired
    private TestService testService;

    @Test
    public void test() {
        testService.testPrint();
    }
}
```

+ @RunWith(SpringRunner.class)     可以通过以下两种方式注入ApplicationContext

  1.

    ```java
    @Autowired
    private ApplicationContext context;
    ```

  2.

    ```java
    @Slf4j
    @Component
    @Lazy(false)
    public class ContextUtils implements ApplicationContextAware, DisposableBean {

        private static ApplicationContext applicationContext = null;

        @Override
        public void setApplicationContext(ApplicationContext applicationContext) {
            ContextUtils.applicationContext = applicationContext;
        }
    }
    ...

    ```