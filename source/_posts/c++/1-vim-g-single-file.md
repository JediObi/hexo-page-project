---
title: (1) vim g++ single file
copyright: true
date: 2019-07-25 22:04:39
categories:
    - c++
tags:
    - c++
    - vim
    - g++
---
使用g++命令编译链接一个cpp文件并运行

<!-- more -->

Ubuntu Linux

### **1. g++ work flow**

preprocess->compile->assemble->link

### **2. g++ commands**

+ #### 2.1 preprocess, usually use .i as file extension for this process.

    ```
    E                          preprocess cpp file, 
                                with -o to generate .i
    ```
    ```
    g++ -E helloworld.cpp -o helloworld.i
    ```

+ #### 2.2 compile  
                              
    ```
    S                   preprocess and compile .cpp 
                        or compile .i
                        finally genearte .s for assemble
    ```

+ #### 2.3 assemble

    ```
    c                              preprocess, compile and assemble .cpp  
                                    or compile and assemble .i
                                    or assemble .s
                                    finally generate .o for link
    ```

+ #### 2.4 link

    ```
                                preprocess, compile, assemble and link  .cpp  
                                    or compile, assemble and link .i
                                    or assemble and link .s
                                    or link .o
                                    finally generate .out for running
    ```   
    you can use -o to specify the generation result inestead of a.out
    ```
    g++ helloworld.cpp -o helloworld
    ```

+ #### 2.5 others 

    ```
    o                       specify target file name 
    ```
    ```
    ~:g++ helloworld.cpp -o helloworld
    ```

### **3. source code **

**helloworld.cpp**

```c++
#include <iostream>

int main(){
    std::cout << "Hello World!" << std::endl;

    return 0;
}
```

### **4. compile and link**

`~:g++ helloworld.cpp`  
will generate a.out

### **5. run output **
`~:./a.out`     
will print "Hello World!".
