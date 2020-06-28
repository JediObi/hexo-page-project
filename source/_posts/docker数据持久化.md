---
title: docker数据持久化
copyright: true
date: 2020-06-17 06:38:51
categories:
tags:
---
docker容器是无状态的，所有的写入如果不做持久化，容器删除时，写入的数据也会删除。
本文容器数据持久化常用的两种方式，volume方式和bind mount方式。

<!-- more -->

容器的数据持久化实际是通过挂载宿主机目录到容器目录上实现的。
在dockerfile的或者run命令参数可以实现目录挂载。但挂载分为两种方式，volume和bind mount。

volume是最常用的方式，它类似于一个容器但只提供存储功能，所以它是由docker管理的，可以在dockerfile里创建，或volume命令创建，也可以在run命令里通过-v参数或mount参数创建或绑定已有的volume。

由于volume是docker管理的，更适合移植，所以可以在dockerfile里创建。

通过run命令创建并绑定一个volume，假设名字是 test-volume且之前不存在

docker run mysql:5.7 -v test-volume:/usr/lib/mysql ... -> 这会创建一个名为test-volume的volume，并且会使用容器里的/usr/lib/mysql数据做覆盖

最新的docker更推荐使用mount参数 --mount source=test-volume target=/usr/lib/mysql

通过run命令绑定一个已存在的volume


通过volume创建一个volume

dockerfile里创建volume




bind mount 是挂载宿主机物理路径的方式，适用于测试环境，配置简单，但由于绑定了真实路径导致无法移植，不能在dockerfile里用这种方式。

在 run命令里 使用绝对路径表示挂载卷就是以bind mount的方式绑定了宿主机上的真实路径。

druid log4j 日志开关
 <!-- 上面的druid的配置 -->
    <bean id="log-filter" class="com.alibaba.druid.filter.logging.Log4j2Filter">
        <!-- 所有连接相关的日志 -->
        <property name="connectionLogEnabled" value="false"/>
        <!-- 所有Statement相关的日志 -->
        <property name="statementLogEnabled" value="false"/>
        <!-- 是否显示结果集 -->
        <property name="resultSetLogEnabled" value="true"/>
        <!-- 是否显示SQL语句 -->
        <property name="statementExecutableSqlLogEnable" value="true"/>
    </bean>

web-stat-filter 用于采集数据web接口关联的jdbc监控数据

stat-view-servlet 用于展示监控数据的servlet提供ui界面。
