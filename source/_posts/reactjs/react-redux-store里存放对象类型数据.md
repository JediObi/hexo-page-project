---
title: react input组件渲染与数据提交
copyright: true
date: 2019-12-06 16:00:39
categories:
    - reactjs
tags:
    - reactjs
    - redux
---
当一个reducer模块的state里包含复杂的object类型数据时，直接修改该对象里的数据时不会触发组件渲染。
需要使用类似{...object}的拷贝方式生成新对象才会触发重渲染。
尤其是当使用了 es的map类型时。


<!-- more -->

复杂类型可能是由于json转换时的拷贝等原因，导致react无法检测到对象的变化，也就是state一直保持在初始状态，此时修改数据并不会发生重渲染。

