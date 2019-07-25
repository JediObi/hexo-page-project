---
title: (1)-numpy api
copyright: true
date: 2019-07-25 17:53:06
categories:
    - tensorflow
tags:
    - python
    - numpy
    - tensorflow
---
numpy 常用的一些接口

<!-- more -->

### (1) random 

+ np.random.rand(d0,d1,d2...)

    ```
    dx is the length of each dimension, and count(dx) is the shape of the array;
    ```

### (2) float32()

+ np.float32(narray)

    ```
    change all element type to float32 and return a new narray;
    ```

### (3) dot(narray(x * y),narray(y * z))

return x * z matrix
