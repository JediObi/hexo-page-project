---
title: (1) android studio cmake
copyright: true
date: 2019-07-26 15:48:35
categories:
    - Android native
tags:
    - Android
    - native
    - jni
    - cmake
---
android studio jni调用native的cmake脚本和代码示例。

<!-- more -->

core file CMakeLists.txt
path: application_module/CMakeLists.txt

### **1. example**
```cmake
# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.

add_library( # Sets the name of the library.
             native-lib

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             src/main/cpp/native-lib.cpp
             )


add_library( # Sets the name of the library.
             my-lib

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             src/main/cpp/my-lib.cpp
             )

# Searches for a specified prebuilt library and stores the path as a
# variable. Because CMake includes system libraries in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

find_library( # Sets the name of the path variable.
              log-lib

              # Specifies the name of the NDK library that
              # you want CMake to locate.
              log )

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

target_link_libraries( # Specifies the target library.
                       native-lib

                       # Links the target library to the log library
                       # included in the NDK.
                       ${log-lib} )
```
multiple library for more than one class file.

### **2. cpp for jni**

```cpp
#include <jni.h>
#include <string>

extern "C"
JNIEXPORT jstring JNICALL
Java_com_example_username_helloworld_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}
```
`Java_com_example_username_helloworld_MainActivity_stringFromJNI`
`Java` means for jni
`com_example_username_helloworld_MainActivity` is package name
`stringFromJNI` is method name

### **3. java code**

```java
package com.example.username.helloworld;

public class NativeHelper {
    static{
        // (1)
        System.loadLibrary("my-lib");
    }

    // (2) 
    public static native String getAppKey();
}
```
`(1)` load library
`(2)` declare the native method, keep the method name same with cpp code
