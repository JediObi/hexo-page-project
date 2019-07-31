---
title: 在props中传递函数对象的机制
copyright: true
date: 2019-07-31 18:50:27
categories:
    - reactjs
tags:
    - reactjs
---
给子组件传递父组件的函数

<!-- more -->

父组件在调用子组件时，可以传递funciton对象到子组件的props中。
比如以下
```
onClick={()=>this.onClick()}
```
还可以通过以下两种方式传递，这两种方式可能会遇到this为null的情况，因为逻辑中用到了代表父组件实例的this，但是因为某种机制（我没看源码），需要使用bind(this)传入父组件实例。
```
//这种方式如果需要父组件对象，则onClick={this.onClick.bind(this)}
onClick={this.onClick}
//这种方式可以在onClick里return 一个function，如果这个function需要父组件对象，需要bind(this)
onClick={this.onClick()}
```
从bind(this)的使用可以看出这种机制，这里的函数调用不像java里实例加"."函数名用法，更像是把父组件里的一段代码传到子组件里重新生成一个实现，而代表上下文的实例则由bind(this)注入。
以上三种方式，首推第一种，调用父组件的状态时过程最为透明。