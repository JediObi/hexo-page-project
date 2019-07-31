---
title: yield
copyright: true
date: 2019-07-31 11:06:07
categories:
    - python3
tags:
    - python3
    - python
    - yield
---
python yield关键字用法

<!-- more -->

一个函数可以返回一个序列（字符串，列表，元组）。如果返回的序列很大，就会非常吃内存。
此时可以使用`yield`来节省内存。

```python
#!/usr/bin/python3
 
import sys
 
def fibonacci(n): # 生成器函数 - 斐波那契
    a, b, counter = 0, 1, 0
    while True:
        if (counter > n): 
            return
        yield a
        a, b = b, a + b
        counter += 1
f = fibonacci(10) # f 是一个迭代器，由生成器返回生成
 
while True:
    try:
        print (next(f), end=" ")
    except StopIteration:
        sys.exit()
```
0自增100次，需要对每次自增的结果做处理。
写一个自增函数，在函数里把参数+1返回结果。调用这个函数，处理结果，重复100次。
写一个自增函数，在函数里循环100次，每次+1结果存进列表；最后返回列表。调用这个函数，遍历列表，处理结果。
第一种逻辑封装不够彻底但是省内存，第二种逻辑封装的好但是需要生成完整列表很占内存。
使用yield的函数会变成一个生成器，可以理解为该函数生成了迭代器，即接收该函数执行结果的变量变成了迭代器可以调用的`next()`方法。实际过程相当于函数变成了动态执行，函数执行时遇到`yield`会保存运行状态并暂停，等到生成的迭代器执行`next()`方法时函数恢复状态继续执行。实际上每次都只是返回一个数据，但是在调用者看来就像返回了一整个集合，逻辑上独立，也节省了内存。
并且使用yield，可以获取函数运行过程中的数据，不再只是冷冰冰的结果。
