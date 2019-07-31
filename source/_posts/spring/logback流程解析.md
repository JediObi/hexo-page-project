---
title: logback流程解析
copyright: true
date: 2019-07-31 15:34:45
categories:
    - spring
tags:
    - spring
    - logback
---
logback打印日志的流程。

<!-- more -->

#### (1) 概述

本篇并不是做源码解析，阅读本文需要熟悉logback调用链。
logback会把所有传入的参数转换为String，所以像异常栈这样的信息，直接以文本输出只会输出第一句。
以log.error("{}",exception.getMessage(),exception)为例

#### (2) 参数解析

+ `log.error("{}",exception.getMessage(),exception)`

    包含三个参数，在logback中类似的多参数调用其第一个string参数是固定的，表示format即格式，通常是一些提示信息和占位符。其他参数一般就是填充占位符，但是logback还有一个固定参数——Exception，这个参数可有可无，放在参数列表最后一个位置。

    所以方法的参数可以按照占位符分为四种
    第一种: 第一个format参数 可能包含占位符。除占位符之外，其他信息会被打印。
    第二种：按顺序填充占位符的参数，属于 message 类型参数。作为文本打印。
    第三种: 无用参数，即那些没有占位符的参数，并且不是最后一个参数。这类参数最终不会被打印。
    第四种: 最后一个参数且是Exception类型的，它不需要占位符。异常栈会被全部打印。

#### (3) 流程

logback的调用链大致的流程是，使用参数生成Event，格式化要输出的数据为String， 打印String。

此处只解析 message类型和最后一个Exception的解析流程。

logback在spring初始化时会解析配置文件，对配置文件的encoder或者layout做解析，初始化一个`Converter`链，`Converter`链可以理解为格式转换器，对特殊符号做解析，比如 `%highlight %msg%n`这类格式字符串，这三个分别对应了三种`Converter` 即高亮，消息，换行。而`%msg`就是负责解析 message类型参数的转换器，而message类型就是我们需要的最重要的信息。在解析完配置文件的`Converter`链之后，logback会在Converter链条末尾再追加一个异常转换器。这就是为什么error()方法最后会固定一个Exception参数，而我们能够用`og.error("{}",exception.getMessage(),exception)`这种方式，不加占位符就可以直接打印异常栈。

+ message类型

    调用链最重要的格式化为String的过程在`PatternLayoutBase.writLoopOnConverters(E event)`，这个方法使用各种`Converter`对原始信息做格式化，最终整合为一个String返回给`Appender`输出。
    该方法根据`Converter`链依次处理对应的数据，当到达`%msg`时就会对message参数做处理，这个Converter会调用Event.getFormattedMessage()获取message的格式化结果字符串(因为Event包含所有第一到第四种参数)。

+ Exception类型

    在生成Event实例时，logback提取参数列表最后一个参数，如果是Exception的实例，则生成一个Throwable对象作为Event的成员。
    `Converter`链最后一个转换器是异常转换器，它会获取这个Throwable对象，如果不为空就会把异常栈里的信息转换成String。

