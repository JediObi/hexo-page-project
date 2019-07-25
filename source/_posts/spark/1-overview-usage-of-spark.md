---
title: (1) overview usage of spark
copyright: true
date: 2019-07-25 17:26:54
categories:
    - spark
tags:
    - spark
    - java
    - 大数据
---
spark在ubuntu上的安装运行。
java数据结构简介，提交java任务。

<!-- more -->

## **overview usage of spark**

### (1) download tgz

### (2) unzip

```
~:tar xzvf spark-xxx.tgz -C /home/user/bin
```

### (3) start spart

```
~:cd /home/user/bin/spark/bin
~:./spark-shell
```

### (4) java maven 统计词频

+ pom
    ```xml
    <dependency>
                <groupId>org.apache.spark</groupId>
                <artifactId>spark-core_2.12</artifactId>
                <version>2.4.3</version>
                <scope>provided</scope>
    </dependency>
    ```

+ com.user.test.TestMain
    ```java
    package com.user.test;

    import org.apache.spark.SparkConf;
    import org.apache.spark.api.java.JavaPairRDD;
    import org.apache.spark.api.java.JavaRDD;
    import org.apache.spark.api.java.JavaSparkContext;
    import org.apache.spark.api.java.function.FlatMapFunction;
    import org.apache.spark.api.java.function.Function2;
    import org.apache.spark.api.java.function.PairFunction;
    import scala.Tuple2;

    import java.util.ArrayList;
    import java.util.Arrays;
    import java.util.Iterator;
    import java.util.List;

    public class TestMain {
        public static void main(String[] args) {
            SparkConf sparkConf = new SparkConf().setAppName("wordCount");
            JavaSparkContext jsc = new JavaSparkContext(sparkConf);

            List<String> list = new ArrayList<String>();
            list.add("a b c d e");
            list.add("a b c d e");
            JavaRDD<String> rddList = jsc.parallelize(list);
            JavaRDD<String> stringJavaRDD = rddList.flatMap(new FlatMapFunction<String, String>() {
                public Iterator<String> call(String s) throws Exception{
                    return Arrays.asList(s.split(" ")).iterator();
                }
            });
            JavaPairRDD<String, Integer> stringIntegerJavaPairRDD = stringJavaRDD.mapToPair(new PairFunction<String, String, Integer>() {
                public Tuple2<String, Integer> call(String s) throws Exception {
                    return new Tuple2<String, Integer>(s, 1);
                }
            }).reduceByKey(new Function2<Integer, Integer, Integer>() {
                public Integer call(Integer x, Integer y) throws Exception {
                    return x + y;
                }
            });
            stringIntegerJavaPairRDD.saveAsTextFile("/home/user/work/spark_data");
            jsc.close();
        }
    }
    ```

+ package test.jar (/home/user/bin/test.jar)
    ```
    ~:mvn clean compile package
    ```

### (5) submit task

```
~:cd /home/user/bin/spark/bin
~:./spark-submit --class com.user.test.TestMain /home/user/bin/test.jar local
```

### (6) 查看结果 

/home/user/work/spark-data/
