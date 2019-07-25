---
title: (2) cmake-3 include test.h
copyright: true
date: 2019-07-25 22:32:25
categories:
    - c++
tags:
    - c++
    - cmake
---
cmake管理头文件依赖。       
在头文件里定义函数，在cpp里实现。   
在main.cpp里引入上述的头文件，即可直接使用cpp里实现的函数功能。

<!-- more -->

### (1) ```#include "test.h"

+ tree

    ```
    .
    ├── build
    ├── CMakeLists.txt
    ├── main.cpp
    ├── sum.h
    └── sum.cpp
    ```

+ main.cpp

    ```cpp
    #include <iostream>
    #include "sum.h"

    using namespace std;

    int main(){
    cout<<sum(1,2)<<endl;
    return 0;
    }
    ```

+ sum.h

    ```cpp
    int sum(int,int);
    ```

+ sum.cpp

    ```cpp
    #include "sum.h>
    int sum(int a, int b)
    {
    return a+b;
    }
    ```

+ g++

    1) once all

        ```
        ~:g++ main.cpp sum.cpp
        ~:./a.out
        3
        ```

    2) by step

        ```
        ~:g++ -c sum.cpp -o sum.o
        ~:g++ -c main.cpp -o main.o
        ~:g++ main.o sum.o
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
        add_executable(main main.cpp sum.cpp)
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

### （2） change to modules

+ tree
    ```
    .
    ├── build
    ├── CMakeLists.txt
    ├── main.cpp
    ├── sum
    │     ├── CMakeLists.txt
    │     ├── sum.h
    │     └── sum.cpp

    ```

+ main.cpp

    ```cpp
    #include <iostream>
    #include "./sum/sum.h"

    using namespace std;

    int main(){
    cout<<sum(1,2)<<endl;
    return 0;
    }
    ```

+ sum.h

+ sum.cpp

+ g++

    1) once all

        ```
        ~:g++ main.cpp sum/sum.cpp
        ~:./a.out
        3
        ```

    2) by step

        ```
        ~:g++ -c sum/sum.cpp -o sum/sum.o
        ~:g++ -c main.cpp -c main.o
        ~:g++ main.o sum/sum.o
        ~:./a.out
        3
        ```

+ cmake

    1) script

        ./CMakeLists.txt

        ```cmake
        cmake_minimum_required(VERSION 3.10)
        set(CMAKE_CXX_STANDARD 11)
        project(test)
        message(status "project: test")
        message(status "project directory: ${PROJECT_SOURCE_DIR}")
        set(CMAKE_BUILD_TYPE debug)
        set(CMAKE_C_FLAGS_DEBUG "-g -Wall")

        add_subdirectory(./sum)

        add_executable(main main.cpp)
        target_link_libraries(main sum_lib)
        ```

        ./sum/CMakeLists.txt

        ```cmake
        add_library(sum_lib sum.cpp)
        ```

    2) run
            
        ```
        ~:cd build
        ~:cmake ..
        ~:make
        ~:./main
        3
        ```

### (3) more than one modules

+ CMakeLists.txt

    ```cmake
    cmake_minimum_required(VERSION 3.10)
    set(CMAKE_CXX_STANDARD 11)
    project(test)
    message(status "project: test")
    message(status "project directory: ${PROJECT_SOURCE_DIR}")
    set(CMAKE_BUILD_TYPE debug)
    set(CMAKE_C_FLAGS_DEBUG "-g -Wall")

    add_subdirectory(./sum)
    add_subdirectory(./my_module2)

    add_executable(main main.cpp)
    target_link_libraries(main sum_lib module2_lib)
    ```
