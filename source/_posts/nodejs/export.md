---
title: export
copyright: true
date: 2019-07-26 17:14:58
categories:
    - node
tags:
    - node
---
nodejs中 `export` 和 `module.exports` 的区别。
nodejs中 `import` 的方式。

<!-- more -->

### **1. 导出默认组件**

使用 `import 模块` 会直接导出该模块默认组件。   
`export` 是对 `module.exports` 的封装。

```js
export default ComponentName;
```

### **2. 导出指定组件**

可以导出多个组件，`import {Component1, Component2...}` 可以导入这些组件

```js
module.exports={}
```