---
title: (15) redux与router
copyright: true
date: 2020-07-02 06:27:02
categories:
    - nodejs
tags:
    - node
    - react
    - redux
    - router
---
redux虽然实现了数据管理，但它无法直接使用router的功能，比如redux-saga异步请求的要根据请求结果做url跳转，只能是组件收到数据后自行跳转。
`connected-react-router` 把跳转过程封装成reducer dispatch，从而实现了一个类似于router push的api，这个api可以在redux-saga里使用。

<!-- more -->

正文
