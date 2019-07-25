---
title: (2)-tensorflow api
copyright: true
date: 2019-07-25 17:56:16
categories:
    - tensorflow
tags:
    - python
    - tensorflow
---
tensorflow 常用的api

<!-- more -->

### (1) data object

tensor里使用的数据类型有３种

+ constant

    ```
    tf.constant(initalValue,dtype)
    ```

+ variable

    ```
    tf.Variable(initialValue,dtype)
    # 需要session执行initializer初始化变量，然后变量才能被session使用
    ```        

+ placeholder
    
    ```
    tf.placeholder(dtype)
    # 可以在session执行时指定placeholder的值
    ```

    ```python
    a = tf.placeholder(tf.float32)
    b = tf.placeholder(tf.float32)
    res = a+b
    print(session.run(res,{a:1,b:2.5})
    ```

### (2) tensor object -> operation

tensor就是数据间的关系组合（可以理解为由数据和运算符构成的多项式集合）
比如上边的res=a+b，res就是一个多项式，它就是一个tensor，或者说是一个tensor-node, tensor-node和数据可以组成更复杂的tensor(node), session可以执行这个tensor得到结果。     
通过组合tensor可以构建出训练流程。      
输入数据->构建激活值公式->构建输出公式->构建损失函数->构建损失函数收敛规则，既最终的train tensor -> session执行train tensor，底层会根据tensor规则训练模型。

### (3) optimizer object

optimize loss function      
tf提供多种optimizer来最小化loss function，而不用我们自己实现。

### (4) session.run()

+ session.run(tensor)

    ```
    execute operation
    ```

+ session.run(data)

    ```
    convert tensorflow data to python data
    ```

+ session.run(otherTFObject)

  1) init variables
    session.run(init)

### (5) other api

### (6) demo
