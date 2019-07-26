---
title: (2) cmake-1 basical
copyright: true
date: 2019-07-25 22:13:27
categories:
    - c++
tags:
    - c++
    - cmake
---
使用cmake编译链接cpp文件，并管理依赖和头文件。  
cmake是对make的包装，它可以根据配置文件对编译链接整个工程。

<!-- more -->

### **1. simple usage**

cmake是对make的包装，底层依然是make

+ #### 1.1 tree

    ```
    .
    ├── build
    ├── CMakeLists.txt
    └── test.cpp
    ```

+ #### 1.2 test.cpp

    ```c++
    #include <iostream>
    int main(int argc, char *argv[])
    {
        std::cout << "Hello World!"<< std::endl;
        return 0;
    }
    ```

+ #### 1.3 CMakeLists.txt

    ```cmake
    cmake_minimum_required(VERSION 3.10)
    # 这行非必须
    project(testcmake)
    # 这行表示使用指定的cpp文件生成可执行文件 testcmake
    add_executable(testcmake
            test.cpp)
    ```
    **==>**
    ```
    add_executable(testcmake
            test.cpp)
    ```
    testcmake is the output file name   
    test.cpp is dependencies source code.

+ #### 1.4 cmake

    执行编译
    ```
    ~:cd build
    ~:cmake ..
    ~:make
    ~:./testcmake
    ```

### **2. configure a header file for make(g++)**

使用cmake脚本配置一个header文件，某个cpp可能include了这个头文件，但是在源码阶段不需要这个header（比如版本号等公共信息），但是在make时这个header必须存在，所以使用cmake生成。

+ #### 2.1 CMakeLists.txt

    ```cmake
    cmake_minimum_required(VERSION 3.10)
    project(testcmake)
    # The version number.
    set(test_version_major 1)
    set(test_version_minor 0)

    # Configure a header file to pass some of the CMake settings
    # to the source code
    configure_file(
        "${PROJECT_SOURCE_DIR}/testConfig.h.in"
        "${PROJECT_BINARY_DIR}/testConfig.h"
        )

    # Add the binary tree to the search path for include files
    # to the source code
    include_directories("${PROJECT_BINARY_DIR}")

    # Add the executable
    add_executable(testCmake test.cpp)
    ```
    **==>**     
    `set(test_version_major 1)`    
    will create a variable test_version_major=1     
    **==>**     
    ```
    # 这行将使用 testConfig.h.in 里的代码生成头文件 testConfig.h
    configure_file(  "${PROJECT_SOURCE_DIR}/testConfig.h.in" 
                    "${PROJECT_BINARY_DIR}/testConfig.h")
    ```
    will use `"${PROJECT_SOURCE_DIR}/testConfig.h.in"` code to create `"${PROJECT_BINARY_DIR}/testConfig.h"  `

    **==>**
    ```
    # 上边的代码生成了头文件，这行代码使make包含生成的头文件所在目录，用于查找头文件
    include_directories("${PROJECT_BINARY_DIR}")
    ```
    will include this directory for make to search header files.

+ testConfig.h.in

    ```cpp
    #define socket_version_major @socket_version_major@
    #define socket_version_minor @socket_version_minor@
    ```

+ #### 2.2 test.cpp

    ```c++
    #include <iostream>
    #include "testConfig.h"

    int main(int argc, char *argv[])
    {
        std::cout << "Hello World!"<< std::endl;
        std::cout << "Version " << socket_version_major << "." << socket_version_minor << std::endl;
        return 0;
    }
    ```

### **3. link libraries**

以上代码展示了生成可执行文件，这个例子展示创建共享库(静态so和动态a)，大多数文件是提供功能依赖，这些文件都要构建成库文件。

+ #### 3.1 library

    库文件源码，一个独立的模块

    **./lib_code/Add/Add.h**
    ```c++
    #ifndef SOCKET_ADD_H
    #define SOCKET_ADD_H

    int add(int);

    #endif //SOCKET_ADD_H
    ```

    **./lib_code/Add/Add.cpp**
    ```c++
    #include "Add.h"

    int add(int inputvalue)
    {
        return inputvalue+1;
    }
    ```

    **./lib_code/Add/CMakeLists.txt**
    ```
    # 这句把cpp文件编译成静态库文件Add_lib.so，add_library可以指定静态还是动态，默认静态SHARED
    add_library(Add_lib Add.cpp)
    ```
    default type is `STATIC`.     
    `add_library(Add_lib SHARED Add.cpp)` to create a .so for make.

+ #### 3.2 use library

    引用库文件

    **./CMakeLists.txt**

    ```cmake
    cmake_minimum_required(VERSION 3.10)
    project(test)

    set(CMAKE_CXX_STANDARD 11)

    set(test_version_major 1)
    set(test_version_minor 0)

    # include testConfig.h
    include_directories("${PROJECT_BINARY_DIR}")

    # generate testConfig.h
    configure_file(
            "${PROJECT_SOURCE_DIR}/testConfig.h.in"
            "${PROJECT_BINARY_DIR}/testConfig.h"
    )

    # include Add.h
    # 这句是包含头文件目录，因为可执行文件include了add的头文件，必须指明搜索路径
    include_directories("${PROJECT_SOURCE_DIR}/lib_code/Add")

    # run lib_code/Add/CMakeLists.txt
    # 添加cmake子文件夹，这将会运行该文件夹下的cmake文件
    add_subdirectory(lib_code/Add)

    add_executable(testcmake
            test.cpp)
    # link Add.so
    # 为可执行文件链接add_library生成的库文件
    target_link_libraries(testcmake Add_lib)

    ```
    **==>**
    `add_subdirectory(lib_code/Add)`        
    will run CMakeLists.txt in this directory.

    **==>**

    **./test.cpp**

    源码 include 库文件的header

    ```c++
    #include <iostream>
    #include "socketConfig.h"
    #include "Add.h"

    int main(int argc, char *argv[])
    {
        std::cout << "Hello World!"<< std::endl;
        std::cout << "Version " << socket_version_major << "." << socket_version_minor << std::endl;
        std::cout << "2+1=" << add(2) << std::endl;
        return 0;
    }
    ```

+ #### 3.3 cmake

    ```
    ~:cd build
    ~:rm -rf *
    ~:cmake ..
    ~:make
    ~:testcmake
    ```

### **4. control libraries**

cmake的逻辑语句，对头文件做控制，对源码也可控制

+ #### 4.1 option

    this command will setup a switch for libraries.     
    **./CMakeLists.txt**

    ```cmake
    cmake_minimum_required(VERSION 3.10)
    project(test)

    set(CMAKE_CXX_STANDARD 11)

    set(test_version_major 1)
    set(test_version_minor 0)

    # include testConfig.h
    include_directories("${PROJECT_BINARY_DIR}")

    # default value is OFF
    option(
            USE_MYADD
            "Use my own add method" ON
    )

    # generate testConfig.h
    configure_file(
            "${PROJECT_SOURCE_DIR}/testConfig.h.in"
            "${PROJECT_BINARY_DIR}/testConfig.h"
    )

    if (USE_MYADD)
        # include Add.h
        include_directories("${PROJECT_SOURCE_DIR}/lib_code/Add")
        # run ./lib_code/Add/CMakeLists.txt
        add_subdirectory(lib_code/Add)
        # setup a variable for library  
        set(EXTRA_LIBS Add_lib)
    endif(USE_MYADD)

    add_executable(testcmake
            test.cpp)
    # link Add.so
    target_link_libraries(testcmake Add_lib)

    ```

+ #### 4.2 cmakedefine

    use cmakedefine to control define in code

    **./testConfig.h.in**

    ```c++
    #define socket_version_major @socket_version_major@
    #define socket_version_minor @socket_version_minor@
    #cmakedefine USE_MYADD
    ```

+ #### 4.3 code

    **./test.cpp**

    ```c++
    #include <iostream>
    #include "socketConfig.h"
    #ifdef USE_MYADD
    #include "Add.h"
    #endif

    int main(int argc, char *argv[])
    {
        std::cout << "Hello World!"<< std::endl;
        std::cout << "Version " << socket_version_major << "." << socket_version_minor << std::endl;
    #ifdef USE_MYADD
        std::cout << "2+1="<< add(2) << std::endl;
    #else
        std::cout << "closed" << std::endl;
    #endif
        return 0;
    }
    ```

+ #### 4.4 cmake

    ```
    ~:cd build
    ~:rm -rf *
    ~:cmake ..
    ~:make
    ```

### **5. install**

把生成的可执行文件添加到系统路径        
把头文件添加到系统查找路径

```
install(TARGETS test DESTINATION bin)
install(FILES ${PROJECT_BINARY_DIR}/testConfig.h DESTINATION include)
```

+ #### 5.1 Example

    **./CMakeLists.txt**

    ```cmake
    cmake_minimum_required(VERSION 3.10)
    project(test)

    set(CMAKE_CXX_STANDARD 11)

    set(test_version_major 1)
    set(test_version_minor 0)

    # include testConfig.h
    include_directories("${PROJECT_BINARY_DIR}")

    option(USE_MYADD "Use my own add method" OFF)

    # generate testConfig.h
    configure_file(
            "${PROJECT_SOURCE_DIR}/testConfig.h.in"
            "${PROJECT_BINARY_DIR}/testConfig.h"
    )

    if (USE_MYADD)
        message("option is on")
    # include Add.h
        include_directories("${PROJECT_SOURCE_DIR}/lib_code/Add")
        # run lib_code/Add/CMakeLists.txt
        add_subdirectory(lib_code/Add)
        set(EXTRA_LIBS Add)
    else(USE_MYADD)
        message("option is off")
    endif(USE_MYADD)


    add_executable(test
            test.cpp)
    # add library
    target_link_libraries(test ${EXTRA_LIBS})

    install(TARGETS test DESTINATION bin)
    install(FILES ${PROJECT_BINARY_DIR}/testConfig.h DESTINATION include)

    ```
