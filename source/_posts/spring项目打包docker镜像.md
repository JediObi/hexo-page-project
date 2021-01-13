---
title: spring项目打包docker镜像
copyright: true
date: 2020-05-10 06:47:42
categories:
tags:
---

使用 dockerfile maven 插件把 spring 项目打包成 docker 镜像。
本文除了打包，还包含加载镜像创建容器，把镜像上传到 nexus 私服。

<!-- more -->

## 1. pom 配置

spring 项目一般会配置 spring maven 插件。
本文打包需要 dockerfile maven 插件

```xml
<plugin>
    <groupId>com.spotify</groupId>
    <artifactId>dockerfile-maven-plugin</artifactId>
    <version>1.4.13</version>
    <executions>
        <execution>
            <id>default</id>
            <goals>
                <goal>build</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
    <!-- 镜像的仓库名 -->
        <repository>jakku/commonlogin</repository>
        <!-- 镜像版本 -->
        <tag>${project.version}</tag>
        <!-- 打包的dockerfile位置 -->
        <dockerfile>Dockerfile</dockerfile>
        <!-- 运行插件时的上下文路径 -->
        <contextDirectory>${project.basedir}</contextDirectory>
        <!-- dockerfile变量声明 这样就可以在dockerfile里使用变量-->
        <buildArgs>
            <!-- 声明一个 JAR_FILE变量，表示生成的jar路径（包含上下文路径） -->
            <JAR_FILE>target/${project.build.finalName}.jar</JAR_FILE>
        </buildArgs>
    </configuration>
</plugin>
```

```dockerfile
ARG JAR_FILE
FROM openjdk:8-jdk-alpine
ADD ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
expose 38081
```

## 2. linux docker 配置

docker 守护进程默认只开启了 unix socket 监听，对应的进程文件为 /var/run/docker.sock，当然你也可以在 service 文件里修改。默认的这个文件归属于 docker 用户组和超级用户，普通用户组没有权限操作这个文件，所以普通用户需要添加到 docker 组。

可能系统默认不开启 docker，开启之后会影响性能尤其是安装了 k8s 之后，所以可能需要手动开启 docker 进程。

- 命令：添加到 docker 用户组

```
~:sudo gpasswd -a user_name docker
```

- 权限生效，命令或重启电脑

```
# 刷新用户组，只对当前会话有效
~:newgrp docker
```

- 命令：从 docker 用户组删除用户

```
~:sudo gpasswd -d user_name docker
```

docker 也支持 tcp 监听，本地测试不需要开启。在 service 里配置，一般开启远程就是指开启 tcp 监听，如果需要在远程服务器上上传镜像，一般是需要开启这个的。
