---
title: (4) quick start (4) webpack-dev-server
date: 2019-07-23 22:04:07
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
使用webpack启动本地调试服务。在没有webpack这类工具之前，需要集成单独的服务器中间件部署静态资源，比如tomcat或者其他的node的服务器中间件。
webpack4

<!-- more -->

The following steps will lead you create http server for development.
Here we use `webpack-dev-server` to build it for `Hot Module Replacement` and `automatic refresh`.

### **1. install webpack-dev-server**
`~:npm install --save-dev webpack-dev-server`

### **2. config in webpack.config.js**
```js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    entry:  path.resolve(__dirname,'src/index.js'),
    output: {
        path: path.resolve(__dirname, 'build/static/js'),
        filename: 'bundle.js'
    },
    plugins:[
        new HtmlWebpackPlugin({
            inject: true, 
            template: path.resolve(__dirname, 'public/index.html'),
            filename: path.resolve(__dirname,'build/index.html'),
            minify:{
                removeAttributeQuotes: true,
                collapseWhitespace: true,
                removeRedundantAttributes: true,
                useShortDoctype: true,
                removeEmptyAttributes: true,
                removeStyleLinkTypeAttributes: true,
                keepClosingSlash: true,
                minifyJS: true,
                minifyCSS: true,
                minifyURLs: true,
            }
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
`contentBase`: specify the content base, the server will serve the static files in this directory.
`historyApiFallback`: if your project is SPA, make it true.
`inline`: automatic refresh and hot module replacement.
### **2. node script**

+ #### 2.1 package.json
    ```json
    {
        "name": "lesson1",
        "version": "1.0.0",
        "description": "",
        "main": "index.js",
        "scripts": {
            "test": "echo \"Error: no test specified\" && exit 1",
            "start": "webpack-dev-server",
            "build": "webpack"
        },
        "author": "",
        "license": "ISC",
        "devDependencies": {
            "html-webpack-plugin": "^3.2.0",
            "webpack": "^4.41.2",
            "webpack-cli": "^3.3.10",
            "webpack-dev-server": "^3.9.0"
        }
    }
    ```
    `~:npm start`

### **3. Javascripts haven't been injected.**

Error: Javascripts haven't been injected. 

### **4. multiple webpack config files**

`webpack --config webpack.config.js`
Webpack could specify a config file for compiling.
We've created some scripts in `package.json` to run `webpack`.
Now we create a new config file for webpack-dev-server so solve the injection problem.

+ #### 4.1 webpack.config.dev.js
    
    ```js
    const path = require('path');
    const HtmlWebpackPlugin = require('html-webpack-plugin');


    module.exports = {
        entry:  path.resolve(__dirname,'src/index.js'),
        output: {
            path: path.resolve(__dirname, 'build/static/js'),
            filename: 'bundle.js'
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
+ #### 4.2 package.json
  
    ```json
    {
        "name": "lesson1",
        "version": "1.0.0",
        "description": "",
        "main": "index.js",
        "scripts": {
            "test": "echo \"Error: no test specified\" && exit 1",
            "build": "webpack",
            "start": "webpack-dev-server --config webpack.config.dev.js"
        },
        "author": "",
        "license": "ISC",
        "devDependencies": {
            "html-webpack-plugin": "^3.2.0",
            "webpack": "^4.41.2",
            "webpack-cli": "^3.3.10",
            "webpack-dev-server": "^3.9.0"
        }
    }
    ```
    `~:npm start`
    open http://localhost:3000

