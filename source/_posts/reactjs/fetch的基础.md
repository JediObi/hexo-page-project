---
title: fetch的基础
copyright: true
date: 2019-07-31 19:04:38
categories:
    - reactjs
tags:
    - reactjs
    - fetch
---

```js
fetch(url).then((response)=>{return response.json();}).then(jsonData=>{console.log(jsonData);}).catch(()=>{console.log("出错");});
```
上面这是一个最基本的请求，200~299的成功处理在jsonData所在的then函数中，而400或者其他错误则在catch里处理。
在ajax里，成功和失败在success和error节点里处理。