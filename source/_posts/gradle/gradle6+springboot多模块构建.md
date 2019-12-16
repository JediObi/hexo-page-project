---
title: gradle6+springboot多模块构建
copyright: true
date: 2019-12-16 16:09:48
categories:
    - gradle
tags:
    - gradle
    - spring
---

gradle 6.0.1
springboot 2.2.2
构建多模块应用

<!-- more -->

(1) 应用结构

```
.
├── biz
│   ├── build.gradle
│   └── src
│       └── main
├── build.gradle
├── common
│   ├── dao
│   │   ├── build.gradle
│   │   └── src
│   └── utils
│       ├── build.gradle
│       └── src
├── settings.gradle
└── web
    ├── build.gradle
    └── src
```

(2) 注意点

- 多模块 spring fatjar 应用，一般只有 web 模块包含启动类。所以除了 web 模块，其他模块 gradle task 里 `build bootJar`应该默认都禁用掉。
  <br/>
- 多模块 spring 应用，web 模块作为入口 jar，所以其他模块都是普通的 library 型的 jar，所以除了 web 模块，其他模块 gradle task 里 `build jar` 应该应该启用
  <br/>
- 由于只有 web 模块是入口 jar，所以其他模块的 gradle task 里的 `application bootRun` 都应该禁用，这样执行根项目的 `applicatoin bootRun` 就会只执行 web 模块的 main，不会报错。

(3) 根项目 gradle 配置

- build.gradle

```xml
buildscript {

    repositories {
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        mavenCentral()
    }

    dependencies {
        classpath "org.springframework.boot:spring-boot-gradle-plugin:2.2.2.RELEASE"
        classpath "io.spring.gradle:dependency-management-plugin:1.0.8.RELEASE"
    }

}

subprojects {

    apply plugin: 'org.springframework.boot'
    apply plugin: 'io.spring.dependency-management'
    apply plugin: 'java'

    group 'com.fc.test'
    version '1.0-SNAPSHOT'
    sourceCompatibility = 1.8

    bootJar {
        enabled = false
    }

    jar {
        enabled = true
    }

    bootRun {
        enabled = false
    }

    configurations {
        compileOnly {
            extendsFrom annotationProcessor
        }
    }
    repositories {
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public/' }
        mavenCentral()
    }
}
```

该配置设置了 springboot 两个插件的版本，并且禁用了子模块的 bootJar, bootRun，启用了 jar，注意在 web 模块需要这三个任务做相反的配置。

- settings.xml

```xml
rootProject.name = 'demo-parent'
include 'biz'
include 'web'
include 'common-dao'
include 'common-utils'
```

(4) 一级子模块配置-biz

```xml
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-cache'
    compile 'org.ehcache:ehcache:3.8.1'
    compile project(":common:dao")
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
}
```

(5) 二级子模块 common/utils, common/dao

- common:utils

```xml
dependencies {
//    compile group: 'org.springframework', name: 'spring-core'
//    compile group: 'org.springframework', name: 'spring-beans'
    implementation 'org.springframework.boot:spring-boot-starter-web'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
}
```

- common:dao

```
dependencies {
    compile group: 'tk.mybatis', name: 'mapper-spring-boot-starter', version: '2.1.1'
    compile group: 'org.xerial', name: 'sqlite-jdbc', version: '3.28.0'
    compile project(':common:utils')
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
}
```

注意lombok的传递依赖问题， 本文使用lombok的方式，即使把 compileOnly改为 compile 也会导致编译时lombok不识别的问题，所以每个用到lombok的模块单独引入，最好的方式还是手写get/set等方法。
