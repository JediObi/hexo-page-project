---
title: 函数式组件无法使用this关键字
copyright: true
date: 2019-07-31 18:46:45
categories:
    - reactjs
tags:
    - reactjs
    - 函数式组件
---
函数式组件通过传参替代this

<!-- more -->

函数式组件是无状态组件，其渲染性能更好，但是无法在其中使用this。仍可以使用props，如果你想用props，比如以下
```
const myComponent = (props)=>{
    return (<>{props.name}</>);
}
```