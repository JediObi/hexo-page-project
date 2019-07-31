---
title: c3p0-Generate data for MySQL
copyright: true
date: 2019-07-31 10:53:54
categories:
    - java
tags:
    - java
    - c3p0
---
使用c3p0向mysql插入数据。
**todo:** 未来支持多种连接池。

<!-- more -->

### (1) pom.xml

```xml
<dependencies>
        <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>5.1.46</version>
        </dependency>

        <dependency>
            <groupId>com.mchange</groupId>
            <artifactId>c3p0</artifactId>
            <version>0.9.5.2</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
        </plugins>
    </build>
```

### (2) c3p0 init

```java
package com.example.mysqltest;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;

public class C3P0Helper {


    private static ComboPooledDataSource ds = new ComboPooledDataSource();
    static{
        try {
            ds.setJdbcUrl("jdbc:mysql://localhost:3306/db_name");
            ds.setUser("root");
            ds.setPassword("root");
            ds.setDriverClass("com.mysql.jdbc.Driver");
            ds.setAcquireIncrement(5);
            ds.setInitialPoolSize(20);
            ds.setMinPoolSize(2);
            ds.setMaxPoolSize(50);
        } catch (PropertyVetoException e) {
            e.printStackTrace();
        }

    }

    public static Connection getConn() throws SQLException {
        return ds.getConnection();
    }
}

```

### (3) Main

```java
package com.example.mysqltest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Random;

public class TestMain implements Runnable{
    
    public static void main(String[] args) {
        for(int i=0;i<10;i++){
            Thread thread = new Thread(new TestMain());
            thread.setName("thread-"+i);
            thread.start();
        }

    }

    @Override
    public void run() {
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = C3P0Helper.getConn();
            ps = connection.prepareStatement("insert into users(username, create_time,creator) values(?)");

            for(int i=0;i<10;i++){
                Timestamp timestamp = new Timestamp(new Date().getTime());
                ps.setString(1,Thread.currentThread().getName());
                ps.setTimestamp(2,timestamp);
                ps.setString(3,Thread.currentThread().getName());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            System.out.println(Thread.currentThread().getName()+" Finished!");
            try {
                if(null != ps) ps.close();
                if(null != connection) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

```