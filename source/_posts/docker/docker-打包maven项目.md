---
title: spring项目打包docker镜像
copyright: true
date: 2020-05-10 06:47:42
categories:
  - docker
tags:
  - docker
  - maven
  - java
  - spring
---

使用 fabric maven 插件把 spring 等 java 项目打包成 docker 镜像。
本文除了打包，还包含加载镜像创建容器，把镜像上传到 nexus 私服。

<!-- more -->

## 1. pom 配置

此处主要展示 这个插件会涉及到的 properties 和 plugin配置。
该插件在运行时，会读取properties里的一些配置并使用，可以参考官方文档

+ 镜像 build，包括dockerfile的动态传参
+ 创建容器， 对应maven插件的 docker:start 或者 docker:run, 二者实际是一个功能
+ 删除容器，对应 maven插件的 docker:stop， 停止并删除容器，该功能会读取properties 里的docker.removeMode参数，该参数是一个删除策略
+ 另外需要注意，该插件在某些地方读取 maven properties时可以省略取值符号${}
```xml
<properties>
    <dockerMavenPlugin.version>0.34.1</dockerMavenPlugin.version>
    <apiServer.port>8080</apiServer.port>
    <!-- fabric docker插件可以读取并使用 maven properties 里的属性，但需要按照一定的命名规则 -->
    <!-- docker.buildArg.JAR_FILE 在build时传入一个变量 -->
    <docker.buildArg.JAR_FILE>${project.build.finalName}.jar</docker.buildArg.JAR_FILE>
    <!-- docker.removeMode 容器销毁的模式 此处指定build模式，表示删除所有带有build脚本的images配置对应的容器 -->
    <docker.removeMode>build</docker.removeMode>
    <!-- 是否在控制台打印日志 -->
    <docker.showLogs>true</docker.showLogs>
</properties>
<build>
    <plugins>
        <plugin>
            <groupId>io.fabric8</groupId>
            <artifactId>docker-maven-plugin</artifactId>
            <version>${dockerMavenPlugin.version}</version>
            <configuration>
                <!-- 配置一个镜像 -->
                <images>
                    <!-- 镜像(仓库)名称和版本 -->
                    <name>springdemo:${project.version}</name>
                    <!-- build配置 -->
                    <build>
                        <!-- 上下文目录 -->
                        <contextDir>${project.basedir}</contextDir>
                        <!-- dockerfile 路径 -->
                        <dockerFile>config/docker/${profiles.active}/Dockerfile</dockerFile>
                    </build>
                    <!-- run 配置 -->
                    <run>
                        <ports>
                            <!-- 端口可以使用maven properties 变量，并且不需要取值符号${} -->
                            <port>apiServer.port:8080</port>
                        </ports>
                        <volumes>
                            <bind>
                                <volume>/etc/localtime:/etc/localtime:ro</volume>
                            </bind>
                        </volumes>
                        <!-- 容器测试，一般是ping http接口 -->
                        <wait>
                            <http>
                                <url>http://localhost:${apiServer.port}/user/hello</url>
                                <time>10000</time>
                            </http>
                        </wait>
                    </run>
                </images>
            </configuration>
        </plugin>

    </plugins>
</build>
```

+ dockerfile
```dockerfile
FROM openjdk:8-jdk-alpine
# 换源
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories
# 安装字体管理
RUN apk update
RUN apk add ttf-dejavu
RUN apk add vim
# 复制字体
ADD ./config/docker/simsun.ttf /usr/share/fonts
# 插件动态传参
ARG JAR_FILE
COPY target/${JAR_FILE} app.jar
# 此处开启了 远程调试
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Xdebug","-Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=n","-jar","/app.jar"]
expose 8080
expose 5005
```


