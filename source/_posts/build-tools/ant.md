---
title: ant
copyright: true
date: 2019-07-26 17:04:04
categories:
    - 构建工具
tags:
    - 构建工具
    - Ant
---
Ant的安装配置和使用。

<!-- more -->

### **1. install**

```
~:tar xzvf apache-ant-1.10.1-bin.tar.gz -C /usr/local/bin
```

### **2. enviroment**

```
# apache ant
ANT_HOME=/usr/local/bin/apache-ant-1.10.1
PATH=$PATH:$ANT_HOME/bin/
export PATH
```

### **3. usage**

```xml
<?xml version="1.0" encoding="utf-8"?>

<!-- 
Build file for Time Expression application from 
Rapid Java Development book.
-->
<project name="My_project" basedir="."> 
  <property name="appname" value="${ant.project.name}"/>  
  <property name="env" value="local"/>  
  <property name="java.home" value="${env.JAVA_HOME}"/>  
  <property name="ant.home" value="${env.ANT_HOME}"/>  
  <!-- load properties file -->  
  <property file="local.properties"/>  
  <property name="lib.dir" value="lib"/>  
  <path id="master-classpath" description="Master CLASSPATH for this script"> 
    <fileset dir="${lib.dir}"> 
      <include name="*.jar"/> 
    </fileset> 
  </path>  
  <target name="clean" description="Deletes files from WAR directory"> 
    <delete failonerror="false"> 
      <fileset dir="${war.dir}"> 
        <include name="**/*.*"/> 
      </fileset> 
    </delete>  
    <delete failonerror="false"> 
      <fileset dir="${java.dir}"> 
        <include name="**/*.scc"/> 
      </fileset> 
    </delete>  
    <delete failonerror="false"> 
      <fileset dir="${dist.dir}"> 
        <include name="**/*"/> 
      </fileset> 
    </delete>  
    <delete> 
      <fileset dir="${class.dir}"> 
        <include name="**/*"/> 
      </fileset> 
    </delete> 
  </target>  
  <target name="init" description="Setup for build script"> 
    <mkdir dir="${conf.dir}"/>  
    <mkdir dir="${web.dir}"/>  
  </target>  
  <target name="compile" depends="init" description="Compiles .java files to WAR directory"> 
    <javac encoding="GBK" destdir="${class.dir}" debug="true" failonerror="true" fork="true" memoryInitialSize="256m" memoryMaximumSize="1068m" includeantruntime="on" classpathref="master-classpath"> 
      <src path="${java.dir}"/>  
      <src path="${java_other.dir}"/>
    </javac> 
  </target>  
  <target name="jar"> 
    <echo>Archiving the base classes</echo>  
    <tstamp prefix="update."> 
      <format property="TimeSign" pattern="yyyy-MM-dd HH.mm.ss"/> 
    </tstamp>  
    <jar jarfile="${lib.dir}/1.jar"> 
      <fileset dir="${class.dir}"> 
        <include name="**/*.class"/>  
        <exclude name="**/*.scc"/> 
      </fileset> 
    </jar> 
  </target>  
  <target name="dist" depends="init" description="Copies web related files to WAR directory"> 
    <copy includeEmptyDirs="false" todir="${dist.dir}" encoding="utf-8"> 
      <fileset dir="${web.dir}"> 
        <include name="**/*"/> 
      </fileset> 
    </copy>  
    <copy encoding="utf-8" includeEmptyDirs="false" todir="${dist.dir}"> 
      <fileset dir="${build.dir}"> 
        <include name="**/*"/> 
      </fileset> 
    </copy> 
  </target>  
  <target name="junitswing"> 
    <java fork="true" classpathref="master-classpath" classname="junit.swingui.TestRunner"/> 
  </target> 
</project>
```

### **4. command**

```
ant clean
```
```
ant clean compile
```
```
ant -f build2.xml clean
```
