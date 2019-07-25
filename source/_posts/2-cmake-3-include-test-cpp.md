---
title: (2) cmake-3 include test.cpp
copyright: true
date: 2019-07-25 22:28:19
categories:
    - c++
tags:
    - c++
    - cmake
---
cmake管理cpp文件依赖。      
在`main.cpp`里`include test.cpp`。

<!-- more -->

### (1) basic `#include "test.cpp"`

main()[main.cpp] will use sum()[sum.cpp]

+ tree

    ```
    .
    ├── build
    ├── CMakeLists.txt
    ├── main.cpp
    └── sum.cpp
    ```

+ main.cpp

    ```cpp
    #include <iostream>
    #include "sum.cpp"

    using namespace std;

    int main(){
    cout<<sum(1,2)<<endl;
    return 0;
    }
    ```

+ sum.cpp

    ```cpp
    int sum(int a, int b)
    {
    return a+b;
    }
    ```

+ g++

    ```
    ~:g++ main.cpp
    ~:./a.out
    3
    ```

+ cmake

    1) CMakeLists.txt

    ```cmake
    cmake_minimum_required(VERSION 3.10)
    set(CMAKE_CXX_STANDARD 11)
    project(test)
    message(status "project: test")
    message(status "project directory: ${PROJECT_SOURCE_DIR}")
    set(CMAKE_BUILD_TYPE debug)
    set(CMAKE_C_FLAGS_DEBUG "-g -Wall")
    add_executable(main main.cpp)
    ```

    2) build
    ```
    ~:cd build
    ~:rm -rf *
    ~:cmake ..
    ~:make
    ~:./main
    3
    ```
