---
title: (11) mathjax in html
date: 2019-07-23 22:11:07
copyright: true
categories:
    - node
    - react
tags:
    - node
    - react
    - mathjax
    - LaTex
---
为 react 项目引入 mathjax.js 用于处理 LaTex 语言数学公式

<!-- more -->

## **(11) mathjax in html**


I want to use formulas in my pages.

+ #### 1. script environment

    index.html
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Document</title>
        <script type="text/javascript"
            src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
        </script>
        <script type="text/x-mathjax-config">
            MathJax.Hub.Config({
                tex2jax: {inlineMath: [['$','$'], ['\(','\)']]}
            });
        </script>
    </head>
    <body>
        <div id='root'>
        </div>
    </body>
    </html>
    ```

+ #### 2. latex in js

    App.js
    ```js
    import React, { Component } from 'react';
    import './App.css'

    class App extends Component{
        render(){
            return (            
                <div>
                    $$\frac {1}{2} $$
                </div>
            );
        }
    }

    export default App;
    ```

+ #### 3. development and build
    development
    `~:npm start`

    build
    `~:npm run build`