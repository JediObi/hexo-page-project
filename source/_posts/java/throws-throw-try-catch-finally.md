---
title: throws throw try catch finally
copyright: true
date: 2019-07-31 10:46:56
categories:
    - java
tags:
    - java
    - Exception
    - 异常
---
try-catch块的使用总结。

<!-- more -->

### **1. 你可以在任何地方使用`try...catch...finally`，包括在它们自己当中**

(1) 异常是一个生产者消费者模式，`try...catch`可以捕获并消费掉它，消费掉了，程序就不会终止否则全盘终止。`try...catch`也可以不消费它而再次`throw`出去或者是包装成自定义异常然后`throw`出去 —— 如果你觉得有这么做的必要。

### **2. 你也可以在任何地方使用`throw`异常，但是应该同时使用`throws`，用来通知方法调用者**

(2) `throw`一个原生异常，编译器不会报错，但这会让Exception变得隐蔽不容易被发现 —— 所以为了代码健康，应该在方法声明上加上`throws`，通知调用者。

(3)  `throw`一个自定义异常，编译器会立刻报错，应该在方法声明里加上`throws`，（你当然可以在`throw`两边包上一个`try...catch`原地消费掉它——但是这么做的意义不大，`throw`一个实质性的Exception就是为了提醒调用者某些潜在的可能的错误）。

### **3. `throws`可以传递Exception但不会消费掉它，最终还是需要`try...catch`来消费掉**
