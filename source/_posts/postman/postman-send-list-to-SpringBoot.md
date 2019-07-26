---
title: postman send list to SpringBoot
copyright: true
date: 2019-07-25 17:49:49
categories:
    - postman
tags:
    - postman
    - spring
    - Spring Boot
---
使用postman向springboot的controller发送list参数

<!-- more -->

### **1. postman**

+ #### 1.1 Body->form-data
    ```
    key    value
    ids    1
    ids    2
    ```
+ #### 1.2 send

### **2. spring**

+ #### 2.1 @RequestParam("ids")
    ```java
        @PostMapping("/testJob")
        public void testJob3(@RequestParam("ids") List<Integer> ids) {
            
        }
    ```