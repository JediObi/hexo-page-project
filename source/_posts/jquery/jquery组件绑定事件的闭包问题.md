---
title: jquery组件绑定事件的闭包问题
copyright: true
date: 2019-07-25 17:32:03
categories:
    - jQuery
tags:
    - js
    - jQuery
    - 闭包
---
闭包问题导致动态组件无法获取正确数据。
比如循环生成的按钮打印序号，打印序号都是最大值。

<!-- more -->

+ #### 1. 产生闭包问题的代码
  
    ```js
    var divDom = $("#div1");
    for(var i=0;i<5;i++){
        var btnDom = $("<button>test" + i + "</button>");
        btnDom.click(function(){alert(i);});
        divDom.append(btnDom);
    }
    ```
    上面这段函数产生5个按钮，在点击按钮时alert对应的id
    但是实际效果是每个按钮都会alert 5。

+ #### 2. 解决方法,动态传参
    ```js
    $(dom).click({"id":i}, function(e){
        alert(e.data.id);
    });
    ```
