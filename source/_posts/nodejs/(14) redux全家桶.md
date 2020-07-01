---
title: (14) redux全家桶
copyright: true
date: 2020-07-02 06:26:50
categories:
    - nodejs
tags:
    - node
    - react
    - redux
    - redux-saga
---
`redux` redux提供了一个store组件，store使用自身的state管理所有数据，并提供api让其他组件注册数据到state和订阅state里的数据，这样react的数据就无需逐层的props传递了。
`react-redux`   该组件封装了redux的注册和订阅逻辑编程Provider组件和connect函数，使redux使用更简单。Provider就是把store引入ui, connect函数就是把各个组件的数据注册到sotre里。
`redux-saga`    使用es6的异步编程模型实现异步能力，使redux可以把网络请求和数据返回变成异步，从而全面结果网络数据。

<!-- more -->

正文
