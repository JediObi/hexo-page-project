---
title: 2 - gradle usage
copyright: true
date: 2019-07-26 15:58:12
categories:
    - Android native
tags:
    - Android
    - gradle
---
gradle 简单使用

<!-- more -->

### **1. project & task**

+ #### 1.1 build.gradle
    ```
    task hello {
    doLast {
        println "hello"
    }
    }
    ```
    ```
    ~:gradle -q hello
    ```

+ #### 1.2 task with doLast

    (<< deprecated)
  + 包含doLast的任务只有在依赖或直接运行时才会执行
  + 不包含doLast的任务每次执行gradle命令都会执行

### **3. 编译android project**
