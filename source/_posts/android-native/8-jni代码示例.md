---
title: 8 - jni代码示例
copyright: true
date: 2019-07-26 16:51:41
categories:
    - Android native
tags:
    - Android
---
jni工程demo。目录结构，代码，g++生成动态库文件，jni调用过程。

<!-- more -->

### **1. 项目结构**

项目根目录
```
~:tree
.
├── bin
│   └── classes
└── src
    ├── cpp
    │   ├── hello-jni.cpp
    └── java
        └── com
            └── example
                └── HelloJni.java
```

### **2. 源代码**

+ #### 2.1 HelloJni.java

    ```java
    package com.example;

    class HelloJni{
    
        public static void main(String [] args){
            HelloJni obj = new HelloJni();
            System.out.println(obj.getStr());
        }

        public native String getStr();

        static {
            System.loadLibrary("hello-jni");
        }
    }
    ```

+ #### 2.2 hello-jni.cpp

    ```c++
    #include <string>
    #include <jni.h>
    #include <com_example_HelloJni.h>

    jstring
    Java_com_example_HelloJni_getStr(JNIEnv * env, jobject thiz)
    {
            return env->NewStringUTF("Hello from JNI !");
    }

    ```
    以上代码是支持c++重载的写法，该写法需要包含生成的头文件。如果使用c的写法，函数不支持重载，可以不包含生成的头文件（省略了生成头文件的过程）。
    <!-- todo -->
    注意：不包含头文件的写法

+  #### 2.3 不支持重载的写法

    ```c++
    #include <string>
    #include <jni.h>
    #include <com_example_HelloJni.h>

    extern "C"{
        jstring
        Java_com_example_HelloJni_getStr(JNIEnv * env, jobject thiz)
        {
                return env->NewStringUTF("Hello from JNI !");
        }
    }
    ```

### **3. 编译java文件**

+ #### 3.1 项目根目录

    ```
    ~:javac -d bin/classes src/com/example/HelloJni.java
    ```
    在 bin/classes目录下生成 com.example.HelloJni.class

### **4. 生成头文件**

+ #### 4.1 项目根目录

    ```
    ~:javah -d bin/includes -classpath bin/classes com.example.HelloJni
    ```
    生成头文件　bin/includes/com_example_HelloJni.h

### **5. 生成库文件**

+ #### 5.1 项目根目录

    ```
    ~:g++ src/cpp/hello-jni.cpp -fPIC -I /usr/local/lib/jdk1.8.0_201/include -I /usr/local/lib/jdk1.8.0_201/include/linux -I <项目根目录>/bin/lib/ -shared -o bin/lib/libhello-jni.so
    ```
    生成库文件　bin/lib/libhello-jni.so

### **6. 执行main方法**

+ #### 6.1 <项目根目录>/bin/classes

    ```
    ~:java -Djava.library.path=<项目根目录>/bin/lib com.example.HelloJni
    Hello from JNI !
    ```
