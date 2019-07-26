---
title: (5) quick start (5) css
date: 2019-07-23 22:05:07
copyright: true
categories:
    - node
    - react
tags:
    - node
    - react
    - webpack
---
react 快速开始    
webpack引入css插件处理css文件，webpack要处理的所有文件都是资源文件包括css，webpack要引入相应的插件才能正确处理不同类型的资源文件。

<!-- more -->

## **(5) quick start (5) css**


+ ### [quick start (1) init project](https://www.jianshu.com/p/b5df2e74aa20)
+ ### [quick start (2) webpack config to compile javascript](https://www.jianshu.com/p/71e4b19c1264)
+ ### [quick start (3) html pages with javascript](https://www.jianshu.com/p/8e2656d51037)
+ ### [quick start (4) webpack-dev-server](https://www.jianshu.com/p/58dd29b62500)
+ ### quick start (5) css
+ ### [quick start (6) react](https://www.jianshu.com/p/9b31cb59ecb5)
+ ### [quick start (7) images and url loader](https://www.jianshu.com/p/30cf1c8bb2b1)
+ ### [quick start (8) loaders and hash](https://www.jianshu.com/p/64fe50f2d3ad)
+ ### [quick start (9) a project of react](https://www.jianshu.com/p/395b299fa8f0)
+ ### [react-helmet customize html head](https://www.jianshu.com/p/97ced0c8f891)

The following steps will lead you to create css file and use styles in the at js.

```
.
├── node_modules
├── package.json
├── package-lock.json
├── public
│   └── index.html
├── src
│   ├── index.css
│   └── index.js
├── webpack.config.dev.js
└── webpack.config.js
```
### **1. loaders**
Webpack can only deal with javascript originally. It must install special loaders to deal with target type files. CSS files need `css-loader` and `style-loader`.
css-loader process the url in js or html.
style-loader replace url to css code in js or html.
+ #### 1.1 install
  
    `~:npm install css-loader style-loader --save-dev`

+ #### 1.2 config of dev server
  
    ```js
    const path = require('path');
    const HtmlWebpackPlugin = require('html-webpack-plugin');


    module.exports = {
        entry:  path.resolve(__dirname,'src/index.js'),
        output: {
            path: path.resolve(__dirname, 'build/static/js'),
            filename: 'bundle.js'
        },
        module: {
            loaders: [
                { test: /\.css$/, loader: "style-loader!css-loader" }
            ]
        },
        plugins:[
            new HtmlWebpackPlugin({
                inject: true, //inject all js at the bottom of the body
                template: path.resolve(__dirname, 'public/index.html'), //source file
            }),
        ],
        devServer: {
            contentBase: path.resolve(__dirname, 'public'),
            historyApiFallback: false,
            inline:true,
            port:3000,
        },
    }
    ```

### **2. code source in src/**

+ #### 2.1 index.css
  
    ```css
    body{
        background-color: red;
    }
    ```

+ #### 2.2 index.js
  
    ```js
    require('./index.css')
    document.write("hello, this is a test!");
    //console.log('Hello, this is a test!');
    ```

### **3. result**

`~:npm start`
